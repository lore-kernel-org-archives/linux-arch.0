From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 13/15] x86: Improve spinlocks using ISO C++11
 intrinsic atomics
Date: Wed, 18 May 2016 19:37:20 +0200
Message-ID: <20160518173720.GG3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358433517.8596.492761570975545534.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38401 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbcERRh2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 13:37:28 -0400
Content-Disposition: inline
In-Reply-To: <146358433517.8596.492761570975545534.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:12:15PM +0100, David Howells wrote:
> diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
> index be0a05913b91..1cbddef2b3f3 100644
> --- a/arch/x86/include/asm/spinlock.h
> +++ b/arch/x86/include/asm/spinlock.h
> @@ -81,7 +81,7 @@ static inline void __ticket_check_and_clear_slowpath(arch_spinlock_t *lock,
>  		new.tickets.tail = old.tickets.tail;
>  
>  		/* try to clear slowpath flag when there are no contenders */
> -		cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
> +		try_cmpxchg_acquire(&lock->head_tail, old.head_tail, new.head_tail);
>  	}
>  }
>  
> @@ -107,7 +107,7 @@ static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
>  	register struct __raw_tickets inc = { .tail = TICKET_LOCK_INC };
>  
> -	inc = xadd(&lock->tickets, inc);
> +	inc = xadd_acquire(&lock->tickets, inc);
>  	if (likely(inc.head == inc.tail))
>  		goto out;
>  
> @@ -128,19 +128,21 @@ out:
>  	barrier();	/* make sure nothing creeps before the lock is taken */
>  }
>  
> -static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
> +static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
>  {
>  	arch_spinlock_t old, new;
>  
>  	old.tickets = READ_ONCE(lock->tickets);
>  	if (!__tickets_equal(old.tickets.head, old.tickets.tail))
> -		return 0;
> +		return false;
>  
>  	new.head_tail = old.head_tail + (TICKET_LOCK_INC << TICKET_SHIFT);
>  	new.head_tail &= ~TICKET_SLOWPATH_FLAG;
>  
> -	/* cmpxchg is a full barrier, so nothing can move before it */
> -	return cmpxchg(&lock->head_tail, old.head_tail, new.head_tail) == old.head_tail;
> +	/* Insert an acquire barrier with the cmpxchg so that nothing
> +	 * can move before it.
> +	 */
> +	return try_cmpxchg_acquire(&lock->head_tail, old.head_tail, new.head_tail);
>  }
>  
>  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> @@ -151,14 +153,14 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>  
>  		BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
>  
> -		head = xadd(&lock->tickets.head, TICKET_LOCK_INC);
> +		head = xadd_release(&lock->tickets.head, TICKET_LOCK_INC);
>  
>  		if (unlikely(head & TICKET_SLOWPATH_FLAG)) {
>  			head &= ~TICKET_SLOWPATH_FLAG;
>  			__ticket_unlock_kick(lock, (head + TICKET_LOCK_INC));
>  		}
>  	} else
> -		__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
> +		add_release(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
>  }
>  
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
> 

This is all very dead code, I should do a patch removing it.
