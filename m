From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Date: Thu, 16 Apr 2020 13:11:36 +0100
Message-ID: <20200416121135.GE4987@lakrids.cambridge.arm.com>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
 <20200415192605.GA21804@willie-the-truck>
 <20200416093106.GB4987@lakrids.cambridge.arm.com>
 <20200416115342.GA32443@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634901AbgDPMLn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 08:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20200416115342.GA32443@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Robin Murphy <robin.murphy@arm.com>

On Thu, Apr 16, 2020 at 12:53:46PM +0100, Will Deacon wrote:
> On Thu, Apr 16, 2020 at 10:31:06AM +0100, Mark Rutland wrote:
> > FWIW, for the arm64 unwind code we could add a helper to snapshot the
> > frame record, and mark that as __no_sanitize_address, e.g.

[...]

> > ... we'd need to do likewied in a few bits of unwind code:

[...]

> Indeed. For now, I'm going to keep this simple with the change below, but
> I'll revisit this later on because I have another series removing
> smp_read_barrier_depends() which makes this a lot simpler.
> 
> Will

The below looks good to me; thanks for putting that together!

Mark.

> 
> --->8
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 00a68063d9d5..c363d8debc43 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -212,18 +212,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	(typeof(x))__x;							\
>  })
>  
> -/*
> - * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
> - * to hide memory access from KASAN.
> - */
> -#define READ_ONCE_NOCHECK(x)						\
> +#define READ_ONCE(x)							\
>  ({									\
>  	compiletime_assert_rwonce_type(x);				\
>  	__READ_ONCE_SCALAR(x);						\
>  })
>  
> -#define READ_ONCE(x)	READ_ONCE_NOCHECK(x)
> -
>  #define __WRITE_ONCE(x, val)				\
>  do {							\
>  	*(volatile typeof(x) *)&(x) = (val);		\
> @@ -247,6 +241,24 @@ do {							\
>  # define __no_kasan_or_inline __always_inline
>  #endif
>  
> +static __no_kasan_or_inline
> +unsigned long __read_once_word_nocheck(const void *addr)
> +{
> +	return __READ_ONCE(*(unsigned long *)addr);
> +}
> +
> +/*
> + * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
> + * word from memory atomically but without telling KASAN. This is usually
> + * used by unwinding code when walking the stack of a running process.
> + */
> +#define READ_ONCE_NOCHECK(x)						\
> +({									\
> +	unsigned long __x = __read_once_word_nocheck(&(x));		\
> +	smp_read_barrier_depends();					\
> +	__x;								\
> +})
> +
>  static __no_kasan_or_inline
>  unsigned long read_word_at_a_time(const void *addr)
>  {
