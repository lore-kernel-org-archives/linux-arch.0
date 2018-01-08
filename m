From: Mark Salter <msalter@redhat.com>
Subject: Re: [RFCv2 1/4] asm-generic/barrier: add generic nospec helpers
Date: Mon, 08 Jan 2018 16:47:37 -0500
Message-ID: <1515448057.15297.34.camel@redhat.com>
References: <20180105145750.53294-1-mark.rutland@arm.com>
         <20180105145750.53294-2-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54281 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbeAHVrj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Jan 2018 16:47:39 -0500
In-Reply-To: <20180105145750.53294-2-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de

On Fri, 2018-01-05 at 14:57 +0000, Mark Rutland wrote:
> Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> memory accesses under a bounds check may be speculated even if the
> bounds check fails, providing a primitive for building a side channel.
> 
> This patch adds helpers which can be used to inhibit the use of
> out-of-bounds pointers under speculation.
> 
> A generic implementation is provided for compatibility, but does not
> guarantee safety under speculation. Architectures are expected to
> override these helpers as necessary.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Cc: Daniel Willams <dan.j.williams@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/asm-generic/barrier.h | 68 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> Dan, I've reworked this so that nospec_ptr() can take an arch-specific barrier
> sequence. I believe that for x86 you just need to implement __nospec_barrier()
> as osb().
> 
> Mark.
> 
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fe297b599b0a..91c3071f49e5 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -54,6 +54,74 @@
>  #define read_barrier_depends()		do { } while (0)
>  #endif
>  
> +/*
> + * Inhibit subsequent speculative memory accesses.
> + *
> + * Architectures with a suitable memory barrier should provide an
> + * implementation. This is non-portable, and generic code should use
> + * nospec_ptr().
> + */
> +#ifndef __nospec_barrier
> +#define __nospec_barrier()		do { } while (0)
> +#endif
> +
> +/**
> + * nospec_ptr() - Ensure a  pointer is bounded, even under speculation.
> + *
> + * @ptr: the pointer to test
> + * @lo: the lower valid bound for @ptr, inclusive
> + * @hi: the upper valid bound for @ptr, exclusive
> + *
> + * If @ptr falls in the interval [@lo, @i), returns @ptr, otherwise returns
> + * NULL.
> + *
> + * Architectures which do not provide __nospec_barrier() should override this
> + * to ensure that ptr falls in the [lo, hi) interval both under architectural
> + * execution and under speculation, preventing propagation of an out-of-bounds
> + * pointer to code which is speculatively executed.
> + */
> +#ifndef nospec_ptr
> +#define nospec_ptr(ptr, lo, hi)						\
> +({									\
> +	typeof (ptr) __ret;						\
> +	typeof (ptr) __ptr = (ptr);					\
> +	typeof (ptr) __lo = (lo);					\
> +	typeof (ptr) __hi = (hi);					\
> +									\
> +	__ret = (__lo <= __ptr && __ptr < __hi) ? __ptr : NULL;		\
> +									\
> +	__nospec_barrier();						\
> +									\
> +	__ret;								\
> +})
> +#endif
> +
> +/**
> + * nospec_array_ptr - Generate a pointer to an array element, ensuring the
> + * pointer is bounded under speculation.
> + *
> + * @arr: the base of the array
> + * @idx: the index of the element
> + * @sz: the number of elements in the array
> + *
> + * If @idx falls in the interval [0, @sz), returns the pointer to @arr[@idx],
> + * otherwise returns NULL.
> + *
> + * This is a wrapper around nospec_ptr(), provided for convenience.
> + * Architectures should implement nospec_ptr() to ensure this is the case
> + * under speculation.
> + */
> +#define nospec_array_ptr(arr, idx, sz)					\
> +({									\
> +	typeof(*(arr)) *__arr = (arr);					\
> +	typeof(idx) __idx = (idx);					\
> +	typeof(sz) __sz = (sz);						\
> +									\
> +	nospec_ptr(__arr + __idx, __arr, __arr + __sz);			\
> +})
> +
> +#undef __nospec_barrier

I see:

kernel/bpf/arraymap.c: In function 'array_map_lookup_elem':
kernel/bpf/arraymap.c:124:2: error: implicit declaration of function '__nospec_barrier' [-Werror=implicit-function-declaration]
  return nospec_ptr(ptr, array->value, high);
  ^
cc1: all warnings being treated as errors

when building using a 4.8ish gcc. Removing the above #undef avoids that
error. I don't get the build error on fedora with gcc7

> +
>  #ifndef __smp_mb
>  #define __smp_mb()	mb()
>  #endif
