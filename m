From: GuanXuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH 0/6] unicore32 subsystem: 6 patches for 2.6.39
Date: Thu, 26 May 2011 11:36:52 +0000
Message-ID: <cover.1306408804.git.gxt@mprc.pku.edu.cn>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57273 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757084Ab1EZLhx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 May 2011 07:37:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

Two patches for PKUnity v3 SoC drivers:
	add mac driver, and move rtc driver to appropriate place
Two patches for new 2.6.39 updates:
	using generic-y and modify PERCPU macro
Other two patches are small fixes.

---
Guan Xuetao (6):
  unicore32: move rtc-puv3.c to drivers/rtc directory
  unicore32: add pkunity-v3 mac/net driver (umal)
  unicore32: change zImage physical address, though it's PIC codes
  unicore32: add KBUILD_DEFCONFIG with unicore32_defconfig (old
    debug_defconfig)
  unicore32: change PERCPU to PERCPU_SECTION
  unicore32: using generic-y format for one line asm-generic files

 MAINTAINERS                                |    2 +
 arch/unicore32/Kconfig                     |    4 -
 arch/unicore32/Makefile                    |   38 +-
 arch/unicore32/boot/compressed/Makefile    |    2 +-
 arch/unicore32/configs/debug_defconfig     |  215 ---
 arch/unicore32/configs/unicore32_defconfig |  215 +++
 arch/unicore32/include/asm/Kbuild          |   59 +
 arch/unicore32/kernel/Makefile             |    1 -
 arch/unicore32/kernel/rtc.c                |  371 ------
 arch/unicore32/kernel/vmlinux.lds.S        |    2 +-
 drivers/net/Kconfig                        |    5 +
 drivers/net/Makefile                       |    1 +
 drivers/net/mac-puv3.c                     | 1942 ++++++++++++++++++++++++++++
 drivers/rtc/Kconfig                        |    9 +
 drivers/rtc/Makefile                       |    1 +
 drivers/rtc/rtc-puv3.c                     |  359 +++++
 16 files changed, 2597 insertions(+), 629 deletions(-)
 delete mode 100644 arch/unicore32/configs/debug_defconfig
 create mode 100644 arch/unicore32/configs/unicore32_defconfig
 delete mode 100644 arch/unicore32/kernel/rtc.c
 create mode 100644 drivers/net/mac-puv3.c
 create mode 100644 drivers/rtc/rtc-puv3.c

-- 
1.7.5.2
