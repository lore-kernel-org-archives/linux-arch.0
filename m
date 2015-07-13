From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 3/5] asm-generic: add relaxed/acquire/release variants for atomic_long_t
Date: Mon, 13 Jul 2015 13:31:25 +0100
Message-ID: <1436790687-11984-4-git-send-email-will.deacon@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

This patch adds atomic_long_t wrappers for the new relaxed atomic
operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/atomic-long.h | 86 +++++++++++++++++++++++++++------------
 include/linux/atomic.h            | 10 ++---
 2 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index beaea541adfb..a94cbebbc33d 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -34,19 +34,69 @@ typedef atomic_t atomic_long_t;
 
 #endif
 
-static inline long atomic_long_read(atomic_long_t *l)
-{
-	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
-
-	return (long)ATOMIC_LONG_PFX(_read)(v);
+#define ATOMIC_LONG_READ_OP(mo)						\
+static inline long atomic_long_read##mo(atomic_long_t *l)		\
+{									\
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;		\
+									\
+	return (long)ATOMIC_LONG_PFX(_read##mo)(v);			\
 }
+ATOMIC_LONG_READ_OP()
+ATOMIC_LONG_READ_OP(_acquire)
 
-static inline void atomic_long_set(atomic_long_t *l, long i)
-{
-	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
+#undef ATOMIC_LONG_READ_OP
 
-	ATOMIC_LONG_PFX(_set)(v, i);
+#define ATOMIC_LONG_SET_OP(mo)						\
+static inline void atomic_long_set##mo(atomic_long_t *l, long i)	\
+{									\
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;		\
+									\
+	ATOMIC_LONG_PFX(_set##mo)(v, i);				\
+}
+ATOMIC_LONG_SET_OP()
+ATOMIC_LONG_SET_OP(_release)
+
+#undef ATOMIC_LONG_SET_OP
+
+#define ATOMIC_LONG_ADD_SUB_OP(op, mo)					\
+static inline long							\
+atomic_long_##op##_return##mo(long i, atomic_long_t *l)			\
+{									\
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;		\
+									\
+	return (long)ATOMIC_LONG_PFX(_##op##_return##mo)(i, v);		\
 }
+ATOMIC_LONG_ADD_SUB_OP(add,)
+ATOMIC_LONG_ADD_SUB_OP(add, _relaxed)
+ATOMIC_LONG_ADD_SUB_OP(add, _acquire)
+ATOMIC_LONG_ADD_SUB_OP(add, _release)
+ATOMIC_LONG_ADD_SUB_OP(sub,)
+ATOMIC_LONG_ADD_SUB_OP(sub, _relaxed)
+ATOMIC_LONG_ADD_SUB_OP(sub, _acquire)
+ATOMIC_LONG_ADD_SUB_OP(sub, _release)
+
+#undef ATOMIC_LONG_ADD_SUB_OP
+
+#define atomic_long_cmpxchg_relaxed(l, old, new) \
+	(ATOMIC_LONG_PFX(_cmpxchg_relaxed)((ATOMIC_LONG_PFX(_t) *)(l), \
+					   (old), (new)))
+#define atomic_long_cmpxchg_acquire(l, old, new) \
+	(ATOMIC_LONG_PFX(_cmpxchg_acquire)((ATOMIC_LONG_PFX(_t) *)(l), \
+					   (old), (new)))
+#define atomic_long_cmpxchg_release(l, old, new) \
+	(ATOMIC_LONG_PFX(_cmpxchg_release)((ATOMIC_LONG_PFX(_t) *)(l), \
+					   (old), (new)))
+#define atomic_long_cmpxchg(l, old, new) \
+	(ATOMIC_LONG_PFX(_cmpxchg)((ATOMIC_LONG_PFX(_t) *)(l), (old), (new)))
+
+#define atomic_long_xchg_relaxed(v, new) \
+	(ATOMIC_LONG_PFX(_xchg_relaxed)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
+#define atomic_long_xchg_acquire(v, new) \
+	(ATOMIC_LONG_PFX(_xchg_acquire)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
+#define atomic_long_xchg_release(v, new) \
+	(ATOMIC_LONG_PFX(_xchg_release)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
+#define atomic_long_xchg(v, new) \
+	(ATOMIC_LONG_PFX(_xchg)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
 
 static inline void atomic_long_inc(atomic_long_t *l)
 {
@@ -104,20 +154,6 @@ static inline int atomic_long_add_negative(long i, atomic_long_t *l)
 	return ATOMIC_LONG_PFX(_add_negative)(i, v);
 }
 
-static inline long atomic_long_add_return(long i, atomic_long_t *l)
-{
-	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
-
-	return (long)ATOMIC_LONG_PFX(_add_return)(i, v);
-}
-
-static inline long atomic_long_sub_return(long i, atomic_long_t *l)
-{
-	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
-
-	return (long)ATOMIC_LONG_PFX(_sub_return)(i, v);
-}
-
 static inline long atomic_long_inc_return(atomic_long_t *l)
 {
 	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
@@ -141,9 +177,5 @@ static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 
 #define atomic_long_inc_not_zero(l) \
 	ATOMIC_LONG_PFX(_inc_not_zero)((ATOMIC_LONG_PFX(_t) *)(l))
-#define atomic_long_cmpxchg(l, old, new) \
-	(ATOMIC_LONG_PFX(_cmpxchg)((ATOMIC_LONG_PFX(_t) *)(l), (old), (new)))
-#define atomic_long_xchg(v, new) \
-	(ATOMIC_LONG_PFX(_xchg)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
 
 #endif  /*  _ASM_GENERIC_ATOMIC_LONG_H  */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index a78c3704cd51..a8b4c68790de 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -124,11 +124,6 @@ static inline void atomic_or(int i, atomic_t *v)
 }
 #endif /* #ifndef CONFIG_ARCH_HAS_ATOMIC_OR */
 
-#include <asm-generic/atomic-long.h>
-#ifdef CONFIG_GENERIC_ATOMIC64
-#include <asm-generic/atomic64.h>
-#endif
-
 /*
  * Relaxed variants of xchg, cmpxchg and some atomic operations.
  *
@@ -268,4 +263,9 @@ static inline void atomic_or(int i, atomic_t *v)
 #define  xchg_release			xchg
 #endif
 
+#include <asm-generic/atomic-long.h>
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
 #endif /* _LINUX_ATOMIC_H */
-- 
2.1.4
