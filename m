From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/28] alpha: Provide atomic_{or,xor,and}
Date: Thu, 16 Jul 2015 19:21:12 +0200
Message-ID: <20150716172924.450731226@infradead.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-alpha-atomic_logic_ops.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/atomic.h |   43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -29,13 +29,13 @@
  * branch back to restart the operation.
  */
 
-#define ATOMIC_OP(op)							\
+#define ATOMIC_OP(op, asm_op)						\
 static __inline__ void atomic_##op(int i, atomic_t * v)			\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
 	"1:	ldl_l %0,%1\n"						\
-	"	" #op "l %0,%2,%0\n"					\
+	"	" #asm_op " %0,%2,%0\n"					\
 	"	stl_c %0,%1\n"						\
 	"	beq %0,2f\n"						\
 	".subsection 2\n"						\
@@ -45,15 +45,15 @@ static __inline__ void atomic_##op(int i
 	:"Ir" (i), "m" (v->counter));					\
 }									\
 
-#define ATOMIC_OP_RETURN(op)						\
+#define ATOMIC_OP_RETURN(op, asm_op)					\
 static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	long temp, result;						\
 	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldl_l %0,%1\n"						\
-	"	" #op "l %0,%3,%2\n"					\
-	"	" #op "l %0,%3,%0\n"					\
+	"	" #asm_op " %0,%3,%2\n"					\
+	"	" #asm_op " %0,%3,%0\n"					\
 	"	stl_c %0,%1\n"						\
 	"	beq %0,2f\n"						\
 	".subsection 2\n"						\
@@ -65,13 +65,13 @@ static inline int atomic_##op##_return(i
 	return result;							\
 }
 
-#define ATOMIC64_OP(op)							\
+#define ATOMIC64_OP(op, asm_op)						\
 static __inline__ void atomic64_##op(long i, atomic64_t * v)		\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
-	"	" #op "q %0,%2,%0\n"					\
+	"	" #asm_op " %0,%2,%0\n"					\
 	"	stq_c %0,%1\n"						\
 	"	beq %0,2f\n"						\
 	".subsection 2\n"						\
@@ -81,15 +81,15 @@ static __inline__ void atomic64_##op(lon
 	:"Ir" (i), "m" (v->counter));					\
 }									\
 
-#define ATOMIC64_OP_RETURN(op)						\
+#define ATOMIC64_OP_RETURN(op, asm_op)					\
 static __inline__ long atomic64_##op##_return(long i, atomic64_t * v)	\
 {									\
 	long temp, result;						\
 	smp_mb();							\
 	__asm__ __volatile__(						\
 	"1:	ldq_l %0,%1\n"						\
-	"	" #op "q %0,%3,%2\n"					\
-	"	" #op "q %0,%3,%0\n"					\
+	"	" #asm_op " %0,%3,%2\n"					\
+	"	" #asm_op " %0,%3,%0\n"					\
 	"	stq_c %0,%1\n"						\
 	"	beq %0,2f\n"						\
 	".subsection 2\n"						\
@@ -101,15 +101,28 @@ static __inline__ long atomic64_##op##_r
 	return result;							\
 }
 
-#define ATOMIC_OPS(opg)							\
-	ATOMIC_OP(opg)							\
-	ATOMIC_OP_RETURN(opg)						\
-	ATOMIC64_OP(opg)						\
-	ATOMIC64_OP_RETURN(opg)
+#define ATOMIC_OPS(op)							\
+	ATOMIC_OP(op, op##l)						\
+	ATOMIC_OP_RETURN(op, op##l)					\
+	ATOMIC64_OP(op, op##q)						\
+	ATOMIC64_OP_RETURN(op, op##q)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
+#define CONFIG_ARCH_HAS_ATOMIC_OR
+#define atomic_andnot atomic_andnot
+#define atomic64_andnot atomic64_andnot
+
+ATOMIC_OP(and, and)
+ATOMIC_OP(andnot, bic)
+ATOMIC_OP(or, bis)
+ATOMIC_OP(xor, xor)
+ATOMIC64_OP(and, and)
+ATOMIC64_OP(andnot, bic)
+ATOMIC64_OP(or, bis)
+ATOMIC64_OP(xor, xor)
+
 #undef ATOMIC_OPS
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
