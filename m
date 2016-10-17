From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Mon, 17 Oct 2016 14:26:52 +0200
Message-ID: <6556201.qTG4Pa4aHk@wuerfel>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:49182 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933081AbcJQM1C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 08:27:02 -0400
In-Reply-To: <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This adds an asm/asm-prototypes.h header for ARM to fix the
broken symbol versioning for symbols exported from assembler
files.

In addition to the header, we have to do these other small
changes:

- move the 'extern' declarations out of memset_io/memcpy_io
  to make them visible to the symbol version generator
- move the exports from bitops.h to {change,clear,set,...}bit.S
- move the exports from csumpartialgeneric.S into the files
  including it

I couldn't find the correct prototypes for the compiler builtins,
so I went with the fake 'void f(void)' prototypes that we had
before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 51458d8273ad..fbc3695293cf 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -316,11 +316,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writesw(p,d,l)		__raw_writesw(p,d,l)
 #define writesl(p,d,l)		__raw_writesl(p,d,l)
 
+extern void mmioset(void *, unsigned int, size_t);
+extern void mmiocpy(void *, const void *, size_t);
+
 #ifndef __ARMBE__
 static inline void memset_io(volatile void __iomem *dst, unsigned c,
 	size_t count)
 {
-	extern void mmioset(void *, unsigned int, size_t);
 	mmioset((void __force *)dst, c, count);
 }
 #define memset_io(dst,c,count) memset_io(dst,c,count)
@@ -328,7 +330,6 @@ static inline void memset_io(volatile void __iomem *dst, unsigned c,
 static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
 	size_t count)
 {
-	extern void mmiocpy(void *, const void *, size_t);
 	mmiocpy(to, (const void __force *)from, count);
 }
 #define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
@@ -336,7 +337,6 @@ static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
 static inline void memcpy_toio(volatile void __iomem *to, const void *from,
 	size_t count)
 {
-	extern void mmiocpy(void *, const void *, size_t);
 	mmiocpy((void __force *)to, from, count);
 }
 #define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
diff --git a/arch/arm/lib/bitops.h b/arch/arm/lib/bitops.h
index df06638b327c..afaef2a7faec 100644
--- a/arch/arm/lib/bitops.h
+++ b/arch/arm/lib/bitops.h
@@ -26,7 +26,6 @@ UNWIND(	.fnstart	)
 	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 	.macro	testop, name, instr, store
@@ -57,7 +56,6 @@ UNWIND(	.fnstart	)
 2:	bx	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #else
 	.macro	bitop, name, instr
@@ -77,7 +75,6 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 
 /**
@@ -106,6 +103,5 @@ UNWIND(	.fnstart	)
 	ret	lr
 UNWIND(	.fnend		)
 ENDPROC(\name		)
-EXPORT_SYMBOL(\name	)
 	.endm
 #endif
diff --git a/arch/arm/lib/changebit.S b/arch/arm/lib/changebit.S
index f4027862172f..005fdd18c509 100644
--- a/arch/arm/lib/changebit.S
+++ b/arch/arm/lib/changebit.S
@@ -13,3 +13,4 @@
                 .text
 
 bitop	_change_bit, eor
+EXPORT_SYMBOL(_change_bit)
diff --git a/arch/arm/lib/clearbit.S b/arch/arm/lib/clearbit.S
index f6b75fb64d30..501eff09968d 100644
--- a/arch/arm/lib/clearbit.S
+++ b/arch/arm/lib/clearbit.S
@@ -13,3 +13,4 @@
                 .text
 
 bitop	_clear_bit, bic
+EXPORT_SYMBOL(_clear_bit)
diff --git a/arch/arm/lib/csumpartialcopy.S b/arch/arm/lib/csumpartialcopy.S
index 9c3383fed129..bdcc2eea4e5c 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -49,6 +49,7 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_nocheck)
 #define FN_EXIT		ENDPROC(csum_partial_copy_nocheck)
-#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_nocheck)
 
 #include "csumpartialcopygeneric.S"
+
+EXPORT_SYMBOL(csum_partial_copy_nocheck)
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 8b94d20e51d1..06825566c0f7 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -332,4 +332,3 @@ FN_ENTRY
 		mov	r5, r4, get_byte_1
 		b	.Lexit
 FN_EXIT
-FN_EXPORT
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 5d495edf3d83..d5522c94f58c 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -73,9 +73,9 @@
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
 #define FN_EXIT		ENDPROC(csum_partial_copy_from_user)
-#define FN_EXPORT	EXPORT_SYMBOL(csum_partial_copy_from_user)
 
 #include "csumpartialcopygeneric.S"
+EXPORT_SYMBOL(csum_partial_copy_from_user)
 
 /*
  * FIXME: minor buglet here
diff --git a/arch/arm/lib/setbit.S b/arch/arm/lib/setbit.S
index 618fedae4b37..d748b8d1326f 100644
--- a/arch/arm/lib/setbit.S
+++ b/arch/arm/lib/setbit.S
@@ -13,3 +13,4 @@
 		.text
 
 bitop	_set_bit, orr
+EXPORT_SYMBOL(_set_bit)
diff --git a/arch/arm/lib/testchangebit.S b/arch/arm/lib/testchangebit.S
index 4becdc3a59cb..4d2dafa9b787 100644
--- a/arch/arm/lib/testchangebit.S
+++ b/arch/arm/lib/testchangebit.S
@@ -13,3 +13,4 @@
                 .text
 
 testop	_test_and_change_bit, eor, str
+EXPORT_SYMBOL(_test_and_change_bit)
diff --git a/arch/arm/lib/testclearbit.S b/arch/arm/lib/testclearbit.S
index 918841dcce7a..fe5cae2e480a 100644
--- a/arch/arm/lib/testclearbit.S
+++ b/arch/arm/lib/testclearbit.S
@@ -13,3 +13,4 @@
                 .text
 
 testop	_test_and_clear_bit, bicne, strne
+EXPORT_SYMBOL(_test_and_clear_bit)
diff --git a/arch/arm/lib/testsetbit.S b/arch/arm/lib/testsetbit.S
index 8d1b2fe9e487..25fed837edb3 100644
--- a/arch/arm/lib/testsetbit.S
+++ b/arch/arm/lib/testsetbit.S
@@ -13,3 +13,4 @@
                 .text
 
 testop	_test_and_set_bit, orreq, streq
+EXPORT_SYMBOL(_test_and_set_bit)
