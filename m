From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 31/33] locking,mips: Convert to _relaxed atomics
Date: Tue, 31 May 2016 12:19:56 +0200
Message-ID: <20160531102643.397146531@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-mips-relaxed.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Generic code will construct {,_acquire,_release} versions by adding the
required smp_mb__{before,after}_atomic() calls.

XXX if/when MIPS will start using their new SYNCxx instructions they
can provide custom __atomic_op_{acquire,release}() macros as per the
powerpc example.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/include/asm/atomic.h |   42 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -79,12 +79,10 @@ static __inline__ void atomic_##op(int i
 }
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				      \
-static __inline__ int atomic_##op##_return(int i, atomic_t * v)		      \
+static __inline__ int atomic_##op##_return_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
-	smp_mb__before_llsc();						      \
-									      \
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
 		int temp;						      \
 									      \
@@ -125,18 +123,14 @@ static __inline__ int atomic_##op##_retu
 		raw_local_irq_restore(flags);				      \
 	}								      \
 									      \
-	smp_llsc_mb();							      \
-									      \
 	return result;							      \
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				      \
-static __inline__ int atomic_fetch_##op(int i, atomic_t * v)		      \
+static __inline__ int atomic_fetch_##op##_relaxed(int i, atomic_t * v)	      \
 {									      \
 	int result;							      \
 									      \
-	smp_mb__before_llsc();						      \
-									      \
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
 		int temp;						      \
 									      \
@@ -176,8 +170,6 @@ static __inline__ int atomic_fetch_##op(
 		raw_local_irq_restore(flags);				      \
 	}								      \
 									      \
-	smp_llsc_mb();							      \
-									      \
 	return result;							      \
 }
 
@@ -189,6 +181,11 @@ static __inline__ int atomic_fetch_##op(
 ATOMIC_OPS(add, +=, addu)
 ATOMIC_OPS(sub, -=, subu)
 
+#define atomic_add_return_relaxed	atomic_add_return_relaxed
+#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
+#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
+#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					      \
 	ATOMIC_OP(op, c_op, asm_op)					      \
@@ -198,6 +195,10 @@ ATOMIC_OPS(and, &=, and)
 ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
+#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
+#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
+#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
@@ -420,12 +421,10 @@ static __inline__ void atomic64_##op(lon
 }
 
 #define ATOMIC64_OP_RETURN(op, c_op, asm_op)				      \
-static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	      \
+static __inline__ long atomic64_##op##_return_relaxed(long i, atomic64_t * v) \
 {									      \
 	long result;							      \
 									      \
-	smp_mb__before_llsc();						      \
-									      \
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
 		long temp;						      \
 									      \
@@ -467,18 +466,14 @@ static __inline__ long atomic64_##op##_r
 		raw_local_irq_restore(flags);				      \
 	}								      \
 									      \
-	smp_llsc_mb();							      \
-									      \
 	return result;							      \
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op, asm_op)				      \
-static __inline__ long atomic64_fetch_##op(long i, atomic64_t * v)	      \
+static __inline__ long atomic64_fetch_##op##_relaxed(long i, atomic64_t * v)  \
 {									      \
 	long result;							      \
 									      \
-	smp_mb__before_llsc();						      \
-									      \
 	if (kernel_uses_llsc && R10000_LLSC_WAR) {			      \
 		long temp;						      \
 									      \
@@ -519,8 +514,6 @@ static __inline__ long atomic64_fetch_##
 		raw_local_irq_restore(flags);				      \
 	}								      \
 									      \
-	smp_llsc_mb();							      \
-									      \
 	return result;							      \
 }
 
@@ -532,6 +525,11 @@ static __inline__ long atomic64_fetch_##
 ATOMIC64_OPS(add, +=, daddu)
 ATOMIC64_OPS(sub, -=, dsubu)
 
+#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
+#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
+#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
+#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, c_op, asm_op)					      \
 	ATOMIC64_OP(op, c_op, asm_op)					      \
@@ -541,6 +539,10 @@ ATOMIC64_OPS(and, &=, and)
 ATOMIC64_OPS(or, |=, or)
 ATOMIC64_OPS(xor, ^=, xor)
 
+#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
+#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
+#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
