Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:21641 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264578AbUEMUfs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 16:35:48 -0400
Message-Id: <200405132035.i4DKZlJ11505@mail.osdl.org>
Subject: [patch 4/4] Implement atomic_inc_and_test() on various architectures
From: akpm@osdl.org
Date: Thu, 13 May 2004 13:38:24 -0700
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>



It's easy to do when the arch provides atomic_inc_return().



---

 25-akpm/include/asm-h8300/atomic.h     |   10 ++++++++++
 25-akpm/include/asm-m68knommu/atomic.h |   10 ++++++++++
 25-akpm/include/asm-parisc/atomic.h    |   10 ++++++++++
 25-akpm/include/asm-ppc/atomic.h       |   10 ++++++++++
 25-akpm/include/asm-ppc64/atomic.h     |   10 ++++++++++
 25-akpm/include/asm-s390/atomic.h      |    1 +
 25-akpm/include/asm-sh/atomic.h        |   10 ++++++++++
 25-akpm/include/asm-sparc/atomic.h     |   10 ++++++++++
 25-akpm/include/asm-sparc64/atomic.h   |   10 ++++++++++
 25-akpm/include/asm-v850/atomic.h      |   10 ++++++++++
 10 files changed, 91 insertions(+)

diff -puN include/asm-h8300/atomic.h~arch-atomic_inc_and_test include/asm-h8300/atomic.h
--- 25/include/asm-h8300/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-h8300/atomic.h	Thu May 13 13:36:21 2004
@@ -50,6 +50,16 @@ static __inline__ int atomic_inc_return(
 
 #define atomic_inc(v) atomic_inc_return(v)
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 static __inline__ int atomic_dec_return(atomic_t *v)
 {
 	int ret,flags;
diff -puN include/asm-m68knommu/atomic.h~arch-atomic_inc_and_test include/asm-m68knommu/atomic.h
--- 25/include/asm-m68knommu/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-m68knommu/atomic.h	Thu May 13 13:36:21 2004
@@ -114,6 +114,16 @@ extern __inline__ int atomic_sub_return(
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 
diff -puN include/asm-parisc/atomic.h~arch-atomic_inc_and_test include/asm-parisc/atomic.h
--- 25/include/asm-parisc/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-parisc/atomic.h	Thu May 13 13:36:21 2004
@@ -187,6 +187,16 @@ static __inline__ int atomic_read(const 
 
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_dec_and_test(v)	(atomic_dec_return(v) == 0)
 
 #define ATOMIC_INIT(i)	{ (i) }
diff -puN include/asm-ppc64/atomic.h~arch-atomic_inc_and_test include/asm-ppc64/atomic.h
--- 25/include/asm-ppc64/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-ppc64/atomic.h	Thu May 13 13:36:21 2004
@@ -120,6 +120,16 @@ static __inline__ int atomic_inc_return(
 	return t;
 }
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 static __inline__ void atomic_dec(atomic_t *v)
 {
 	int t;
diff -puN include/asm-ppc/atomic.h~arch-atomic_inc_and_test include/asm-ppc/atomic.h
--- 25/include/asm-ppc/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-ppc/atomic.h	Thu May 13 13:36:21 2004
@@ -134,6 +134,16 @@ static __inline__ int atomic_inc_return(
 	return t;
 }
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 static __inline__ void atomic_dec(atomic_t *v)
 {
 	int t;
diff -puN include/asm-s390/atomic.h~arch-atomic_inc_and_test include/asm-s390/atomic.h
--- 25/include/asm-s390/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-s390/atomic.h	Thu May 13 13:36:21 2004
@@ -69,6 +69,7 @@ static __inline__ int atomic_inc_return(
 {
 	return __CS_LOOP(v, 1, "ar");
 }
+
 static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
 {
 	return __CS_LOOP(v, 1, "ar") != 0;
diff -puN include/asm-sh/atomic.h~arch-atomic_inc_and_test include/asm-sh/atomic.h
--- 25/include/asm-sh/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-sh/atomic.h	Thu May 13 13:36:21 2004
@@ -71,6 +71,16 @@ static __inline__ int atomic_sub_return(
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v) (atomic_sub_return(1, (v)) == 0)
 
diff -puN include/asm-sparc64/atomic.h~arch-atomic_inc_and_test include/asm-sparc64/atomic.h
--- 25/include/asm-sparc64/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-sparc64/atomic.h	Thu May 13 13:36:21 2004
@@ -40,6 +40,16 @@ extern int __atomic64_sub(__s64, atomic6
 #define atomic_inc_return(v) __atomic_add(1, v)
 #define atomic64_inc_return(v) __atomic64_add(1, v)
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_sub_and_test(i, v) (__atomic_sub(i, v) == 0)
 #define atomic64_sub_and_test(i, v) (__atomic64_sub(i, v) == 0)
 
diff -puN include/asm-sparc/atomic.h~arch-atomic_inc_and_test include/asm-sparc/atomic.h
--- 25/include/asm-sparc/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-sparc/atomic.h	Thu May 13 13:36:21 2004
@@ -35,6 +35,16 @@ extern void atomic_set(atomic_t *, int);
 
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_dec_and_test(v) (atomic_dec_return(v) == 0)
 
 /* This is the old 24-bit implementation.  It's still used internally
diff -puN include/asm-v850/atomic.h~arch-atomic_inc_and_test include/asm-v850/atomic.h
--- 25/include/asm-v850/atomic.h~arch-atomic_inc_and_test	Thu May 13 13:36:21 2004
+++ 25-akpm/include/asm-v850/atomic.h	Thu May 13 13:36:21 2004
@@ -76,6 +76,16 @@ static __inline__ void atomic_clear_mask
 #define atomic_inc(v) 		atomic_inc_return (v)
 #define atomic_dec(v) 		atomic_dec_return (v)
 
+/*
+ * atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+
 #define atomic_sub_and_test(i,v)	(atomic_sub_return ((i), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_sub_return (1, (v)) == 0)
 #define atomic_add_negative(i,v)	(atomic_add_return ((i), (v)) < 0)

_
