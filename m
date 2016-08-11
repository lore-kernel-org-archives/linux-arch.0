From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/6] powerpc/64: use linker dead code elimination
Date: Thu, 11 Aug 2016 20:16:19 +1000
Message-ID: <1470910580-18458-6-git-send-email-npiggin@gmail.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35402 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcHKKRR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 06:17:17 -0400
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/Makefile           | 3 +++
 arch/powerpc/kernel/vmlinux.lds.S      | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b2027a5..974a068 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -4,7 +4,10 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
+ccflags-y		+= -fno-function-sections -fno-data-sections
+
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
+subdir-ccflags-y	+= -fno-function-sections -fno-data-sections
 
 ifeq ($(CONFIG_PPC64),y)
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b5fba68..baad2af 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -50,7 +50,7 @@ SECTIONS
 		HEAD_TEXT
 		_text = .;
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text .text.* .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index b5fc6cb..59c9097 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -2,6 +2,7 @@ config PPC64
 	bool "64-bit kernel"
 	default n
 	select THIN_ARCHIVES
+	select LD_DEAD_CODE_DATA_ELIMINATION
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
-- 
2.8.1
