From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] arch: Move smp_mb__{before,after}_atomic_{inc,dec}.h
 into asm/atomic.h
Date: Mon, 16 Dec 2013 12:13:09 -0800
Message-ID: <20131216201309.GJ4200@linux.vnet.ibm.com>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.786183683@infradead.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:43671 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab3LPUNQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2013 15:13:16 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 16 Dec 2013 13:13:15 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DFDB51FF001E
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 13:12:48 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBGKDB2r64618704
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 21:13:11 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id rBGKGEsV000513
	for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2013 13:16:17 -0700
Content-Disposition: inline
In-Reply-To: <20131213150640.786183683@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On Fri, Dec 13, 2013 at 03:56:59PM +0100, Peter Zijlstra wrote:
> Move the barriers functions that depend on the atomic implementation
> into the atomic implementation.
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/arc/include/asm/atomic.h      |    5 +++++
>  arch/arc/include/asm/barrier.h     |    5 -----
>  arch/hexagon/include/asm/atomic.h  |    6 +++++-
>  arch/hexagon/include/asm/barrier.h |    4 ----
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/arch/arc/include/asm/atomic.h
> +++ b/arch/arc/include/asm/atomic.h
> @@ -190,6 +190,11 @@ static inline void atomic_clear_mask(uns
> 
>  #endif /* !CONFIG_ARC_HAS_LLSC */
> 
> +#define smp_mb__before_atomic_dec()	barrier()
> +#define smp_mb__after_atomic_dec()	barrier()
> +#define smp_mb__before_atomic_inc()	barrier()
> +#define smp_mb__after_atomic_inc()	barrier()
> +
>  /**
>   * __atomic_add_unless - add unless the number is a given value
>   * @v: pointer of type atomic_t
> --- a/arch/arc/include/asm/barrier.h
> +++ b/arch/arc/include/asm/barrier.h
> @@ -30,11 +30,6 @@
>  #define smp_wmb()       barrier()
>  #endif
> 
> -#define smp_mb__before_atomic_dec()	barrier()
> -#define smp_mb__after_atomic_dec()	barrier()
> -#define smp_mb__before_atomic_inc()	barrier()
> -#define smp_mb__after_atomic_inc()	barrier()
> -
>  #define smp_read_barrier_depends()      do { } while (0)
> 
>  #endif
> --- a/arch/hexagon/include/asm/atomic.h
> +++ b/arch/hexagon/include/asm/atomic.h
> @@ -160,8 +160,12 @@ static inline int __atomic_add_unless(at
>  #define atomic_sub_and_test(i, v) (atomic_sub_return(i, (v)) == 0)
>  #define atomic_add_negative(i, v) (atomic_add_return(i, (v)) < 0)
> 
> -
>  #define atomic_inc_return(v) (atomic_add_return(1, v))
>  #define atomic_dec_return(v) (atomic_sub_return(1, v))
> 
> +#define smp_mb__before_atomic_dec()	barrier()
> +#define smp_mb__after_atomic_dec()	barrier()
> +#define smp_mb__before_atomic_inc()	barrier()
> +#define smp_mb__after_atomic_inc()	barrier()
> +
>  #endif
> --- a/arch/hexagon/include/asm/barrier.h
> +++ b/arch/hexagon/include/asm/barrier.h
> @@ -29,10 +29,6 @@
>  #define smp_read_barrier_depends()	barrier()
>  #define smp_wmb()			barrier()
>  #define smp_mb()			barrier()
> -#define smp_mb__before_atomic_dec()	barrier()
> -#define smp_mb__after_atomic_dec()	barrier()
> -#define smp_mb__before_atomic_inc()	barrier()
> -#define smp_mb__after_atomic_inc()	barrier()
> 
>  /*  Set a value and use a memory barrier.  Used by the scheduler somewhere.  */
>  #define set_mb(var, value) \
> 
> 
