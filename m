From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Wed, 7 Jun 2017 14:06:13 +0200
Message-ID: <20170607120613.ocbqpfajxj6eedbt@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdFGMGU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 08:06:20 -0400
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-14-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org

On Tue, Jun 06, 2017 at 04:00:03PM -0700, Palmer Dabbelt wrote:

> + * atomic_add - add integer to atomic variable
> + * @i: integer value to add
> + * @v: pointer of type atomic_t
> + *
> + * Atomically adds @i to @v.
> + */
> +static inline void atomic_add(int i, atomic_t *v)
> +{
> +	__asm__ __volatile__ (
> +		"amoadd.w zero, %1, %0"
> +		: "+A" (v->counter)
> +		: "r" (i));
> +}
> +
> +#define atomic_fetch_add atomic_fetch_add
> +static inline int atomic_fetch_add(unsigned int mask, atomic_t *v)
> +{
> +	int out;
> +
> +	__asm__ __volatile__ (
> +		"amoadd.w %2, %1, %0"
> +		: "+A" (v->counter), "=r" (out)
> +		: "r" (mask));
> +	return out;
> +}
> +
> +/**
> + * atomic_sub - subtract integer from atomic variable
> + * @i: integer value to subtract
> + * @v: pointer of type atomic_t
> + *
> + * Atomically subtracts @i from @v.
> + */
> +static inline void atomic_sub(int i, atomic_t *v)
> +{
> +	atomic_add(-i, v);
> +}
> +
> +#define atomic_fetch_sub atomic_fetch_sub
> +static inline int atomic_fetch_sub(unsigned int mask, atomic_t *v)
> +{
> +	int out;
> +
> +	__asm__ __volatile__ (
> +		"amosub.w %2, %1, %0"
> +		: "+A" (v->counter), "=r" (out)
> +		: "r" (mask));
> +	return out;
> +}
> +
> +/**
> + * atomic_add_return - add integer to atomic variable
> + * @i: integer value to add
> + * @v: pointer of type atomic_t
> + *
> + * Atomically adds @i to @v and returns the result
> + */
> +static inline int atomic_add_return(int i, atomic_t *v)
> +{
> +	register int c;
> +
> +	__asm__ __volatile__ (
> +		"amoadd.w %0, %2, %1"
> +		: "=r" (c), "+A" (v->counter)
> +		: "r" (i));
> +	return (c + i);
> +}
> +
> +/**
> + * atomic_sub_return - subtract integer from atomic variable
> + * @i: integer value to subtract
> + * @v: pointer of type atomic_t
> + *
> + * Atomically subtracts @i from @v and returns the result
> + */
> +static inline int atomic_sub_return(int i, atomic_t *v)
> +{
> +	return atomic_add_return(-i, v);
> +}
> +

> +/**
> + * atomic_and - Atomically clear bits in atomic variable
> + * @mask: Mask of the bits to be retained
> + * @v: pointer of type atomic_t
> + *
> + * Atomically retains the bits set in @mask from @v
> + */
> +static inline void atomic_and(unsigned int mask, atomic_t *v)
> +{
> +	__asm__ __volatile__ (
> +		"amoand.w zero, %1, %0"
> +		: "+A" (v->counter)
> +		: "r" (mask));
> +}
> +
> +#define atomic_fetch_and atomic_fetch_and
> +static inline int atomic_fetch_and(unsigned int mask, atomic_t *v)
> +{
> +	int out;
> +
> +	__asm__ __volatile__ (
> +		"amoand.w %2, %1, %0"
> +		: "+A" (v->counter), "=r" (out)
> +		: "r" (mask));
> +	return out;
> +}
> +
> +/**
> + * atomic_or - Atomically set bits in atomic variable
> + * @mask: Mask of the bits to be set
> + * @v: pointer of type atomic_t
> + *
> + * Atomically sets the bits set in @mask in @v
> + */
> +static inline void atomic_or(unsigned int mask, atomic_t *v)
> +{
> +	__asm__ __volatile__ (
> +		"amoor.w zero, %1, %0"
> +		: "+A" (v->counter)
> +		: "r" (mask));
> +}
> +
> +#define atomic_fetch_or atomic_fetch_or
> +static inline int atomic_fetch_or(unsigned int mask, atomic_t *v)
> +{
> +	int out;
> +
> +	__asm__ __volatile__ (
> +		"amoor.w %2, %1, %0"
> +		: "+A" (v->counter), "=r" (out)
> +		: "r" (mask));
> +	return out;
> +}
> +
> +/**
> + * atomic_xor - Atomically flips bits in atomic variable
> + * @mask: Mask of the bits to be flipped
> + * @v: pointer of type atomic_t
> + *
> + * Atomically flips the bits set in @mask in @v
> + */
> +static inline void atomic_xor(unsigned int mask, atomic_t *v)
> +{
> +	__asm__ __volatile__ (
> +		"amoxor.w zero, %1, %0"
> +		: "+A" (v->counter)
> +		: "r" (mask));
> +}
> +
> +#define atomic_fetch_xor atomic_fetch_xor
> +static inline int atomic_fetch_xor(unsigned int mask, atomic_t *v)
> +{
> +	int out;
> +
> +	__asm__ __volatile__ (
> +		"amoxor.w %2, %1, %0"
> +		: "+A" (v->counter), "=r" (out)
> +		: "r" (mask));
> +	return out;
> +}

What pretty much all the other architectures do is something like:

#define ATOMIC_OP(op, asm_op, c_op)				\
static __always_inline void atomic_##op(int i, atomic_t *v)	\
{								\
	__asm__ __volatile__ (					\
		"amo" #asm_op ".w zero, %1, %0"			\
		: "+A" (v->counter)				\
		: "r" (i));					\
}

#define ATOMIC_FETCH_OP(op, asm_op, c_op)			\
static __always_inline int atomic_fetch_##op(int i, atomic_t *v)\
{								\
	register int ret;					\
	__asm__ __volatile__ (					\
		"amo" #asm_op ".w %2, %1, %0"			\
		: "+A" (v->counter), "=r" (ret)			\
		: "r" (mask));					\
	return ret;						\
}

#define ATOMIC_OP_RETURN(op, asm_op, c_op)			\
static __always_inline int atomic_##op##_return(int i, atomic_t *v) \
{								\
	return atomic_fetch_##op(i, v) c_op i;			\
}

#define ATOMIC_OPS(op, asm_op, c_op)				\
	ATOMIC_OP(op, asm_op, c_op)				\
	ATOMIC_OP_RETURN(op, asm_op, c_op)			\
	ATOMIC_FETCH_OP(op, asm_op, c_op)

ATOMIC_OPS(add, add, +)
ATOMIC_OPS(sub, sub, -)

#undef ATOMIC_OPS

#define ATOMIC_OPS(op, asm_op, c_op)				\
	ATOMIC_OP(op, asm_op, c_op)				\
	ATOMIC_FETCH_OP(op, asm_op, c_op)

ATOMIC_OPS(and, and, &)
ATOMIC_OPS(or, or, |)
ATOMIC_OPS(xor, xor, ^)

#undef ATOMIC_OPS

Which is much simpler no?
