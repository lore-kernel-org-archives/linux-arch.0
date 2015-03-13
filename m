From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 8/8] kallsyms: allow kallsyms data to reside in the .data section
Date: Fri, 13 Mar 2015 13:07:32 +0100
Message-ID: <1426248452-4773-9-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37889 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbbCMMIF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Mar 2015 08:08:05 -0400
Received: by widex7 with SMTP id ex7so5594830wid.3
        for <linux-arch@vger.kernel.org>; Fri, 13 Mar 2015 05:08:04 -0700 (PDT)
In-Reply-To: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, linux@arm.linux.org.uk, nico@linaro.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>

On architectures such as ARM, the default location of the kallsyms
data in the rodata section may be problematic, as it then sits right
between the .text and .init.text/.exit.text sections. This is usually
not a problem, but as soon as the code size exceeds a certain threshold,
the linker will start adding trampolines to ensure the two code regions
can reach each other through ordinary relative branches. This causes
inconsistencies between subsequent versions of the kallsyms data,
causing the build to fail.

This adds a Kconfig symbol that, when set, causes the kallsyms data
regions to be moved to the .data section instead, which works around
this problem.

Cc: linux-arch@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/Kconfig                  |  1 +
 include/asm-generic/vmlinux.lds.h | 12 +++++++++++-
 init/Kconfig                      |  4 ++++
 scripts/kallsyms.c                |  2 +-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a2bc9b..639e215bd9a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_HAVE_KALLSYMS_IN_DATA_SECTION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 463231d5bfc7..09f93bfaad0e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -150,6 +150,14 @@
 #define TRACE_SYSCALLS()
 #endif
 
+#ifdef	CONFIG_ARCH_HAVE_KALLSYMS_IN_DATA_SECTION
+#define	KALLSYMS_RODATA
+#define	KALLSYMS_DATA		*(.kallsyms_data)
+#else
+#define	KALLSYMS_RODATA		*(.kallsyms_data)
+#define	KALLSYMS_DATA
+#endif
+
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
 #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
@@ -197,7 +205,8 @@
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KALLSYMS_DATA
 
 /*
  * Data section helpers
@@ -234,6 +243,7 @@
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
+		KALLSYMS_RODATA						\
 		*(__vermagic)		/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
diff --git a/init/Kconfig b/init/Kconfig
index 058e3671fa11..d6f4920f3487 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1410,6 +1410,10 @@ config KALLSYMS_ALL
 
 	   Say N unless you really need all symbols.
 
+config ARCH_HAVE_KALLSYMS_IN_DATA_SECTION
+	bool
+	depends on KALLSYMS
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index c6d33bd15b04..b23682a967e0 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -333,7 +333,7 @@ static void write_src(void)
 	printf("#define ALGN .align 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	printf("\t.section .kallsyms_data, \"a\"\n");
 
 	/* Provide proper symbols relocatability by their '_text'
 	 * relativeness.  The symbol names cannot be used to construct
-- 
1.8.3.2
