From: GuanXuetao <gxt@mprc.pku.edu.cn>
Subject: [GIT PULL] unicore32 patches for linux-2.6
Date: Thu,  9 Jun 2011 10:48:13 +0000
Message-ID: <cover.1307614950.git.gxt@mprc.pku.edu.cn>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41376 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab1FIKtP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Jun 2011 06:49:15 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

Hi Linus,
Please pull the patches of unicore32 subsystem for linux-2.6 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/epip/linux-2.6-unicore32.git unicore32

Five patches are included after last review, and mac driver is excluded.

Thanks

Guan Xuetao

---
Guan Xuetao (5):
  unicore32: move rtc-puv3.c to drivers/rtc directory
  unicore32: change zImage physical address, though it's PIC codes
  unicore32: add KBUILD_DEFCONFIG with unicore32_defconfig (old
    debug_defconfig)
  unicore32: change PERCPU to PERCPU_SECTION
  unicore32: using generic-y format for one line asm-generic files

 MAINTAINERS                                        |    1 +
 arch/unicore32/Kconfig                             |    4 -
 arch/unicore32/Makefile                            |   38 +------------
 arch/unicore32/boot/compressed/Makefile            |    2 +-
 .../{debug_defconfig => unicore32_defconfig}       |    8 +-
 arch/unicore32/include/asm/Kbuild                  |   59 ++++++++++++++++++++
 arch/unicore32/kernel/Makefile                     |    1 -
 arch/unicore32/kernel/vmlinux.lds.S                |    2 +-
 drivers/rtc/Kconfig                                |    9 +++
 drivers/rtc/Makefile                               |    1 +
 .../kernel/rtc.c => drivers/rtc/rtc-puv3.c         |   14 +----
 11 files changed, 79 insertions(+), 60 deletions(-)
 rename arch/unicore32/configs/{debug_defconfig => unicore32_defconfig} (97%)
 rename arch/unicore32/kernel/rtc.c => drivers/rtc/rtc-puv3.c (98%)

-- 
1.7.5.4
