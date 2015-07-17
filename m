From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 1/7] atomics: add acquire/release/relaxed variants
 of some atomic operations
Date: Thu, 16 Jul 2015 20:07:28 -0400
Message-ID: <55A84740.7080705@hp.com>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com> <1437060758-10381-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52]:39923 "EHLO
	g2t2353.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbGQAHc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 20:07:32 -0400
In-Reply-To: <1437060758-10381-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On 07/16/2015 11:32 AM, Will Deacon wrote:
> Whilst porting the generic qrwlock code over to arm64, it became
> apparent that any portable locking code needs finer-grained control of
> the memory-ordering guarantees provided by our atomic routines.
>
> In particular: xchg, cmpxchg, {add,sub}_return are often used in
> situations where full barrier semantics (currently the only option
> available) are not required. For example, when a reader increments a
> reader count to obtain a lock, checking the old value to see if a writer
> was present, only acquire semantics are strictly needed.
>
> This patch introduces three new ordering semantics for these operations:
>
>    - *_relaxed: No ordering guarantees. This is similar to what we have
>                 already for the non-return atomics (e.g. atomic_add).
>
>    - *_acquire: ACQUIRE semantics, similar to smp_load_acquire.
>
>    - *_release: RELEASE semantics, similar to smp_store_release.
>
> In memory-ordering speak, this means that the acquire/release semantics
> are RCpc as opposed to RCsc. Consequently a RELEASE followed by an
> ACQUIRE does not imply a full barrier, as already documented in
> memory-barriers.txt.
>
> Currently, all the new macros are conditionally mapped to the full-mb
> variants, however if the *_relaxed version is provided by the
> architecture, then the acquire/release variants are constructed by
> supplementing the relaxed routine with an explicit barrier.
>
> Cc: Peter Zijlstra<peterz@infradead.org>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   include/linux/atomic.h | 312 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 312 insertions(+)
>
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 5b08a8540ecf..08c2f6e56f76 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -2,6 +2,318 @@
>   #ifndef _LINUX_ATOMIC_H
>   #define _LINUX_ATOMIC_H
>   #include<asm/atomic.h>
> +#include<asm/barrier.h>
> +
> +/*
> + * Relaxed variants of xchg, cmpxchg and some atomic operations.
> + *
> + * We support four variants:
> + *
> + * - Fully ordered: The default implementation, no suffix required.
> + * - Acquire: Provides ACQUIRE semantics, _acquire suffix.
> + * - Release: Provides RELEASE semantics, _release suffix.
> + * - Relaxed: No ordering guarantees, _relaxed suffix.
> + *
> + * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
> + */
> +
> +#ifndef atomic_read_acquire
> +#define  atomic_read_acquire(v)		smp_load_acquire(&(v)->counter)
> +#endif
> +
> +#ifndef atomic_set_release
> +#define  atomic_set_release(v, i)	smp_store_release(&(v)->counter, (i))
> +#endif
> +
> +/*
> + * The idea here is to build acquire/release variants by adding explicit
> + * barriers on top of the relaxed variant. In the case where the relaxed
> + * variant is already fully ordered, no additional barriers are needed.
> + */
> +#define __atomic_op_acquire(ret_t, op, ...)				\
> +({									\
> +	ret_t __ret = op##_relaxed(__VA_ARGS__);			\
> +	smp_mb__after_atomic();						\
> +	__ret;								\
> +})
> +
> +#define __atomic_op_release(ret_t, op, ...)				\
> +({									\
> +	ret_t __ret;							\
> +	smp_mb__before_atomic();					\
> +	__ret = op##_relaxed(__VA_ARGS__);				\
> +	__ret;								\
> +})
> +
> +#define __atomic_op_fence(ret_t, op, ...)				\
> +({									\
> +	ret_t __ret;							\
> +	smp_mb__before_atomic();					\
> +	__ret = op##_relaxed(__VA_ARGS__);				\
> +	smp_mb__after_atomic();						\
> +	__ret;								\
> +})
> +
> +#ifndef atomic_add_return_relaxed
> +#define  atomic_add_return_relaxed	atomic_add_return
> +#define  atomic_add_return_acquire	atomic_add_return
> +#define  atomic_add_return_release	atomic_add_return
> +
> +#else /* atomic_add_return_relaxed */
> +
> +#ifndef atomic_add_return_acquire
> +#define  atomic_add_return_acquire(...)					\
> +	__atomic_op_acquire(int, atomic_add_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_add_return_release
> +#define  atomic_add_return_release(...)					\
> +	__atomic_op_release(int, atomic_add_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_add_return
> +#define  atomic_add_return(...)						\
> +	__atomic_op_fence(int, atomic_add_return, __VA_ARGS__)
> +#endif
> +#endif /* atomic_add_return_relaxed */
> +
> +#ifndef atomic_sub_return_relaxed
> +#define  atomic_sub_return_relaxed	atomic_sub_return
> +#define  atomic_sub_return_acquire	atomic_sub_return
> +#define  atomic_sub_return_release	atomic_sub_return
> +
> +#else /* atomic_sub_return_relaxed */
> +
> +#ifndef atomic_sub_return_acquire
> +#define  atomic_sub_return_acquire(...)					\
> +	__atomic_op_acquire(int, atomic_sub_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_sub_return_release
> +#define  atomic_sub_return_release(...)					\
> +	__atomic_op_release(int, atomic_sub_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_sub_return
> +#define  atomic_sub_return(...)						\
> +	__atomic_op_fence(int, atomic_sub_return, __VA_ARGS__)
> +#endif
> +#endif /* atomic_sub_return_relaxed */
> +
> +#ifndef atomic_xchg_relaxed
> +#define  atomic_xchg_relaxed		atomic_xchg
> +#define  atomic_xchg_acquire		atomic_xchg
> +#define  atomic_xchg_release		atomic_xchg
> +
> +#else /* atomic_xchg_relaxed */
> +
> +#ifndef atomic_xchg_acquire
> +#define  atomic_xchg_acquire(...)					\
> +	__atomic_op_acquire(int, atomic_xchg, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_xchg_release
> +#define  atomic_xchg_release(...)					\
> +	__atomic_op_release(int, atomic_xchg, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_xchg
> +#define  atomic_xchg(...)						\
> +	__atomic_op_fence(int, atomic_xchg, __VA_ARGS__)
> +#endif
> +#endif /* atomic_xchg_relaxed */
> +
> +#ifndef atomic_cmpxchg_relaxed
> +#define  atomic_cmpxchg_relaxed		atomic_cmpxchg
> +#define  atomic_cmpxchg_acquire		atomic_cmpxchg
> +#define  atomic_cmpxchg_release		atomic_cmpxchg
> +
> +#else /* atomic_cmpxchg_relaxed */
> +
> +#ifndef atomic_cmpxchg_acquire
> +#define  atomic_cmpxchg_acquire(...)					\
> +	__atomic_op_acquire(int, atomic_cmpxchg, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_cmpxchg_release
> +#define  atomic_cmpxchg_release(...)					\
> +	__atomic_op_release(int, atomic_cmpxchg, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic_cmpxchg
> +#define  atomic_cmpxchg(...)						\
> +	__atomic_op_fence(int, atomic_cmpxchg, __VA_ARGS__)
> +#endif
> +#endif /* atomic_cmpxchg_relaxed */
> +
> +#ifndef atomic64_read_acquire
> +#define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
> +#endif
> +
> +#ifndef atomic64_set_release
> +#define  atomic64_set_release(v, i)	smp_store_release(&(v)->counter, (i))
> +#endif
> +
> +#ifndef atomic64_add_return_relaxed
> +#define  atomic64_add_return_relaxed	atomic64_add_return
> +#define  atomic64_add_return_acquire	atomic64_add_return
> +#define  atomic64_add_return_release	atomic64_add_return
> +
> +#else /* atomic64_add_return_relaxed */
> +
> +#ifndef atomic64_add_return_acquire
> +#define  atomic64_add_return_acquire(...)				\
> +	__atomic_op_acquire(long long, atomic64_add_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic64_add_return_release
> +#define  atomic64_add_return_release(...)				\
> +	__atomic_op_release(long long, atomic64_add_return, __VA_ARGS__)
> +#endif
> +
> +#ifndef atomic64_add_return
> +#define  atomic64_add_return(...)					\
> +	__atomic_op_fence(long long, atomic64_add_return, __VA_ARGS__)
> +#endif
> +#endif /* atomic64_add_return_relaxed */
> +

I have a minor nit. The atomic_add_return block is repeated with 
"s/atomic_add_return/.../". Perhaps some more comments to delineate the 
blocks more visibly will make this patch easier to read.

Cheers,
Longman
