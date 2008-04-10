From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/8] kernel: remove asm-generic implementation of
	unaligned.h
Date: Thu, 10 Apr 2008 12:44:10 -0700
Message-ID: <1207856650.22001.31.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

All arches now moved to new implementations.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-generic/unaligned.h |  124 ---------------------------------------
 1 files changed, 0 insertions(+), 124 deletions(-)

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
-- 
1.5.5.144.g3e42
