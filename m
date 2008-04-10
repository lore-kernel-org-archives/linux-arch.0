From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/8] kernel: move arches the use the generic byteshifting
	implemetation
Date: Thu, 10 Apr 2008 12:44:08 -0700
Message-ID: <1207856648.22001.29.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

arm chooses endianness based on compiler settings.

v850 is le, but does not use the generic c-struct implementation and
uses the byteshifting for both be and le.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-arm/unaligned.h  |  166 +-----------------------------------------
 include/asm-v850/unaligned.h |  111 +---------------------------
 2 files changed, 4 insertions(+), 273 deletions(-)

diff --git a/include/asm-arm/unaligned.h b/include/asm-arm/unaligned.h
index 5db03cf..d5cf478 100644
--- a/include/asm-arm/unaligned.h
+++ b/include/asm-arm/unaligned.h
@@ -1,171 +1,7 @@
 #ifndef __ASM_ARM_UNALIGNED_H
 #define __ASM_ARM_UNALIGNED_H
 
-#include <asm/types.h>
-
-extern int __bug_unaligned_x(const void *ptr);
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
-#define __get_unaligned_2_le(__p)					\
-	(unsigned int)(__p[0] | __p[1] << 8)
-
-#define __get_unaligned_2_be(__p)					\
-	(unsigned int)(__p[0] << 8 | __p[1])
-
-#define __get_unaligned_4_le(__p)					\
-	(unsigned int)(__p[0] | __p[1] << 8 | __p[2] << 16 | __p[3] << 24)
-
-#define __get_unaligned_4_be(__p)					\
-	(unsigned int)(__p[0] << 24 | __p[1] << 16 | __p[2] << 8 | __p[3])
-
-#define __get_unaligned_8_le(__p)					\
-	((unsigned long long)__get_unaligned_4_le((__p+4)) << 32 |	\
-		__get_unaligned_4_le(__p))
-
-#define __get_unaligned_8_be(__p)					\
-	((unsigned long long)__get_unaligned_4_be(__p) << 32 |		\
-		__get_unaligned_4_be((__p+4)))
-
-#define __get_unaligned_le(ptr)						\
-	((__force typeof(*(ptr)))({					\
-		const __u8 *__p = (const __u8 *)(ptr);			\
-		__builtin_choose_expr(sizeof(*(ptr)) == 1, *__p,	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 2, __get_unaligned_2_le(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 4, __get_unaligned_4_le(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 8, __get_unaligned_8_le(__p),	\
-		    (void)__bug_unaligned_x(__p)))));			\
-	}))
-
-#define __get_unaligned_be(ptr)						\
-	((__force typeof(*(ptr)))({					\
-		const __u8 *__p = (const __u8 *)(ptr);			\
-		__builtin_choose_expr(sizeof(*(ptr)) == 1, *__p,	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 2, __get_unaligned_2_be(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 4, __get_unaligned_4_be(__p),	\
-		  __builtin_choose_expr(sizeof(*(ptr)) == 8, __get_unaligned_8_be(__p),	\
-		    (void)__bug_unaligned_x(__p)))));			\
-	}))
-
-
-static inline void __put_unaligned_2_le(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v;
-	*__p++ = __v >> 8;
-}
-
-static inline void __put_unaligned_2_be(__u32 __v, register __u8 *__p)
-{
-	*__p++ = __v >> 8;
-	*__p++ = __v;
-}
-
-static inline void __put_unaligned_4_le(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2_le(__v >> 16, __p + 2);
-	__put_unaligned_2_le(__v, __p);
-}
-
-static inline void __put_unaligned_4_be(__u32 __v, register __u8 *__p)
-{
-	__put_unaligned_2_be(__v >> 16, __p);
-	__put_unaligned_2_be(__v, __p + 2);
-}
-
-static inline void __put_unaligned_8_le(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4_le(__v >> 32, __p+4);
-	__put_unaligned_4_le(__v, __p);
-}
-
-static inline void __put_unaligned_8_be(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4_be(__v >> 32, __p);
-	__put_unaligned_4_be(__v, __p+4);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define __put_unaligned_le(val,ptr)					\
-	({							\
-		(void)sizeof(*(ptr) = (val));			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2_le((__force u16)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4_le((__force u32)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8_le((__force u64)(val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
-
-#define __put_unaligned_be(val,ptr)					\
-	({							\
-		(void)sizeof(*(ptr) = (val));			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2_be((__force u16)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4_be((__force u32)(val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8_be((__force u64)(val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
+#include <linux/unaligned/generic.h>
 
 /*
  * Select endianness
diff --git a/include/asm-v850/unaligned.h b/include/asm-v850/unaligned.h
index e30b186..09fc37c 100644
--- a/include/asm-v850/unaligned.h
+++ b/include/asm-v850/unaligned.h
@@ -17,114 +17,9 @@
 #ifndef __V850_UNALIGNED_H__
 #define __V850_UNALIGNED_H__
 
-#include <asm/types.h>
-
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
-	({							\
-		__typeof__(*(ptr)) __v;				\
-		__u8 *__p = (__u8 *)(ptr);			\
-		switch (sizeof(*(ptr))) {			\
-		case 1:	__v = *(ptr);			break;	\
-		case 2: __v = __get_unaligned_2(__p);	break;	\
-		case 4: __v = __get_unaligned_4(__p);	break;	\
-		case 8: {					\
-				unsigned int __v1, __v2;	\
-				__v2 = __get_unaligned_4((__p+4)); \
-				__v1 = __get_unaligned_4(__p);	\
-				__v = ((unsigned long long)__v2 << 32 | __v1);	\
-			}					\
-			break;					\
-		default: __v = __bug_unaligned_x(__p);	break;	\
-		}						\
-		__v;						\
-	})
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
-static inline void __put_unaligned_8(const unsigned long long __v, register __u8 *__p)
-{
-	/*
-	 * tradeoff: 8 bytes of stack for all unaligned puts (2
-	 * instructions), or an extra register in the long long
-	 * case - go for the extra register.
-	 */
-	__put_unaligned_4(__v >> 32, __p+4);
-	__put_unaligned_4(__v, __p);
-}
-
-/*
- * Try to store an unaligned value as efficiently as possible.
- */
-#define put_unaligned(val,ptr)					\
-	({							\
-		switch (sizeof(*(ptr))) {			\
-		case 1:						\
-			*(ptr) = (val);				\
-			break;					\
-		case 2: __put_unaligned_2((val),(__u8 *)(ptr));	\
-			break;					\
-		case 4:	__put_unaligned_4((val),(__u8 *)(ptr));	\
-			break;					\
-		case 8:	__put_unaligned_8((val),(__u8 *)(ptr)); \
-			break;					\
-		default: __bug_unaligned_x(ptr);		\
-			break;					\
-		}						\
-		(void) 0;					\
-	})
+#include <linux/unaligned/generic.h>
 
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
 
 #endif /* __V850_UNALIGNED_H__ */
-- 
1.5.5.144.g3e42
