From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 29/31] locking,alpha: Convert to _relaxed atomics
Date: Fri, 22 Apr 2016 11:04:42 +0200
Message-ID: <20160422093924.922130570@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-alpha-relaxed.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Generic code will construct {,_acquire,_release} versions by adding the
required smp_mb__{before,after}_atomic() calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/atomic.h |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -46,10 +46,9 @@ static __inline__ void atomic_##op(int i
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
-	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldl_l %0,%1\n"						\
 	"	" #asm_op " %0,%3,%2\n"					\
@@ -61,15 +60,13 @@ static inline int atomic_##op##_return(i
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_mb();							\
 	return result;							\
 }
 
 #define ATOMIC_FETCH_OP(op, asm_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
-	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldl_l %0,%1\n"						\
 	"       mov %0,%2\n"						\
@@ -81,7 +78,6 @@ static inline int atomic_fetch_##op(int
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_mb();							\
 	return result;							\
 }
 
@@ -102,10 +98,9 @@ static __inline__ void atomic64_##op(lon
 }									\
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	\
+static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v)	\
 {									\
 	long temp, result;						\
-	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
 	"	" #asm_op " %0,%3,%2\n"					\
@@ -117,15 +112,13 @@ static __inline__ long atomic64_##op##_r
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_mb();							\
 	return result;							\
 }
 
 #define ATOMIC64_FETCH_OP(op, asm_op)					\
-static __inline__ long atomic64_fetch_##op(long i, atomic64_t * v)	\
+static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)	\
 {									\
 	long temp, result;						\
-	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
 	"	mov %0,%2\n"						\
@@ -137,7 +130,6 @@ static __inline__ long atomic64_fetch_##
 	".previous"							\
 	:"=&r" (temp), "=m" (v->counter), "=&r" (result)		\
 	:"Ir" (i), "m" (v->counter) : "memory");			\
-	smp_mb();							\
 	return result;							\
 }
 
@@ -152,6 +144,16 @@ static __inline__ long atomic64_fetch_##
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+
 #define atomic_andnot atomic_andnot
 #define atomic64_andnot atomic64_andnot
 
@@ -167,6 +169,16 @@ ATOMIC_OPS(andnot, bic)
 ATOMIC_OPS(or, bis)
 ATOMIC_OPS(xor, xor)
 
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+
 #undef ATOMIC_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
