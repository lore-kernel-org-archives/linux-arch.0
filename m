From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 21/31] locking,sparc: Implement atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Fri, 22 Apr 2016 11:04:34 +0200
Message-ID: <20160422093924.408974831@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35026 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcDVJm6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 05:42:58 -0400
Content-Disposition: inline; filename=peterz-atomic-fetch-sparc.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/atomic.h    |    1 
 arch/sparc/include/asm/atomic_32.h |   15 +++++++--
 arch/sparc/include/asm/atomic_64.h |   16 +++++++--
 arch/sparc/lib/atomic32.c          |   29 ++++++++++-------
 arch/sparc/lib/atomic_64.S         |   61 ++++++++++++++++++++++++++++++-------
 arch/sparc/lib/ksyms.c             |   17 +++++++---
 6 files changed, 105 insertions(+), 34 deletions(-)

--- a/arch/sparc/include/asm/atomic.h
+++ b/arch/sparc/include/asm/atomic.h
@@ -5,4 +5,5 @@
 #else
 #include <asm/atomic_32.h>
 #endif
+#define atomic_fetch_or atomic_fetch_or
 #endif
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -20,9 +20,10 @@
 #define ATOMIC_INIT(i)  { (i) }
 
 int atomic_add_return(int, atomic_t *);
-void atomic_and(int, atomic_t *);
-void atomic_or(int, atomic_t *);
-void atomic_xor(int, atomic_t *);
+int atomic_fetch_add(int, atomic_t *);
+int atomic_fetch_and(int, atomic_t *);
+int atomic_fetch_or(int, atomic_t *);
+int atomic_fetch_xor(int, atomic_t *);
 int atomic_cmpxchg(atomic_t *, int, int);
 int atomic_xchg(atomic_t *, int);
 int __atomic_add_unless(atomic_t *, int, int);
@@ -35,7 +36,15 @@ void atomic_set(atomic_t *, int);
 #define atomic_inc(v)		((void)atomic_add_return(        1, (v)))
 #define atomic_dec(v)		((void)atomic_add_return(       -1, (v)))
 
+#define atomic_fetch_or	atomic_fetch_or
+
+#define atomic_and(i, v)	((void)atomic_fetch_and((i), (v)))
+#define atomic_or(i, v)		((void)atomic_fetch_or((i), (v)))
+#define atomic_xor(i, v)	((void)atomic_fetch_xor((i), (v)))
+
 #define atomic_sub_return(i, v)	(atomic_add_return(-(int)(i), (v)))
+#define atomic_fetch_sub(i, v)  (atomic_fetch_add (-(int)(i), (v)))
+
 #define atomic_inc_return(v)	(atomic_add_return(        1, (v)))
 #define atomic_dec_return(v)	(atomic_add_return(       -1, (v)))
 
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -28,16 +28,24 @@ void atomic64_##op(long, atomic64_t *);
 int atomic_##op##_return(int, atomic_t *);				\
 long atomic64_##op##_return(long, atomic64_t *);
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+int atomic_fetch_##op(int, atomic_t *);					\
+long atomic64_fetch_##op(long, atomic64_t *);
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -27,39 +27,44 @@ static DEFINE_SPINLOCK(dummy);
 
 #endif /* SMP */
 
-#define ATOMIC_OP_RETURN(op, c_op)					\
-int atomic_##op##_return(int i, atomic_t *v)				\
+#define ATOMIC_FETCH_OP(op, c_op)					\
+int atomic_fetch_##op(int i, atomic_t *v)				\
 {									\
 	int ret;							\
 	unsigned long flags;						\
 	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
 									\
-	ret = (v->counter c_op i);					\
+	ret = v->counter;						\
+	v->counter c_op i;						\
 									\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_##op##_return);
+EXPORT_SYMBOL(atomic_fetch_##op);
 
-#define ATOMIC_OP(op, c_op)						\
-void atomic_##op(int i, atomic_t *v)					\
+#define ATOMIC_OP_RETURN(op, c_op)					\
+int atomic_##op##_return(int i, atomic_t *v)				\
 {									\
+	int ret;							\
 	unsigned long flags;						\
 	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
 									\
-	v->counter c_op i;						\
+	ret = (v->counter c_op i);					\
 									\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
+	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_##op);
+EXPORT_SYMBOL(atomic_##op##_return);
 
 ATOMIC_OP_RETURN(add, +=)
-ATOMIC_OP(and, &=)
-ATOMIC_OP(or, |=)
-ATOMIC_OP(xor, ^=)
 
+ATOMIC_FETCH_OP(add, +=)
+ATOMIC_FETCH_OP(and, &=)
+ATOMIC_FETCH_OP(or, |=)
+ATOMIC_FETCH_OP(xor, ^=)
+
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
-#undef ATOMIC_OP
 
 int atomic_xchg(atomic_t *v, int new)
 {
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -9,10 +9,11 @@
 
 	.text
 
-	/* Two versions of the atomic routines, one that
+	/* Three versions of the atomic routines, one that
 	 * does not return a value and does not perform
-	 * memory barriers, and a second which returns
-	 * a value and does the barriers.
+	 * memory barriers, and a two which return
+	 * a value, the new and old value resp. and does the
+	 * barriers.
 	 */
 
 #define ATOMIC_OP(op)							\
@@ -43,15 +44,34 @@ ENTRY(atomic_##op##_return) /* %o0 = inc
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
 ENDPROC(atomic_##op##_return);
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+ENTRY(atomic_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
+	BACKOFF_SETUP(%o2);						\
+1:	lduw	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	cas	[%o1], %g1, %g7;					\
+	cmp	%g1, %g7;						\
+	bne,pn	%icc, BACKOFF_LABEL(2f, 1b);				\
+	 nop;								\
+	retl;								\
+	 sra	%g1, 0, %o0;						\
+2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
+ENDPROC(atomic_fetch_##op);
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
@@ -83,15 +103,34 @@ ENTRY(atomic64_##op##_return) /* %o0 = i
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
 ENDPROC(atomic64_##op##_return);
 
-#define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op)
+#define ATOMIC64_FETCH_OP(op)						\
+ENTRY(atomic64_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
+	BACKOFF_SETUP(%o2);						\
+1:	ldx	[%o1], %g1;						\
+	op	%g1, %o0, %g7;						\
+	casx	[%o1], %g1, %g7;					\
+	cmp	%g1, %g7;						\
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b);				\
+	 nop;								\
+	retl;								\
+	 mov	%g1, %o0;						\
+2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
+ENDPROC(atomic64_fetch_##op);
+
+#define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
-ATOMIC64_OP(and)
-ATOMIC64_OP(or)
-ATOMIC64_OP(xor)
 
 #undef ATOMIC64_OPS
+#define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_FETCH_OP(op)
+
+ATOMIC64_OPS(and)
+ATOMIC64_OPS(or)
+ATOMIC64_OPS(xor)
+
+#undef ATOMIC64_OPS
+#undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -107,15 +107,24 @@ EXPORT_SYMBOL(atomic64_##op);
 EXPORT_SYMBOL(atomic_##op##_return);					\
 EXPORT_SYMBOL(atomic64_##op##_return);
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op)
+#define ATOMIC_FETCH_OP(op)						\
+EXPORT_SYMBOL(atomic_fetch_##op);					\
+EXPORT_SYMBOL(atomic64_fetch_##op);
+
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
-ATOMIC_OP(and)
-ATOMIC_OP(or)
-ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
+#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+
+ATOMIC_OPS(and)
+ATOMIC_OPS(or)
+ATOMIC_OPS(xor)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
