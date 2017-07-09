From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 00/28] kbuild: complete UAPI de-coupling and cleanup scripts/Makefile.headersinst
Date: Mon, 10 Jul 2017 03:32:32 +0900
Message-ID: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In v4.12-rc1, we had a big progress for headers_install.
All (and only) headers under UAPI directories are exported.
However, asm-generic wrappers are still exceptions because
most of arch/*/include/asm/Kbuild include "generic-y" for
exported headers.  As a result, many of generic-wrappers to be
exported are generated outside UAPI directories.

To finish de-coupling UAPI, "generic-y" for exported headers
should be moved to arch/*/include/uapi/asm/Kbuild.

With those cleanups, the logic of headers_install will become
even simpler.  UAPI will be completely self-contained.

This series is based on:
commit 19bf2e0ef18ec8a7284ecc83459a2664cb885cd5

Changes for v2:
  - rebase on the latest in the mainline in order to avoid merge conflicts



Masahiro Yamada (28):
  kbuild: remove useless $(gen) variable in Makefile.headersinst
  kbuild: fix comment about dst of headers_{install,check}_all
  kbuild: pass dst= to Makefile.headersinst from top Makefile
  arm64: move generic-y of exported headers to uapi/asm/Kbuild
  ARM: move generic-y of exported headers to uapi/asm/Kbuild
  arc: move generic-y of exported headers to uapi/asm/Kbuild
  blackfin: move generic-y of exported headers to uapi/asm/Kbuild
  c6x: move generic-y of exported headers to uapi/asm/Kbuild
  cris: move generic-y of exported headers to uapi/asm/Kbuild
  h8300: move generic-y of exported headers to uapi/asm/Kbuild
  hexagon: move generic-y of exported headers to uapi/asm/Kbuild
  ia64: remove redundant generic-y += kvm_para.h from asm/Kbuild
  m32r: move generic-y of exported headers to uapi/asm/Kbuild
  m68k: move generic-y of exported headers to uapi/asm/Kbuild
  metag: move generic-y of exported headers to uapi/asm/Kbuild
  microblaze: move generic-y of exported headers to uapi/asm/Kbuild
  nios2: remove unneeded arch/nios2/include/(generated/)asm/signal.h
  nios2: move generic-y of exported headers to uapi/asm/Kbuild
  openrisc: move generic-y of exported headers to uapi/asm/Kbuild
  parisc: move generic-y of exported headers to uapi/asm/Kbuild
  sh: move generic-y of exported headers to uapi/asm/Kbuild
  sparc: move generic-y of exported headers to uapi/asm/Kbuild
  tile: move generic-y of exported headers to uapi/asm/Kbuild
  unicore32: move generic-y of exported headers to uapi/asm/Kbuild
  xtensa: move generic-y of exported headers to uapi/asm/Kbuild
  kbuild: do not include old-kbuild-file from Makefile.headersinst
  kbuild: split exported generic header creation into uapi-asm-generic
  kbuild: remove wrapper files handling from Makefile.headersinst

 Makefile                                | 13 +++++++------
 arch/arc/include/asm/Kbuild             | 24 ------------------------
 arch/arc/include/uapi/asm/Kbuild        | 24 ++++++++++++++++++++++++
 arch/arm/include/asm/Kbuild             | 16 ----------------
 arch/arm/include/uapi/asm/Kbuild        | 14 ++++++++++++++
 arch/arm64/include/asm/Kbuild           | 17 -----------------
 arch/arm64/include/uapi/asm/Kbuild      | 16 ++++++++++++++++
 arch/blackfin/include/asm/Kbuild        | 24 +-----------------------
 arch/blackfin/include/uapi/asm/Kbuild   | 22 ++++++++++++++++++++++
 arch/c6x/include/asm/Kbuild             | 28 +---------------------------
 arch/c6x/include/uapi/asm/Kbuild        | 25 +++++++++++++++++++++++++
 arch/cris/include/asm/Kbuild            | 21 ++-------------------
 arch/cris/include/uapi/asm/Kbuild       | 17 +++++++++++++++++
 arch/h8300/include/asm/Kbuild           | 30 ++----------------------------
 arch/h8300/include/uapi/asm/Kbuild      | 26 ++++++++++++++++++++++++++
 arch/hexagon/include/asm/Kbuild         | 24 +-----------------------
 arch/hexagon/include/uapi/asm/Kbuild    | 22 ++++++++++++++++++++++
 arch/ia64/include/asm/Kbuild            |  2 --
 arch/m32r/include/asm/Kbuild            |  4 +---
 arch/m32r/include/uapi/asm/Kbuild       |  3 ++-
 arch/m68k/include/asm/Kbuild            | 13 +------------
 arch/m68k/include/uapi/asm/Kbuild       | 10 ++++++++++
 arch/metag/include/asm/Kbuild           | 26 +-------------------------
 arch/metag/include/uapi/asm/Kbuild      | 24 ++++++++++++++++++++++++
 arch/microblaze/include/asm/Kbuild      | 25 -------------------------
 arch/microblaze/include/uapi/asm/Kbuild | 25 ++++++++++++++++++++++++-
 arch/nios2/include/asm/Kbuild           | 26 +-------------------------
 arch/nios2/include/asm/signal.h         | 22 ----------------------
 arch/nios2/include/uapi/asm/Kbuild      | 23 +++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild        | 29 +----------------------------
 arch/openrisc/include/uapi/asm/Kbuild   | 27 +++++++++++++++++++++++++++
 arch/parisc/include/asm/Kbuild          |  7 +------
 arch/parisc/include/uapi/asm/Kbuild     |  4 ++++
 arch/sh/include/asm/Kbuild              | 19 -------------------
 arch/sh/include/uapi/asm/Kbuild         | 18 ++++++++++++++++++
 arch/sparc/include/asm/Kbuild           |  1 -
 arch/sparc/include/uapi/asm/Kbuild      |  2 ++
 arch/tile/include/asm/Kbuild            | 19 -------------------
 arch/tile/include/uapi/asm/Kbuild       | 19 +++++++++++++++++++
 arch/unicore32/include/asm/Kbuild       | 30 +-----------------------------
 arch/unicore32/include/uapi/asm/Kbuild  | 27 +++++++++++++++++++++++++++
 arch/xtensa/include/asm/Kbuild          | 10 +---------
 arch/xtensa/include/uapi/asm/Kbuild     |  9 +++++++++
 scripts/Makefile.headersinst            | 29 ++++-------------------------
 44 files changed, 381 insertions(+), 435 deletions(-)
 delete mode 100644 arch/nios2/include/asm/signal.h

-- 
2.7.4
