Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:21387 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbdFLDbd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2017 23:31:33 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 00/27] kbuild, arch: complete UAPI de-coupling and cleanup scripts/Makefile.headersinst
Date: Mon, 12 Jun 2017 12:26:54 +0900
Message-ID: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Ley Foon Tan <lftan@altera.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, linux-parisc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Mikael Starvik <starvik@axis.com>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Vineet Gupta <vgupta@synopsys.com>, linux-metag@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jesper Nilsson <jesper.nilsson@axis.com>, Will Deacon <will.deacon@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-snps-arc@lists.infradead.org, Max Filippov <jcmvbkbc@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Michal Marek <mmarek@suse.com>, Chris Zankel <chris@zankel.net>, adi-buildroot-devel@lists.sourceforge.net, Rich Felker <dalias@libc.org>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Mark Salter <msalter@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, nios2-dev@lists.rocketboards.org, Stafford Horne <shorne@gmail.com>, Russell King <linux@armlinux.org.uk>, Aurelien Jacquiot <a-jacquiot@ti.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Richard Kuo <rkuo@codeaurora.org>, Helge Deller <deller@gmx.de>
Message-ID: <20170612032654.PC79FBcFhuV8xCckfBkO-O8bWc6or68xOpECz6DpBeU@z>


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

This series is based on v4.12-rc2 tag.

This series touches Kbuild files under arch/.  We have two options
to merge this series.

[1] I will collect Acked-by from arch maintainers, then apply the
    whole series to the Kbuild tree.

[2] I will ask arch maintainers to pick up arch changes (for v4.13),
    then apply Makefile changes to the Kbuild tree (for v4.14).

[1] will finish this work by v4.13, but need to deal with some conflicts.
[2] will allow us to reduce conflicts (still a bit conflicts),
    but take more time to finish this work.

If arch maintainers ack [1], I can manage conflicts
before sending a pull request to Linus.



Masahiro Yamada (27):
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
  ia64: move generic-y of exported headers to uapi/asm/Kbuild
  m32r: move generic-y of exported headers to uapi/asm/Kbuild
  m68k: move generic-y of exported headers to uapi/asm/Kbuild
  metag: move generic-y of exported headers to uapi/asm/Kbuild
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

 Makefile                               | 13 +++++++------
 arch/arc/include/asm/Kbuild            | 25 -------------------------
 arch/arc/include/uapi/asm/Kbuild       | 26 ++++++++++++++++++++++++++
 arch/arm/include/asm/Kbuild            | 17 -----------------
 arch/arm/include/uapi/asm/Kbuild       | 16 ++++++++++++++++
 arch/arm64/include/asm/Kbuild          | 17 -----------------
 arch/arm64/include/uapi/asm/Kbuild     | 16 ++++++++++++++++
 arch/blackfin/include/asm/Kbuild       | 22 ----------------------
 arch/blackfin/include/uapi/asm/Kbuild  | 22 ++++++++++++++++++++++
 arch/c6x/include/asm/Kbuild            | 27 ---------------------------
 arch/c6x/include/uapi/asm/Kbuild       | 26 ++++++++++++++++++++++++++
 arch/cris/include/asm/Kbuild           | 18 ------------------
 arch/cris/include/uapi/asm/Kbuild      | 19 +++++++++++++++++++
 arch/h8300/include/asm/Kbuild          | 27 ---------------------------
 arch/h8300/include/uapi/asm/Kbuild     | 28 ++++++++++++++++++++++++++++
 arch/hexagon/include/asm/Kbuild        | 23 -----------------------
 arch/hexagon/include/uapi/asm/Kbuild   | 24 ++++++++++++++++++++++++
 arch/ia64/include/asm/Kbuild           |  2 --
 arch/m32r/include/asm/Kbuild           |  2 --
 arch/m32r/include/uapi/asm/Kbuild      |  2 ++
 arch/m68k/include/asm/Kbuild           | 12 ------------
 arch/m68k/include/uapi/asm/Kbuild      | 11 +++++++++++
 arch/metag/include/asm/Kbuild          | 24 ------------------------
 arch/metag/include/uapi/asm/Kbuild     | 24 ++++++++++++++++++++++++
 arch/nios2/include/asm/Kbuild          | 25 -------------------------
 arch/nios2/include/asm/signal.h        | 22 ----------------------
 arch/nios2/include/uapi/asm/Kbuild     | 24 ++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild       | 28 ----------------------------
 arch/openrisc/include/uapi/asm/Kbuild  | 29 +++++++++++++++++++++++++++++
 arch/parisc/include/asm/Kbuild         |  5 -----
 arch/parisc/include/uapi/asm/Kbuild    |  4 ++++
 arch/sh/include/asm/Kbuild             | 20 --------------------
 arch/sh/include/uapi/asm/Kbuild        | 20 ++++++++++++++++++++
 arch/sparc/include/asm/Kbuild          |  1 -
 arch/sparc/include/uapi/asm/Kbuild     |  2 ++
 arch/tile/include/asm/Kbuild           | 19 -------------------
 arch/tile/include/uapi/asm/Kbuild      | 19 +++++++++++++++++++
 arch/unicore32/include/asm/Kbuild      | 31 +------------------------------
 arch/unicore32/include/uapi/asm/Kbuild | 28 ++++++++++++++++++++++++++++
 arch/xtensa/include/asm/Kbuild         |  9 ---------
 arch/xtensa/include/uapi/asm/Kbuild    | 10 ++++++++++
 scripts/Makefile.headersinst           | 28 ++++------------------------
 42 files changed, 362 insertions(+), 405 deletions(-)
 delete mode 100644 arch/nios2/include/asm/signal.h

-- 
2.7.4
