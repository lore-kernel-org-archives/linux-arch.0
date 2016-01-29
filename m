From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 07/12] arm: move exports to definitions
Date: Fri, 29 Jan 2016 19:18:29 +0000
Message-ID: <1454095114-4128-7-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/include/asm/Kbuild           |   1 +
 arch/arm/kernel/Makefile              |   2 +-
 arch/arm/kernel/armksyms.c            | 183 ----------------------------------
 arch/arm/kernel/entry-ftrace.S        |   3 +
 arch/arm/kernel/head.S                |   3 +
 arch/arm/kernel/smccc-call.S          |   3 +
 arch/arm/lib/ashldi3.S                |   3 +
 arch/arm/lib/ashrdi3.S                |   3 +
 arch/arm/lib/bitops.h                 |   5 +
 arch/arm/lib/bswapsdi2.S              |   3 +
 arch/arm/lib/clear_user.S             |   4 +
 arch/arm/lib/copy_from_user.S         |   2 +
 arch/arm/lib/copy_page.S              |   2 +
 arch/arm/lib/copy_to_user.S           |   4 +
 arch/arm/lib/csumipv6.S               |   3 +-
 arch/arm/lib/csumpartial.S            |   2 +
 arch/arm/lib/csumpartialcopy.S        |   1 +
 arch/arm/lib/csumpartialcopygeneric.S |   2 +
 arch/arm/lib/csumpartialcopyuser.S    |   1 +
 arch/arm/lib/delay.c                  |   2 +
 arch/arm/lib/div64.S                  |   2 +
 arch/arm/lib/findbit.S                |   9 ++
 arch/arm/lib/getuser.S                |   9 ++
 arch/arm/lib/io-readsb.S              |   2 +
 arch/arm/lib/io-readsl.S              |   2 +
 arch/arm/lib/io-readsw-armv3.S        |   3 +-
 arch/arm/lib/io-readsw-armv4.S        |   2 +
 arch/arm/lib/io-writesb.S             |   2 +
 arch/arm/lib/io-writesl.S             |   2 +
 arch/arm/lib/io-writesw-armv3.S       |   2 +
 arch/arm/lib/io-writesw-armv4.S       |   2 +
 arch/arm/lib/lib1funcs.S              |   9 ++
 arch/arm/lib/lshrdi3.S                |   3 +
 arch/arm/lib/memchr.S                 |   2 +
 arch/arm/lib/memcpy.S                 |   3 +
 arch/arm/lib/memmove.S                |   2 +
 arch/arm/lib/memset.S                 |   3 +
 arch/arm/lib/memzero.S                |   2 +
 arch/arm/lib/muldi3.S                 |   3 +
 arch/arm/lib/putuser.S                |   5 +
 arch/arm/lib/strchr.S                 |   2 +
 arch/arm/lib/strrchr.S                |   2 +
 arch/arm/lib/uaccess_with_memcpy.c    |   3 +
 arch/arm/lib/ucmpdi2.S                |   3 +
 arch/arm/mach-imx/Makefile            |   1 -
 arch/arm/mach-imx/ssi-fiq-ksym.c      |  20 ----
 arch/arm/mach-imx/ssi-fiq.S           |   7 +-
 47 files changed, 131 insertions(+), 208 deletions(-)
 delete mode 100644 arch/arm/kernel/armksyms.c
 delete mode 100644 arch/arm/mach-imx/ssi-fiq-ksym.c

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 16da638..f4b6dd5 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -7,6 +7,7 @@ generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
+generic-y += export.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 2c5f160..69b0c57 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -33,7 +33,7 @@ endif
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
-obj-$(CONFIG_MODULES)		+= armksyms.o module.o
+obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_ARM_MODULE_PLTS)	+= module-plts.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
deleted file mode 100644
index 7e45f69..0000000
--- a/arch/arm/kernel/armksyms.c
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- *  linux/arch/arm/kernel/armksyms.c
- *
- *  Copyright (C) 2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/cryptohash.h>
-#include <linux/delay.h>
-#include <linux/in6.h>
-#include <linux/syscalls.h>
-#include <linux/uaccess.h>
-#include <linux/io.h>
-#include <linux/arm-smccc.h>
-
-#include <asm/checksum.h>
-#include <asm/ftrace.h>
-
-/*
- * libgcc functions - functions that are used internally by the
- * compiler...  (prototypes are not correct though, but that
- * doesn't really matter since they're not versioned).
- */
-extern void __ashldi3(void);
-extern void __ashrdi3(void);
-extern void __divsi3(void);
-extern void __lshrdi3(void);
-extern void __modsi3(void);
-extern void __muldi3(void);
-extern void __ucmpdi2(void);
-extern void __udivsi3(void);
-extern void __umodsi3(void);
-extern void __do_div64(void);
-extern void __bswapsi2(void);
-extern void __bswapdi2(void);
-
-extern void __aeabi_idiv(void);
-extern void __aeabi_idivmod(void);
-extern void __aeabi_lasr(void);
-extern void __aeabi_llsl(void);
-extern void __aeabi_llsr(void);
-extern void __aeabi_lmul(void);
-extern void __aeabi_uidiv(void);
-extern void __aeabi_uidivmod(void);
-extern void __aeabi_ulcmp(void);
-
-extern void fpundefinstr(void);
-
-void mmioset(void *, unsigned int, size_t);
-void mmiocpy(void *, const void *, size_t);
-
-	/* platform dependent support */
-EXPORT_SYMBOL(arm_delay_ops);
-
-	/* networking */
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_from_user);
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
-EXPORT_SYMBOL(__csum_ipv6_magic);
-
-	/* io */
-#ifndef __raw_readsb
-EXPORT_SYMBOL(__raw_readsb);
-#endif
-#ifndef __raw_readsw
-EXPORT_SYMBOL(__raw_readsw);
-#endif
-#ifndef __raw_readsl
-EXPORT_SYMBOL(__raw_readsl);
-#endif
-#ifndef __raw_writesb
-EXPORT_SYMBOL(__raw_writesb);
-#endif
-#ifndef __raw_writesw
-EXPORT_SYMBOL(__raw_writesw);
-#endif
-#ifndef __raw_writesl
-EXPORT_SYMBOL(__raw_writesl);
-#endif
-
-	/* string / mem functions */
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memchr);
-EXPORT_SYMBOL(__memzero);
-
-EXPORT_SYMBOL(mmioset);
-EXPORT_SYMBOL(mmiocpy);
-
-#ifdef CONFIG_MMU
-EXPORT_SYMBOL(copy_page);
-
-EXPORT_SYMBOL(arm_copy_from_user);
-EXPORT_SYMBOL(arm_copy_to_user);
-EXPORT_SYMBOL(arm_clear_user);
-
-EXPORT_SYMBOL(__get_user_1);
-EXPORT_SYMBOL(__get_user_2);
-EXPORT_SYMBOL(__get_user_4);
-EXPORT_SYMBOL(__get_user_8);
-
-#ifdef __ARMEB__
-EXPORT_SYMBOL(__get_user_64t_1);
-EXPORT_SYMBOL(__get_user_64t_2);
-EXPORT_SYMBOL(__get_user_64t_4);
-EXPORT_SYMBOL(__get_user_32t_8);
-#endif
-
-EXPORT_SYMBOL(__put_user_1);
-EXPORT_SYMBOL(__put_user_2);
-EXPORT_SYMBOL(__put_user_4);
-EXPORT_SYMBOL(__put_user_8);
-#endif
-
-	/* gcc lib functions */
-EXPORT_SYMBOL(__ashldi3);
-EXPORT_SYMBOL(__ashrdi3);
-EXPORT_SYMBOL(__divsi3);
-EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(__modsi3);
-EXPORT_SYMBOL(__muldi3);
-EXPORT_SYMBOL(__ucmpdi2);
-EXPORT_SYMBOL(__udivsi3);
-EXPORT_SYMBOL(__umodsi3);
-EXPORT_SYMBOL(__do_div64);
-EXPORT_SYMBOL(__bswapsi2);
-EXPORT_SYMBOL(__bswapdi2);
-
-#ifdef CONFIG_AEABI
-EXPORT_SYMBOL(__aeabi_idiv);
-EXPORT_SYMBOL(__aeabi_idivmod);
-EXPORT_SYMBOL(__aeabi_lasr);
-EXPORT_SYMBOL(__aeabi_llsl);
-EXPORT_SYMBOL(__aeabi_llsr);
-EXPORT_SYMBOL(__aeabi_lmul);
-EXPORT_SYMBOL(__aeabi_uidiv);
-EXPORT_SYMBOL(__aeabi_uidivmod);
-EXPORT_SYMBOL(__aeabi_ulcmp);
-#endif
-
-	/* bitops */
-EXPORT_SYMBOL(_set_bit);
-EXPORT_SYMBOL(_test_and_set_bit);
-EXPORT_SYMBOL(_clear_bit);
-EXPORT_SYMBOL(_test_and_clear_bit);
-EXPORT_SYMBOL(_change_bit);
-EXPORT_SYMBOL(_test_and_change_bit);
-EXPORT_SYMBOL(_find_first_zero_bit_le);
-EXPORT_SYMBOL(_find_next_zero_bit_le);
-EXPORT_SYMBOL(_find_first_bit_le);
-EXPORT_SYMBOL(_find_next_bit_le);
-
-#ifdef __ARMEB__
-EXPORT_SYMBOL(_find_first_zero_bit_be);
-EXPORT_SYMBOL(_find_next_zero_bit_be);
-EXPORT_SYMBOL(_find_first_bit_be);
-EXPORT_SYMBOL(_find_next_bit_be);
-#endif
-
-#ifdef CONFIG_FUNCTION_TRACER
-#ifdef CONFIG_OLD_MCOUNT
-EXPORT_SYMBOL(mcount);
-#endif
-EXPORT_SYMBOL(__gnu_mcount_nc);
-#endif
-
-#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
-EXPORT_SYMBOL(__pv_phys_pfn_offset);
-EXPORT_SYMBOL(__pv_offset);
-#endif
-
-#ifdef CONFIG_HAVE_ARM_SMCCC
-EXPORT_SYMBOL(arm_smccc_smc);
-EXPORT_SYMBOL(arm_smccc_hvc);
-#endif
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index c73c403..b629d3f 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -7,6 +7,7 @@
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #include "entry-header.S"
 
@@ -153,6 +154,7 @@ ENTRY(mcount)
 	__mcount _old
 #endif
 ENDPROC(mcount)
+EXPORT_SYMBOL(mcount)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(ftrace_caller_old)
@@ -205,6 +207,7 @@ UNWIND(.fnstart)
 #endif
 UNWIND(.fnend)
 ENDPROC(__gnu_mcount_nc)
+EXPORT_SYMBOL(__gnu_mcount_nc)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 ENTRY(ftrace_caller)
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 04286fd..f41cee4 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -22,6 +22,7 @@
 #include <asm/memory.h>
 #include <asm/thread_info.h>
 #include <asm/pgtable.h>
+#include <asm/export.h>
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_SEMIHOSTING)
 #include CONFIG_DEBUG_LL_INCLUDE
@@ -727,6 +728,8 @@ __pv_phys_pfn_offset:
 __pv_offset:
 	.quad	0
 	.size	__pv_offset, . -__pv_offset
+EXPORT_SYMBOL(__pv_phys_pfn_offset)
+EXPORT_SYMBOL(__pv_offset)
 #endif
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 2e48b67..37669e7 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -16,6 +16,7 @@
 #include <asm/opcodes-sec.h>
 #include <asm/opcodes-virt.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 	/*
 	 * Wrap c macros in asm macros to delay expansion until after the
@@ -51,6 +52,7 @@ UNWIND(	.fnend)
 ENTRY(arm_smccc_smc)
 	SMCCC SMCCC_SMC
 ENDPROC(arm_smccc_smc)
+EXPORT_SYMBOL(arm_smccc_smc)
 
 /*
  * void smccc_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
@@ -60,3 +62,4 @@ ENDPROC(arm_smccc_smc)
 ENTRY(arm_smccc_hvc)
 	SMCCC SMCCC_HVC
 ENDPROC(arm_smccc_hvc)
+EXPORT_SYMBOL(arm_smccc_hvc)
diff --git a/arch/arm/lib/ashldi3.S b/arch/arm/lib/ashldi3.S
index b05e958..a7e7de8 100644
--- a/arch/arm/lib/ashldi3.S
+++ b/arch/arm/lib/ashldi3.S
@@ -28,6 +28,7 @@ Boston, MA 02110-1301, USA.  */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define al r1
@@ -52,3 +53,5 @@ ENTRY(__aeabi_llsl)
 
 ENDPROC(__ashldi3)
 ENDPROC(__aeabi_llsl)
+EXPORT_SYMBOL(__ashldi3)
+EXPORT_SYMBOL(__aeabi_llsl)
diff --git a/arch/arm/lib/ashrdi3.S b/arch/arm/lib/ashrdi3.S
index 275d7d2..490336e 100644
--- a/arch/arm/lib/ashrdi3.S
+++ b/arch/arm/lib/ashrdi3.S
@@ -28,6 +28,7 @@ Boston, MA 02110-1301, USA.  */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define al r1
@@ -52,3 +53,5 @@ ENTRY(__aeabi_lasr)
 
 ENDPROC(__ashrdi3)
 ENDPROC(__aeabi_lasr)
+EXPORT_SYMBOL(__ashrdi3)
+EXPORT_SYMBOL(__aeabi_lasr)
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index 7d807cf..df06638 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -1,5 +1,6 @@
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
@@ -25,6 +26,7 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
+EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
@@ -55,6 +57,7 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
+EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -74,6 +77,7 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
+EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -102,5 +106,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
+EXPORT_SYMBOL(\name	)
 	.endm
 #endif
diff --git a/arch/arm/lib/bswapsdi2.S b/arch/arm/lib/bswapsdi2.S
index 07cda73..f05f782 100644
--- a/arch/arm/lib/bswapsdi2.S
+++ b/arch/arm/lib/bswapsdi2.S
@@ -1,5 +1,6 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #if __LINUX_ARM_ARCH__ >= 6
 ENTRY(__bswapsi2)
@@ -35,3 +36,5 @@ ENTRY(__bswapdi2)
 	ret lr
 ENDPROC(__bswapdi2)
 #endif
+EXPORT_SYMBOL(__bswapsi2)
+EXPORT_SYMBOL(__bswapdi2)
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index e936352..b566154 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 		.text
 
@@ -50,6 +51,9 @@ USER(		strnebt	r2, [r0])
 UNWIND(.fnend)
 ENDPROC(arm_clear_user)
 ENDPROC(__clear_user_std)
+#ifndef CONFIG_UACCESS_WITH_MEMCPY
+EXPORT_SYMBOL(arm_clear_user)
+#endif
 
 		.pushsection .text.fixup,"ax"
 		.align	0
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 1512beb..f549c57 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 /*
  * Prototype:
@@ -94,6 +95,7 @@ ENTRY(arm_copy_from_user)
 #include "copy_template.S"
 
 ENDPROC(arm_copy_from_user)
+EXPORT_SYMBOL(arm_copy_from_user)
 
 	.pushsection .fixup,"ax"
 	.align 0
diff --git a/arch/arm/lib/copy_page.S b/arch/arm/lib/copy_page.S
index 6ee2f67..d97851d 100644
--- a/arch/arm/lib/copy_page.S
+++ b/arch/arm/lib/copy_page.S
@@ -13,6 +13,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
+#include <asm/export.h>
 
 #define COPY_COUNT (PAGE_SZ / (2 * L1_CACHE_BYTES) PLD( -1 ))
 
@@ -45,3 +46,4 @@ ENTRY(copy_page)
 	PLD(	beq	2b			)
 		ldmfd	sp!, {r4, pc}			@	3
 ENDPROC(copy_page)
+EXPORT_SYMBOL(copy_page)
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index caf5019..592c179 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 /*
  * Prototype:
@@ -99,6 +100,9 @@ WEAK(arm_copy_to_user)
 
 ENDPROC(arm_copy_to_user)
 ENDPROC(__copy_to_user_std)
+#ifndef CONFIG_UACCESS_WITH_MEMCPY
+EXPORT_SYMBOL(arm_copy_to_user)
+#endif
 
 	.pushsection .text.fixup,"ax"
 	.align 0
diff --git a/arch/arm/lib/csumipv6.S b/arch/arm/lib/csumipv6.S
index 3ac6ef0..68603b5 100644
--- a/arch/arm/lib/csumipv6.S
+++ b/arch/arm/lib/csumipv6.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.text
 
@@ -30,4 +31,4 @@ ENTRY(__csum_ipv6_magic)
 		adcs	r0, r0, #0
 		ldmfd	sp!, {pc}
 ENDPROC(__csum_ipv6_magic)
-
+EXPORT_SYMBOL(__csum_ipv6_magic)
diff --git a/arch/arm/lib/csumpartial.S b/arch/arm/lib/csumpartial.S
index 984e0f2..830b20e 100644
--- a/arch/arm/lib/csumpartial.S
+++ b/arch/arm/lib/csumpartial.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.text
 
@@ -140,3 +141,4 @@ ENTRY(csum_partial)
 		bne	4b
 		b	.Lless4
 ENDPROC(csum_partial)
+EXPORT_SYMBOL(csum_partial)
diff --git a/arch/arm/lib/csumpartialcopy.S b/arch/arm/lib/csumpartialcopy.S
index d03fc71..9c3383f 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -49,5 +49,6 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_nocheck)
 #define FN_EXIT		ENDPROC(csum_partial_copy_nocheck)
+#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_nocheck)
 
 #include "csumpartialcopygeneric.S"
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 10b4590..8b94d20 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * unsigned int
@@ -331,3 +332,4 @@ FN_ENTRY
 		mov	r5, r4, get_byte_1
 		b	.Lexit
 FN_EXIT
+FN_EXPORT
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1712f13..5d495ed 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -73,6 +73,7 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
 #define FN_EXIT		ENDPROC(csum_partial_copy_from_user)
+#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_from_user)
 
 #include "csumpartialcopygeneric.S"
 
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 8044591..e60ce15 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -24,6 +24,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/export.h>
 #include <linux/timex.h>
 
 /*
@@ -34,6 +35,7 @@ struct arm_delay_ops arm_delay_ops = {
 	.const_udelay	= __loop_const_udelay,
 	.udelay		= __loop_udelay,
 };
+EXPORT_SYMBOL(arm_delay_ops);
 
 static const struct delay_timer *delay_timer;
 static bool delay_calibrated;
diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
index a9eafe4..0c9e1c18 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -15,6 +15,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define xh r0
@@ -210,3 +211,4 @@ Ldiv0_64:
 
 UNWIND(.fnend)
 ENDPROC(__do_div64)
+EXPORT_SYMBOL(__do_div64)
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 7848780..26302b8 100644
--- a/arch/arm/lib/findbit.S
+++ b/arch/arm/lib/findbit.S
@@ -15,6 +15,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
                 .text
 
 /*
@@ -37,6 +38,7 @@ ENTRY(_find_first_zero_bit_le)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_zero_bit_le)
+EXPORT_SYMBOL(_find_first_zero_bit_le)
 
 /*
  * Purpose  : Find next 'zero' bit
@@ -57,6 +59,7 @@ ENTRY(_find_next_zero_bit_le)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_zero_bit_le)
+EXPORT_SYMBOL(_find_next_zero_bit_le)
 
 /*
  * Purpose  : Find a 'one' bit
@@ -78,6 +81,7 @@ ENTRY(_find_first_bit_le)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_bit_le)
+EXPORT_SYMBOL(_find_first_bit_le)
 
 /*
  * Purpose  : Find next 'one' bit
@@ -97,6 +101,7 @@ ENTRY(_find_next_bit_le)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_bit_le)
+EXPORT_SYMBOL(_find_next_bit_le)
 
 #ifdef __ARMEB__
 
@@ -116,6 +121,7 @@ ENTRY(_find_first_zero_bit_be)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_zero_bit_be)
+EXPORT_SYMBOL(_find_first_zero_bit_be)
 
 ENTRY(_find_next_zero_bit_be)
 		teq	r1, #0
@@ -133,6 +139,7 @@ ENTRY(_find_next_zero_bit_be)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_zero_bit_be)
+EXPORT_SYMBOL(_find_next_zero_bit_be)
 
 ENTRY(_find_first_bit_be)
 		teq	r1, #0
@@ -150,6 +157,7 @@ ENTRY(_find_first_bit_be)
 3:		mov	r0, r1			@ no free bits
 		ret	lr
 ENDPROC(_find_first_bit_be)
+EXPORT_SYMBOL(_find_first_bit_be)
 
 ENTRY(_find_next_bit_be)
 		teq	r1, #0
@@ -166,6 +174,7 @@ ENTRY(_find_next_bit_be)
 		add	r2, r2, #1		@ align bit pointer
 		b	2b			@ loop for next bit
 ENDPROC(_find_next_bit_be)
+EXPORT_SYMBOL(_find_next_bit_be)
 
 #endif
 
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index 8ecfd15..9d09a38 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -31,6 +31,7 @@
 #include <asm/assembler.h>
 #include <asm/errno.h>
 #include <asm/domain.h>
+#include <asm/export.h>
 
 ENTRY(__get_user_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad
@@ -38,6 +39,7 @@ ENTRY(__get_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_1)
+EXPORT_SYMBOL(__get_user_1)
 
 ENTRY(__get_user_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad
@@ -58,6 +60,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_2)
+EXPORT_SYMBOL(__get_user_2)
 
 ENTRY(__get_user_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad
@@ -65,6 +68,7 @@ ENTRY(__get_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_4)
+EXPORT_SYMBOL(__get_user_4)
 
 ENTRY(__get_user_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad
@@ -78,6 +82,7 @@ ENTRY(__get_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_8)
+EXPORT_SYMBOL(__get_user_8)
 
 #ifdef __ARMEB__
 ENTRY(__get_user_32t_8)
@@ -91,6 +96,7 @@ ENTRY(__get_user_32t_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_32t_8)
+EXPORT_SYMBOL(__get_user_32t_8)
 
 ENTRY(__get_user_64t_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad8
@@ -98,6 +104,7 @@ ENTRY(__get_user_64t_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_1)
+EXPORT_SYMBOL(__get_user_64t_1)
 
 ENTRY(__get_user_64t_2)
 	check_uaccess r0, 2, r1, r2, __get_user_bad8
@@ -114,6 +121,7 @@ rb	.req	r0
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_2)
+EXPORT_SYMBOL(__get_user_64t_2)
 
 ENTRY(__get_user_64t_4)
 	check_uaccess r0, 4, r1, r2, __get_user_bad8
@@ -121,6 +129,7 @@ ENTRY(__get_user_64t_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__get_user_64t_4)
+EXPORT_SYMBOL(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
diff --git a/arch/arm/lib/io-readsb.S b/arch/arm/lib/io-readsb.S
index c31b2f3..3dff7a3 100644
--- a/arch/arm/lib/io-readsb.S
+++ b/arch/arm/lib/io-readsb.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 .Linsb_align:	rsb	ip, ip, #4
 		cmp	ip, r2
@@ -121,3 +122,4 @@ ENTRY(__raw_readsb)
 
 		ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(__raw_readsb)
+EXPORT_SYMBOL(__raw_readsb)
diff --git a/arch/arm/lib/io-readsl.S b/arch/arm/lib/io-readsl.S
index 2ed86fa..bfd3968 100644
--- a/arch/arm/lib/io-readsl.S
+++ b/arch/arm/lib/io-readsl.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 ENTRY(__raw_readsl)
 		teq	r2, #0		@ do we have to check for the zero len?
@@ -77,3 +78,4 @@ ENTRY(__raw_readsl)
 		strb	r3, [r1, #0]
 		ret	lr
 ENDPROC(__raw_readsl)
+EXPORT_SYMBOL(__raw_readsl)
diff --git a/arch/arm/lib/io-readsw-armv3.S b/arch/arm/lib/io-readsw-armv3.S
index 413da99..b3af3db 100644
--- a/arch/arm/lib/io-readsw-armv3.S
+++ b/arch/arm/lib/io-readsw-armv3.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 .Linsw_bad_alignment:
 		adr	r0, .Linsw_bad_align_msg
@@ -103,4 +104,4 @@ ENTRY(__raw_readsw)
 
 		ldmfd	sp!, {r4, r5, r6, pc}
 
-
+EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-readsw-armv4.S b/arch/arm/lib/io-readsw-armv4.S
index d9a45e9..3c7a7a4 100644
--- a/arch/arm/lib/io-readsw-armv4.S
+++ b/arch/arm/lib/io-readsw-armv4.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.macro	pack, rd, hw1, hw2
 #ifndef __ARMEB__
@@ -129,3 +130,4 @@ ENTRY(__raw_readsw)
 		strneb	ip, [r1]
 		ldmfd	sp!, {r4, pc}
 ENDPROC(__raw_readsw)
+EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-writesb.S b/arch/arm/lib/io-writesb.S
index a46bbc9..fa36335 100644
--- a/arch/arm/lib/io-writesb.S
+++ b/arch/arm/lib/io-writesb.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.macro	outword, rd
 #ifndef __ARMEB__
@@ -92,3 +93,4 @@ ENTRY(__raw_writesb)
 
 		ldmfd	sp!, {r4, r5, pc}
 ENDPROC(__raw_writesb)
+EXPORT_SYMBOL(__raw_writesb)
diff --git a/arch/arm/lib/io-writesl.S b/arch/arm/lib/io-writesl.S
index 4ea2435..98ed6ae 100644
--- a/arch/arm/lib/io-writesl.S
+++ b/arch/arm/lib/io-writesl.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 ENTRY(__raw_writesl)
 		teq	r2, #0		@ do we have to check for the zero len?
@@ -65,3 +66,4 @@ ENTRY(__raw_writesl)
 		bne	6b
 		ret	lr
 ENDPROC(__raw_writesl)
+EXPORT_SYMBOL(__raw_writesl)
diff --git a/arch/arm/lib/io-writesw-armv3.S b/arch/arm/lib/io-writesw-armv3.S
index 121789e..577184c 100644
--- a/arch/arm/lib/io-writesw-armv3.S
+++ b/arch/arm/lib/io-writesw-armv3.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 .Loutsw_bad_alignment:
 		adr	r0, .Loutsw_bad_align_msg
@@ -124,3 +125,4 @@ ENTRY(__raw_writesw)
 		strne	ip, [r0]
 
 		ldmfd	sp!, {r4, r5, r6, pc}
+EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/io-writesw-armv4.S b/arch/arm/lib/io-writesw-armv4.S
index 269f90c..e335f48 100644
--- a/arch/arm/lib/io-writesw-armv4.S
+++ b/arch/arm/lib/io-writesw-armv4.S
@@ -9,6 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.macro	outword, rd
 #ifndef __ARMEB__
@@ -98,3 +99,4 @@ ENTRY(__raw_writesw)
 		strneh	ip, [r0]
 		ret	lr
 ENDPROC(__raw_writesw)
+EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index 9397b2e..f541bc0 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -36,6 +36,7 @@ Boston, MA 02111-1307, USA.  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 .macro ARM_DIV_BODY dividend, divisor, result, curbit
 
@@ -238,6 +239,8 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__udivsi3)
 ENDPROC(__aeabi_uidiv)
+EXPORT_SYMBOL(__udivsi3)
+EXPORT_SYMBOL(__aeabi_uidiv)
 
 ENTRY(__umodsi3)
 UNWIND(.fnstart)
@@ -256,6 +259,7 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__umodsi3)
+EXPORT_SYMBOL(__umodsi3)
 
 #ifdef CONFIG_ARM_PATCH_IDIV
 	.align 3
@@ -303,6 +307,8 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__divsi3)
 ENDPROC(__aeabi_idiv)
+EXPORT_SYMBOL(__divsi3)
+EXPORT_SYMBOL(__aeabi_idiv)
 
 ENTRY(__modsi3)
 UNWIND(.fnstart)
@@ -327,6 +333,7 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__modsi3)
+EXPORT_SYMBOL(__modsi3)
 
 #ifdef CONFIG_AEABI
 
@@ -343,6 +350,7 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_uidivmod)
+EXPORT_SYMBOL(__aeabi_uidivmod)
 
 ENTRY(__aeabi_idivmod)
 UNWIND(.fnstart)
@@ -356,6 +364,7 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_idivmod)
+EXPORT_SYMBOL(__aeabi_idivmod)
 
 #endif
 
diff --git a/arch/arm/lib/lshrdi3.S b/arch/arm/lib/lshrdi3.S
index 922dcd8..e408339 100644
--- a/arch/arm/lib/lshrdi3.S
+++ b/arch/arm/lib/lshrdi3.S
@@ -28,6 +28,7 @@ Boston, MA 02110-1301, USA.  */
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define al r1
@@ -52,3 +53,5 @@ ENTRY(__aeabi_llsr)
 
 ENDPROC(__lshrdi3)
 ENDPROC(__aeabi_llsr)
+EXPORT_SYMBOL(__lshrdi3)
+EXPORT_SYMBOL(__aeabi_llsr)
diff --git a/arch/arm/lib/memchr.S b/arch/arm/lib/memchr.S
index 74a5bed..44182bf 100644
--- a/arch/arm/lib/memchr.S
+++ b/arch/arm/lib/memchr.S
@@ -11,6 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 	.text
 	.align	5
@@ -24,3 +25,4 @@ ENTRY(memchr)
 2:	movne	r0, #0
 	ret	lr
 ENDPROC(memchr)
+EXPORT_SYMBOL(memchr)
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 64111bd..1be5b6d 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #define LDR1W_SHIFT	0
 #define STR1W_SHIFT	0
@@ -68,3 +69,5 @@ ENTRY(memcpy)
 
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
+EXPORT_SYMBOL(memcpy)
+EXPORT_SYMBOL(mmiocpy)
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 69a9d47..71dcc54 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 		.text
 
@@ -225,3 +226,4 @@ ENTRY(memmove)
 18:		backward_copy_shift	push=24	pull=8
 
 ENDPROC(memmove)
+EXPORT_SYMBOL(memmove)
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 3c65e3b..7b72044 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 	.text
 	.align	5
@@ -135,3 +136,5 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+EXPORT_SYMBOL(memset)
+EXPORT_SYMBOL(mmioset)
diff --git a/arch/arm/lib/memzero.S b/arch/arm/lib/memzero.S
index 0eded95..6dec26e 100644
--- a/arch/arm/lib/memzero.S
+++ b/arch/arm/lib/memzero.S
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 	.text
 	.align	5
@@ -135,3 +136,4 @@ UNWIND(	.fnstart			)
 	ret	lr			@ 1
 UNWIND(	.fnend				)
 ENDPROC(__memzero)
+EXPORT_SYMBOL(__memzero)
diff --git a/arch/arm/lib/muldi3.S b/arch/arm/lib/muldi3.S
index 2043059..b8f1238 100644
--- a/arch/arm/lib/muldi3.S
+++ b/arch/arm/lib/muldi3.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define xh r0
@@ -46,3 +47,5 @@ ENTRY(__aeabi_lmul)
 
 ENDPROC(__muldi3)
 ENDPROC(__aeabi_lmul)
+EXPORT_SYMBOL(__muldi3)
+EXPORT_SYMBOL(__aeabi_lmul)
diff --git a/arch/arm/lib/putuser.S b/arch/arm/lib/putuser.S
index 38d660d..11de126 100644
--- a/arch/arm/lib/putuser.S
+++ b/arch/arm/lib/putuser.S
@@ -31,6 +31,7 @@
 #include <asm/assembler.h>
 #include <asm/errno.h>
 #include <asm/domain.h>
+#include <asm/export.h>
 
 ENTRY(__put_user_1)
 	check_uaccess r0, 1, r1, ip, __put_user_bad
@@ -38,6 +39,7 @@ ENTRY(__put_user_1)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_1)
+EXPORT_SYMBOL(__put_user_1)
 
 ENTRY(__put_user_2)
 	check_uaccess r0, 2, r1, ip, __put_user_bad
@@ -62,6 +64,7 @@ ENTRY(__put_user_2)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_2)
+EXPORT_SYMBOL(__put_user_2)
 
 ENTRY(__put_user_4)
 	check_uaccess r0, 4, r1, ip, __put_user_bad
@@ -69,6 +72,7 @@ ENTRY(__put_user_4)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_4)
+EXPORT_SYMBOL(__put_user_4)
 
 ENTRY(__put_user_8)
 	check_uaccess r0, 8, r1, ip, __put_user_bad
@@ -82,6 +86,7 @@ ENTRY(__put_user_8)
 	mov	r0, #0
 	ret	lr
 ENDPROC(__put_user_8)
+EXPORT_SYMBOL(__put_user_8)
 
 __put_user_bad:
 	mov	r0, #-EFAULT
diff --git a/arch/arm/lib/strchr.S b/arch/arm/lib/strchr.S
index 013d64c..7301f6e 100644
--- a/arch/arm/lib/strchr.S
+++ b/arch/arm/lib/strchr.S
@@ -11,6 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.text
 		.align	5
@@ -25,3 +26,4 @@ ENTRY(strchr)
 		subeq	r0, r0, #1
 		ret	lr
 ENDPROC(strchr)
+EXPORT_SYMBOL(strchr)
diff --git a/arch/arm/lib/strrchr.S b/arch/arm/lib/strrchr.S
index 3cec1c7..aaf9fd9 100644
--- a/arch/arm/lib/strrchr.S
+++ b/arch/arm/lib/strrchr.S
@@ -11,6 +11,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 		.text
 		.align	5
@@ -24,3 +25,4 @@ ENTRY(strrchr)
 		mov	r0, r3
 		ret	lr
 ENDPROC(strrchr)
+EXPORT_SYMBOL(strrchr)
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 6bd1089..1626e3a 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -19,6 +19,7 @@
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
+#include <linux/export.h>
 #include <asm/current.h>
 #include <asm/page.h>
 
@@ -156,6 +157,7 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 	}
 	return n;
 }
+EXPORT_SYMBOL(arm_copy_to_user);
 	
 static unsigned long noinline
 __clear_user_memset(void __user *addr, unsigned long n)
@@ -213,6 +215,7 @@ unsigned long arm_clear_user(void __user *addr, unsigned long n)
 	}
 	return n;
 }
+EXPORT_SYMBOL(arm_clear_user);
 
 #if 0
 
diff --git a/arch/arm/lib/ucmpdi2.S b/arch/arm/lib/ucmpdi2.S
index ad4a630..127a91a 100644
--- a/arch/arm/lib/ucmpdi2.S
+++ b/arch/arm/lib/ucmpdi2.S
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define xh r0
@@ -35,6 +36,7 @@ ENTRY(__ucmpdi2)
 	ret	lr
 
 ENDPROC(__ucmpdi2)
+EXPORT_SYMBOL(__ucmpdi2)
 
 #ifdef CONFIG_AEABI
 
@@ -48,6 +50,7 @@ ENTRY(__aeabi_ulcmp)
 	ret	lr
 
 ENDPROC(__aeabi_ulcmp)
+EXPORT_SYMBOL(__aeabi_ulcmp)
 
 #endif
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index fb689d8..c4e3317 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -32,7 +32,6 @@ endif
 
 ifdef CONFIG_SND_IMX_SOC
 obj-y += ssi-fiq.o
-obj-y += ssi-fiq-ksym.o
 endif
 
 # i.MX1 based machines
diff --git a/arch/arm/mach-imx/ssi-fiq-ksym.c b/arch/arm/mach-imx/ssi-fiq-ksym.c
deleted file mode 100644
index 792090f..0000000
--- a/arch/arm/mach-imx/ssi-fiq-ksym.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Exported ksyms for the SSI FIQ handler
- *
- * Copyright (C) 2009, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-
-#include <linux/platform_data/asoc-imx-ssi.h>
-
-EXPORT_SYMBOL(imx_ssi_fiq_tx_buffer);
-EXPORT_SYMBOL(imx_ssi_fiq_rx_buffer);
-EXPORT_SYMBOL(imx_ssi_fiq_start);
-EXPORT_SYMBOL(imx_ssi_fiq_end);
-EXPORT_SYMBOL(imx_ssi_fiq_base);
-
diff --git a/arch/arm/mach-imx/ssi-fiq.S b/arch/arm/mach-imx/ssi-fiq.S
index a8b93c5..fd7917f 100644
--- a/arch/arm/mach-imx/ssi-fiq.S
+++ b/arch/arm/mach-imx/ssi-fiq.S
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * r8  = bit 0-15: tx offset, bit 16-31: tx buffer size
@@ -144,4 +145,8 @@ imx_ssi_fiq_tx_buffer:
 		.word 0x0
 .L_imx_ssi_fiq_end:
 imx_ssi_fiq_end:
-
+EXPORT_SYMBOL(imx_ssi_fiq_tx_buffer)
+EXPORT_SYMBOL(imx_ssi_fiq_rx_buffer)
+EXPORT_SYMBOL(imx_ssi_fiq_start)
+EXPORT_SYMBOL(imx_ssi_fiq_end)
+EXPORT_SYMBOL(imx_ssi_fiq_base)
-- 
2.1.4
