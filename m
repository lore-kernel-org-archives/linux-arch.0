From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 3/3] ARM: fix asm symbol exports
Date: Wed, 30 Nov 2016 03:50:24 -0500
Message-ID: <1480495824-4151-4-git-send-email-nicolas.pitre@linaro.org>
References: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1480495824-4151-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This assumes a revert of commit 8478132a87 before being applied.

Annotate exported assembly symbols so they are properly checksummed
when modversion is selected.

Also, don't use \name with EXPORT_SYMBOL() in bitops.h. Here \name is
an assembler macro argument which is not subject to preprocessor
substitutions. And the assembler doesn't handle preprocessor macros
either. That has the effect of breaking CONFIG_TRIM_UNUSED_KSYMS=y.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/boot/compressed/voidproto.h  |  1 +
 arch/arm/kernel/head.S                |  1 +
 arch/arm/kernel/smccc-call.S          |  2 ++
 arch/arm/lib/ashldi3.S                |  5 +++--
 arch/arm/lib/ashrdi3.S                |  5 +++--
 arch/arm/lib/bitops.h                 | 14 ++++++++++----
 arch/arm/lib/bswapsdi2.S              |  5 +++--
 arch/arm/lib/changebit.S              |  2 +-
 arch/arm/lib/clear_user.S             |  1 +
 arch/arm/lib/clearbit.S               |  2 +-
 arch/arm/lib/copy_from_user.S         |  1 +
 arch/arm/lib/copy_page.S              |  1 +
 arch/arm/lib/copy_to_user.S           |  1 +
 arch/arm/lib/csumipv6.S               |  1 +
 arch/arm/lib/csumpartial.S            |  1 +
 arch/arm/lib/csumpartialcopygeneric.S |  2 ++
 arch/arm/lib/div64.S                  |  3 ++-
 arch/arm/lib/getuser.S                |  2 ++
 arch/arm/lib/io-readsb.S              |  1 +
 arch/arm/lib/io-readsl.S              |  1 +
 arch/arm/lib/io-readsw-armv3.S        |  1 +
 arch/arm/lib/io-readsw-armv4.S        |  1 +
 arch/arm/lib/io-writesb.S             |  1 +
 arch/arm/lib/io-writesl.S             |  1 +
 arch/arm/lib/io-writesw-armv3.S       |  1 +
 arch/arm/lib/io-writesw-armv4.S       |  1 +
 arch/arm/lib/lib1funcs.S              | 17 +++++++++--------
 arch/arm/lib/lshrdi3.S                |  5 +++--
 arch/arm/lib/memchr.S                 |  1 +
 arch/arm/lib/memcpy.S                 |  4 ++++
 arch/arm/lib/memmove.S                |  1 +
 arch/arm/lib/memset.S                 |  4 ++++
 arch/arm/lib/memzero.S                |  1 +
 arch/arm/lib/muldi3.S                 |  5 +++--
 arch/arm/lib/putuser.S                |  2 ++
 arch/arm/lib/setbit.S                 |  2 +-
 arch/arm/lib/strchr.S                 |  1 +
 arch/arm/lib/strrchr.S                |  1 +
 arch/arm/lib/testchangebit.S          |  2 +-
 arch/arm/lib/testclearbit.S           |  2 +-
 arch/arm/lib/testsetbit.S             |  2 +-
 arch/arm/lib/ucmpdi2.S                |  5 +++--
 arch/arm/lib/voidproto.h              |  7 +++++++
 43 files changed, 89 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/compressed/voidproto.h
 create mode 100644 arch/arm/lib/voidproto.h

diff --git a/arch/arm/boot/compressed/voidproto.h b/arch/arm/boot/compressed/voidproto.h
new file mode 100644
index 0000000000..9c5f5e7e49
--- /dev/null
+++ b/arch/arm/boot/compressed/voidproto.h
@@ -0,0 +1 @@
+#define EXPORT_SYMBOL_VOIDPROTO(x) /* nothing */
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f41cee4c57..e37d7bc8da 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -728,6 +728,7 @@ __pv_phys_pfn_offset:
 __pv_offset:
 	.quad	0
 	.size	__pv_offset, . -__pv_offset
+SYMBOL_CPROTO_INCLUDE(<asm/memory.h>)
 EXPORT_SYMBOL(__pv_phys_pfn_offset)
 EXPORT_SYMBOL(__pv_offset)
 #endif
diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
index 37669e7e13..b50961de14 100644
--- a/arch/arm/kernel/smccc-call.S
+++ b/arch/arm/kernel/smccc-call.S
@@ -18,6 +18,8 @@
 #include <asm/unwind.h>
 #include <asm/export.h>
 
+SYMBOL_CPROTO_INCLUDE(<linux/arm-smccc.h>)
+
 	/*
 	 * Wrap c macros in asm macros to delay expansion until after the
 	 * SMCCC asm macro is expanded.
diff --git a/arch/arm/lib/ashldi3.S b/arch/arm/lib/ashldi3.S
index a7e7de89bd..8e4db9e1b6 100644
--- a/arch/arm/lib/ashldi3.S
+++ b/arch/arm/lib/ashldi3.S
@@ -29,6 +29,7 @@ Boston, MA 02110-1301, USA.  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define al r1
@@ -53,5 +54,5 @@ ENTRY(__aeabi_llsl)
 
 ENDPROC(__ashldi3)
 ENDPROC(__aeabi_llsl)
-EXPORT_SYMBOL(__ashldi3)
-EXPORT_SYMBOL(__aeabi_llsl)
+EXPORT_SYMBOL_VOIDPROTO(__ashldi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_llsl)
diff --git a/arch/arm/lib/ashrdi3.S b/arch/arm/lib/ashrdi3.S
index 490336e425..e373606cd8 100644
--- a/arch/arm/lib/ashrdi3.S
+++ b/arch/arm/lib/ashrdi3.S
@@ -29,6 +29,7 @@ Boston, MA 02110-1301, USA.  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define al r1
@@ -53,5 +54,5 @@ ENTRY(__aeabi_lasr)
 
 ENDPROC(__ashrdi3)
 ENDPROC(__aeabi_lasr)
-EXPORT_SYMBOL(__ashrdi3)
-EXPORT_SYMBOL(__aeabi_lasr)
+EXPORT_SYMBOL_VOIDPROTO(__ashrdi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_lasr)
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index df06638b32..af39eeb1a8 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -2,6 +2,16 @@
 #include <asm/unwind.h>
 #include <asm/export.h>
 
+SYMBOL_CPROTO_INCLUDE(<linux/bitops.h>)
+
+#define BITOP(name, instr)		\
+	bitop	name, instr;		\
+	EXPORT_SYMBOL(name)
+
+#define TESTOP(name, instr, store)	\
+	testop	name, instr, store;	\
+	EXPORT_SYMBOL(name)
+
 #if __LINUX_ARM_ARCH__ >= 6
 	.macro	bitop, name, instr
 ENTRY(	\name		)
@@ -26,7 +36,6 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
@@ -57,7 +66,6 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -77,7 +85,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -106,6 +113,5 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #endif
diff --git a/arch/arm/lib/bswapsdi2.S b/arch/arm/lib/bswapsdi2.S
index f05f782473..7c503191db 100644
--- a/arch/arm/lib/bswapsdi2.S
+++ b/arch/arm/lib/bswapsdi2.S
@@ -1,6 +1,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #if __LINUX_ARM_ARCH__ >= 6
 ENTRY(__bswapsi2)
@@ -36,5 +37,5 @@ ENTRY(__bswapdi2)
 	ret lr
 ENDPROC(__bswapdi2)
 #endif
-EXPORT_SYMBOL(__bswapsi2)
-EXPORT_SYMBOL(__bswapdi2)
+EXPORT_SYMBOL_VOIDPROTO(__bswapsi2)
+EXPORT_SYMBOL_VOIDPROTO(__bswapdi2)
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f402786217..4f3f77f416 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
                 .text
 
-bitop	_change_bit, eor
+BITOP( _change_bit, eor )
diff --git a/arch/arm/lib/clear_user.S b/arch/arm/lib/clear_user.S
index b566154f5c..caaa40b85f 100644
--- a/arch/arm/lib/clear_user.S
+++ b/arch/arm/lib/clear_user.S
@@ -52,6 +52,7 @@ UNWIND(.fnend)
 ENDPROC(arm_clear_user)
 ENDPROC(__clear_user_std)
 #ifndef CONFIG_UACCESS_WITH_MEMCPY
+SYMBOL_CPROTO_INCLUDE(<asm/uaccess.h>)
 EXPORT_SYMBOL(arm_clear_user)
 #endif
 
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d..444789f37a 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
                 .text
 
-bitop	_clear_bit, bic
+BITOP( _clear_bit, bic )
diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 63e4c1ed02..b01dcb5e27 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -95,6 +95,7 @@ ENTRY(arm_copy_from_user)
 #include "copy_template.S"
 
 ENDPROC(arm_copy_from_user)
+SYMBOL_CPROTO_INCLUDE(<asm/uaccess.h>)
 EXPORT_SYMBOL(arm_copy_from_user)
 
 	.pushsection .fixup,"ax"
diff --git a/arch/arm/lib/copy_page.S b/arch/arm/lib/copy_page.S
index d97851d4af..652d2c9acf 100644
--- a/arch/arm/lib/copy_page.S
+++ b/arch/arm/lib/copy_page.S
@@ -46,4 +46,5 @@ ENTRY(copy_page)
 	PLD(	beq	2b			)
 		ldmfd	sp!, {r4, pc}			@	3
 ENDPROC(copy_page)
+SYMBOL_CPROTO_INCLUDE(<asm/page.h>)
 EXPORT_SYMBOL(copy_page)
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 592c179112..8cd8500df9 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -101,6 +101,7 @@ WEAK(arm_copy_to_user)
 ENDPROC(arm_copy_to_user)
 ENDPROC(__copy_to_user_std)
 #ifndef CONFIG_UACCESS_WITH_MEMCPY
+SYMBOL_CPROTO_INCLUDE(<asm/uaccess.h>)
 EXPORT_SYMBOL(arm_copy_to_user)
 #endif
 
diff --git a/arch/arm/lib/csumipv6.S b/arch/arm/lib/csumipv6.S
index 68603b5ee5..0ba2d8d7c3 100644
--- a/arch/arm/lib/csumipv6.S
+++ b/arch/arm/lib/csumipv6.S
@@ -31,4 +31,5 @@ ENTRY(__csum_ipv6_magic)
 		adcs	r0, r0, #0
 		ldmfd	sp!, {pc}
 ENDPROC(__csum_ipv6_magic)
+SYMBOL_CPROTO_INCLUDE(<asm/checksum.h>)
 EXPORT_SYMBOL(__csum_ipv6_magic)
diff --git a/arch/arm/lib/csumpartial.S b/arch/arm/lib/csumpartial.S
index 830b20e81c..86b9aa25e1 100644
--- a/arch/arm/lib/csumpartial.S
+++ b/arch/arm/lib/csumpartial.S
@@ -141,4 +141,5 @@ ENTRY(csum_partial)
 		bne	4b
 		b	.Lless4
 ENDPROC(csum_partial)
+SYMBOL_CPROTO_INCLUDE(<asm/checksum.h>)
 EXPORT_SYMBOL(csum_partial)
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 8b94d20e51..30beddf85f 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -10,6 +10,8 @@
 #include <asm/assembler.h>
 #include <asm/export.h>
 
+SYMBOL_CPROTO_INCLUDE(<asm/checksum.h>)
+
 /*
  * unsigned int
  * csum_partial_copy_xxx(const char *src, char *dst, int len, int sum, )
diff --git a/arch/arm/lib/div64.S b/arch/arm/lib/div64.S
index 0c9e1c18fc..e9418ac052 100644
--- a/arch/arm/lib/div64.S
+++ b/arch/arm/lib/div64.S
@@ -16,6 +16,7 @@
 #include <asm/assembler.h>
 #include <asm/unwind.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define xh r0
@@ -211,4 +212,4 @@ Ldiv0_64:
 
 UNWIND(.fnend)
 ENDPROC(__do_div64)
-EXPORT_SYMBOL(__do_div64)
+EXPORT_SYMBOL_VOIDPROTO(__do_div64)
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index 9d09a38e73..b755a97e53 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -33,6 +33,8 @@
 #include <asm/domain.h>
 #include <asm/export.h>
 
+SYMBOL_CPROTO_INCLUDE(<asm/uaccess.h>)
+
 ENTRY(__get_user_1)
 	check_uaccess r0, 1, r1, r2, __get_user_bad
 1: TUSER(ldrb)	r2, [r0]
diff --git a/arch/arm/lib/io-readsb.S b/arch/arm/lib/io-readsb.S
index 3dff7a3a2a..899a690258 100644
--- a/arch/arm/lib/io-readsb.S
+++ b/arch/arm/lib/io-readsb.S
@@ -122,4 +122,5 @@ ENTRY(__raw_readsb)
 
 		ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(__raw_readsb)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_readsb)
diff --git a/arch/arm/lib/io-readsl.S b/arch/arm/lib/io-readsl.S
index bfd3968232..8c88bea554 100644
--- a/arch/arm/lib/io-readsl.S
+++ b/arch/arm/lib/io-readsl.S
@@ -78,4 +78,5 @@ ENTRY(__raw_readsl)
 		strb	r3, [r1, #0]
 		ret	lr
 ENDPROC(__raw_readsl)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_readsl)
diff --git a/arch/arm/lib/io-readsw-armv3.S b/arch/arm/lib/io-readsw-armv3.S
index b3af3db6ca..cc07c1da87 100644
--- a/arch/arm/lib/io-readsw-armv3.S
+++ b/arch/arm/lib/io-readsw-armv3.S
@@ -104,4 +104,5 @@ ENTRY(__raw_readsw)
 
 		ldmfd	sp!, {r4, r5, r6, pc}
 
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-readsw-armv4.S b/arch/arm/lib/io-readsw-armv4.S
index 3c7a7a40b3..75e84cd300 100644
--- a/arch/arm/lib/io-readsw-armv4.S
+++ b/arch/arm/lib/io-readsw-armv4.S
@@ -130,4 +130,5 @@ ENTRY(__raw_readsw)
 		strneb	ip, [r1]
 		ldmfd	sp!, {r4, pc}
 ENDPROC(__raw_readsw)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_readsw)
diff --git a/arch/arm/lib/io-writesb.S b/arch/arm/lib/io-writesb.S
index fa36335944..1ab2e7dfa8 100644
--- a/arch/arm/lib/io-writesb.S
+++ b/arch/arm/lib/io-writesb.S
@@ -93,4 +93,5 @@ ENTRY(__raw_writesb)
 
 		ldmfd	sp!, {r4, r5, pc}
 ENDPROC(__raw_writesb)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_writesb)
diff --git a/arch/arm/lib/io-writesl.S b/arch/arm/lib/io-writesl.S
index 98ed6aec0b..4df08f5998 100644
--- a/arch/arm/lib/io-writesl.S
+++ b/arch/arm/lib/io-writesl.S
@@ -66,4 +66,5 @@ ENTRY(__raw_writesl)
 		bne	6b
 		ret	lr
 ENDPROC(__raw_writesl)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_writesl)
diff --git a/arch/arm/lib/io-writesw-armv3.S b/arch/arm/lib/io-writesw-armv3.S
index 577184c082..c643c48d7c 100644
--- a/arch/arm/lib/io-writesw-armv3.S
+++ b/arch/arm/lib/io-writesw-armv3.S
@@ -125,4 +125,5 @@ ENTRY(__raw_writesw)
 		strne	ip, [r0]
 
 		ldmfd	sp!, {r4, r5, r6, pc}
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/io-writesw-armv4.S b/arch/arm/lib/io-writesw-armv4.S
index e335f489d1..ec8ef93e71 100644
--- a/arch/arm/lib/io-writesw-armv4.S
+++ b/arch/arm/lib/io-writesw-armv4.S
@@ -99,4 +99,5 @@ ENTRY(__raw_writesw)
 		strneh	ip, [r0]
 		ret	lr
 ENDPROC(__raw_writesw)
+SYMBOL_CPROTO_INCLUDE(<asm/io.h>)
 EXPORT_SYMBOL(__raw_writesw)
diff --git a/arch/arm/lib/lib1funcs.S b/arch/arm/lib/lib1funcs.S
index f541bc013b..692cf3bba7 100644
--- a/arch/arm/lib/lib1funcs.S
+++ b/arch/arm/lib/lib1funcs.S
@@ -37,6 +37,7 @@ Boston, MA 02111-1307, USA.  */
 #include <asm/assembler.h>
 #include <asm/unwind.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 .macro ARM_DIV_BODY dividend, divisor, result, curbit
 
@@ -239,8 +240,8 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__udivsi3)
 ENDPROC(__aeabi_uidiv)
-EXPORT_SYMBOL(__udivsi3)
-EXPORT_SYMBOL(__aeabi_uidiv)
+EXPORT_SYMBOL_VOIDPROTO(__udivsi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_uidiv)
 
 ENTRY(__umodsi3)
 UNWIND(.fnstart)
@@ -259,7 +260,7 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__umodsi3)
-EXPORT_SYMBOL(__umodsi3)
+EXPORT_SYMBOL_VOIDPROTO(__umodsi3)
 
 #ifdef CONFIG_ARM_PATCH_IDIV
 	.align 3
@@ -307,8 +308,8 @@ UNWIND(.fnstart)
 UNWIND(.fnend)
 ENDPROC(__divsi3)
 ENDPROC(__aeabi_idiv)
-EXPORT_SYMBOL(__divsi3)
-EXPORT_SYMBOL(__aeabi_idiv)
+EXPORT_SYMBOL_VOIDPROTO(__divsi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_idiv)
 
 ENTRY(__modsi3)
 UNWIND(.fnstart)
@@ -333,7 +334,7 @@ UNWIND(.fnstart)
 
 UNWIND(.fnend)
 ENDPROC(__modsi3)
-EXPORT_SYMBOL(__modsi3)
+EXPORT_SYMBOL_VOIDPROTO(__modsi3)
 
 #ifdef CONFIG_AEABI
 
@@ -350,7 +351,7 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_uidivmod)
-EXPORT_SYMBOL(__aeabi_uidivmod)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_uidivmod)
 
 ENTRY(__aeabi_idivmod)
 UNWIND(.fnstart)
@@ -364,7 +365,7 @@ UNWIND(.save {r0, r1, ip, lr}	)
 
 UNWIND(.fnend)
 ENDPROC(__aeabi_idivmod)
-EXPORT_SYMBOL(__aeabi_idivmod)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_idivmod)
 
 #endif
 
diff --git a/arch/arm/lib/lshrdi3.S b/arch/arm/lib/lshrdi3.S
index e408339814..b12317fe99 100644
--- a/arch/arm/lib/lshrdi3.S
+++ b/arch/arm/lib/lshrdi3.S
@@ -29,6 +29,7 @@ Boston, MA 02110-1301, USA.  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define al r1
@@ -53,5 +54,5 @@ ENTRY(__aeabi_llsr)
 
 ENDPROC(__lshrdi3)
 ENDPROC(__aeabi_llsr)
-EXPORT_SYMBOL(__lshrdi3)
-EXPORT_SYMBOL(__aeabi_llsr)
+EXPORT_SYMBOL_VOIDPROTO(__lshrdi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_llsr)
diff --git a/arch/arm/lib/memchr.S b/arch/arm/lib/memchr.S
index 44182bf686..ea6d86e195 100644
--- a/arch/arm/lib/memchr.S
+++ b/arch/arm/lib/memchr.S
@@ -25,4 +25,5 @@ ENTRY(memchr)
 2:	movne	r0, #0
 	ret	lr
 ENDPROC(memchr)
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(memchr)
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 1be5b6ddf3..04be16dbbd 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -69,5 +69,9 @@ ENTRY(memcpy)
 
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
+
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(memcpy)
+
+SYMBOL_CPROTO(void mmiocpy(void *, const void *, size_t))
 EXPORT_SYMBOL(mmiocpy)
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 71dcc5400d..e10ef8024e 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -226,4 +226,5 @@ ENTRY(memmove)
 18:		backward_copy_shift	push=24	pull=8
 
 ENDPROC(memmove)
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 7b72044cba..ea797a483f 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -136,5 +136,9 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(memset)
+
+SYMBOL_CPROTO(extern void mmioset(void *, unsigned int, size_t))
 EXPORT_SYMBOL(mmioset)
diff --git a/arch/arm/lib/memzero.S b/arch/arm/lib/memzero.S
index 6dec26ed5b..9e1d05c79a 100644
--- a/arch/arm/lib/memzero.S
+++ b/arch/arm/lib/memzero.S
@@ -136,4 +136,5 @@ UNWIND(	.fnstart			)
 	ret	lr			@ 1
 UNWIND(	.fnend				)
 ENDPROC(__memzero)
+SYMBOL_CPROTO_INCLUDE(<asm/string.h>)
 EXPORT_SYMBOL(__memzero)
diff --git a/arch/arm/lib/muldi3.S b/arch/arm/lib/muldi3.S
index b8f12388cc..2104660d54 100644
--- a/arch/arm/lib/muldi3.S
+++ b/arch/arm/lib/muldi3.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define xh r0
@@ -47,5 +48,5 @@ ENTRY(__aeabi_lmul)
 
 ENDPROC(__muldi3)
 ENDPROC(__aeabi_lmul)
-EXPORT_SYMBOL(__muldi3)
-EXPORT_SYMBOL(__aeabi_lmul)
+EXPORT_SYMBOL_VOIDPROTO(__muldi3)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_lmul)
diff --git a/arch/arm/lib/putuser.S b/arch/arm/lib/putuser.S
index 11de126e2e..bb6507cd06 100644
--- a/arch/arm/lib/putuser.S
+++ b/arch/arm/lib/putuser.S
@@ -33,6 +33,8 @@
 #include <asm/domain.h>
 #include <asm/export.h>
 
+SYMBOL_CPROTO_INCLUDE(<asm/uaccess.h>)
+
 ENTRY(__put_user_1)
 	check_uaccess r0, 1, r1, ip, __put_user_bad
 1: TUSER(strb)	r2, [r0]
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b..0b51a2a905 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
 		.text
 
-bitop	_set_bit, orr
+BITOP( _set_bit, orr )
diff --git a/arch/arm/lib/strchr.S b/arch/arm/lib/strchr.S
index 7301f6e604..199d092ec3 100644
--- a/arch/arm/lib/strchr.S
+++ b/arch/arm/lib/strchr.S
@@ -26,4 +26,5 @@ ENTRY(strchr)
 		subeq	r0, r0, #1
 		ret	lr
 ENDPROC(strchr)
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(strchr)
diff --git a/arch/arm/lib/strrchr.S b/arch/arm/lib/strrchr.S
index aaf9fd98b7..f7f261f80f 100644
--- a/arch/arm/lib/strrchr.S
+++ b/arch/arm/lib/strrchr.S
@@ -25,4 +25,5 @@ ENTRY(strrchr)
 		mov	r0, r3
 		ret	lr
 ENDPROC(strrchr)
+SYMBOL_CPROTO_INCLUDE(<linux/string.h>)
 EXPORT_SYMBOL(strrchr)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59..fb2b429ad1 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
                 .text
 
-testop	_test_and_change_bit, eor, str
+TESTOP( _test_and_change_bit, eor, str )
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce..c9bcbdf2f2 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
                 .text
 
-testop	_test_and_clear_bit, bicne, strne
+TESTOP( _test_and_clear_bit, bicne, strne )
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e4..7ccaaf0861 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -12,4 +12,4 @@
 #include "bitops.h"
                 .text
 
-testop	_test_and_set_bit, orreq, streq
+TESTOP( _test_and_set_bit, orreq, streq )
diff --git a/arch/arm/lib/ucmpdi2.S b/arch/arm/lib/ucmpdi2.S
index 127a91af46..a13f3c911e 100644
--- a/arch/arm/lib/ucmpdi2.S
+++ b/arch/arm/lib/ucmpdi2.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/export.h>
+#include "voidproto.h"
 
 #ifdef __ARMEB__
 #define xh r0
@@ -36,7 +37,7 @@ ENTRY(__ucmpdi2)
 	ret	lr
 
 ENDPROC(__ucmpdi2)
-EXPORT_SYMBOL(__ucmpdi2)
+EXPORT_SYMBOL_VOIDPROTO(__ucmpdi2)
 
 #ifdef CONFIG_AEABI
 
@@ -50,7 +51,7 @@ ENTRY(__aeabi_ulcmp)
 	ret	lr
 
 ENDPROC(__aeabi_ulcmp)
-EXPORT_SYMBOL(__aeabi_ulcmp)
+EXPORT_SYMBOL_VOIDPROTO(__aeabi_ulcmp)
 
 #endif
 
diff --git a/arch/arm/lib/voidproto.h b/arch/arm/lib/voidproto.h
new file mode 100644
index 0000000000..4926f4f022
--- /dev/null
+++ b/arch/arm/lib/voidproto.h
@@ -0,0 +1,7 @@
+/*
+ * The gcc helper functions exported from assembly code are never
+ * called from C code directly, however they traditionally always had
+ * a prototype like void __symbol(void) for modversion.
+ */
+#define EXPORT_SYMBOL_VOIDPROTO(sym)	\
+	SYMBOL_CPROTO(void sym(void)); EXPORT_SYMBOL(sym)
-- 
2.7.4

