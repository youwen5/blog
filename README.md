# gradient ascent - yet another developer blog

This repository hosts the source code for my blog, written in Haskell and
powered by [hakyll](https://jaspervdj.be/hakyll/) and
[pandoc](https://pandoc.org). Builds are managed by [nix](https://nixos.org).

This repo is merely the source code, the actual site is hosted at
[blog.youwen.dev](https://blog.youwen.dev).

To build locally, install `nix` and enable flakes.

```sh
nix build

nix run . watch
```

This starts a hot reload server at `localhost:8000`.

```sh
nix run . build
```

This builds a local production version.

If any updates are made to the JavaScript or CSS, you will need to run

```sh
pnpm install # only the first time

pnpm build
```

This is because I still haven't figured out how to integrate the `rollup` build
pipeline with `nix`. Since the CSS and JS are minimal, I just do it manually for
now.
