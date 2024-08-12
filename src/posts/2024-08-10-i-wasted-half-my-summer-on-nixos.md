---
author: "Youwen Wu"
authorTwitter: "@youwen"
desc: "some thoughts"
image: "./images/gradient-ascent.jpg"
keywords: "haskell, blog, functional programming"
lang: "en"
title: "i wasted half my summer setting up NixOS"
updated: "2024-05-25T12:00:00Z"
---

Here's what I've been up to since the start of the summer: after a month long
fender-bender with functional programming and the mathematicians up in the ivory
tower at Haskell Industries™, I spent a month setting up an esoteric Linux
distribution likely conceived of by bitter Haskell theorists who were fed up
with the fact that the real world and computers were stateful and wanted to do
something about it.

This distribution, of course, was NixOS. And I guess you could consider the
following either a case study or an autopsy of a real user of it.

## what even is NixOS?

It's somewhat difficult to explain the concept of Nix/NixOS to even the average
Linux user. It's simple, really: Nix is a tool described and developed by Eelco
Dolstra in his Ph.D thesis, _The Purely Functional Software Deployment Model_,
where he shows how to implement a tool which atomically resolves dependencies
through the use of derivations, which are pure functions that encode the build
process of a package...

The majority of readers have likely left at this point immediately after the
mention of _Ph.D thesis_. If you are still reading, I presume that the previous
word salad either made some semblance of sense to you, or you're masochistic
enough that you're willing to sit through a seminar about esoteric and
overcomplicated concepts - both great qualities for a Nix user to have.

First of all, if you've never heard of Nix, it may be hard to get a straight
answer for what it is. And that's because it's many different things. Nix, by
itself, is a package manager which can be installed on any distro that can also
help create _reproducible_ environments declaratively. This means that you can
use it to install packages like a regular package manager:

```bash
# Arch Linux
$ pacman -S neofetch

# Nix
$ nix-env -i neofetch
```

Or, you can define a shell environment in a `nix` file, and it will fetch all
the required packages and throw you into an environment with them available,
_without polluting your global PATH_. This is powerful for specifying all the
packages needed to develop on a project, with their exact version, and have them
all automatically available to developers without affecting their system
installations. This feature of Nix is used to manage
[this blog](https://github.com/youwen5/blog), in fact. You can also define build
scripts in this file, so Nix can also be used as a simple build tool, like
**Make**.

There are many more features of Nix, but I don't intend for this post to be a
full introduction to Nix or even a simple tutorial. There's enough of that over
at [nix.dev](https://nix.dev/) and the wonderful
[NixOS and Flakes Book](https://nixos-and-flakes.thiscute.world/).

But the defining factor of Nix, which makes it different from other tools like
`direnv` which do similar things, is its **reproducible builds**. Through a
concept called "derivations", Nix encodes _exactly_ how a package is built, down
to the patches and compiler options. It also requires the exact dependencies be
specified - Nix cannot access system-wide programs while building.

This means that the slightest change to a build process will result in a
different derivation. And this means that, in theory, if a derivation builds on
one machine, it should also build on every other machine, exactly the same way.
It solves the "it works on my machine issue", without any virtualisation a la
Docker.

### NixOS is a different kind of operating system

Most Linux distributions are really just some set of base software and a package
manager (usually the defining aspect for power users). NixOS is a Linux
distribution that uses Nix as its principle package manager. But it's also more
than that.

The principle issue I have with Arch (and every other distro) is that
fundamentally, it pretty much does what every distro after Slackware has tried
to do: provide the user with a base working system and a package manager that
can efficiently install and manage software. Arch just happens to contain a
pretty decent package manager with massive repositories and a minimal set of
base software, which aligns exactly with the goal of \*nix enthusiasts.

When I say that NixOS is a new kind of operating system, I don't mean that it
has a novel kernel, or even a new init system or completely new userspace
components. At the end of the day, you'll be running the same Linux applications
on the same Linux kernel you know. Strictly speaking, it is just another set of
base packages running on the Linux kernel, with the Nix package manager.

What makes NixOS different is its completely new approach to system management
and configuration from everything else that has been tried in the last two
decades [^1]. In a traditional distribution, you are provided with a tool to
fetch packages and install them into your system. That's all well and good, but
what about the rest? How do you manage the rest of your system configuration?
How do you manage already installed packages, like updating or removing them
cleanly? How do you deal with a system in a broken state, or with mismatching
dependency versions (the so-called dependency hell)? As a user, how can you set
up a system from scratch automatically with all the little things configured
like you want?

Nix and NixOS claims to solve all of these issues and more. Let's see if it
lives up to its promises.

### system configuration

Most critical system components need some form of configuration, usually by text
file. Most distributions provide no built-in way to manage these. Also,
third-party solutions are mostly unwieldy.

[^1]:
    Well, there's the _other distro_: [GNU Guix](https://guix.gnu.org/)
    (pronounced _geeks_), which is a fork of Nix released in 2019 that aims to
    achieve similar goals.
