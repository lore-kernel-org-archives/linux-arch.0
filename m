From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][PATCH 03/31] locking,arc: Implement
 atomic_fetch_{add,sub,and,andnot,or,xor}()
Date: Fri, 22 Apr 2016 10:50:41 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.218866387@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "dhowells@redhat.com" <dhowells@redhat.com>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "dalias@libc.org" <dalias@libc.org>, dav
List-Id: linux-arch.vger.kernel.org

On Friday 22 April 2016 03:13 PM, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
>
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arc/include/asm/atomic.h |   69 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 5 deletions(-)
>
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -102,6 +102,38 @@ static inline int atomic_##op##_return(i
>  	return val;							\
>  }
>  
> +#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned int val, result;			                \
> +	SCOND_FAIL_RETRY_VAR_DEF                                        \
> +									\
> +	/*								\
> +	 * Explicit full memory barrier needed before/after as		\
> +	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
> +	 */								\
> +	smp_mb();							\
> +									\
> +	__asm__ __volatile__(						\
> +	"1:	llock   %[val], [%[ctr]]		\n"		\
> +	"	mov %[result], %[val]			\n"		\

Calling it result could be a bit confusing, this is meant to be the "orig" value.
So it indeed "result" of the API, but for atomic operation it is pristine value.

Also we can optimize away that MOV - given there are plenty of regs, so

> +	"	" #asm_op " %[val], %[val], %[i]	\n"		\
> +	"	scond   %[val], [%[ctr]]		\n"		\

Instead have

+	"	" #asm_op " %[result], %[val], %[i]	\n"		\
+	"	scond   %[result], [%[ctr]]		\n"		\



> +	"						\n"		\
> +	SCOND_FAIL_RETRY_ASM						\
> +									\
> +	: [val]	"=&r"	(val),						\
> +	  [result] "=&r" (result)					\
> +	  SCOND_FAIL_RETRY_VARS						\
> +	: [ctr]	"r"	(&v->counter),					\
> +	  [i]	"ir"	(i)						\
> +	: "cc");							\
> +									\
> +	smp_mb();							\
> +									\
> +	return result;							\

This needs to be

+	return val;							\



> +}
> +
>  #else	/* !CONFIG_ARC_HAS_LLSC */
>  
>  #ifndef CONFIG_SMP
> @@ -164,23 +196,50 @@ static inline int atomic_##op##_return(i
>  	return temp;							\
>  }
>  
> +#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	unsigned long flags;						\
> +	unsigned long temp, result;					\

Same s above, I wouldn't call it result here !

Also per your other comment/patches, converting ARC to _relaxed atomics sounds
trivial, I can provide a fixup patch once your series is stable'ish and u point me
to ur git tree or some such .

Thx,
-Vineet

> +									\
> +	/*								\
> +	 * spin lock/unlock provides the needed smp_mb() before/after	\
> +	 */								\
> +	atomic_ops_lock(flags);						\
> +	result = temp = v->counter;					\
> +	temp c_op i;							\
> +	v->counter = temp;						\
> +	atomic_ops_unlock(flags);					\
> +									\
> +	return result;							\
> +}
> +
>  #endif /* !CONFIG_ARC_HAS_LLSC */
>  
>  #define ATOMIC_OPS(op, c_op, asm_op)					\
>  	ATOMIC_OP(op, c_op, asm_op)					\
> -	ATOMIC_OP_RETURN(op, c_op, asm_op)
> +	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
> +	ATOMIC_FETCH_OP(op, c_op, asm_op)
>  
>  ATOMIC_OPS(add, +=, add)
>  ATOMIC_OPS(sub, -=, sub)
>  
>  #define atomic_andnot atomic_andnot
>  
> -ATOMIC_OP(and, &=, and)
> -ATOMIC_OP(andnot, &= ~, bic)
> -ATOMIC_OP(or, |=, or)
> -ATOMIC_OP(xor, ^=, xor)
> +#define atomic_fetch_or atomic_fetch_or
> +
> +#undef ATOMIC_OPS
> +#define ATOMIC_OPS(op, c_op, asm_op)					\
> +	ATOMIC_OP(op, c_op, asm_op)					\
> +	ATOMIC_FETCH_OP(op, c_op, asm_op)
> +
> +ATOMIC_OPS(and, &=, and)
> +ATOMIC_OPS(andnot, &= ~, bic)
> +ATOMIC_OPS(or, |=, or)
> +ATOMIC_OPS(xor, ^=, xor)
>  
>  #undef ATOMIC_OPS
> +#undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>  #undef ATOMIC_OP
>  #undef SCOND_FAIL_RETRY_VAR_DEF
