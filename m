From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/5] powerpc/64: use linker dce
Date: Fri,  5 Aug 2016 22:12:03 +1000
Message-ID: <1470399123-8455-6-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33069 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161250AbcHEMNH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2016 08:13:07 -0400
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

---
 arch/powerpc/kernel/Makefile           | 3 +++
 arch/powerpc/kernel/vmlinux.lds.S      | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..b356e59 100644
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
index 2dd91f7..c157b8d 100644
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
index 3c77091..6afeb9d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -3,6 +3,7 @@ config PPC64
 	default n
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select THIN_ARCHIVES
+	select LINKER_DCE
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
-- 
2.8.1
