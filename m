From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 08/31] locking,frv: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:21 +0200
Message-ID: <20160422093923.549937787@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-frv.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/frv/include/asm/atomic.h      |   32 ++++++++++++--------------------
 arch/frv/include/asm/atomic_defs.h |    2 ++
 2 files changed, 14 insertions(+), 20 deletions(-)

--- a/arch/frv/include/asm/atomic.h
+++ b/arch/frv/include/asm/atomic.h
@@ -60,16 +60,6 @@ static inline int atomic_add_negative(in
 	return atomic_add_return(i, v) < 0;
 }
 
-static inline void atomic_add(int i, atomic_t *v)
-{
-	atomic_add_return(i, v);
-}
-
-static inline void atomic_sub(int i, atomic_t *v)
-{
-	atomic_sub_return(i, v);
-}
-
 static inline void atomic_inc(atomic_t *v)
 {
 	atomic_inc_return(v);
@@ -84,6 +74,8 @@ static inline void atomic_dec(atomic_t *
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
 #define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
 
+#define atomic_fetch_or atomic_fetch_or
+
 /*
  * 64-bit atomic ops
  */
@@ -136,16 +128,6 @@ static inline long long atomic64_add_neg
 	return atomic64_add_return(i, v) < 0;
 }
 
-static inline void atomic64_add(long long i, atomic64_t *v)
-{
-	atomic64_add_return(i, v);
-}
-
-static inline void atomic64_sub(long long i, atomic64_t *v)
-{
-	atomic64_sub_return(i, v);
-}
-
 static inline void atomic64_inc(atomic64_t *v)
 {
 	atomic64_inc_return(v);
@@ -182,11 +164,19 @@ static __inline__ int __atomic_add_unles
 }
 
 #define ATOMIC_OP(op)							\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	return __atomic32_fetch_##op(i, &v->counter);			\
+}									\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
 	(void)__atomic32_fetch_##op(i, &v->counter);			\
 }									\
 									\
+static inline long long atomic64_fetch_##op(long long i, atomic64_t *v)	\
+{									\
+	return __atomic64_fetch_##op(i, &v->counter);			\
+}									\
 static inline void atomic64_##op(long long i, atomic64_t *v)		\
 {									\
 	(void)__atomic64_fetch_##op(i, &v->counter);			\
@@ -195,6 +185,8 @@ static inline void atomic64_##op(long lo
 ATOMIC_OP(or)
 ATOMIC_OP(and)
 ATOMIC_OP(xor)
+ATOMIC_OP(add)
+ATOMIC_OP(sub)
 
 #undef ATOMIC_OP
 
--- a/arch/frv/include/asm/atomic_defs.h
+++ b/arch/frv/include/asm/atomic_defs.h
@@ -162,6 +162,8 @@ ATOMIC_EXPORT(__atomic64_fetch_##op);
 ATOMIC_FETCH_OP(or)
 ATOMIC_FETCH_OP(and)
 ATOMIC_FETCH_OP(xor)
+ATOMIC_FETCH_OP(add)
+ATOMIC_FETCH_OP(sub)
 
 ATOMIC_OP_RETURN(add)
 ATOMIC_OP_RETURN(sub)
