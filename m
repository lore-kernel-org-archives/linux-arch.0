From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Wed, 23 Nov 2016 10:36:40 +0000
Message-ID: <20161123103640.GC14217@n2100.armlinux.org.uk>
References: <20161122110557.1533467-1-arnd@arndb.de>
 <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
 <20161123120436.18dc21e7@roar.ozlabs.ibm.com>
 <alpine.LFD.2.20.1611222030050.1814@knanqh.ubzr>
 <20161123093332.GB14217@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161123093332.GB14217@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, regressions@leemhuis.info, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 23, 2016 at 09:33:32AM +0000, Russell King - ARM Linux wrote:
> I don't see it makes any difference - the armksyms.c originally had
> the same:
> 
> -#include <linux/export.h>
> -#include <linux/sched.h>
> -#include <linux/string.h>
> -#include <linux/cryptohash.h>
> -#include <linux/delay.h>
> -#include <linux/in6.h>
> -#include <linux/syscalls.h>
> -#include <linux/uaccess.h>
> -#include <linux/io.h>
> -#include <linux/arm-smccc.h>
> -
> -#include <asm/checksum.h>
> -#include <asm/ftrace.h>
> 
> followed by prototypes for the GCC internal functions, and:
> 
> -extern void fpundefinstr(void);
> -
> -void mmioset(void *, unsigned int, size_t);
> -void mmiocpy(void *, const void *, size_t);
> 
> So, the asm-prototypes.h approach is just the same, only that we now
> have a bunch of prototypes in a header file, and the EXPORT_SYMBOL()s
> in the assembly files.
> 
> As the C prototypes are remote from the definitions, it means that
> the C prototypes are going to get forgotten about in exactly the same
> way that armksyms.c would've been forgotten about too.
> 
> It _is_ worse than that though - with the armksyms.c approach, if the
> assembly code for it is removed, you get a build error reminding you
> to remove the export (and prototype).  With this approach, you get no
> reminder to touch asm-prototypes.h.
> 
> It's also error prone for another reason - adding a new assembly level
> export, if you forget to add it to asm-prototypes.h, we're back into
> the problem we have right now with MODVERSIONS breaking.
> 
> So, I still think the whole approach is wrong - it's added extra
> fragility that wasn't there with the armksyms.c approach.

Here's what the diffstat and patch looks like when you combine the
original commit and the three fixes.  The LoC delta of 25 lines can
be accounted for as deleted commentry.  So, I think (as I've detailed
above) that the _technical_ benefit of the approach is very low.

If we want to move the exports into assembly files, I've no problem
with that, provided we can do it better than this - and by better I
mean not creating the fragile asm-prototypes.h which divorses the
prototypes from everything else.

Looking at _this_ patch, there's also an issue with the __raw_*
functions which are conditionally exported, which isn't taken account
of in these fixes.  We currently build most of the io-*.S files whether
we use them or not, and rely on the linker's archive processing, along
with the ifdefs in armksyms to omit them from the kernel image.  This
won't happen with this new approach.

So, I'm reverting the original commit today, because there's no clear
benefit, it's fragile, and I think there's still a few corner cases
that need to be fixed.  We can revisit when we have more time to
properly review and test these changes, rather than at what is now the
11th hour.

 arch/arm/include/asm/Kbuild           |   1 +
 arch/arm/include/asm/asm-prototypes.h |  34 +++++++
 arch/arm/kernel/Makefile              |   2 +-
 arch/arm/kernel/armksyms.c            | 183 ----------------------------------
 arch/arm/kernel/entry-ftrace.S        |   3 +
 arch/arm/kernel/head.S                |   3 +
 arch/arm/kernel/io.c                  |   7 ++
 arch/arm/kernel/smccc-call.S          |   3 +
 arch/arm/lib/ashldi3.S                |   3 +
 arch/arm/lib/ashrdi3.S                |   3 +
 arch/arm/lib/bswapsdi2.S              |   3 +
 arch/arm/lib/changebit.S              |   3 +
 arch/arm/lib/clear_user.S             |   4 +
 arch/arm/lib/clearbit.S               |   3 +
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
 arch/arm/lib/memcpy.S                 |   2 +
 arch/arm/lib/memmove.S                |   2 +
 arch/arm/lib/memset.S                 |   2 +
 arch/arm/lib/memzero.S                |   2 +
 arch/arm/lib/muldi3.S                 |   3 +
 arch/arm/lib/putuser.S                |   5 +
 arch/arm/lib/setbit.S                 |   3 +
 arch/arm/lib/strchr.S                 |   2 +
 arch/arm/lib/strrchr.S                |   2 +
 arch/arm/lib/testchangebit.S          |   3 +
 arch/arm/lib/testclearbit.S           |   3 +
 arch/arm/lib/testsetbit.S             |   3 +
 arch/arm/lib/uaccess_with_memcpy.c    |   3 +
 arch/arm/lib/ucmpdi2.S                |   3 +
 arch/arm/mach-imx/Makefile            |   1 -
 arch/arm/mach-imx/ssi-fiq-ksym.c      |  20 ----
 arch/arm/mach-imx/ssi-fiq.S           |   7 +-
 54 files changed, 183 insertions(+), 208 deletions(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 55e0e3ea9cb6..0745538b26d3 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += early_ioremap.h
 generic-y += emergency-restart.h
 generic-y += errno.h
 generic-y += exec.h
+generic-y += export.h
 generic-y += ioctl.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
diff --git a/arch/arm/include/asm/asm-prototypes.h b/arch/arm/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..04e5616a7b15
--- /dev/null
+++ b/arch/arm/include/asm/asm-prototypes.h
@@ -0,0 +1,34 @@
+#include <linux/arm-smccc.h>
+#include <linux/bitops.h>
+#include <linux/ftrace.h>
+#include <linux/io.h>
+#include <linux/platform_data/asoc-imx-ssi.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <asm/checksum.h>
+#include <asm/div64.h>
+#include <asm/memory.h>
+
+extern void __aeabi_idivmod(void);
+extern void __aeabi_idiv(void);
+extern void __aeabi_lasr(void);
+extern void __aeabi_llsl(void);
+extern void __aeabi_llsr(void);
+extern void __aeabi_lmul(void);
+extern void __aeabi_uidivmod(void);
+extern void __aeabi_uidiv(void);
+extern void __aeabi_ulcmp(void);
+
+extern void __ashldi3(void);
+extern void __ashrdi3(void);
+extern void __bswapdi2(void);
+extern void __bswapsi2(void);
+extern void __divsi3(void);
+extern void __do_div64(void);
+extern void __lshrdi3(void);
+extern void __modsi3(void);
+extern void __muldi3(void);
+extern void __ucmpdi2(void);
+extern void __udivsi3(void);
+extern void __umodsi3(void);
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8c7e1e..68c2c097cffe 100644
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
index 7e45f69a0ddc..000000000000
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
index c73c4030ca5d..b629d3f11c3d 100644
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
index 04286fd9e09c..f41cee4c5746 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -22,6 +22,7 @@
 #include <asm/memory.h>
 #include <asm/thread_info.h>
 #include <asm/pgtable.h>
+#include <asm/export.h>
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_SEMIHOSTING)
 #include CONFIG_DEBUG_LL_INCLUDE
@@ -727,6 +728,8 @@ ENDPROC(fixup_pv_table)
 __pv_offset:
 	.quad	0
 	.size	__pv_offset, . -__pv_offset
+EXPORT_SYMBOL(__pv_phys_pfn_offset)
+EXPORT_SYMBOL(__pv_offset)
 #endif
 
 #include "head-common.S"
diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index eedefe050022..c74746997626 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -82,3 +82,10 @@ void _memset_io(volatile void __iomem *dst, int c, size_t count)
 	}
 }
 EXPORT_SYMBOL(_memset_io);
+
+/* can't export them from memcpy.S/memset.S because of hidden declaration */
+void mmioset(void __iomem *addr, unsigned int c, size_t n);
+EXPORT_SYMBOL(mmioset);
+
+void mmiocpy(void *dest, const void __iomem *src, size_t n);
+EXPORT_SYMBOL(mmiocpy);
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 2e48b674aab1..37669e7e13af 100644
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
index b05e95840651..a7e7de89bd75 100644
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
index 275d7d2341a4..490336e42518 100644
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
diff --git a/arch/arm/lib/bswapsdi2.S b/arch/arm/lib/bswapsdi2.S
index 07cda737bb11..f05f78247304 100644
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
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f4027862172f..1cfdb138d2d9 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_change_bit, eor
+
+EXPORT_SYMBOL(_change_bit)
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index e936352ccb00..b566154f5cf4 100644
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
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d30..e901ca5af0df 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 bitop	_clear_bit, bic
+
+EXPORT_SYMBOL(_clear_bit)
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 1512bebfbf1b..f549c57ea435 100644
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
index 6ee2f6706f86..d97851d4af7a 100644
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
index caf5019d8161..592c179112d1 100644
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
index 3ac6ef01bc43..68603b5ee537 100644
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
index 984e0f29d548..830b20e81c37 100644
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
index d03fc71fc88c..9c3383fed129 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -49,5 +49,6 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_nocheck)
 #define FN_EXIT		ENDPROC(csum_partial_copy_nocheck)
+#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_nocheck)
 
 #include "csumpartialcopygeneric.S"
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 10b45909610c..8b94d20e51d1 100644
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
index 1712f132b80d..5d495edf3d83 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -73,6 +73,7 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
 #define FN_EXIT		ENDPROC(csum_partial_copy_from_user)
+#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_from_user)
 
 #include "csumpartialcopygeneric.S"
 
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 8044591dca72..e60ce1549759 100644
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
index a9eafe4981eb..0c9e1c18fc9e 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -15,6 +15,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #ifdef __ARMEB__
 #define xh r0
@@ -210,3 +211,4 @@ UNWIND(.save {lr})
 
 UNWIND(.fnend)
 ENDPROC(__do_div64)
+EXPORT_SYMBOL(__do_div64)
diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
index 7848780e8834..26302b8cd38f 100644
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
index 8ecfd15c3a02..9d09a38e73af 100644
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
index c31b2f3153f1..3dff7a3a2aef 100644
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
index 2ed86fa5465f..bfd39682325b 100644
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
index 413da9914529..b3af3db6caac 100644
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
index d9a45e9692ae..3c7a7a40b33e 100644
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
index a46bbc9b168b..fa3633594415 100644
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
index 4ea2435988c1..98ed6aec0b47 100644
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
index 121789eb6802..577184c082bb 100644
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
index 269f90c51ad2..e335f489d1fc 100644
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
index 9397b2e532af..f541bc013bff 100644
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
index 922dcd88b02b..e40833981417 100644
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
index 74a5bed6d999..44182bf686a5 100644
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
index 64111bd4440b..1f822fc52400 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 #define LDR1W_SHIFT	0
 #define STR1W_SHIFT	0
@@ -68,3 +69,4 @@ ENTRY(memcpy)
 
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
+EXPORT_SYMBOL(memcpy)
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 69a9d47fc5ab..71dcc5400d02 100644
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
index 3c65e3bd790f..6f075ca09abc 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/unwind.h>
+#include <asm/export.h>
 
 	.text
 	.align	5
@@ -135,3 +136,4 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+EXPORT_SYMBOL(memset)
diff --git a/arch/arm/lib/memzero.S b/arch/arm/lib/memzero.S
index 0eded952e089..6dec26ed5bcc 100644
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
index 204305956925..b8f12388ccac 100644
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
index 38d660d3705f..11de126e2ed6 100644
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
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b37..3c8b11240fca 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
 		.text
 
 bitop	_set_bit, orr
+
+EXPORT_SYMBOL(_set_bit)
diff --git a/arch/arm/lib/strchr.S b/arch/arm/lib/strchr.S
index 013d64c71e8d..7301f6e6046c 100644
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
index 3cec1c7482c4..aaf9fd98b754 100644
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
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59cb..e3d19b87fbe0 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_change_bit, eor, str
+
+EXPORT_SYMBOL(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce7a..d247e6f70fe6 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+
+EXPORT_SYMBOL(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e487..76800ff601ff 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -9,7 +9,10 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 #include "bitops.h"
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+
+EXPORT_SYMBOL(_test_and_set_bit)
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 6bd1089b07e0..1626e3a551a1 100644
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
index ad4a6309141a..127a91af46f3 100644
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
index 9f5fffd62702..8ed8ab56bb78 100644
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
index 792090f9a032..000000000000
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
index a8b93c5f29b5..fd7917f1c204 100644
--- a/arch/arm/mach-imx/ssi-fiq.S
+++ b/arch/arm/mach-imx/ssi-fiq.S
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/export.h>
 
 /*
  * r8  = bit 0-15: tx offset, bit 16-31: tx buffer size
@@ -144,4 +145,8 @@
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
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
