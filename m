From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:36:27 +0200
Message-ID: <20170607123627.ofjobsxxv5ut776m@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
 <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 07, 2017 at 02:06:13PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:
> What pretty much all the other architectures do is something like:
> 
> #define ATOMIC_OP(op, asm_op, c_op)				\
> static __always_inline void atomic_##op(int i, atomic_t *v)	\
> {								\
> 	__asm__ __volatile__ (					\
> 		"amo" #asm_op ".w zero, %1, %0"			\
> 		: "+A" (v->counter)				\
> 		: "r" (i));					\
> }
> 
> #define ATOMIC_FETCH_OP(op, asm_op, c_op)			\
> static __always_inline int atomic_fetch_##op(int i, atomic_t *v)\
> {								\
> 	register int ret;					\
> 	__asm__ __volatile__ (					\
> 		"amo" #asm_op ".w %2, %1, %0"			\
> 		: "+A" (v->counter), "=r" (ret)			\
> 		: "r" (mask));					\
> 	return ret;						\
> }
> 
> #define ATOMIC_OP_RETURN(op, asm_op, c_op)			\
> static __always_inline int atomic_##op##_return(int i, atomic_t *v) \
> {								\
> 	return atomic_fetch_##op(i, v) c_op i;			\
> }
> 
> #define ATOMIC_OPS(op, asm_op, c_op)				\
> 	ATOMIC_OP(op, asm_op, c_op)				\
> 	ATOMIC_OP_RETURN(op, asm_op, c_op)			\
> 	ATOMIC_FETCH_OP(op, asm_op, c_op)
> 
> ATOMIC_OPS(add, add, +)
> ATOMIC_OPS(sub, sub, -)
> 
> #undef ATOMIC_OPS
> 
> #define ATOMIC_OPS(op, asm_op, c_op)				\
> 	ATOMIC_OP(op, asm_op, c_op)				\
> 	ATOMIC_FETCH_OP(op, asm_op, c_op)
> 
> ATOMIC_OPS(and, and, &)
> ATOMIC_OPS(or, or, |)
> ATOMIC_OPS(xor, xor, ^)
> 
> #undef ATOMIC_OPS
> 
> Which is much simpler no?

In fact, after having read your manual you'd want something like:


#define ATOMIC_OP(op, asm_op, c_op)				\
static __always_inline void atomic_##op(int i, atomic_t *v)	\
{								\
	__asm__ __volatile__ (					\
		"amo" #asm_op ".w zero, %1, %0"			\
		: "+A" (v->counter)				\
		: "r" (i));					\
}

#define ATOMIC_FETCH_OP(op, asm_op, c_op, asm_or, order)	\
static __always_inline int atomic_fetch_##op##order(int i, atomic_t *v)\
{								\
	register int ret;					\
	__asm__ __volatile__ (					\
		"amo" #asm_op ".w" #asm_or " %2, %1, %0"	\
		: "+A" (v->counter), "=r" (ret)			\
		: "r" (mask));					\
	return ret;						\
}

#define ATOMIC_OP_RETURN(op, asm_op, c_op, asm_or, order)	\
static __always_inline int atomic_##op##_return##order(int i, atomic_t *v) \
{								\
	return atomic_fetch_##op##order(i, v) c_op i;		\
}

#define ATOMIC_OPS(op, asm_op, c_op)				\
	ATOMIC_OP(op, asm_op, c_op, , _relaxed)			\
	ATOMIC_OP_RETURN(op, asm_op, c_op, , _relaxed)		\
	ATOMIC_FETCH_OP(op, asm_op, c_op, , _relaxed)

ATOMIC_OPS(add, add, +)
ATOMIC_OPS(sub, sub, -)

#undef ATOMIC_OPS

#define ATOMIC_OPS(op, asm_op, c_op, asm_or, order)		\
	ATOMIC_OP_RETURN(op, asm_op, c_op, , _relaxed)		\
	ATOMIC_FETCH_OP(op, asm_op, c_op, , _relaxed)

ATOMIC_OPS(add, add, +, ".aq", _acquire)
ATOMIC_OPS(add, add, +, ".rl", _release)
ATOMIC_OPS(add, add, +, ".aq.rl", )

ATOMIC_OPS(sub, sub, -, ".aq", _acquire)
ATOMIC_OPS(sub, sub, -, ".rl", _release)
ATOMIC_OPS(sub, sub, -, ".aq.rl", )

#undef ATOMIC_OPS

#define ATOMIC_OPS(op, asm_op, c_op)				\
	ATOMIC_OP(op, asm_op, c_op)				\
	ATOMIC_FETCH_OP(op, asm_op, c_op, , _relaxed)

ATOMIC_OPS(and, and, &)
ATOMIC_OPS(or, or, |)
ATOMIC_OPS(xor, xor, ^)

#undef ATOMIC_OPS

ATOMIC_FETCH_OP(and, and, &, ".aq", _acquire)
ATOMIC_FETCH_OP(and, and, &, ".rl", _release)
ATOMIC_FETCH_OP(and, and, &, ".aq.rl", )

ATOMIC_FETCH_OP(or, or, |, ".aq", _acquire)
ATOMIC_FETCH_OP(or, or, |, ".rl", _release)
ATOMIC_FETCH_OP(or, or, |, ".aq.rl", )

ATOMIC_FETCH_OP(xor, xor, ^, ".aq", _acquire)
ATOMIC_FETCH_OP(xor, xor, ^, ".rl", _release)
ATOMIC_FETCH_OP(xor, xor, ^, ".aq.rl", )


#define smp_mb__before_atomic()	smp_mb()
#define smp_mb__after_atomic()	smp_mb()


Which (pending the sub confusion) will generate the entire set of:

 atomic_add, atomic_add_return{_relaxed,_acquire,_release,} atomic_fetch_add{_relaxed,_acquire,_release,}
 atomic_sub, atomic_sub_return{_relaxed,_acquire,_release,} atomic_fetch_sub{_relaxed,_acquire,_release,}

 atomic_and, atomic_fetch_and{_relaxed,_acquire,_release,}
 atomic_or,  atomic_fetch_or{_relaxed,_acquire,_release,}
 atomic_xor, atomic_fetch_xor{_relaxed,_acquire,_release,}
