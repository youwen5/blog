---
author: "Youwen Wu"
authorTwitter: "@youwen"
desc: "keep your flakes up to date"
image: "https://wallpapercave.com/wp/wp12329537.png"
keywords: "nix, update, zen browser"
lang: "en"
title: "Nix automatic hash updates made easy"
---

Nix users often create flakes to package software out of tree, like this [Zen
Browser flake](https://github.com/youwen5/zen-browser-flake) I've been
maintaining. Keeping them up to date is a hassle though, since you have to
update the Subresource Integrity (SRI) hashes that Nix uses to ensure
reproducibility.

Here's a neat method I've been using to cleanly handle automatic hash updates.
I use [Nushell](https://www.nushell.sh/) to easily work with data, prefetch
some hashes, and put it all in a JSON file that can be read by Nix at build
time.

First, let's create a file called `update.nu`. At the top, place this shebang:

```nu
#!/usr/bin/env -S nix shell nixpkgs#nushell --command nu
```

This will execute the script in a Nushell environment, which is fetched by Nix.

## Get the up to date URLs

We need to obtain the latest version of whatever software we want to update.
In this case, I'll use GitHub releases as my source of truth.

You can use the GitHub API to fetch metadata about all the releases of a repository.

```
https://api.github.com/repos/($repo)/releases
```

Roughly speaking, the raw JSON returned by the GitHub releases API looks something like:

```
[
   {tag_name: "foo", prerelease: false, ...},
   {tag_name: "bar", prerelease: true, ...},
   {tag_name: "foobar", prerelease: false, ...},
]

```

Note that the ordering of the objects in the array is chronological.

> Even if you aren't using GitHub releases, as long as there is a reliable way to
> programmatically fetch the latest download URLs of whatever software you're
> packaging, you can adapt this approach for your specific case.

We use Nushell's `http get` to make a network request. Nushell will
automatically detect and parse the JSON reponse into a Nushell table.

In my case, Zen Browser frequently publishes prerelease "twilight" builds which
we don't want to update to. So, we ignore any releases tagged "twilight" or
marked "prerelease" by filtering them out with the `where` selector.

Finally, we retrieve the tag name of the item at the first index, which would
be the latest release (since the JSON array was chronologically sorted).


```nu
#!/usr/bin/env -S nix shell nixpkgs#nushell --command nu

# get the latest tag of the latest release that isn't a prerelease
def get_latest_release [repo: string] {
  try {
	http get $"https://api.github.com/repos/($repo)/releases"
	  | where prerelease == false
	  | where tag_name != "twilight"
	  | get tag_name
	  | get 0
  } catch { |err| $"Failed to fetch latest release, aborting: ($err.msg)" }
}
```

## Prefetching SRI hashes

Now that we have the latest tags, we can easily obtain the latest download URLs, which are of the form:

```
https://github.com/zen-browser/desktop/releases/download/$tag/zen.linux-x86_64.tar.bz2
https://github.com/zen-browser/desktop/releases/download/$tag/zen.aarch64-x86_64.tar.bz2
```

However, we still need the corresponding SRI hashes to pass to Nix.

```nix
src = fetchurl {
   url = "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.5/zen.linux-x86_64.tar.bz2";
   hash = "sha256-00000000000000000000000000000000000000000000";
};
```

The easiest way to obtain these new hashes is to update the URL and then set
the hash property to an empty string (`""`). Nix will spit out an hash mismatch
error with the correct hash. However, this is inconvenient for automated
command line scripting.

The Nix documentation mentions
[nix-prefetch-url](https://nix.dev/manual/nix/2.18/command-ref/nix-prefetch-url)
as a way to obtain these hashes, but as usual, it doesn't work quite right and
has also been replaced by a more powerful but underdocumented experimental
feature instead.

The [nix store
prefetch-file](https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-store-prefetch-file)
command does what `nix-prefetch-url` is supposed to do, but handles the caveats
that lead to the wrong hash being produced automatically.

Let's write a Nushell function that outputs the SRI hash of the given URL. We
tell `prefetch-file` to output structured JSON that we can parse.

Since Nushell _is_ a shell, we can directly invoke shell commands like usual,
and then process their output with pipes.

```nu
def get_nix_hash [url: string] {
  nix store prefetch-file --hash-type sha256 --json $url | from json | get hash
}
```

Cool! Now `get_nix_hash` can give us SRI hashes that look like this:

```
sha256-K3zTCLdvg/VYQNsfeohw65Ghk8FAjhOl8hXU6REO4/s=
```

## Putting it all together

Now that we're able to fetch the latest release, obtain the download URLs, and
compute their SRI hashes, we have all the information we need to make an
automated update. However, these URLs are typically hardcoded in our Nix
expressions. The question remains as to how to update these values.

A common way I've seen updates performed is using something like `sed` to
modify the Nix expressions in place. However, there's actually a more
maintainable and easy to understand approach.

Let's have our Nushell script generate the URLs and hashes and place them in a
JSON file! Then, we'll be able to read the JSON file from Nix and obtain the
URL and hash.

```nu
def generate_sources [] {
  let tag = get_latest_release "zen-browser/desktop"
  let prev_sources = open ./sources.json

  if $tag == $prev_sources.version {
	# everything up to date
	return $tag
  }

  # generate the download URLs with the new tag
  let x86_64_url = $"https://github.com/zen-browser/desktop/releases/download/($tag)/zen.linux-x86_64.tar.bz2"
  let aarch64_url = $"https://github.com/zen-browser/desktop/releases/download/($tag)/zen.linux-aarch64.tar.bz2"

  # create a Nushell record that maps cleanly to JSON
  let sources = {
    # add a version field as well for convenience
	version: $tag

	x86_64-linux: {
	  url:  $x86_64_url
	  hash: (get_nix_hash $x86_64_url)
	}
	aarch64-linux: {
	  url: $aarch64_url
	  hash: (get_nix_hash $aarch64_url)
	}
  }

  echo $sources | save --force "sources.json"

  return $tag
}
```

Running this script with

```bash
chmod +x ./update.nu
./update.nu
```

gives us the file `sources.json`:

```json
{
  "version": "1.0.2-b.5",
  "x86_64-linux": {
    "url": "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.5/zen.linux-x86_64.tar.bz2",
    "hash": "sha256-K3zTCLdvg/VYQNsfeohw65Ghk8FAjhOl8hXU6REO4/s="
  },
  "aarch64-linux": {
    "url": "https://github.com/zen-browser/desktop/releases/download/1.0.2-b.5/zen.linux-aarch64.tar.bz2",
    "hash": "sha256-NwIYylGal2QoWhWKtMhMkAAJQ6iNHfQOBZaxTXgvxAk="
  }
}
```

Now, let's read this from Nix. My file organization looks like the following:

```
./
| flake.nix
| zen-browser-unwrapped.nix
| ...other files...
```

`zen-browser-unwrapped.nix` contains the derivation for Zen Browser. Let's add
`version`, `url`, and `hash` to its inputs:

```nix
{
  stdenv,
  fetchurl,
  # add these below
  version,
  url,
  hash,
  ...
}:
stdenv.mkDerivation {
   # inherit version from inputs
  inherit version;
  pname = "zen-browser-unwrapped";

  src = fetchurl {
    # inherit the URL and hash we obtain from the inputs
    inherit url hash;
  };
}
```

Then in `flake.nix`, let's provide the derivation with the data from `sources.json`:

```nix
let
   supportedSystems = [
     "x86_64-linux"
     "aarch64-linux"
   ];
   forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
in
{
   # rest of file omitted for simplicity
   packages = forAllSystems (
     system:
     let
       pkgs = import nixpkgs { inherit system; };
       # parse sources.json into a Nix attrset
       sources = builtins.fromJSON (builtins.readFile ./sources.json);
     in
     rec {
       zen-browser-unwrapped = pkgs.callPackage ./zen-browser-unwrapped.nix {
         inherit (sources.${system}) hash url;
         inherit (sources) version;

         # if the above is difficult to understand, it is equivalent to the following:
         hash = sources.${system}.hash;
         url = sources.${system}.url;
         version = sources.version;
       };
}
```

Now, running `nix build .#zen-browser-unwrapped` will be able to use the hashes
and URLs from `sources.json` to build the package!

## Automating it in CI

We now have a script that can automatically fetch releases and generate hashes
and URLs, as well as a way for Nix to use the outputted JSON to build
derivations. All that's left is to fully automate it using CI!

We are going to use GitHub actions for this, as it's free and easy and you're
probably already hosting on GitHub.

Ensure you've set up actions for your repo and given it sufficient permissions.

We're gonna run it on a cron timer that checks for updates at 8 PM PST every day.

We use DeterminateSystems' actions to help set up Nix. Then, we simply run our
update script. Since we made the script return the tag it fetched, we can store
it in a variable and then use it in our commit message.

```
name: Update to latest version, and update flake inputs

on:
  schedule:
    - cron: "0 4 * * *"
  workflow_dispatch:

jobs:
  update:
    name: Update flake inputs and browser
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Check flake inputs
        uses: DeterminateSystems/flake-checker-action@v4

      - name: Install Nix
        uses: DeterminateSystems/nix-installer-action@main

      - name: Set up magic Nix cache
        uses: DeterminateSystems/magic-nix-cache-action@main

      - name: Check for update and perform update
        run: |
          git config --global user.name "github-actions[bot]"
          git config --global user.email "github-actions[bot]@users.noreply.github.com"

          chmod +x ./update.nu
          export ZEN_LATEST_VER="$(./update.nu)"

          git add -A
          git commit -m "github-actions: update to $ZEN_LATEST_VER" || echo "Latest version is $ZEN_LATEST_VER, no updates found"

          nix flake update --commit-lock-file

          git push
```

Now, our repository will automatically check for and perform updates every day!
