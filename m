Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from localhost
	([127.0.0.1] helo=cheetah.davemloft.net ident=davem)
	by cheetah.davemloft.net with smtp (Exim 3.36 #1 (Debian))
	id 1DC024-0007Je-00
	for <linux-arch@vger.kernel.org>; Thu, 17 Mar 2005 10:47:44 -0800
Date: Thu, 17 Mar 2005 10:47:44 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Consolidation of asm/unaligned.h
Message-Id: <20050317104744.4be7e550.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Several architectures do their asm/unaligned.h unaligned load/store
support by simply casting the value to a packed strcuture, and
this forces gcc to assume the object is not aligned properly.

This technique originated in Richard Henderson's asm-alpha/unaligned.h,
IA64 uses the same technique as well.

This works well on RISC systems for two reasons:

1) On systems like Alpha, MIPS, et al. which have special
   "load unaligned" instructions, GCC knows to emit them
   for code like this.

2) Even on systems without explicit unaligned load/store instruction
   support, the code emitted (basically, byte loads with shifts and
   ors) is about the same as you get when emitting a memmove() call
   and you don't need the local stack slot to boot.

I was going to thus move asm-sparc64/unaligned.h over to such a
scheme, but then I noticed that nobody actually includes the current
memmove() based asm-generic/unaligned.h code.  So why not put the
portable packed structure implementation into asm-generic/unaligned.h
and then make asm-{alpha,ia64,sparc64}/unaligned.h simply include that?

I only had to make minor modifications to the alpha header when placing
it into the generic area.  In particular I had to convert some explicit
"unsigned long", "unsigned int" et al. into the arch-agnostic "u64" "u32"
etc.  so that even 32-bit platforms could use this.

Come to think of it I'll make sparc32 use this as well.

I looked at some other platform unaligned.h headers:

1) ARM is trying to be incredibly clever, and open codes the shifts
   and ors.  I think it would be better if it used something similar
   to the packed structure technique.

2) CRIS, like x86, can do unaligned stuff directly.

3) FRV needs help doing unaligned stuff, it probably also could use
   the packed structure stuff.

4) h8300 needs help, could use this new asm-generic/unaligned.h header

5) m32r likewise

6) M68K can do unaligned access directly.

7) MIPS appears to be a copy of the original alpha/ia64 unaligned.h header,
   so I converted it to use the new asm-generic/unaligned.h too

8) PARISC is just a copy of asm-sparc/unaligned.h, so I converted it over
   to use asm-generic/unaligned.h too

9) PPC/PPC64 can do unaligned access directly in big-endian mode which is
   what the Linux kernel runs in

10) S390 can do it directly as well

11) SH/SH64 just has the memmove() code ala asm-sparc/unaligned.h, I converted
    it to use asm-generic/unaligned.h

12) V850 has some clever code just like ARM, so I didn't touch it.

So this is the patch I came up with.

Any suggested changes or objections?

Thanks.

===== include/asm-alpha/unaligned.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/unaligned.h	2003-06-08 15:31:17 -07:00
+++ edited/include/asm-alpha/unaligned.h	2005-03-17 10:25:43 -08:00
@@ -1,114 +1,6 @@
 #ifndef __ALPHA_UNALIGNED_H
 #define __ALPHA_UNALIGNED_H
 
-/* 
- * The main single-value unaligned transfer routines.
- */
-#define get_unaligned(ptr) \
-	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
-#define put_unaligned(x,ptr) \
-	__put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
-
-/*
- * This is a silly but good way to make sure that
- * the get/put functions are indeed always optimized,
- * and that we use the correct sizes.
- */
-extern void bad_unaligned_access_length(void) __attribute__((noreturn));
-
-/*
- * EGCS 1.1 knows about arbitrary unaligned loads.  Define some
- * packed structures to talk about such things with.
- */
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-/*
- * Elemental unaligned loads 
- */
-
-extern inline unsigned long __uldq(const unsigned long * r11)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) r11;
-	return ptr->x;
-}
-
-extern inline unsigned long __uldl(const unsigned int * r11)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) r11;
-	return ptr->x;
-}
-
-extern inline unsigned long __uldw(const unsigned short * r11)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) r11;
-	return ptr->x;
-}
-
-/*
- * Elemental unaligned stores 
- */
-
-extern inline void __ustq(unsigned long r5, unsigned long * r11)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) r11;
-	ptr->x = r5;
-}
-
-extern inline void __ustl(unsigned long r5, unsigned int * r11)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) r11;
-	ptr->x = r5;
-}
-
-extern inline void __ustw(unsigned long r5, unsigned short * r11)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) r11;
-	ptr->x = r5;
-}
-
-extern inline unsigned long __get_unaligned(const void *ptr, size_t size)
-{
-	unsigned long val;
-	switch (size) {
-	      case 1:
-		val = *(const unsigned char *)ptr;
-		break;
-	      case 2:
-		val = __uldw((const unsigned short *)ptr);
-		break;
-	      case 4:
-		val = __uldl((const unsigned int *)ptr);
-		break;
-	      case 8:
-		val = __uldq((const unsigned long *)ptr);
-		break;
-	      default:
-		bad_unaligned_access_length();
-	}
-	return val;
-}
-
-extern inline void __put_unaligned(unsigned long val, void *ptr, size_t size)
-{
-	switch (size) {
-	      case 1:
-		*(unsigned char *)ptr = (val);
-	        break;
-	      case 2:
-		__ustw(val, (unsigned short *)ptr);
-		break;
-	      case 4:
-		__ustl(val, (unsigned int *)ptr);
-		break;
-	      case 8:
-		__ustq(val, (unsigned long *)ptr);
-		break;
-	      default:
-	    	bad_unaligned_access_length();
-	}
-}
+#include <asm-generic/unaligned.h>
 
 #endif
===== include/asm-generic/unaligned.h 1.1 vs edited =====
--- 1.1/include/asm-generic/unaligned.h	2002-02-05 09:39:44 -08:00
+++ edited/include/asm-generic/unaligned.h	2005-03-17 10:25:14 -08:00
@@ -4,17 +4,118 @@
 /*
  * For the benefit of those who are trying to port Linux to another
  * architecture, here are some C-language equivalents. 
+ *
+ * This is based almost entirely upon Richard Henderson's
+ * asm-alpha/unaligned.h implementation.  Some comments were
+ * taken from David Mosberger's asm-ia64/unaligned.h header.
  */
 
-#include <asm/string.h>
-
+#include <linux/types.h>
 
+/* 
+ * The main single-value unaligned transfer routines.
+ */
 #define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memcpy(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
+	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
+#define put_unaligned(x,ptr) \
+	__put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
+
+/*
+ * This function doesn't actually exist.  The idea is that when
+ * someone uses the macros below with an unsupported size (datatype),
+ * the linker will alert us to the problem via an unresolved reference
+ * error.
+ */
+extern void bad_unaligned_access_length(void) __attribute__((noreturn));
+
+struct __una_u64 { __u64 x __attribute__((packed)); };
+struct __una_u32 { __u32 x __attribute__((packed)); };
+struct __una_u16 { __u16 x __attribute__((packed)); };
+
+/*
+ * Elemental unaligned loads 
+ */
+
+static inline unsigned long __uldq(const __u64 *addr)
+{
+	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
+	return ptr->x;
+}
+
+static inline unsigned long __uldl(const __u32 *addr)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
+	return ptr->x;
+}
+
+static inline unsigned long __uldw(const __u16 *addr)
+{
+	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
+	return ptr->x;
+}
+
+/*
+ * Elemental unaligned stores 
+ */
+
+static inline void __ustq(__u64 val, __u64 *addr)
+{
+	struct __una_u64 *ptr = (struct __una_u64 *) addr;
+	ptr->x = val;
+}
+
+static inline void __ustl(__u32 val, __u32 *addr)
+{
+	struct __una_u32 *ptr = (struct __una_u32 *) addr;
+	ptr->x = val;
+}
+
+static inline void __ustw(__u16 val, __u16 *addr)
+{
+	struct __una_u16 *ptr = (struct __una_u16 *) addr;
+	ptr->x = val;
+}
+
+static inline unsigned long __get_unaligned(const void *ptr, size_t size)
+{
+	unsigned long val;
+	switch (size) {
+	case 1:
+		val = *(const __u8 *)ptr;
+		break;
+	case 2:
+		val = __uldw((const __u16 *)ptr);
+		break;
+	case 4:
+		val = __uldl((const __u32 *)ptr);
+		break;
+	case 8:
+		val = __uldq((const __u64 *)ptr);
+		break;
+	default:
+		bad_unaligned_access_length();
+	};
+	return val;
+}
 
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memcpy((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+static inline void __put_unaligned(unsigned long val, void *ptr, size_t size)
+{
+	switch (size) {
+	case 1:
+		*(__u8 *)ptr = val;
+	        break;
+	case 2:
+		__ustw(val, (__u16 *)ptr);
+		break;
+	case 4:
+		__ustl(val, (__u32 *)ptr);
+		break;
+	case 8:
+		__ustq(val, (__u64 *)ptr);
+		break;
+	default:
+	    	bad_unaligned_access_length();
+	};
+}
 
 #endif /* _ASM_GENERIC_UNALIGNED_H */
===== include/asm-ia64/unaligned.h 1.4 vs edited =====
--- 1.4/include/asm-ia64/unaligned.h	2004-01-23 10:52:25 -08:00
+++ edited/include/asm-ia64/unaligned.h	2005-03-17 10:25:54 -08:00
@@ -1,121 +1,6 @@
 #ifndef _ASM_IA64_UNALIGNED_H
 #define _ASM_IA64_UNALIGNED_H
 
-#include <linux/types.h>
-
-/*
- * The main single-value unaligned transfer routines.
- *
- * Based on <asm-alpha/unaligned.h>.
- *
- * Copyright (C) 1998, 1999, 2003 Hewlett-Packard Co
- *	David Mosberger-Tang <davidm@hpl.hp.com>
- */
-#define get_unaligned(ptr) \
-	((__typeof__(*(ptr)))ia64_get_unaligned((ptr), sizeof(*(ptr))))
-
-#define put_unaligned(x,ptr) \
-	ia64_put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-static inline unsigned long
-__uld8 (const unsigned long * addr)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) addr;
-	return ptr->x;
-}
-
-static inline unsigned long
-__uld4 (const unsigned int * addr)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) addr;
-	return ptr->x;
-}
-
-static inline unsigned long
-__uld2 (const unsigned short * addr)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) addr;
-	return ptr->x;
-}
-
-static inline void
-__ust8 (unsigned long val, unsigned long * addr)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) addr;
-	ptr->x = val;
-}
-
-static inline void
-__ust4 (unsigned long val, unsigned int * addr)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) addr;
-	ptr->x = val;
-}
-
-static inline void
-__ust2 (unsigned long val, unsigned short * addr)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) addr;
-	ptr->x = val;
-}
-
-
-/*
- * This function doesn't actually exist.  The idea is that when someone uses the macros
- * below with an unsupported size (datatype), the linker will alert us to the problem via
- * an unresolved reference error.
- */
-extern unsigned long ia64_bad_unaligned_access_length (void);
-
-#define ia64_get_unaligned(_ptr,size)						\
-({										\
-	const void *__ia64_ptr = (_ptr);					\
-	unsigned long __ia64_val;						\
-										\
-	switch (size) {								\
-	      case 1:								\
-		__ia64_val = *(const unsigned char *) __ia64_ptr;		\
-		break;								\
-	      case 2:								\
-		__ia64_val = __uld2((const unsigned short *)__ia64_ptr);	\
-		break;								\
-	      case 4:								\
-		__ia64_val = __uld4((const unsigned int *)__ia64_ptr);		\
-		break;								\
-	      case 8:								\
-		__ia64_val = __uld8((const unsigned long *)__ia64_ptr);		\
-		break;								\
-	      default:								\
-		__ia64_val = ia64_bad_unaligned_access_length();		\
-	}									\
-	__ia64_val;								\
-})
-
-#define ia64_put_unaligned(_val,_ptr,size)				\
-do {									\
-	const void *__ia64_ptr = (_ptr);				\
-	unsigned long __ia64_val = (_val);				\
-									\
-	switch (size) {							\
-	      case 1:							\
-		*(unsigned char *)__ia64_ptr = (__ia64_val);		\
-	        break;							\
-	      case 2:							\
-		__ust2(__ia64_val, (unsigned short *)__ia64_ptr);	\
-		break;							\
-	      case 4:							\
-		__ust4(__ia64_val, (unsigned int *)__ia64_ptr);		\
-		break;							\
-	      case 8:							\
-		__ust8(__ia64_val, (unsigned long *)__ia64_ptr);	\
-		break;							\
-	      default:							\
-	    	ia64_bad_unaligned_access_length();			\
-	}								\
-} while (0)
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_IA64_UNALIGNED_H */
===== include/asm-mips/unaligned.h 1.5 vs edited =====
--- 1.5/include/asm-mips/unaligned.h	2004-02-19 12:53:03 -08:00
+++ edited/include/asm-mips/unaligned.h	2005-03-17 10:43:02 -08:00
@@ -9,136 +9,6 @@
 #ifndef _ASM_UNALIGNED_H
 #define _ASM_UNALIGNED_H
 
-#include <linux/types.h>
-
-/*
- * get_unaligned - get value from possibly mis-aligned location
- * @ptr: pointer to value
- *
- * This macro should be used for accessing values larger in size than
- * single bytes at locations that are expected to be improperly aligned,
- * e.g. retrieving a u16 value from a location not u16-aligned.
- *
- * Note that unaligned accesses can be very expensive on some architectures.
- */
-#define get_unaligned(ptr) \
-	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
-
-/*
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
-#define put_unaligned(x,ptr) \
-	__put_unaligned((__u64)(x), (ptr), sizeof(*(ptr)))
-
-/*
- * This is a silly but good way to make sure that
- * the get/put functions are indeed always optimized,
- * and that we use the correct sizes.
- */
-extern void bad_unaligned_access_length(void);
-
-/*
- * EGCS 1.1 knows about arbitrary unaligned loads.  Define some
- * packed structures to talk about such things with.
- */
-
-struct __una_u64 { __u64 x __attribute__((packed)); };
-struct __una_u32 { __u32 x __attribute__((packed)); };
-struct __una_u16 { __u16 x __attribute__((packed)); };
-
-/*
- * Elemental unaligned loads 
- */
-
-static inline __u64 __uldq(const __u64 * r11)
-{
-	const struct __una_u64 *ptr = (const struct __una_u64 *) r11;
-	return ptr->x;
-}
-
-static inline __u32 __uldl(const __u32 * r11)
-{
-	const struct __una_u32 *ptr = (const struct __una_u32 *) r11;
-	return ptr->x;
-}
-
-static inline __u16 __uldw(const __u16 * r11)
-{
-	const struct __una_u16 *ptr = (const struct __una_u16 *) r11;
-	return ptr->x;
-}
-
-/*
- * Elemental unaligned stores 
- */
-
-static inline void __ustq(__u64 r5, __u64 * r11)
-{
-	struct __una_u64 *ptr = (struct __una_u64 *) r11;
-	ptr->x = r5;
-}
-
-static inline void __ustl(__u32 r5, __u32 * r11)
-{
-	struct __una_u32 *ptr = (struct __una_u32 *) r11;
-	ptr->x = r5;
-}
-
-static inline void __ustw(__u16 r5, __u16 * r11)
-{
-	struct __una_u16 *ptr = (struct __una_u16 *) r11;
-	ptr->x = r5;
-}
-
-static inline __u64 __get_unaligned(const void *ptr, size_t size)
-{
-	__u64 val;
-
-	switch (size) {
-	case 1:
-		val = *(const __u8 *)ptr;
-		break;
-	case 2:
-		val = __uldw((const __u16 *)ptr);
-		break;
-	case 4:
-		val = __uldl((const __u32 *)ptr);
-		break;
-	case 8:
-		val = __uldq((const __u64 *)ptr);
-		break;
-	default:
-		bad_unaligned_access_length();
-	}
-	return val;
-}
-
-static inline void __put_unaligned(__u64 val, void *ptr, size_t size)
-{
-	switch (size) {
-	      case 1:
-		*(__u8 *)ptr = (val);
-	        break;
-	      case 2:
-		__ustw(val, (__u16 *)ptr);
-		break;
-	      case 4:
-		__ustl(val, (__u32 *)ptr);
-		break;
-	      case 8:
-		__ustq(val, (__u64 *)ptr);
-		break;
-	      default:
-	    	bad_unaligned_access_length();
-	}
-}
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_UNALIGNED_H */
===== include/asm-parisc/unaligned.h 1.2 vs edited =====
--- 1.2/include/asm-parisc/unaligned.h	2002-07-20 02:52:25 -07:00
+++ edited/include/asm-parisc/unaligned.h	2005-03-17 10:44:06 -08:00
@@ -1,22 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-/* parisc can't handle unaligned accesses. */
-/* copied from asm-sparc/unaligned.h */
-
-#include <linux/string.h>
-
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
+#include <asm-parisc/unaligned.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
===== include/asm-sh/unaligned.h 1.1 vs edited =====
--- 1.1/include/asm-sh/unaligned.h	2002-02-05 09:39:53 -08:00
+++ edited/include/asm-sh/unaligned.h	2005-03-17 10:45:52 -08:00
@@ -2,18 +2,6 @@
 #define __ASM_SH_UNALIGNED_H
 
 /* SH can't handle unaligned accesses. */
-
-#include <linux/string.h>
-
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
+#include <asm-generic/unaligned.h>
 
 #endif /* __ASM_SH_UNALIGNED_H */
===== include/asm-sh64/unaligned.h 1.1 vs edited =====
--- 1.1/include/asm-sh64/unaligned.h	2004-06-29 07:44:46 -07:00
+++ edited/include/asm-sh64/unaligned.h	2005-03-17 10:46:04 -08:00
@@ -12,17 +12,6 @@
  *
  */
 
-#include <linux/string.h>
-
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
+#include <asm-generic/unaligned.h>
 
 #endif /* __ASM_SH64_UNALIGNED_H */
===== include/asm-sparc/unaligned.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/unaligned.h	2002-02-05 09:39:48 -08:00
+++ edited/include/asm-sparc/unaligned.h	2005-03-17 10:38:21 -08:00
@@ -1,19 +1,6 @@
 #ifndef _ASM_SPARC_UNALIGNED_H_
 #define _ASM_SPARC_UNALIGNED_H_
 
-/* Sparc can't handle unaligned accesses. */
-
-#include <linux/string.h>
-
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
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_SPARC_UNALIGNED_H */
===== include/asm-sparc64/unaligned.h 1.1 vs edited =====
--- 1.1/include/asm-sparc64/unaligned.h	2002-02-05 09:39:50 -08:00
+++ edited/include/asm-sparc64/unaligned.h	2005-03-17 10:26:04 -08:00
@@ -1,19 +1,6 @@
 #ifndef _ASM_SPARC64_UNALIGNED_H_
 #define _ASM_SPARC64_UNALIGNED_H_
 
-/* Sparc can't handle unaligned accesses. */
-
-#include <linux/string.h>
-
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
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_SPARC64_UNALIGNED_H */
