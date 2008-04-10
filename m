From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/8] kernel: Move arches with efficient unaligned access.
Date: Thu, 10 Apr 2008 12:44:07 -0700
Message-ID: <1207856647.22001.26.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Roman Zippel <zippel-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, "heiko.carstens" <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

cris, m68k, mn10300, powerpc, s390, and x86 have efficient unaligned
access.  Change their asm includes.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-cris/unaligned.h    |    8 +--
 include/asm-m68k/unaligned.h    |    9 +---
 include/asm-mn10300/unaligned.h |  126 +--------------------------------------
 include/asm-powerpc/unaligned.h |    9 +---
 include/asm-s390/unaligned.h    |    9 +---
 include/asm-x86/unaligned.h     |   30 +---------
 6 files changed, 8 insertions(+), 183 deletions(-)

diff --git a/include/asm-cris/unaligned.h b/include/asm-cris/unaligned.h
index 7fbbb39..8bd3555 100644
--- a/include/asm-cris/unaligned.h
+++ b/include/asm-cris/unaligned.h
@@ -3,14 +3,8 @@
 
 /*
  * CRIS can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
 
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-m68k/unaligned.h b/include/asm-m68k/unaligned.h
index 804cb3f..94b4a77 100644
--- a/include/asm-m68k/unaligned.h
+++ b/include/asm-m68k/unaligned.h
@@ -3,14 +3,7 @@
 
 /*
  * The m68k can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-mn10300/unaligned.h b/include/asm-mn10300/unaligned.h
index cad3afb..c377ba0 100644
--- a/include/asm-mn10300/unaligned.h
+++ b/include/asm-mn10300/unaligned.h
@@ -8,129 +8,9 @@
  * as published by the Free Software Foundation; either version
  * 2 of the Licence, or (at your option) any later version.
  */
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_MN10300_UNALIGNED_H
+#define _ASM_MN10300_UNALIGNED_H
 
-#include <asm/types.h>
-
-#if 0
-extern int __bug_unaligned_x(void *ptr);
-
-/*
- * What is the most efficient way of loading/storing an unaligned value?
- *
- * That is the subject of this file.  Efficiency here is defined as
- * minimum code size with minimum register usage for the common cases.
- * It is currently not believed that long longs are common, so we
- * trade efficiency for the chars, shorts and longs against the long
- * longs.
- *
- * Current stats with gcc 2.7.2.2 for these functions:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	3		7	3
- *	8		20	6		16	6
- *
- * gcc 2.95.1 seems to code differently:
- *
- *	ptrsize	get:	code	regs	put:	code	regs
- *	1		1	1		1	2
- *	2		3	2		3	2
- *	4		7	4		7	4
- *	8		19	8		15	6
- *
- * which may or may not be more efficient (depending upon whether
- * you can afford the extra registers).  Hopefully the gcc 2.95
- * is inteligent enough to decide if it is better to use the
- * extra register, but evidence so far seems to suggest otherwise.
- *
- * Unfortunately, gcc is not able to optimise the high word
- * out of long long >> 32, or the low word from long long << 32
- */
-
-#define __get_unaligned_2(__p)					\
-	(__p[0] | __p[1] << 8)
-
-#define __get_unaligned_4(__p)					\
-	(__p[0] | __p[1] << 8 | __p[2] << 16 | __p[3] << 24)
-
-#define get_unaligned(ptr)					\
-({								\
-	unsigned int __v1, __v2;				\
-	__typeof__(*(ptr)) __v;					\
-	__u8 *__p = (__u8 *)(ptr);				\
-								\
-	switch (sizeof(*(ptr))) {				\
-	case 1:	__v = *(ptr);			break;		\
-	case 2: __v = __get_unaligned_2(__p);	break;		\
-	case 4: __v = __get_unaligned_4(__p);	break;		\
-	case 8:							\
-		__v2 = __get_unaligned_4((__p+4));		\
-		__v1 = __get_unaligned_4(__p);			\
-		__v = ((unsigned long long)__v2 << 32 | __v1);	\
-		break;						\
-	default: __v = __bug_unaligned_x(__p);	break;		\
-	}							\
-	__v;							\
-})
-
-
-static inline void __put_unaligned_2(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v;
-	*__p++ = __v >> 8;
-}
-
-static inline void __put_unaligned_4(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2(__v >> 16, __p + 2);
-	__put_unaligned_2(__v, __p);
-}
-
-static inline void __put_unaligned_8(const unsigned long long __v, __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4(__v >> 32, __p + 4);
-	__put_unaligned_4(__v, __p);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define put_unaligned(val, ptr)						\
-	({								\
-		switch (sizeof(*(ptr))) {				\
-		case 1:							\
-			*(ptr) = (val);					\
-			break;						\
-		case 2:							\
-			__put_unaligned_2((val), (__u8 *)(ptr));	\
-			break;						\
-		case 4:							\
-			__put_unaligned_4((val), (__u8 *)(ptr));	\
-			break;						\
-		case 8:							\
-			__put_unaligned_8((val), (__u8 *)(ptr));	\
-			break;						\
-		default:						\
-			__bug_unaligned_x(ptr);				\
-			break;						\
-		}							\
-		(void) 0;						\
-	})
-
-
-#else
-
-#define get_unaligned(ptr) (*(ptr))
-#define put_unaligned(val, ptr) ({ *(ptr) = (val); (void) 0; })
-
-#endif
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-powerpc/unaligned.h b/include/asm-powerpc/unaligned.h
index 6c95dfa..59bcc21 100644
--- a/include/asm-powerpc/unaligned.h
+++ b/include/asm-powerpc/unaligned.h
@@ -5,15 +5,8 @@
 
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_UNALIGNED_H */
diff --git a/include/asm-s390/unaligned.h b/include/asm-s390/unaligned.h
index 8ee86db..1d4a684 100644
--- a/include/asm-s390/unaligned.h
+++ b/include/asm-s390/unaligned.h
@@ -11,14 +11,7 @@
 
 /*
  * The S390 can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif
diff --git a/include/asm-x86/unaligned.h b/include/asm-x86/unaligned.h
index 913598d..7ba2e1a 100644
--- a/include/asm-x86/unaligned.h
+++ b/include/asm-x86/unaligned.h
@@ -3,35 +3,7 @@
 
 /*
  * The x86 can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
-
-/**
- * get_unaligned - get value from possibly mis-aligned location
- * @ptr: pointer to value
- *
- * This macro should be used for accessing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. retrieving a u16 value from a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define get_unaligned(ptr) (*(ptr))
-
-/**
- * put_unaligned - put value to a possibly mis-aligned location
- * @val: value to place
- * @ptr: pointer to location
- *
- * This macro should be used for placing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. writing a u16 value to a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#include <linux/unaligned/access_ok.h>
 
 #endif /* _ASM_X86_UNALIGNED_H */
-- 
1.5.5.144.g3e42
