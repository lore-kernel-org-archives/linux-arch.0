From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/5] asm-generic: rework atomic-long.h to avoid bulk code duplication
Date: Mon, 13 Jul 2015 13:31:24 +0100
Message-ID: <1436790687-11984-3-git-send-email-will.deacon@arm.com>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Waiman.Long@hp.com, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

We can use some (admittedly ugly) macros to generate the 32-bit and
64-bit based atomic_long implementations from the same code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/atomic-long.h | 189 ++++++++------------------------------
 1 file changed, 40 insertions(+), 149 deletions(-)

diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index b7babf0206b8..beaea541adfb 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -23,236 +23,127 @@
 typedef atomic64_t atomic_long_t;
 
 #define ATOMIC_LONG_INIT(i)	ATOMIC64_INIT(i)
+#define ATOMIC_LONG_PFX(x)	atomic64 ## x
 
-static inline long atomic_long_read(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_read(v);
-}
-
-static inline void atomic_long_set(atomic_long_t *l, long i)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	atomic64_set(v, i);
-}
-
-static inline void atomic_long_inc(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	atomic64_inc(v);
-}
-
-static inline void atomic_long_dec(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	atomic64_dec(v);
-}
-
-static inline void atomic_long_add(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	atomic64_add(i, v);
-}
-
-static inline void atomic_long_sub(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	atomic64_sub(i, v);
-}
-
-static inline int atomic_long_sub_and_test(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return atomic64_sub_and_test(i, v);
-}
-
-static inline int atomic_long_dec_and_test(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return atomic64_dec_and_test(v);
-}
-
-static inline int atomic_long_inc_and_test(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return atomic64_inc_and_test(v);
-}
-
-static inline int atomic_long_add_negative(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return atomic64_add_negative(i, v);
-}
-
-static inline long atomic_long_add_return(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_add_return(i, v);
-}
-
-static inline long atomic_long_sub_return(long i, atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_sub_return(i, v);
-}
-
-static inline long atomic_long_inc_return(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_inc_return(v);
-}
-
-static inline long atomic_long_dec_return(atomic_long_t *l)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_dec_return(v);
-}
-
-static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
-{
-	atomic64_t *v = (atomic64_t *)l;
-
-	return (long)atomic64_add_unless(v, a, u);
-}
-
-#define atomic_long_inc_not_zero(l) atomic64_inc_not_zero((atomic64_t *)(l))
-
-#define atomic_long_cmpxchg(l, old, new) \
-	(atomic64_cmpxchg((atomic64_t *)(l), (old), (new)))
-#define atomic_long_xchg(v, new) \
-	(atomic64_xchg((atomic64_t *)(v), (new)))
-
-#else  /*  BITS_PER_LONG == 64  */
+#else
 
 typedef atomic_t atomic_long_t;
 
 #define ATOMIC_LONG_INIT(i)	ATOMIC_INIT(i)
+#define ATOMIC_LONG_PFX(x)	atomic ## x
+
+#endif
+
 static inline long atomic_long_read(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_read(v);
+	return (long)ATOMIC_LONG_PFX(_read)(v);
 }
 
 static inline void atomic_long_set(atomic_long_t *l, long i)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	atomic_set(v, i);
+	ATOMIC_LONG_PFX(_set)(v, i);
 }
 
 static inline void atomic_long_inc(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	atomic_inc(v);
+	ATOMIC_LONG_PFX(_inc)(v);
 }
 
 static inline void atomic_long_dec(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	atomic_dec(v);
+	ATOMIC_LONG_PFX(_dec)(v);
 }
 
 static inline void atomic_long_add(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	atomic_add(i, v);
+	ATOMIC_LONG_PFX(_add)(i, v);
 }
 
 static inline void atomic_long_sub(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	atomic_sub(i, v);
+	ATOMIC_LONG_PFX(_sub)(i, v);
 }
 
 static inline int atomic_long_sub_and_test(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return atomic_sub_and_test(i, v);
+	return ATOMIC_LONG_PFX(_sub_and_test)(i, v);
 }
 
 static inline int atomic_long_dec_and_test(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return atomic_dec_and_test(v);
+	return ATOMIC_LONG_PFX(_dec_and_test)(v);
 }
 
 static inline int atomic_long_inc_and_test(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return atomic_inc_and_test(v);
+	return ATOMIC_LONG_PFX(_inc_and_test)(v);
 }
 
 static inline int atomic_long_add_negative(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return atomic_add_negative(i, v);
+	return ATOMIC_LONG_PFX(_add_negative)(i, v);
 }
 
 static inline long atomic_long_add_return(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_add_return(i, v);
+	return (long)ATOMIC_LONG_PFX(_add_return)(i, v);
 }
 
 static inline long atomic_long_sub_return(long i, atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_sub_return(i, v);
+	return (long)ATOMIC_LONG_PFX(_sub_return)(i, v);
 }
 
 static inline long atomic_long_inc_return(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_inc_return(v);
+	return (long)ATOMIC_LONG_PFX(_inc_return)(v);
 }
 
 static inline long atomic_long_dec_return(atomic_long_t *l)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_dec_return(v);
+	return (long)ATOMIC_LONG_PFX(_dec_return)(v);
 }
 
 static inline long atomic_long_add_unless(atomic_long_t *l, long a, long u)
 {
-	atomic_t *v = (atomic_t *)l;
+	ATOMIC_LONG_PFX(_t) *v = (ATOMIC_LONG_PFX(_t) *)l;
 
-	return (long)atomic_add_unless(v, a, u);
+	return (long)ATOMIC_LONG_PFX(_add_unless)(v, a, u);
 }
 
-#define atomic_long_inc_not_zero(l) atomic_inc_not_zero((atomic_t *)(l))
-
+#define atomic_long_inc_not_zero(l) \
+	ATOMIC_LONG_PFX(_inc_not_zero)((ATOMIC_LONG_PFX(_t) *)(l))
 #define atomic_long_cmpxchg(l, old, new) \
-	(atomic_cmpxchg((atomic_t *)(l), (old), (new)))
+	(ATOMIC_LONG_PFX(_cmpxchg)((ATOMIC_LONG_PFX(_t) *)(l), (old), (new)))
 #define atomic_long_xchg(v, new) \
-	(atomic_xchg((atomic_t *)(v), (new)))
-
-#endif  /*  BITS_PER_LONG == 64  */
+	(ATOMIC_LONG_PFX(_xchg)((ATOMIC_LONG_PFX(_t) *)(v), (new)))
 
 #endif  /*  _ASM_GENERIC_ATOMIC_LONG_H  */
-- 
2.1.4
