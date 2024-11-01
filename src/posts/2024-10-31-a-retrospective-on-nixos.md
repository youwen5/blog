---
author: "Youwen Wu"
authorTwitter: "@youwen"
desc: "and the future of operating systems"
image: "./images/gradient-ascent.jpg"
keywords: "nix, nixos, functional programming, linux, unix"
lang: "en"
title: "a retrospective on NixOS"
updated: "2024-05-25T12:00:00Z"
---

Many people more knowledgeable than me have already written at length about the
virtues of NixOS and _declarative configuration_ and _immutability_ and such. I
doubt what I have to say is particularly novel to those already familiar with
Nix, but I'd like to discuss precisely what brings people to NixOS in the first
place.

Many people will introduce NixOS by first introducing the Nix package manager,
and immediately jumping into terms like _derivation_ and _immutability_ and
_reproducibility_ and whatnot. And while these are important concepts for
understanding the system at large, it's not very convincing for people looking
to try out the system. After all, most people don't (or at least shouldn't!)
choose their tools based on hype or purported benefits, but based the problems
that they help them solve.

Instead of immediately evangelizing about the virtues of Nix and NixOS, I'll
first motivate the reasons for why I chose a tool with exactly its properties
(but not to worry, the evangelizing will come later).

Essentially: allow me to introduce you to the
origins of the [NixOS God
Complex](https://www.reddit.com/r/NixOS/comments/kauf1m/dealing_with_post_nixflake_god_complex/).

---

My goals for my system are as follows:

- Allow my computing environment to exist on different computers at the same
  time (essentially, sync up configurations between machines)
- Precisely control the software and services on my machine. I should be able
  to obtain binaries of most things to save time, but be able to step into the
  source and apply patches or configuration as desired
- For the OS to be absolutely unbreakable
- Never configure the system twice; once I solve a problem, I should have a
  reproducible solution that solves it permanently
- Be able to backup my system configuration and quickly redeploy it whenever
  needed
- Avoid janky solutions to these problems that introduce tech debt. I don't
  want to have to rely on disk images or backups, I want to be able to create
  fresh installations quickly

Essentially, I want to synchronize the configuration of my entire system across
multiple machines while maintaining a stable and usable system I'm not worried
will inadvertently fall apart with a routine system update. When I tweak and
mess with some settings on my desktop, I should be able to push to a `git`
repository and pull it down on my laptop and have the tweaks carried over. This
even includes system-level configuration like the applications installed,
system daemons, and other core system services.

I want a source and binary based distribution simultaneously. And I want a
self-documenting reproducible system where every tiny tweak is
deterministically applied. And I want to be able to install my configurations
onto a new computer, from scratch, in an installer, effectively creating my own
custom Linux distribution.

Oh, and I also want to solve the "works on my machine" problem, and never have
trouble using software someone else packaged and claims works on their end, but
fails on my computer.

All or even just a few of these goals seem unattainable to the typical Linux
user (not to mention those still on Windows and macOS $\dots$ _oh, the
horror!_). But I was in fact able to achieve all of them.

---

To begin, let's examine how one might try to approach these problems with the
common solutions.

Let's talk about sharing configuration among multiple computers first, which
can be thought of as some form of "settings sync".

Most people have encountered solutions to sychronizing configuration in two
ways: either the entire service is ran in the cloud, so it's really the _same_
environment accessed from multiple places (eg. Google Docs), or it's some often
half baked opaque solution involving you making an account and sending all your
settings to a sync server (eg. Mozilla Firefox).

The more technically minded may instead opt to create a "dotfiles" repository,
holding their vast collection of meticulously crafted configuration files.
These repos often come with a janky `install.sh` script that does its best to
install all the files into the correct place. This usually works the first
time, but trying to keep the installed dotfiles in sync with a central
repository is a whole other problem.

There are also dotfile manager like `chezmoi` or GNU Stow. I have not tried
these so I make no judgements on their utility for their intended purpose.
These dotfile management solutions may work well for managing configuration
files, but they both have the same issue: you also need to install the software
you're configuring!

The software and the configuration are fundamentally tied together; these are
not concerns to be separated. If the software is installed, it almost always
needs to be configured anyways. If the configuration exists, the software
should be installed. So a sane solution needs to both put the configuration in
the right place, _and_ set up the system's programs along with all their
dependencies!

So, the most obsessive *nix hackers reach for tools like
[Ansible](https://www.ansible.com/), that promise automatic configuration of
entire systems. Though Ansible was initially designed to deploy cloud servers
quickly through the Infrastructure-as-Code approach, some people opt to use it
for deploying and managing their systems quickly as well. I have not personally
tried it beyond playing with a few examples The consensus seems to be that it
seems to work fine for simple use cases but gets quite unwieldy for more
complex purposes (especially for personal systems, which aren't expected to be
as ephemeral as servers).

A system like Ansible combined with a system to manage configuration files
might be able to achieve a few of our goals. We can keep configuration in sync
between computers and we can quickly redeploy our system. But anyone who has
tried this will tell you that it's incredibly uncomfortable to use; our
existing operating systems are simply not designed to be managed in this
manner. Inevitably you will experience desynchronization between the
configuration and the actual state of the machine.

Also, this does not solve some of our other problems. We'll still need tools
like Docker to reproducibly build software and figure out a way to keep our
system stable.

If you agree with the premises I've laid out up to this point, that none of
these solutions provide a satisfying solution to our computing woes, you might
come to the conclusion that I've made. We need a solution that does _all of
it_. A unified tool for reliably deploying software and managing your system
configuration. And it must necessarily be declarative and reproducible, because
that is the only sane way to manage a system. Imagine working on a programming
project where recompiling with the same source code would non-deterministically
produce different results based on the environment! We should be able to write
files that declaratively and precisely specify the state of whole system, and
then be able to revert these files or tweak them with deterministic results
that don't leave behind any broken programs or files.

Well, [Nix](https://nixos.org/) is the _purely functional_ package manager
(i.e. declarative, reproducible), and NixOS is a Linux distribution that is
managed entirely by Nix. Essentially, Nix provides a solution to the problem of
_software deployment_, and in fact was purpose built to do so in Eelco
Dolstra's seminal [PhD
thesis](https://edolstra.github.io/pubs/phd-thesis.pdf). It effectively solves
the problem of "works on my machine" by _forcing_ the user to actually specify
all required dependencies. This makes it a little harder to write the initial
build configurations due to the strictness imposed. But the reward is that if a
piece of software builds on one machine, it's guaranteed to build on another.

NixOS is a system that takes the power of Nix and applies it to declaratively
configure an _entire Linux system_. All of the installed software and activated
services can be specified precisely using the Nix expression language, a purely
functional DSL used by Nix. And alongside the software, it also configures it,
effectively acting as a dotfile manager. Indeed, many core NixOS services and a
wide range of programs can be set up through _NixOS modules_, where the program
is installed and configured in the same place. (and many programs like `fzf`,
`btop`, etc have similar corresponding `home-manager` modules).

NixOS is also _immutable_, which means that the system cannot be modified after
it is built from the Nix files that declare it. How do you make changes to the
system then? Obviously, we just create a new system where the changed programs
and files are included, and the old ones are removed. But they are not deleted
from the hard drive, they still exist in the _Nix store_. So, the system can
provide precise atomic rollbacks between each "generation" of itself. Broke
your GRUB configuration so your system won't boot? Messed up your kernel
settings? Just select an older working generation from the boot menu and you
instantly have a working system again. You never worry about breaking things
during either routine or massive system updates.

And because the system is fully declarative, and modifying the system is done
only through modifying its Nix configuration files,  you can version and sync
them up with Git. This solves the problem of keeping system environments in
sync; now, you truly only have to keep one repository of all your configuration
in sync, and all the software installation and deployment is handled for you by
a system designed precisely for that purpose.

This makes it possible for me to share common configuration between a multitude
of entirely distinct machines, including an `x86_64` desktop, an `x86_64`
laptop, an Apple Silicon Macbook running NixOS `aarch64` using [Asahi
Linux](https://asahilinux.org/), and the same Macbook running macOS with
`nix-darwin`, sharing `home-manager` configuration with NixOS. Specific
configuration necessary to adjust hardware-specific details between each
machines are isolated to the [hosts](./hosts) directory.

This works exceptionally well, evidenced by the fact that I have (almost) the
exact same environment across three separate machines, spanning two entirely
distinct CPU architectures.

In essence, the primary failure of deployment scripts, Ansible and the like is
that they are _imperative_ - they must specify precisely _how_ to set up the
system, down to minute details, whereas in a _declarative_ approach, the user
can simply specify what the system _should look like_, and abstractions take
care of the _how_. This is what NixOS does, and it gives you remote syncing,
versioning (via `git`), and rollbacks _for free_.
