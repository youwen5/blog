---
author: "Youwen Wu"
authorTwitter: "@youwen"
desc: "why we can't have nice things"
image: "./images/i-hate-you-microsoft-torvalds.jpg"
keywords: "microsoft, linux, windows, trash software"
lang: "en"
title: "i hate you microsoft"
---

## two terrible mistakes

recently i decided to try valorant again after a 6 month hiatus (mistake 1).
this, of course, meant rebooting into my slowly dying windows OS that remained
dual booted and barely touched (mistake 2). i exclusively use windows for gaming
now as it's the last frontier that linux hasn't conquered. this has actually
been a great productivity boost for me as windows is so terrible that i _don't
even want to boot it just for games_.

## spoiled by linux

at the risk of sounding too much like i have a neckbeard and fedora, linux truly
helped me _enjoy computers_ again, after macOS and windows took that from me.
following a brief period of time configuring [hyprland](https://hyprland.org/),
i really felt comfortable with my desktop. i could switch around desktops,
launch applications, and shuffle windows like an extension of my mind. without
all of the baby-proofing and bloat designed for "casual users", everything was
instantly snappy and responsive (even compared to apple's famous UIs).

immediately upon booting back into windows and being greeted with the ridiculous
ad billboard login screen, i immediately remembered why i despised it. even the
login screen was janky when i seemed to overload it with quick inputs. the
desktop stayed barely responsive for several seconds after and every single ui
action seemed to require me to slow down and walk it through each step, lest it
fail and refuse to register inputs altogether. it's astonishing how the biggest
companies seem to make the most terrible sh\*t.

## but this isn't a post comparing linux and windows

linux vs windows has been done to death, so i won't say more. the point of this
post is to vent my frustration with the _most basic things_ being so hard to fix
on windows.

the first thing that happened when i tried to play valorant was a vanguard
(their ring 0 malware anti-cheat) error telling me that i needed to enable
"secure boot", whatever that did. i vaguely remember having to disable that to
get GRUB and arch to work. according to google, it basically forces you to sign
all of your efi boot partitions for dubious security benefits -- in other words,
make it harder to install free operating systems.

ok, fine. i'll just re-enable this thing. surely it can't be that hard?

the glorious arch linux wiki of course had an (entire
page)[https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot]
dedicated to enabling secure boot. while it was fairly straightforward, i ended
up lost in what i call "linux limbo", and so after an hour of trying, i gave up.

> linux limbo: a stage of troubleshooting something on linux where every command
> seems to succeed, yet nothing actually works, and you're left without an error
> log to work with.

whatever, i'll just enable secure boot, then boot directly into windows and
bypass GRUB.
