Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Consolidation of asm/unaligned.h
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20050317104744.4be7e550.davem@davemloft.net>
References: <20050317104744.4be7e550.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 22:42:41 -0500
Message-Id: <1112586161.7087.3.camel@mulgrave>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I just got around to checking this on parisc, and I'm afraid we have a
toolchain cockup:  Our gcc can't optimise the sizeof() if the user is an
inline function.  It can, however if the functions are made #defines
instead.

Would the attached be OK with everyone?  It works fine for us.

Thanks,

James

===== include/asm-generic/unaligned.h 1.2 vs edited =====
--- 1.2/include/asm-generic/unaligned.h	2005-03-17 15:54:10 -06:00
+++ edited/include/asm-generic/unaligned.h	2005-04-03 21:17:14 -05:00
@@ -12,14 +12,6 @@
 
 #include <linux/types.h>
 
-/* 
- * The main single-value unaligned transfer routines.
- */
-#define get_unaligned(ptr) \
-	((__typeof__(*(ptr)))__get_unaligned((ptr), sizeof(*(ptr))))
-#define put_unaligned(x,ptr) \
-	__put_unaligned((unsigned long)(x), (ptr), sizeof(*(ptr)))
-
 /*
  * This function doesn't actually exist.  The idea is that when
  * someone uses the macros below with an unsupported size (datatype),
@@ -76,46 +68,44 @@
 	ptr->x = val;
 }
 
-static inline unsigned long __get_unaligned(const void *ptr, size_t size)
-{
-	unsigned long val;
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
-	};
-	return val;
-}
-
-static inline void __put_unaligned(unsigned long val, void *ptr, size_t size)
-{
-	switch (size) {
-	case 1:
-		*(__u8 *)ptr = val;
-	        break;
-	case 2:
-		__ustw(val, (__u16 *)ptr);
-		break;
-	case 4:
-		__ustl(val, (__u32 *)ptr);
-		break;
-	case 8:
-		__ustq(val, (__u64 *)ptr);
-		break;
-	default:
-	    	bad_unaligned_access_length();
-	};
-}
+#define get_unaligned(ptr) ({				\
+	unsigned long val;				\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+		val = *(const __u8 *)(ptr);		\
+		break;					\
+	case 2:						\
+		val = __uldw((const __u16 *)(ptr));	\
+		break;					\
+	case 4:						\
+		val = __uldl((const __u32 *)(ptr));	\
+		break;					\
+	case 8:						\
+		val = __uldq((const __u64 *)(ptr));	\
+		break;					\
+	default:					\
+		bad_unaligned_access_length();		\
+	};						\
+	(__typeof__(*(ptr)))val;			\
+})
+
+#define put_unaligned(val, ptr) ({			\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+		*(__u8 *)(ptr) = (val);			\
+	        break;					\
+	case 2:						\
+		__ustw(val, (__u16 *)(ptr));		\
+		break;					\
+	case 4:						\
+		__ustl(val, (__u32 *)(ptr));		\
+		break;					\
+	case 8:						\
+		__ustq(val, (__u64 *)(ptr));		\
+		break;					\
+	default:					\
+	    	bad_unaligned_access_length();		\
+	};						\
+})
 
 #endif /* _ASM_GENERIC_UNALIGNED_H */
===== include/asm-parisc/unaligned.h 1.3 vs edited =====
--- 1.3/include/asm-parisc/unaligned.h	2005-03-17 15:54:10 -06:00
+++ edited/include/asm-parisc/unaligned.h	2005-04-03 16:14:55 -05:00
@@ -1,7 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-#include <asm-parisc/unaligned.h>
+#include <asm-generic/unaligned.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
