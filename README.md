# gradient ascent - yet another developer blog

This repository hosts the source code for my blog, written in Haskell and
powered by [hakyll](https://jaspervdj.be/hakyll/) and
[pandoc](https://pandoc.org). Builds are managed by [nix](https://nixos.org).

This repo is merely the source code, the actual site is hosted at
[blog.youwen.dev](https://blog.youwen.dev).

To build locally, install `nix` and enable flakes. Additionally, install the
`direnv` tool so that the provided binary utilities can be hooked into your
shell. It is also possible to perform the following steps without `direnv` if
you know what you are doing.

Allow the `.envrc`:

```bash
direnv allow
```

Wait for the build to finish. Now, you will have the `rollup` and `hakyll-site`
binaries in your PATH.

We need to compile the site source code first, and then inject the bundled CSS
and JS using `rollup`. This is done automatically by `nix build`, which is used
for GitHub Pages deployment, but it is inconvenient for local development.
Here's how to do it locally.

First, we need to build the site. Run

```bash
hakyll-site build

# sometimes, we need to ignore the cache if things aren't working
hakyll-site rebuild

# can also use `watch` for convenient development
hakyll-site watch
# starts dev server at localhost:8000
```

This will create `./dist`, containing the static assets. However, the required
CSS and JS is not in there yet! That is built by `rollup`, since we are using
`tailwindcss` and `postcss` and some JS minifying tools.

First, we need the `node_modules`. We don't provide a `package-lock.json` since
we don't use `npm` to manage node modules. Therefore, we need to obtain the
`node_modules` used by the project.

In the directory, there is a `node_modules` symlink to
`result/lib/node_modules`. If we build the `nodeDeps` package, the
`node_modules` will be made available at this path. So, run the following:

```bash
nix build .#nodeDeps
```

This will install the node modules in the Nix store and create the `result`
symlink. Keep in mind that if this `result` symlink is ever overwritten, you
need to re-run the above command or else node_modules will not be accessible.

Finally, run the following to generate the bundled CSS and JS files.

```bash
rollup -c
```

You have to re-run this whenever you change the CSS and JS files in `src/`.

Keep in mind that if `hakyll-site` ever overwrites `dist/out`, you will also
have to re-run this command.

<!--```sh-->
<!--nix build-->
<!---->
<!--nix run . watch-->
<!--```-->
<!---->
<!--This starts a hot reload server at `localhost:8000`.-->
<!---->
<!--```sh-->
<!--nix run . build-->
<!--```-->
