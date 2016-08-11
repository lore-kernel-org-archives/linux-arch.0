From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/6] powerpc: switch to using thin archives
Date: Thu, 11 Aug 2016 20:16:18 +1000
Message-ID: <1470910580-18458-5-git-send-email-npiggin@gmail.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36729 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcHKKRL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 06:17:11 -0400
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

From: Stephen Rothwell <sfr@canb.auug.org.au>

Some change to the way we invoke ar is required so it can be used
by scripts/link-vmlinux.sh

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                  | 6 ++++--
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ca25454..04a1332 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -23,7 +23,8 @@ CROSS32AR		:= $(CROSS32_COMPILE)ar
 ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
-CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
+CROSS32AR	:= $(AR)
+KBUILD_ARFLAGS	+= --target elf32-powerpc
 endif
 endif
 
@@ -93,7 +94,8 @@ ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(CONFIG_WORD_SIZE)
 override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
 override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-$(GNUTARGET) $(AR)
+override AR	:= $(AR)
+KBUILD_ARFLAGS	+= --target elf$(CONFIG_WORD_SIZE)-$(GNUTARGET)
 endif
 
 LDFLAGS_vmlinux-y := -Bstatic
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec..b5fc6cb 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -1,6 +1,7 @@
 config PPC64
 	bool "64-bit kernel"
 	default n
+	select THIN_ARCHIVES
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
-- 
2.8.1
