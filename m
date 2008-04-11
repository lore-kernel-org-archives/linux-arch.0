From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 14:47:29 -0700
Message-ID: <1207950449.22001.106.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Unaligned access is ok for the following arches:
cris, m68k, mn10300, powerpc, s390, x86

Arches that use the memmove implementation for native endian, and
the byteshifting for the opposite endianness.
h8300, m32r, xtensa

Packed struct for native endian, byteshifting for other endian:
alpha, blackfin, ia64, parisc, sparc, sparc64, mips, sh

m86knommu is generic_be for Coldfire, otherwise unaligned access is ok.

frv, arm chooses endianness based on compiler settings, uses the byteshifting
versions.

v850 is le, uses the byteshifting versions for both be and le.

Remove the now unused asm-generic implementation.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-alpha/unaligned.h     |   13 ++-
 include/asm-arm/unaligned.h       |  174 +-------------------------------
 include/asm-avr32/unaligned.h     |   13 ++-
 include/asm-blackfin/unaligned.h  |   13 ++-
 include/asm-cris/unaligned.h      |   17 ++--
 include/asm-frv/unaligned.h       |  196 ++-----------------------------------
 include/asm-generic/unaligned.h   |  124 -----------------------
 include/asm-h8300/unaligned.h     |   20 ++---
 include/asm-ia64/unaligned.h      |   13 ++-
 include/asm-m32r/unaligned.h      |   33 +++---
 include/asm-m68k/unaligned.h      |   17 ++--
 include/asm-m68knommu/unaligned.h |   22 +++--
 include/asm-mips/unaligned.h      |   37 ++++----
 include/asm-mn10300/unaligned.h   |  130 ++-----------------------
 include/asm-parisc/unaligned.h    |    6 +-
 include/asm-powerpc/unaligned.h   |   17 ++--
 include/asm-s390/unaligned.h      |   25 ++----
 include/asm-sh/unaligned.h        |   20 +++-
 include/asm-sparc/unaligned.h     |    8 +-
 include/asm-sparc64/unaligned.h   |    8 +-
 include/asm-um/unaligned.h        |    6 +-
 include/asm-v850/unaligned.h      |  119 ++---------------------
 include/asm-x86/unaligned.h       |   38 ++------
 include/asm-xtensa/unaligned.h    |   33 ++++---
 24 files changed, 208 insertions(+), 894 deletions(-)

diff --git a/include/asm-alpha/unaligned.h b/include/asm-alpha/unaligned.h
index a1d7284..3cbf7c0 100644
--- a/include/asm-alpha/unaligned.h
+++ b/include/asm-alpha/unaligned.h
@@ -1,6 +1,11 @@
-#ifndef __ALPHA_UNALIGNED_H
-#define __ALPHA_UNALIGNED_H
+#ifndef _ASM_ALPHA_UNALIGNED_H_
+#define _ASM_ALPHA_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-#endif
+#define get_unaligned __get_unaligned_le
+#define put_unaligned __put_unaligned_le
+
+#endif /* _ASM_ALPHA_UNALIGNED_H_ */
diff --git a/include/asm-arm/unaligned.h b/include/asm-arm/unaligned.h
index 5db03cf..7dd023f 100644
--- a/include/asm-arm/unaligned.h
+++ b/include/asm-arm/unaligned.h
@@ -1,171 +1,9 @@
-#ifndef __ASM_ARM_UNALIGNED_H
-#define __ASM_ARM_UNALIGNED_H
+#ifndef _ASM_ARM_UNALIGNED_H_
+#define _ASM_ARM_UNALIGNED_H_
 
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
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
 
 /*
  * Select endianness
@@ -178,4 +16,4 @@ static inline void __put_unaligned_8_be(const unsigned long long __v, register _
 #define put_unaligned	__put_unaligned_be
 #endif
 
-#endif
+#endif /* _ASM_ARM_UNALIGNED_H_ */
diff --git a/include/asm-avr32/unaligned.h b/include/asm-avr32/unaligned.h
index 36f5fd4..14b3684 100644
--- a/include/asm-avr32/unaligned.h
+++ b/include/asm-avr32/unaligned.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_AVR32_UNALIGNED_H
-#define __ASM_AVR32_UNALIGNED_H
+#ifndef _ASM_AVR32_UNALIGNED_H_
+#define _ASM_AVR32_UNALIGNED_H_
 
 /*
  * AVR32 can handle some unaligned accesses, depending on the
@@ -11,6 +11,11 @@
  * optimize word loads in general.
  */
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-#endif /* __ASM_AVR32_UNALIGNED_H */
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
+
+#endif /* _ASM_AVR32_UNALIGNED_H_ */
diff --git a/include/asm-blackfin/unaligned.h b/include/asm-blackfin/unaligned.h
index 10081dc..ee05b8f 100644
--- a/include/asm-blackfin/unaligned.h
+++ b/include/asm-blackfin/unaligned.h
@@ -1,6 +1,11 @@
-#ifndef __BFIN_UNALIGNED_H
-#define __BFIN_UNALIGNED_H
+#ifndef _ASM_BLACKFIN_UNALIGNED_H_
+#define _ASM_BLACKFIN_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-#endif				/* __BFIN_UNALIGNED_H */
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
+
+#endif /* _ASM_BLACKFIN_UNALIGNED_H_ */
diff --git a/include/asm-cris/unaligned.h b/include/asm-cris/unaligned.h
index 7fbbb39..6dfa969 100644
--- a/include/asm-cris/unaligned.h
+++ b/include/asm-cris/unaligned.h
@@ -1,16 +1,13 @@
-#ifndef __CRIS_UNALIGNED_H
-#define __CRIS_UNALIGNED_H
+#ifndef _ASM_CRIS_UNALIGNED_H_
+#define _ASM_CRIS_UNALIGNED_H_
 
 /*
  * CRIS can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#define get_unaligned(ptr) (*(ptr))
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
 
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-
-#endif
+#endif /* _ASM_CRIS_UNALIGNED_H_ */
diff --git a/include/asm-frv/unaligned.h b/include/asm-frv/unaligned.h
index dc8e9c9..c787a30 100644
--- a/include/asm-frv/unaligned.h
+++ b/include/asm-frv/unaligned.h
@@ -9,194 +9,14 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_FRV_UNALIGNED_H_
+#define _ASM_FRV_UNALIGNED_H_
 
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-/*
- * Unaligned accesses on uClinux can't be performed in a fault handler - the
- * CPU detects them as imprecise exceptions making this impossible.
- *
- * With the FR451, however, they are precise, and so we used to fix them up in
- * the memory access fault handler.  However, instruction bundling make this
- * impractical.  So, now we fall back to using memcpy.
- */
-#ifdef CONFIG_MMU
-
-/*
- * The asm statement in the macros below is a way to get GCC to copy a
- * value from one variable to another without having any clue it's
- * actually doing so, so that it won't have any idea that the values
- * in the two variables are related.
- */
-
-#define get_unaligned(ptr) ({				\
-	typeof((*(ptr))) __x;				\
-	void *__ptrcopy;				\
-	asm("" : "=r" (__ptrcopy) : "0" (ptr));		\
-	memcpy(&__x, __ptrcopy, sizeof(*(ptr)));	\
-	__x;						\
-})
-
-#define put_unaligned(val, ptr) ({			\
-	typeof((*(ptr))) __x = (val);			\
-	void *__ptrcopy;				\
-	asm("" : "=r" (__ptrcopy) : "0" (ptr));		\
-	memcpy(__ptrcopy, &__x, sizeof(*(ptr)));	\
-})
-
-extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned long epcr0);
-
-#else
-
-#define get_unaligned(ptr)							\
-({										\
-	typeof(*(ptr)) x;							\
-	const char *__p = (const char *) (ptr);					\
-										\
-	switch (sizeof(x)) {							\
-	case 1:									\
-		x = *(ptr);							\
-		break;								\
-	case 2:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1])					\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 4:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I4.p	%M4,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I5.p	%M5,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])	\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 8:									\
-	{									\
-		union { uint64_t x; u32 y[2]; } z;				\
-		uint8_t a;							\
-		asm("	ldub%I3		%M3,%0		\n"			\
-		    "	ldub%I4.p	%M4,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I5.p	%M5,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I6.p	%M6,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I7		%M7,%1		\n"			\
-		    "	ldub%I8.p	%M8,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I9.p	%M9,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I10.p	%M10,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)			\
-		    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),	\
-		      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])	\
-		    );								\
-		x = z.x;							\
-		break;								\
-	}									\
-										\
-	default:								\
-		x = 0;								\
-		BUG();								\
-		break;								\
-	}									\
-										\
-	x;									\
-})
-
-#define put_unaligned(val, ptr)								\
-do {											\
-	char *__p = (char *) (ptr);							\
-	int x;										\
-											\
-	switch (sizeof(*ptr)) {								\
-	case 2:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2		%0,%M2		\n"				\
-		    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])				\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 4:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4		%0,%M4		\n"				\
-		    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])	\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 8:										\
-	{										\
-		uint32_t __high, __low;							\
-		__high = (uint64_t)val >> 32;						\
-		__low = val & 0xffffffff;						\
-		asm("	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4.p	%0,%M4		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I5.p	%0,%M5		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I6.p	%1,%M6		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I7.p	%1,%M7		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I8.p	%1,%M8		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I9		%1,%M9		\n"				\
-		    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]), 		\
-		      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]), 		\
-		      "=m"(__p[1]), "=m"(__p[0])					\
-		    : "0"(__low), "1"(__high)						\
-		    );									\
-		break;									\
-	}										\
-											\
-        default:									\
-		*(ptr) = (val);								\
-		break;									\
-	}										\
-} while(0)
-
-#endif
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#endif
+#endif /* _ASM_FRV_UNALIGNED_H_ */
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
deleted file mode 100644
index 2fe1b2e..0000000
--- a/include/asm-generic/unaligned.h
+++ /dev/null
@@ -1,124 +0,0 @@
-#ifndef _ASM_GENERIC_UNALIGNED_H_
-#define _ASM_GENERIC_UNALIGNED_H_
-
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents. 
- *
- * This is based almost entirely upon Richard Henderson's
- * asm-alpha/unaligned.h implementation.  Some comments were
- * taken from David Mosberger's asm-ia64/unaligned.h header.
- */
-
-#include <linux/types.h>
-
-/* 
- * The main single-value unaligned transfer routines.
- */
-#define get_unaligned(ptr) \
-	__get_unaligned((ptr), sizeof(*(ptr)))
-#define put_unaligned(x,ptr) \
-	((void)sizeof(*(ptr)=(x)),\
-	__put_unaligned((__force __u64)(x), (ptr), sizeof(*(ptr))))
-
-/*
- * This function doesn't actually exist.  The idea is that when
- * someone uses the macros below with an unsupported size (datatype),
- * the linker will alert us to the problem via an unresolved reference
- * error.
- */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-/*
- * Elemental unaligned loads 
- */
-
-static inline __u64 __uldq(const __u64 *addr)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
-	return ptr->x;
-}
-
-static inline __u32 __uldl(const __u32 *addr)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
-	return ptr->x;
-}
-
-static inline __u16 __uldw(const __u16 *addr)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
-	return ptr->x;
-}
-
-/*
- * Elemental unaligned stores 
- */
-
-static inline void __ustq(__u64 val, __u64 *addr)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) addr;
-	ptr->x = val;
-}
-
-static inline void __ustl(__u32 val, __u32 *addr)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) addr;
-	ptr->x = val;
-}
-
-static inline void __ustw(__u16 val, __u16 *addr)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) addr;
-	ptr->x = val;
-}
-
-#define __get_unaligned(ptr, size) ({		\
-	const void *__gu_p = ptr;		\
-	__u64 __val;				\
-	switch (size) {				\
-	case 1:					\
-		__val = *(const __u8 *)__gu_p;	\
-		break;				\
-	case 2:					\
-		__val = __uldw(__gu_p);		\
-		break;				\
-	case 4:					\
-		__val = __uldl(__gu_p);		\
-		break;				\
-	case 8:					\
-		__val = __uldq(__gu_p);		\
-		break;				\
-	default:				\
-		bad_unaligned_access_length();	\
-	};					\
-	(__force __typeof__(*(ptr)))__val;	\
-})
-
-#define __put_unaligned(val, ptr, size)		\
-({						\
-	void *__gu_p = ptr;			\
-	switch (size) {				\
-	case 1:					\
-		*(__u8 *)__gu_p = (__force __u8)val;		\
-	        break;				\
-	case 2:					\
-		__ustw((__force __u16)val, __gu_p);		\
-		break;				\
-	case 4:					\
-		__ustl((__force __u32)val, __gu_p);		\
-		break;				\
-	case 8:					\
-		__ustq(val, __gu_p);		\
-		break;				\
-	default:				\
-	    	bad_unaligned_access_length();	\
-	};					\
-	(void)0;				\
-})
-
-#endif /* _ASM_GENERIC_UNALIGNED_H */
diff --git a/include/asm-h8300/unaligned.h b/include/asm-h8300/unaligned.h
index ffb67f4..87276e0 100644
--- a/include/asm-h8300/unaligned.h
+++ b/include/asm-h8300/unaligned.h
@@ -1,15 +1,11 @@
-#ifndef __H8300_UNALIGNED_H
-#define __H8300_UNALIGNED_H
+#ifndef _ASM_H8300_UNALIGNED_H_
+#define _ASM_H8300_UNALIGNED_H_
 
+#include <linux/unaligned/be_memmove.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
-
-#endif
+#endif /* _ASM_H8300_UNALIGNED_H_ */
diff --git a/include/asm-ia64/unaligned.h b/include/asm-ia64/unaligned.h
index bb85598..8a54206 100644
--- a/include/asm-ia64/unaligned.h
+++ b/include/asm-ia64/unaligned.h
@@ -1,6 +1,11 @@
-#ifndef _ASM_IA64_UNALIGNED_H
-#define _ASM_IA64_UNALIGNED_H
+#ifndef _ASM_IA64_UNALIGNED_H_
+#define _ASM_IA64_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/le_struct.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-#endif /* _ASM_IA64_UNALIGNED_H */
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
+
+#endif /* _ASM_IA64_UNALIGNED_H_ */
diff --git a/include/asm-m32r/unaligned.h b/include/asm-m32r/unaligned.h
index fccc180..b7db6fc 100644
--- a/include/asm-m32r/unaligned.h
+++ b/include/asm-m32r/unaligned.h
@@ -1,19 +1,18 @@
-#ifndef _ASM_M32R_UNALIGNED_H
-#define _ASM_M32R_UNALIGNED_H
+#ifndef _ASM_M32R_UNALIGNED_H_
+#define _ASM_M32R_UNALIGNED_H_
 
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.
- */
+#if defined(__LITTLE_ENDIAN__)
+# include <linux/unaligned/le_memmove.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_le
+# define put_unaligned	__put_unaligned_le
+#else
+# include <linux/unaligned/be_memmove.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_be
+# define put_unaligned	__put_unaligned_be
+#endif
 
-#include <asm/string.h>
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
-
-#endif /* _ASM_M32R_UNALIGNED_H */
+#endif /* _ASM_M32R_UNALIGNED_H_ */
diff --git a/include/asm-m68k/unaligned.h b/include/asm-m68k/unaligned.h
index 804cb3f..04425d7 100644
--- a/include/asm-m68k/unaligned.h
+++ b/include/asm-m68k/unaligned.h
@@ -1,16 +1,13 @@
-#ifndef __M68K_UNALIGNED_H
-#define __M68K_UNALIGNED_H
+#ifndef _ASM_M68K_UNALIGNED_H_
+#define _ASM_M68K_UNALIGNED_H_
 
 /*
  * The m68k can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#define get_unaligned(ptr) (*(ptr))
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-
-#endif
+#endif /* _ASM_M68K_UNALIGNED_H_ */
diff --git a/include/asm-m68knommu/unaligned.h b/include/asm-m68knommu/unaligned.h
index 869e9dd..dee9adb 100644
--- a/include/asm-m68knommu/unaligned.h
+++ b/include/asm-m68knommu/unaligned.h
@@ -1,23 +1,25 @@
-#ifndef __M68K_UNALIGNED_H
-#define __M68K_UNALIGNED_H
+#ifndef _ASM_M68KNOMMU_UNALIGNED_H_
+#define _ASM_M68KNOMMU_UNALIGNED_H_
 

 #ifdef CONFIG_COLDFIRE
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-#include <asm-generic/unaligned.h>
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
 #else
 /*
  * The m68k can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#define get_unaligned(ptr) (*(ptr))
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
 #endif
 
-#endif
+#endif /* _ASM_M68KNOMMU_UNALIGNED_H_ */
diff --git a/include/asm-mips/unaligned.h b/include/asm-mips/unaligned.h
index 3249049..850b72a 100644
--- a/include/asm-mips/unaligned.h
+++ b/include/asm-mips/unaligned.h
@@ -5,25 +5,24 @@
  *
  * Copyright (C) 2007 Ralf Baechle (ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org)
  */
-#ifndef __ASM_GENERIC_UNALIGNED_H
-#define __ASM_GENERIC_UNALIGNED_H
+#ifndef _ASM_MIPS_UNALIGNED_H_
+#define _ASM_MIPS_UNALIGNED_H_
 
 #include <linux/compiler.h>
+#if defined(__MIPSEB__)
+# include <linux/unaligned/be_struct.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_be
+# define put_unaligned	__put_unaligned_be
+#elif defined(__MIPSEL__)
+# include <linux/unaligned/le_struct.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_le
+# define put_unaligned	__put_unaligned_le
+#else
+#  error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
+#endif
 
-#define get_unaligned(ptr)					\
-({								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v;						\
-})
-
-#define put_unaligned(val, ptr)					\
-do {								\
-	struct __packed {					\
-		typeof(*(ptr)) __v;				\
-	} *__p = (void *) (ptr);				\
-	__p->__v = (val);					\
-} while(0)
-
-#endif /* __ASM_GENERIC_UNALIGNED_H */
+#endif /* _ASM_MIPS_UNALIGNED_H_ */
diff --git a/include/asm-mn10300/unaligned.h b/include/asm-mn10300/unaligned.h
index cad3afb..29bae86 100644
--- a/include/asm-mn10300/unaligned.h
+++ b/include/asm-mn10300/unaligned.h
@@ -8,129 +8,13 @@
  * as published by the Free Software Foundation; either version
  * 2 of the Licence, or (at your option) any later version.
  */
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_MN10300_UNALIGNED_H_
+#define _ASM_MN10300_UNALIGNED_H_
 
-#include <asm/types.h>
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#if 0
-extern int __bug_unaligned_x(void *ptr);
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
 
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
-
-#endif
+#endif /* _ASM_MN10300_UNALIGNED_H_ */
diff --git a/include/asm-parisc/unaligned.h b/include/asm-parisc/unaligned.h
index 53c9058..05b4be8 100644
--- a/include/asm-parisc/unaligned.h
+++ b/include/asm-parisc/unaligned.h
@@ -1,7 +1,11 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
 #ifdef __KERNEL__
 struct pt_regs;
diff --git a/include/asm-powerpc/unaligned.h b/include/asm-powerpc/unaligned.h
index 6c95dfa..12af55f 100644
--- a/include/asm-powerpc/unaligned.h
+++ b/include/asm-powerpc/unaligned.h
@@ -1,19 +1,16 @@
-#ifndef _ASM_POWERPC_UNALIGNED_H
-#define _ASM_POWERPC_UNALIGNED_H
+#ifndef _ASM_POWERPC_UNALIGNED_H_
+#define _ASM_POWERPC_UNALIGNED_H_
 
 #ifdef __KERNEL__
 
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
 #endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_UNALIGNED_H */
+#endif	/* _ASM_POWERPC_UNALIGNED_H_ */
diff --git a/include/asm-s390/unaligned.h b/include/asm-s390/unaligned.h
index 8ee86db..5dc538f 100644
--- a/include/asm-s390/unaligned.h
+++ b/include/asm-s390/unaligned.h
@@ -1,24 +1,13 @@
-/*
- *  include/asm-s390/unaligned.h
- *
- *  S390 version
- *
- *  Derived from "include/asm-i386/unaligned.h"
- */
-
-#ifndef __S390_UNALIGNED_H
-#define __S390_UNALIGNED_H
+#ifndef _ASM_S390_UNALIGNED_H_
+#define _ASM_S390_UNALIGNED_H_
 
 /*
  * The S390 can do unaligned accesses itself. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#endif
+#endif /* _ASM_S390_UNALIGNED_H_ */
diff --git a/include/asm-sh/unaligned.h b/include/asm-sh/unaligned.h
index 5250e30..67494d0 100644
--- a/include/asm-sh/unaligned.h
+++ b/include/asm-sh/unaligned.h
@@ -1,7 +1,19 @@
-#ifndef __ASM_SH_UNALIGNED_H
-#define __ASM_SH_UNALIGNED_H
+#ifndef _ASM_SH_UNALIGNED_H_
+#define _ASM_SH_UNALIGNED_H_
 
 /* SH can't handle unaligned accesses. */
-#include <asm-generic/unaligned.h>
+#ifdef __LITTLE_ENDIAN__
+# include <linux/unaligned/le_struct.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_le
+# define put_unaligned	__put_unaligned_le
+#else
+# include <linux/unaligned/be_struct.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_be
+# define put_unaligned	__put_unaligned_be
+#endif
 
-#endif /* __ASM_SH_UNALIGNED_H */
+#endif /* _ASM_SH_UNALIGNED_H_ */
diff --git a/include/asm-sparc/unaligned.h b/include/asm-sparc/unaligned.h
index b6f8edd..87a540d 100644
--- a/include/asm-sparc/unaligned.h
+++ b/include/asm-sparc/unaligned.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_SPARC_UNALIGNED_H_
 #define _ASM_SPARC_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#endif /* _ASM_SPARC_UNALIGNED_H */
+#endif /* _ASM_SPARC_UNALIGNED_H_ */
diff --git a/include/asm-sparc64/unaligned.h b/include/asm-sparc64/unaligned.h
index 1ed3ba5..bffa8c9 100644
--- a/include/asm-sparc64/unaligned.h
+++ b/include/asm-sparc64/unaligned.h
@@ -1,6 +1,10 @@
 #ifndef _ASM_SPARC64_UNALIGNED_H_
 #define _ASM_SPARC64_UNALIGNED_H_
 
-#include <asm-generic/unaligned.h>
+#include <linux/unaligned/be_struct.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
 
-#endif /* _ASM_SPARC64_UNALIGNED_H */
+#endif /* _ASM_SPARC64_UNALIGNED_H_ */
diff --git a/include/asm-um/unaligned.h b/include/asm-um/unaligned.h
index 1d2497c..bc2cc11 100644
--- a/include/asm-um/unaligned.h
+++ b/include/asm-um/unaligned.h
@@ -1,6 +1,6 @@
-#ifndef __UM_UNALIGNED_H
-#define __UM_UNALIGNED_H
+#ifndef _ASM_UM_UNALIGNED_H_
+#define _ASM_UM_UNALIGNED_H_
 
 #include "asm/arch/unaligned.h"
 
-#endif
+#endif /* _ASM_UM_UNALIGNED_H_ */
diff --git a/include/asm-v850/unaligned.h b/include/asm-v850/unaligned.h
index e30b186..cc35faf 100644
--- a/include/asm-v850/unaligned.h
+++ b/include/asm-v850/unaligned.h
@@ -14,117 +14,14 @@
  * annoying to use.
  */
 
-#ifndef __V850_UNALIGNED_H__
-#define __V850_UNALIGNED_H__
+#ifndef _ASM_V850_UNALIGNED_H_
+#define _ASM_V850_UNALIGNED_H_
 
-#include <asm/types.h>
+#include <linux/unaligned/be_byteshift.h>
+#include <linux/unaligned/le_byteshift.h>
+#include <linux/unaligned/generic.h>
 
-extern int __bug_unaligned_x(void *ptr);
+#define get_unaligned	__get_unaligned_le
+#define put_unaligned	__put_unaligned_le
 
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
-
-
-#endif /* __V850_UNALIGNED_H__ */
+#endif /* _ASM_V850_UNALIGNED_H_ */
diff --git a/include/asm-x86/unaligned.h b/include/asm-x86/unaligned.h
index 913598d..04df926 100644
--- a/include/asm-x86/unaligned.h
+++ b/include/asm-x86/unaligned.h
@@ -1,37 +1,13 @@
-#ifndef _ASM_X86_UNALIGNED_H
-#define _ASM_X86_UNALIGNED_H
+#ifndef _ASM_X86_UNALIGNED_H_
+#define _ASM_X86_UNALIGNED_H_
 
 /*
  * The x86 can do unaligned accesses itself.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
  */
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
 
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
+#define get_unaligned __get_unaligned_le
+#define put_unaligned __put_unaligned_le
 
-#endif /* _ASM_X86_UNALIGNED_H */
+#endif /* _ASM_X86_UNALIGNED_H_ */
diff --git a/include/asm-xtensa/unaligned.h b/include/asm-xtensa/unaligned.h
index 2822089..563b829 100644
--- a/include/asm-xtensa/unaligned.h
+++ b/include/asm-xtensa/unaligned.h
@@ -9,20 +9,23 @@
  *
  * Copyright (C) 2001 - 2005 Tensilica Inc.
  */
+#ifndef _ASM_XTENSA_UNALIGNED_H_
+#define _ASM_XTENSA_UNALIGNED_H_
 
-#ifndef _XTENSA_UNALIGNED_H
-#define _XTENSA_UNALIGNED_H
+#ifdef __XTENSA_EL__
+# include <linux/unaligned/le_memmove.h>
+# include <linux/unaligned/be_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_le
+# define put_unaligned	__put_unaligned_le
+#elif defined(__XTENSA_EB__)
+# include <linux/unaligned/be_memmove.h>
+# include <linux/unaligned/le_byteshift.h>
+# include <linux/unaligned/generic.h>
+# define get_unaligned	__get_unaligned_be
+# define put_unaligned	__put_unaligned_be
+#else
+# error processor byte order undefined!
+#endif
 
-#include <linux/string.h>
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
-
-#endif	/* _XTENSA_UNALIGNED_H */
+#endif	/* _ASM_XTENSA_UNALIGNED_H_ */
-- 
1.5.5.144.g3e42
