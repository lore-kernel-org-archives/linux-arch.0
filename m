From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] Remove execution domain support
Date: Wed, 15 Apr 2015 21:59:24 +0200
Message-ID: <552EC31C.6070007@nod.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JKA84d6p86VSkvpidTtUc9DSo0SQwcm9B"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349AbbDOT70 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Apr 2015 15:59:26 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JKA84d6p86VSkvpidTtUc9DSo0SQwcm9B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Linus,

the following changes since commit f22e6e847115abc3a0e2ad7bb18d243d42275a=
f1:

  Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git exec_domain_r=
ip_v2

for you to fetch changes up to 97b2f0dc331474fb80ba4f4e4aee1d8e9ffbf7ce:

  arm64: Removed unused variable (2015-04-13 20:40:10 +0200)

----------------------------------------------------------------
This series removes execution domain support from Linux.
The idea behind exec domains was to support different ABIs.
The feature was never complete nor stable.
Let's rip it out and make the kernel signal handling code less
complicated.

----------------------------------------------------------------
Guenter Roeck (1):
      sparc: Fix execution domain removal

Richard Weinberger (26):
      arm: Remove RISC OS personality
      ia64: Remove Linux/x86 exec domain support
      Remove execution domain support
      arm: Remove signal translation and exec_domain
      arm64: Remove signal translation and exec_domain
      blackfin: Autogenerate offsets in struct thread_info
      blackfin: Remove exec_domain usage
      frv: Remove signal translation and exec_domain
      m32r: Autogenerate offsets in struct thread_info
      m32r: Remove signal translation and exec_domain
      m68k: Remove signal translation and exec_domain
      microblaze: Remove signal translation and exec_domain
      mn10300: Remove signal translation and exec_domain
      s390: Remove signal translation and exec_domain
      sh: Remove signal translation and exec_domain
      sparc: Remove signal translation and exec_domain
      tile: Remove signal translation and exec_domain
      um: Remove signal translation and exec_domain
      unicore32: Remove signal translation and exec_domain
      x86: Remove signal translation and exec_domain
      xtensa: Autogenerate offsets in struct thread_info
      xtensa: Remove signal translation and exec_domain
      arc: Remove signal translation and exec_domain
      arch: Remove exec_domain from remaining archs
      Remove rest of exec domains.
      arm64: Removed unused variable

 arch/alpha/include/asm/thread_info.h      |   2 -
 arch/arc/include/asm/thread_info.h        |   2 -
 arch/arc/kernel/signal.c                  |  14 +--
 arch/arm/Kconfig                          |  10 ---
 arch/arm/configs/badge4_defconfig         |   1 -
 arch/arm/include/asm/thread_info.h        |   3 -
 arch/arm/kernel/Makefile                  |   1 -
 arch/arm/kernel/arthur.c                  |  94 --------------------
 arch/arm/kernel/asm-offsets.c             |   1 -
 arch/arm/kernel/signal.c                  |  13 +--
 arch/arm/kernel/traps.c                   |   6 +-
 arch/arm64/include/asm/thread_info.h      |   3 -
 arch/arm64/kernel/asm-offsets.c           |   1 -
 arch/arm64/kernel/signal.c                |   7 --
 arch/avr32/include/asm/thread_info.h      |   3 -
 arch/avr32/kernel/asm-offsets.c           |   1 -
 arch/blackfin/include/asm/thread_info.h   |  11 ---
 arch/blackfin/kernel/asm-offsets.c        |   6 ++
 arch/blackfin/kernel/signal.c             |   6 +-
 arch/blackfin/kernel/traps.c              |   1 +
 arch/c6x/include/asm/thread_info.h        |   2 -
 arch/cris/arch-v10/kernel/signal.c        |   2 -
 arch/cris/arch-v32/kernel/signal.c        |   2 -
 arch/cris/include/asm/thread_info.h       |   2 -
 arch/frv/include/asm/thread_info.h        |   2 -
 arch/frv/kernel/asm-offsets.c             |   1 -
 arch/frv/kernel/signal.c                  |  20 +----
 arch/hexagon/include/asm/thread_info.h    |   2 -
 arch/ia64/include/asm/thread_info.h       |   2 -
 arch/ia64/mm/init.c                       |  25 ------
 arch/m32r/include/asm/asm-offsets.h       |   1 +
 arch/m32r/include/asm/thread_info.h       |  15 +---
 arch/m32r/kernel/asm-offsets.c            |  15 +++-
 arch/m32r/kernel/entry.S                  |   1 +
 arch/m32r/kernel/signal.c                 |  12 +--
 arch/m68k/include/asm/thread_info.h       |   2 -
 arch/m68k/kernel/signal.c                 |  14 +--
 arch/metag/include/asm/thread_info.h      |   2 -
 arch/metag/kernel/irq.c                   |   2 -
 arch/microblaze/include/asm/thread_info.h |   2 -
 arch/microblaze/kernel/signal.c           |   9 +-
 arch/mips/include/asm/thread_info.h       |   2 -
 arch/mips/kernel/asm-offsets.c            |   1 -
 arch/mn10300/include/asm/thread_info.h    |   2 -
 arch/mn10300/kernel/asm-offsets.c         |   2 -
 arch/mn10300/kernel/signal.c              |  20 +----
 arch/nios2/include/asm/thread_info.h      |   2 -
 arch/openrisc/include/asm/thread_info.h   |   2 -
 arch/openrisc/kernel/signal.c             |   2 -
 arch/parisc/include/asm/thread_info.h     |   2 -
 arch/parisc/kernel/asm-offsets.c          |   1 -
 arch/powerpc/include/asm/thread_info.h    |   2 -
 arch/s390/include/asm/thread_info.h       |   2 -
 arch/s390/kernel/asm-offsets.c            |   1 -
 arch/s390/kernel/compat_signal.c          |  14 +--
 arch/s390/kernel/signal.c                 |  14 +--
 arch/score/include/asm/thread_info.h      |   2 -
 arch/score/kernel/asm-offsets.c           |   1 -
 arch/sh/include/asm/thread_info.h         |   2 -
 arch/sh/kernel/asm-offsets.c              |   1 -
 arch/sh/kernel/irq.c                      |   2 -
 arch/sh/kernel/signal_32.c                |  18 +---
 arch/sh/kernel/signal_64.c                |  21 +----
 arch/sparc/include/asm/thread_info_32.h   |  15 ++--
 arch/sparc/include/asm/thread_info_64.h   |  26 +++---
 arch/sparc/kernel/traps_32.c              |   1 -
 arch/sparc/kernel/traps_64.c              |   2 -
 arch/tile/include/asm/thread_info.h       |   2 -
 arch/tile/kernel/compat_signal.c          |   9 +-
 arch/tile/kernel/signal.c                 |   9 +-
 arch/um/include/asm/thread_info.h         |   2 -
 arch/unicore32/include/asm/thread_info.h  |   3 -
 arch/unicore32/kernel/asm-offsets.c       |   1 -
 arch/unicore32/kernel/signal.c            |   7 --
 arch/x86/include/asm/thread_info.h        |   3 -
 arch/x86/kernel/signal.c                  |  16 +---
 arch/x86/um/signal.c                      |   7 --
 arch/xtensa/include/asm/thread_info.h     |  13 ---
 arch/xtensa/kernel/asm-offsets.c          |   8 ++
 arch/xtensa/kernel/signal.c               |  11 +--
 include/linux/personality.h               |  40 +--------
 include/linux/sched.h                     |   6 --
 kernel/exec_domain.c                      | 137 +-----------------------=
------
 kernel/exit.c                             |   2 -
 kernel/fork.c                             |   4 -
 85 files changed, 86 insertions(+), 675 deletions(-)
 delete mode 100644 arch/arm/kernel/arthur.c
 create mode 100644 arch/m32r/include/asm/asm-offsets.h


--JKA84d6p86VSkvpidTtUc9DSo0SQwcm9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVLsMcAAoJEPmeIjfg4UaaDCgQAIxOSh71+wPKUIUviFZzsqVg
b9616L+ONM8kFhBLgXasmfExMKhWwpBK+ibvQyVJX8zdxv+qGHuHHCLxqdBqO9H9
U6iOtCaYh0XKbtgcaz4XUIgVIKYejF/tyDRYkWMVJfu6iFJlSOqvSA0Peqbzi4ii
fNoQJMI2Fm/BT99F9o2smE13QSJPb2FvMmT3NG7ZOIwIika5oAE56cHhqTOh1SxS
44gIkYSUurGOR9iAE7tmFEnoNANnRxTKIUjVDpATROD2A9QbOfkPJ8D2PRVdvVPi
78rKfk0d0j2pTo9aeJW6QZnQ78fWs0larmzuUq/VbpYb32Jn+NbrpoD6FNdWtQox
WfEAi9TmEt44S/LGs3ypffs7YPI/0HitcukT9MoeHrTuL++XFwMzV1sn8Qh11ppa
HvI9wYY53sujqhuznZ71frlT6I4Ln35xFvwAj3hW8uFecljuupIYPwUH6i5r+Idm
URMjZfXbmss/ifo43NAljEQppnq4AJsuvMt/zCBmDMwjMKsShoFHic6qvvjRRu9p
ZTZ5vqijNlH3RX2Gt6ovW/ifh4s5aDLN2damY8yGqLAz8ke39afLu2sLNC4w4goo
6ypWy1xLHiAyjem/2WFE/1HUsKGklZ0JTQWpHK7SxTykKhH2QafaleH5AehFfMXS
QonZ8ajqRlXEs+xipaGp
=xSa7
-----END PGP SIGNATURE-----

--JKA84d6p86VSkvpidTtUc9DSo0SQwcm9B--
