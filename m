From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v5 8/8] ARM: atomics: define our SMP atomics in terms of _relaxed operations
Date: Thu,  6 Aug 2015 17:54:44 +0100
Message-ID: <1438880084-18856-9-git-send-email-will.deacon@arm.com>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

By defining our SMP atomics in terms of relaxed operations, we gain
a small reduction in code size and have acquire/release/fence variants
generated automatically by the core code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/atomic.h  | 37 ++++++++++++++-------------------
 arch/arm/include/asm/cmpxchg.h | 47 +++++++-----------------------------------
 2 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index e22c11970b7b..bc9da3a3ff5e 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -57,12 +57,11 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
 									\
-	smp_mb();							\
 	prefetchw(&v->counter);						\
 									\
 	__asm__ __volatile__("@ atomic_" #op "_return\n"		\
@@ -75,17 +74,17 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 	: "r" (&v->counter), "Ir" (i)					\
 	: "cc");							\
 									\
-	smp_mb();							\
-									\
 	return result;							\
 }
 
-static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+
+static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 {
 	int oldval;
 	unsigned long res;
 
-	smp_mb();
 	prefetchw(&ptr->counter);
 
 	do {
@@ -99,10 +98,9 @@ static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
 		    : "cc");
 	} while (res);
 
-	smp_mb();
-
 	return oldval;
 }
+#define atomic_cmpxchg_relaxed		atomic_cmpxchg_relaxed
 
 static inline int __atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -290,12 +288,12 @@ static inline void atomic64_##op(long long i, atomic64_t *v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)				\
-static inline long long atomic64_##op##_return(long long i, atomic64_t *v) \
+static inline long long							\
+atomic64_##op##_return_relaxed(long long i, atomic64_t *v)		\
 {									\
 	long long result;						\
 	unsigned long tmp;						\
 									\
-	smp_mb();							\
 	prefetchw(&v->counter);						\
 									\
 	__asm__ __volatile__("@ atomic64_" #op "_return\n"		\
@@ -309,8 +307,6 @@ static inline long long atomic64_##op##_return(long long i, atomic64_t *v) \
 	: "r" (&v->counter), "r" (i)					\
 	: "cc");							\
 									\
-	smp_mb();							\
-									\
 	return result;							\
 }
 
@@ -321,17 +317,19 @@ static inline long long atomic64_##op##_return(long long i, atomic64_t *v) \
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
 
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static inline long long atomic64_cmpxchg(atomic64_t *ptr, long long old,
-					long long new)
+static inline long long
+atomic64_cmpxchg_relaxed(atomic64_t *ptr, long long old, long long new)
 {
 	long long oldval;
 	unsigned long res;
 
-	smp_mb();
 	prefetchw(&ptr->counter);
 
 	do {
@@ -346,17 +344,15 @@ static inline long long atomic64_cmpxchg(atomic64_t *ptr, long long old,
 		: "cc");
 	} while (res);
 
-	smp_mb();
-
 	return oldval;
 }
+#define atomic64_cmpxchg_relaxed	atomic64_cmpxchg_relaxed
 
-static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
+static inline long long atomic64_xchg_relaxed(atomic64_t *ptr, long long new)
 {
 	long long result;
 	unsigned long tmp;
 
-	smp_mb();
 	prefetchw(&ptr->counter);
 
 	__asm__ __volatile__("@ atomic64_xchg\n"
@@ -368,10 +364,9 @@ static inline long long atomic64_xchg(atomic64_t *ptr, long long new)
 	: "r" (&ptr->counter), "r" (new)
 	: "cc");
 
-	smp_mb();
-
 	return result;
 }
+#define atomic64_xchg_relaxed		atomic64_xchg_relaxed
 
 static inline long long atomic64_dec_if_positive(atomic64_t *v)
 {
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 1692a05d3207..916a2744d5c6 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -35,7 +35,6 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	unsigned int tmp;
 #endif
 
-	smp_mb();
 	prefetchw((const void *)ptr);
 
 	switch (size) {
@@ -98,12 +97,11 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 		__bad_xchg(ptr, size), ret = 0;
 		break;
 	}
-	smp_mb();
 
 	return ret;
 }
 
-#define xchg(ptr, x) ({							\
+#define xchg_relaxed(ptr, x) ({						\
 	(__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr),		\
 				   sizeof(*(ptr)));			\
 })
@@ -117,6 +115,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 #error "SMP is not supported on this platform"
 #endif
 
+#define xchg xchg_relaxed
+
 /*
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
@@ -194,23 +194,11 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	return oldval;
 }
 
-static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
-					 unsigned long new, int size)
-{
-	unsigned long ret;
-
-	smp_mb();
-	ret = __cmpxchg(ptr, old, new, size);
-	smp_mb();
-
-	return ret;
-}
-
-#define cmpxchg(ptr,o,n) ({						\
-	(__typeof__(*(ptr)))__cmpxchg_mb((ptr),				\
-					 (unsigned long)(o),		\
-					 (unsigned long)(n),		\
-					 sizeof(*(ptr)));		\
+#define cmpxchg_relaxed(ptr,o,n) ({					\
+	(__typeof__(*(ptr)))__cmpxchg((ptr),				\
+				      (unsigned long)(o),		\
+				      (unsigned long)(n),		\
+				      sizeof(*(ptr)));			\
 })
 
 static inline unsigned long __cmpxchg_local(volatile void *ptr,
@@ -273,25 +261,6 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 
 #define cmpxchg64_local(ptr, o, n) cmpxchg64_relaxed((ptr), (o), (n))
 
-static inline unsigned long long __cmpxchg64_mb(unsigned long long *ptr,
-						unsigned long long old,
-						unsigned long long new)
-{
-	unsigned long long ret;
-
-	smp_mb();
-	ret = __cmpxchg64(ptr, old, new);
-	smp_mb();
-
-	return ret;
-}
-
-#define cmpxchg64(ptr, o, n) ({						\
-	(__typeof__(*(ptr)))__cmpxchg64_mb((ptr),			\
-					   (unsigned long long)(o),	\
-					   (unsigned long long)(n));	\
-})
-
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
 #endif /* __ASM_ARM_CMPXCHG_H */
-- 
2.1.4
