Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58203 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaDQP6y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 11:58:54 -0400
Date: Thu, 17 Apr 2014 17:58:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Message-ID: <20140417155844.GS11096@twins.programming.kicks-ass.net>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
 <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140417155844.44LLTgWL_IgDIkoRT6wwkfn9sQbY91IJfzO_31ty1F0@z>

On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
> +static __always_inline void
> +clear_pending_set_locked(struct qspinlock *lock, u32 val)
> +{
> +	struct __qspinlock *l = (void *)lock;
> +
> +	ACCESS_ONCE(l->locked_pending) = 1;
> +}

> @@ -157,8 +251,13 @@ static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
>  	 * we're pending, wait for the owner to go away.
>  	 *
>  	 * *,1,1 -> *,1,0
> +	 *
> +	 * this wait loop must be a load-acquire such that we match the
> +	 * store-release that clears the locked bit and create lock
> +	 * sequentiality; this because not all try_clear_pending_set_locked()
> +	 * implementations imply full barriers.

You renamed the function referred in the above comment.

>  	 */
> -	while ((val = atomic_read(&lock->val)) & _Q_LOCKED_MASK)
> +	while ((val = smp_load_acquire(&lock->val.counter)) & _Q_LOCKED_MASK)
>  		arch_mutex_cpu_relax();
>  
>  	/*
