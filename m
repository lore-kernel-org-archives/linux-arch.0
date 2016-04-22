From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 03/31] locking,arc: Implement
 atomic_fetch_{add,sub,and,andnot,or,xor}()
Date: Fri, 22 Apr 2016 16:16:14 +0200
Message-ID: <20160422141614.GP3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.218866387@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56389 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbcDVOQt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 10:16:49 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>

On Fri, Apr 22, 2016 at 10:50:41AM +0000, Vineet Gupta wrote:

> > +#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
> > +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> > +{									\
> > +	unsigned int val, result;			                \
> > +	SCOND_FAIL_RETRY_VAR_DEF                                        \
> > +									\
> > +	/*								\
> > +	 * Explicit full memory barrier needed before/after as		\
> > +	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
> > +	 */								\
> > +	smp_mb();							\
> > +									\
> > +	__asm__ __volatile__(						\
> > +	"1:	llock   %[val], [%[ctr]]		\n"		\
> > +	"	mov %[result], %[val]			\n"		\
> 
> Calling it result could be a bit confusing, this is meant to be the "orig" value.
> So it indeed "result" of the API, but for atomic operation it is pristine value.
> 
> Also we can optimize away that MOV - given there are plenty of regs, so
> 
> > +	"	" #asm_op " %[val], %[val], %[i]	\n"		\
> > +	"	scond   %[val], [%[ctr]]		\n"		\
> 
> Instead have
> 
> +	"	" #asm_op " %[result], %[val], %[i]	\n"		\
> +	"	scond   %[result], [%[ctr]]		\n"		\
> 
> 

Indeed, how about something like so?

---
Subject: locking,arc: Implement atomic_fetch_{add,sub,and,andnot,or,xor}()
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Apr 18 01:16:09 CEST 2016

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/atomic.h |   69 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 5 deletions(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -102,6 +102,37 @@ static inline int atomic_##op##_return(i
 	return val;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned int val, orig;						\
+	SCOND_FAIL_RETRY_VAR_DEF                                        \
+									\
+	/*								\
+	 * Explicit full memory barrier needed before/after as		\
+	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
+	 */								\
+	smp_mb();							\
+									\
+	__asm__ __volatile__(						\
+	"1:	llock   %[orig], [%[ctr]]		\n"		\
+	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
+	"	scond   %[val], [%[ctr]]		\n"		\
+	"						\n"		\
+	SCOND_FAIL_RETRY_ASM						\
+									\
+	: [val]	"=&r"	(val),						\
+	  [orig] "=&r" (orig)						\
+	  SCOND_FAIL_RETRY_VARS						\
+	: [ctr]	"r"	(&v->counter),					\
+	  [i]	"ir"	(i)						\
+	: "cc");							\
+									\
+	smp_mb();							\
+									\
+	return orig;							\
+}
+
 #else	/* !CONFIG_ARC_HAS_LLSC */
 
 #ifndef CONFIG_SMP
@@ -164,23 +196,49 @@ static inline int atomic_##op##_return(i
 	return temp;							\
 }
 
+#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
+static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+{									\
+	unsigned long flags;						\
+	unsigned long orig;						\
+									\
+	/*								\
+	 * spin lock/unlock provides the needed smp_mb() before/after	\
+	 */								\
+	atomic_ops_lock(flags);						\
+	orig = v->counter;						\
+	v->counter c_op i;						\
+	atomic_ops_unlock(flags);					\
+									\
+	return orig;							\
+}
+
 #endif /* !CONFIG_ARC_HAS_LLSC */
 
 #define ATOMIC_OPS(op, c_op, asm_op)					\
 	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)
+	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
 
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
 #define atomic_andnot atomic_andnot
 
-ATOMIC_OP(and, &=, and)
-ATOMIC_OP(andnot, &= ~, bic)
-ATOMIC_OP(or, |=, or)
-ATOMIC_OP(xor, ^=, xor)
+#define atomic_fetch_or atomic_fetch_or
+
+#undef ATOMIC_OPS
+#define ATOMIC_OPS(op, c_op, asm_op)					\
+	ATOMIC_OP(op, c_op, asm_op)					\
+	ATOMIC_FETCH_OP(op, c_op, asm_op)
+
+ATOMIC_OPS(and, &=, and)
+ATOMIC_OPS(andnot, &= ~, bic)
+ATOMIC_OPS(or, |=, or)
+ATOMIC_OPS(xor, ^=, xor)
 
 #undef ATOMIC_OPS
+#undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 #undef SCOND_FAIL_RETRY_VAR_DEF
