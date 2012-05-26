From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 00:44:59 -0400 (EDT)
Message-ID: <20120526.004459.1494543364832806830.davem@davemloft.net>
References: <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
	<20120526.001552.1171433126500742038.davem@davemloft.net>
	<CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:55398 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab2EZEpB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 00:45:01 -0400
In-Reply-To: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 21:19:01 -0700

> The second one should actually hopefully come close to working. At
> least I tested the compile by building the lib/ files with that,
> instead of the x86 native version.

Ok, with the following patch, it seems to work on sparc too.

I'll beat it up with some glibc testsuite runs and stuff like that,
but so far it looks great.

 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/uaccess_32.h     |   22 ++-----
 arch/sparc/include/asm/uaccess_64.h     |    8 +--
 arch/sparc/include/asm/word-at-a-time.h |    1 +
 arch/sparc/lib/Makefile                 |    1 -
 arch/sparc/lib/ksyms.c                  |    2 -
 arch/sparc/lib/strlen_user_32.S         |  109 -------------------------------
 arch/sparc/lib/strlen_user_64.S         |   97 ---------------------------
 8 files changed, 10 insertions(+), 231 deletions(-)
 create mode 100644 arch/sparc/include/asm/word-at-a-time.h
 delete mode 100644 arch/sparc/lib/strlen_user_32.S
 delete mode 100644 arch/sparc/lib/strlen_user_64.S

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 15e9e05..83bd051 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -35,6 +35,7 @@ config SPARC
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 59586b5..53a28dd 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -16,6 +16,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/processor.h>
+
 #define ARCH_HAS_SORT_EXTABLE
 #define ARCH_HAS_SEARCH_EXTABLE
 
@@ -304,24 +306,8 @@ static inline unsigned long clear_user(void __user *addr, unsigned long n)
 		return n;
 }
 
-extern long __strlen_user(const char __user *);
-extern long __strnlen_user(const char __user *, long len);
-
-static inline long strlen_user(const char __user *str)
-{
-	if (!access_ok(VERIFY_READ, str, 0))
-		return 0;
-	else
-		return __strlen_user(str);
-}
-
-static inline long strnlen_user(const char __user *str, long len)
-{
-	if (!access_ok(VERIFY_READ, str, 0))
-		return 0;
-	else
-		return __strnlen_user(str, len);
-}
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
 #endif  /* __ASSEMBLY__ */
 
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index dcdfb89..7c831d8 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -17,6 +17,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/processor.h>
+
 /*
  * Sparc64 is segmented, though more like the M68K than the I386.
  * We use the secondary ASI to address user memory, which references a
@@ -257,11 +259,9 @@ extern unsigned long __must_check __clear_user(void __user *, unsigned long);
 
 #define clear_user __clear_user
 
-extern long __strlen_user(const char __user *);
-extern long __strnlen_user(const char __user *, long len);
+extern __must_check long strlen_user(const char __user *str);
+extern __must_check long strnlen_user(const char __user *str, long n);
 
-#define strlen_user __strlen_user
-#define strnlen_user __strnlen_user
 #define __copy_to_user_inatomic ___copy_to_user
 #define __copy_from_user_inatomic ___copy_from_user
 
diff --git a/arch/sparc/include/asm/word-at-a-time.h b/arch/sparc/include/asm/word-at-a-time.h
new file mode 100644
index 0000000..b522cc3
--- /dev/null
+++ b/arch/sparc/include/asm/word-at-a-time.h
@@ -0,0 +1 @@
+#include <asm-generic/word-at-a-time.h>
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 943d98d..dff4096 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -10,7 +10,6 @@ lib-y                 += strlen.o
 lib-y                 += checksum_$(BITS).o
 lib-$(CONFIG_SPARC32) += blockops.o
 lib-y                 += memscan_$(BITS).o memcmp.o strncmp_$(BITS).o
-lib-y                 += strlen_user_$(BITS).o
 lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
 lib-$(CONFIG_SPARC64) += atomic_64.o
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index 6b278ab..3b31218 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -15,8 +15,6 @@
 
 /* string functions */
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(__strlen_user);
-EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(strncmp);
 
 /* mem* functions */
diff --git a/arch/sparc/lib/strlen_user_32.S b/arch/sparc/lib/strlen_user_32.S
deleted file mode 100644
index 8c8a371..0000000
--- a/arch/sparc/lib/strlen_user_32.S
+++ /dev/null
@@ -1,109 +0,0 @@
-/* strlen_user.S: Sparc optimized strlen_user code
- *
- * Return length of string in userspace including terminating 0
- * or 0 for error
- *
- * Copyright (C) 1991,1996 Free Software Foundation
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#define LO_MAGIC 0x01010101
-#define HI_MAGIC 0x80808080
-
-10:
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	1f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be	4f
-	 or	%o4, %lo(HI_MAGIC), %o3
-11:
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	2f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be	5f
-	 sethi	%hi(LO_MAGIC), %o4
-12:
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	3f
-	 add	%o0, 1, %o0
-	b	13f
-	 or	%o4, %lo(LO_MAGIC), %o2
-1:
-	retl
-	 mov	1, %o0
-2:
-	retl
-	 mov	2, %o0
-3:
-	retl
-	 mov	3, %o0
-
-	.align 4
-	.global __strlen_user, __strnlen_user
-__strlen_user:
-	sethi	%hi(32768), %o1
-__strnlen_user:
-	mov	%o1, %g1
-	mov	%o0, %o1
-	andcc	%o0, 3, %g0
-	bne	10b
-	 sethi	%hi(HI_MAGIC), %o4
-	or	%o4, %lo(HI_MAGIC), %o3
-4:
-	sethi	%hi(LO_MAGIC), %o4
-5:
-	or	%o4, %lo(LO_MAGIC), %o2
-13:
-	ld	[%o0], %o5
-2:
-	sub	%o5, %o2, %o4
-	andcc	%o4, %o3, %g0
-	bne	82f
-	 add	%o0, 4, %o0
-	sub	%o0, %o1, %g2
-81:	cmp	%g2, %g1
-	blu	13b
-	 mov	%o0, %o4
-	ba,a	1f
-
-	/* Check every byte. */
-82:	srl	%o5, 24, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o0, -3, %o4
-	srl	%o5, 16, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o4, 1, %o4
-	srl	%o5, 8, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o4, 1, %o4
-	andcc	%o5, 0xff, %g0
-	bne	81b
-	 sub	%o0, %o1, %g2
-
-	add	%o4, 1, %o4
-1:
-	retl
-	 sub	%o4, %o1, %o0
-
-	.section .fixup,#alloc,#execinstr
-	.align	4
-9:
-	retl
-	 clr	%o0
-
-	.section __ex_table,#alloc
-	.align	4
-
-	.word	10b, 9b
-	.word	11b, 9b
-	.word	12b, 9b
-	.word	13b, 9b
diff --git a/arch/sparc/lib/strlen_user_64.S b/arch/sparc/lib/strlen_user_64.S
deleted file mode 100644
index c3df71f..0000000
--- a/arch/sparc/lib/strlen_user_64.S
+++ /dev/null
@@ -1,97 +0,0 @@
-/* strlen_user.S: Sparc64 optimized strlen_user code
- *
- * Return length of string in userspace including terminating 0
- * or 0 for error
- *
- * Copyright (C) 1991,1996 Free Software Foundation
- * Copyright (C) 1996,1999 David S. Miller (davem@redhat.com)
- * Copyright (C) 1996,1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/linkage.h>
-#include <asm/asi.h>
-
-#define LO_MAGIC 0x01010101
-#define HI_MAGIC 0x80808080
-
-	.align 4
-ENTRY(__strlen_user)
-	sethi	%hi(32768), %o1
-ENTRY(__strnlen_user)
-	mov	%o1, %g1
-	mov	%o0, %o1
-	andcc	%o0, 3, %g0
-	be,pt	%icc, 9f
-	 sethi	%hi(HI_MAGIC), %o4
-10:	lduba	[%o0] %asi, %o5
-	brz,pn	%o5, 21f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be,pn	%icc, 4f
-	 or	%o4, %lo(HI_MAGIC), %o3
-11:	lduba	[%o0] %asi, %o5
-	brz,pn	%o5, 22f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be,pt	%icc, 13f
-	 srl	%o3, 7, %o2
-12:	lduba	[%o0] %asi, %o5
-	brz,pn	%o5, 23f
-	 add	%o0, 1, %o0
-	ba,pt	%icc, 2f
-15:	 lda	[%o0] %asi, %o5
-9:	or	%o4, %lo(HI_MAGIC), %o3
-4:	srl	%o3, 7, %o2
-13:	lda	[%o0] %asi, %o5
-2:	sub	%o5, %o2, %o4
-	andcc	%o4, %o3, %g0
-	bne,pn	%icc, 82f
-	 add	%o0, 4, %o0
-	sub	%o0, %o1, %g2
-81:	cmp	%g2, %g1
-	blu,pt	%icc, 13b
-	 mov	%o0, %o4
-	ba,a,pt	%xcc, 1f
-
-	/* Check every byte. */
-82:	srl	%o5, 24, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o0, -3, %o4
-	srl	%o5, 16, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o4, 1, %o4
-	srl	%o5, 8, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o4, 1, %o4
-	andcc	%o5, 0xff, %g0
-	bne,pt	%icc, 81b
-	 sub	%o0, %o1, %g2
-	add	%o4, 1, %o4
-1:	retl
-	 sub	%o4, %o1, %o0
-21:	retl
-	 mov	1, %o0
-22:	retl
-	 mov	2, %o0
-23:	retl
-	 mov	3, %o0
-ENDPROC(__strlen_user)
-ENDPROC(__strnlen_user)
-
-        .section .fixup,#alloc,#execinstr
-        .align  4
-30:
-        retl
-         clr    %o0
-
-	.section __ex_table,"a"
-	.align	4
-
-	.word	10b, 30b
-	.word	11b, 30b
-	.word	12b, 30b
-	.word	15b, 30b
-	.word	13b, 30b
-- 
1.7.10
