From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] add typecheck on irqsave and friends for correct flags
Date: Fri, 2 May 2008 12:37:55 +0400
Message-ID: <20080502083755.GA4922@martell.zuzino.mipt.ru>
References: <Pine.LNX.4.58.0805011946290.12785@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:61840 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbYEBHmm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 May 2008 03:42:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so625096nfc.21
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2008 00:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0805011946290.12785@gandalf.stny.rr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, Adrian Bunk <bunk@kernel.org>, linux-arch@vger.kernel.org, dhowells@redhat.com

On Thu, May 01, 2008 at 07:51:18PM -0400, Steven Rostedt wrote:
> There has been several areas in the kernel where an int has been used
> for flags in local_irq_save and friends instead of a long. This can
> cause some hard to debug problems on some architectures.
> 
> This patch adds a typecheck inside the irqsave and restore functions
> to flag these cases.

OK, at least something that uncovers such bugs.
Same checks in include/asm-frv/system.h should be removed then.

> --- linux-compile.git.orig/include/linux/irqflags.h
> +++ linux-compile.git/include/linux/irqflags.h
> @@ -49,18 +49,24 @@
>  	do { trace_hardirqs_on(); raw_local_irq_enable(); } while (0)
>  #define local_irq_disable() \
>  	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
> -#define local_irq_save(flags) \
> -	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
> +#define local_irq_save(flags)				\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		raw_local_irq_save(flags);		\
> +		trace_hardirqs_off();			\
> +	} while (0)
> 
> -#define local_irq_restore(flags)				\
> -	do {							\
> -		if (raw_irqs_disabled_flags(flags)) {		\
> -			raw_local_irq_restore(flags);		\
> -			trace_hardirqs_off();			\
> -		} else {					\
> -			trace_hardirqs_on();			\
> -			raw_local_irq_restore(flags);		\
> -		}						\
> +
> +#define local_irq_restore(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		if (raw_irqs_disabled_flags(flags)) {	\
> +			raw_local_irq_restore(flags);	\
> +			trace_hardirqs_off();		\
> +		} else {				\
> +			trace_hardirqs_on();		\
> +			raw_local_irq_restore(flags);	\
> +		}					\
>  	} while (0)
>  #else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
>  /*
> @@ -69,8 +75,16 @@
>   */
>  # define raw_local_irq_disable()	local_irq_disable()
>  # define raw_local_irq_enable()		local_irq_enable()
> -# define raw_local_irq_save(flags)	local_irq_save(flags)
> -# define raw_local_irq_restore(flags)	local_irq_restore(flags)
> +# define raw_local_irq_save(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		local_irq_save(flags);			\
> +	} while (0)
> +# define raw_local_irq_restore(flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		local_irq_restore(flags);		\
> +	} while (0)
>  #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
> 
>  #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
> @@ -80,7 +94,11 @@
>  		raw_safe_halt();				\
>  	} while (0)
> 
> -#define local_save_flags(flags)		raw_local_save_flags(flags)
> +#define local_save_flags(flags)				\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		raw_local_save_flags(flags);		\
> +	} while(0)
> 
>  #define irqs_disabled()						\
>  ({								\
> @@ -90,7 +108,11 @@
>  	raw_irqs_disabled_flags(_flags);			\
>  })
> 
> -#define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
> +#define irqs_disabled_flags(flags)		\
> +({						\
> +	typecheck(unsigned long, flags);	\
> +	raw_irqs_disabled_flags(flags);		\
> +})
>  #endif		/* CONFIG_X86 */
> 
>  #endif
> Index: linux-compile.git/include/linux/spinlock.h
> ===================================================================
> --- linux-compile.git.orig/include/linux/spinlock.h	2008-05-01 16:58:58.000000000 -0400
> +++ linux-compile.git/include/linux/spinlock.h	2008-05-01 19:16:21.000000000 -0400
> @@ -191,23 +191,53 @@ do {								\
> 
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
> 
> -#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
> -#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
> -#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
> +#define spin_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		flags = _spin_lock_irqsave(lock);	\
> +	} while (0)
> +#define read_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		flags = _read_lock_irqsave(lock);	\
> +	} while (0)
> +#define write_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		flags = _write_lock_irqsave(lock);	\
> +	} while (0)
> 
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> -#define spin_lock_irqsave_nested(lock, flags, subclass) \
> -	flags = _spin_lock_irqsave_nested(lock, subclass)
> +#define spin_lock_irqsave_nested(lock, flags, subclass)			\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		flags = _spin_lock_irqsave_nested(lock, subclass);	\
> +	} while (0)
>  #else
> -#define spin_lock_irqsave_nested(lock, flags, subclass) \
> -	flags = _spin_lock_irqsave(lock)
> +#define spin_lock_irqsave_nested(lock, flags, subclass)			\
> +	do {								\
> +		typecheck(unsigned long, flags);			\
> +		flags = _spin_lock_irqsave(lock);			\
> +	} while (0)
>  #endif
> 
>  #else
> 
> -#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
> -#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
> -#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
> +#define spin_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_spin_lock_irqsave(lock, flags);	\
> +	} while (0)
> +#define read_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_read_lock_irqsave(lock, flags);	\
> +	} while (0)
> +#define write_lock_irqsave(lock, flags)			\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_write_lock_irqsave(lock, flags);	\
> +	} while (0)
>  #define spin_lock_irqsave_nested(lock, flags, subclass)	\
>  	spin_lock_irqsave(lock, flags)
> 
> @@ -260,16 +290,25 @@ do {						\
>  } while (0)
>  #endif
> 
> -#define spin_unlock_irqrestore(lock, flags) \
> -					_spin_unlock_irqrestore(lock, flags)
> +#define spin_unlock_irqrestore(lock, flags)		\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_spin_unlock_irqrestore(lock, flags);	\
> +	} while (0)
>  #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
> 
> -#define read_unlock_irqrestore(lock, flags) \
> -					_read_unlock_irqrestore(lock, flags)
> +#define read_unlock_irqrestore(lock, flags)		\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_read_unlock_irqrestore(lock, flags);	\
> +	} while (0)
>  #define read_unlock_bh(lock)		_read_unlock_bh(lock)
> 
> -#define write_unlock_irqrestore(lock, flags) \
> -					_write_unlock_irqrestore(lock, flags)
> +#define write_unlock_irqrestore(lock, flags)		\
> +	do {						\
> +		typecheck(unsigned long, flags);	\
> +		_write_unlock_irqrestore(lock, flags);	\
> +	} while (0)
>  #define write_unlock_bh(lock)		_write_unlock_bh(lock)
> 
>  #define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
