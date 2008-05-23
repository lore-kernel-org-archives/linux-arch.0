From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 2/2] Examples using new linux/byteorder.h alpha/arm/x86
Date: Fri, 23 May 2008 11:01:07 -0700
Message-ID: <1211565667.6888.30.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:62530 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbYEWSBJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 May 2008 14:01:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so616128wfd.4
        for <linux-arch@vger.kernel.org>; Fri, 23 May 2008 11:01:09 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/asm-alpha/byteorder.h |   13 ++++---------
 include/asm-arm/byteorder.h   |   23 ++++++++++-------------
 include/asm-x86/byteorder.h   |   29 +++++++++++++++--------------
 3 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/include/asm-alpha/byteorder.h b/include/asm-alpha/byteorder.h
index 58e958f..cc9d368 100644
--- a/include/asm-alpha/byteorder.h
+++ b/include/asm-alpha/byteorder.h
@@ -5,9 +5,9 @@
 #include <linux/compiler.h>
 #include <asm/compiler.h>
 
-#ifdef __GNUC__
+#define __LITTLE_ENDIAN
 
-static inline __attribute_const__ __u32 __arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	/*
 	 * Unfortunately, we can't use the 6 instruction sequence
@@ -35,13 +35,8 @@ static inline __attribute_const__ __u32 __arch__swab32(__u32 x)
 
 	return t1;
 }
+#define HAVE_ARCH_SWAB32
 
-#define __arch__swab32 __arch__swab32
-
-#endif /* __GNUC__ */
-
-#define __BYTEORDER_HAS_U64__
-
-#include <linux/byteorder/little_endian.h>
+#include <linux/byteorder.h>
 
 #endif /* _ALPHA_BYTEORDER_H */
diff --git a/include/asm-arm/byteorder.h b/include/asm-arm/byteorder.h
index e6f7fcd..2e41cda 100644
--- a/include/asm-arm/byteorder.h
+++ b/include/asm-arm/byteorder.h
@@ -18,7 +18,13 @@
 #include <linux/compiler.h>
 #include <asm/types.h>
 
-static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
+#ifdef __ARMEB__
+# define __BIG_ENDIAN
+#else
+# define __LITTLE_ENDIAN
+#endif
+
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	__u32 t;
 
@@ -40,19 +46,10 @@ static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
 
 	return x;
 }
+#define HAVE_ARCH_SWAB32
 
-#define __arch__swab32(x) ___arch__swab32(x)
-
-#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#  define __BYTEORDER_HAS_U64__
-#  define __SWAB_64_THRU_32__
-#endif
+#define __SWAB_64_THRU_32__
 
-#ifdef __ARMEB__
-#include <linux/byteorder/big_endian.h>
-#else
-#include <linux/byteorder/little_endian.h>
-#endif
+#include <linux/byteorder.h>
 
 #endif
-
diff --git a/include/asm-x86/byteorder.h b/include/asm-x86/byteorder.h
index e02ae2d..e6cc54e 100644
--- a/include/asm-x86/byteorder.h
+++ b/include/asm-x86/byteorder.h
@@ -4,25 +4,28 @@
 #include <asm/types.h>
 #include <linux/compiler.h>
 
+#define __LITTLE_ENDIAN
+
 #ifdef __GNUC__
 
 #ifdef __i386__
 
-static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 val)
 {
 #ifdef CONFIG_X86_BSWAP
-	asm("bswap %0" : "=r" (x) : "0" (x));
+	asm("bswap %0" : "=r" (val) : "0" (val));
 #else
 	asm("xchgb %b0,%h0\n\t"	/* swap lower bytes	*/
 	    "rorl $16,%0\n\t"	/* swap words		*/
 	    "xchgb %b0,%h0"	/* swap higher bytes	*/
-	    : "=q" (x)
-	    : "0" (x));
+	    : "=q" (val)
+	    : "0" (val));
 #endif
-	return x;
+	return val;
 }
+#define HAVE_ARCH_SWAB32
 
-static inline __attribute_const__ __u64 ___arch__swab64(__u64 val)
+static inline __attribute_const__ __u64 __arch_swab64(__u64 val)
 {
 	union {
 		struct {
@@ -45,37 +48,35 @@ static inline __attribute_const__ __u64 ___arch__swab64(__u64 val)
 #endif
 	return v.u;
 }
+#define HAVE_ARCH_SWAB64
 
 #else /* __i386__ */
 
-static inline __attribute_const__ __u64 ___arch__swab64(__u64 x)
+static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	asm("bswapq %0"
 	    : "=r" (x)
 	    : "0" (x));
 	return x;
 }
+#define HAVE_ARCH_SWAB64
 
-static inline __attribute_const__ __u32 ___arch__swab32(__u32 x)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 {
 	asm("bswapl %0"
 	    : "=r" (x)
 	    : "0" (x));
 	return x;
 }
+#define HAVE_ARCH_SWAB32
 
 #endif
 
 /* Do not define swab16.  Gcc is smart enough to recognize "C" version and
    convert it into rotation or exhange.  */
 
-#define __arch__swab64(x) ___arch__swab64(x)
-#define __arch__swab32(x) ___arch__swab32(x)
-
-#define __BYTEORDER_HAS_U64__
-
 #endif /* __GNUC__ */
 
-#include <linux/byteorder/little_endian.h>
+#include <linux/byteorder.h>
 
 #endif /* _ASM_X86_BYTEORDER_H */
-- 
1.5.5.1.579.g4e43
