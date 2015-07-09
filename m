From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 17/24] sparc: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:12 +0200
Message-ID: <20150709175309.588450000@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59663 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbGIR4b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:31 -0400
Content-Disposition: inline; filename=peterz-sparc-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/atomic_32.h |    3 +++
 arch/sparc/include/asm/atomic_64.h |    3 +++
 arch/sparc/lib/atomic32.c          |   22 +++++++++++++++++++---
 arch/sparc/lib/atomic_64.S         |    6 ++++++
 arch/sparc/lib/ksyms.c             |    3 +++
 5 files changed, 34 insertions(+), 3 deletions(-)

--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -21,6 +21,9 @@
 #define ATOMIC_INIT(i)  { (i) }
 
 int atomic_add_return(int, atomic_t *);
+void atomic_and(int, atomic_t *);
+void atomic_or(int, atomic_t *);
+void atomic_xor(int, atomic_t *);
 int atomic_cmpxchg(atomic_t *, int, int);
 int atomic_xchg(atomic_t *, int);
 int __atomic_add_unless(atomic_t *, int, int);
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -32,6 +32,9 @@ long atomic64_##op##_return(long, atomic
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -27,22 +27,38 @@ static DEFINE_SPINLOCK(dummy);
 
 #endif /* SMP */
 
-#define ATOMIC_OP(op, cop)						\
+#define ATOMIC_OP_RETURN(op, c_op)					\
 int atomic_##op##_return(int i, atomic_t *v)				\
 {									\
 	int ret;							\
 	unsigned long flags;						\
 	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
 									\
-	ret = (v->counter cop i);					\
+	ret = (v->counter c_op i);					\
 									\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
 EXPORT_SYMBOL(atomic_##op##_return);
 
-ATOMIC_OP(add, +=)
+#define ATOMIC_OP(op, c_op)						\
+void atomic_##op(int i, atomic_t *v)					\
+{									\
+	unsigned long flags;						\
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);			\
+									\
+	v->counter c_op i;						\
+									\
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
+}									\
+EXPORT_SYMBOL(atomic_##op);
+
+ATOMIC_OP_RETURN(add, +=)
+ATOMIC_OP(and, &=)
+ATOMIC_OP(or, |=)
+ATOMIC_OP(xor, ^=)
 
+#undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
 int atomic_xchg(atomic_t *v, int new)
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -47,6 +47,9 @@ ENDPROC(atomic_##op##_return);
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
@@ -84,6 +87,9 @@ ENDPROC(atomic64_##op##_return);
 
 ATOMIC64_OPS(add)
 ATOMIC64_OPS(sub)
+ATOMIC64_OP(and)
+ATOMIC64_OP(or)
+ATOMIC64_OP(xor)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_OP_RETURN
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -111,6 +111,9 @@ EXPORT_SYMBOL(atomic64_##op##_return);
 
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
+ATOMIC_OP(and)
+ATOMIC_OP(or)
+ATOMIC_OP(xor)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP_RETURN
