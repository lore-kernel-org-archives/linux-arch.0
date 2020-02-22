From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Date: Fri, 21 Feb 2020 22:08:43 -0500
Message-ID: <20200222030843.GA191380@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.090538203@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36757 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgBVDIr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 22:08:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so2810914qto.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 19:08:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200221134215.090538203@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Fri, Feb 21, 2020 at 02:34:17PM +0100, Peter Zijlstra wrote:
> nmi_enter() does lockdep_off() and hence lockdep ignores everything.
> 
> And NMI context makes it impossible to do full IN-NMI tracking like we
> do IN-HARDIRQ, that could result in graph_lock recursion.

The patch makes sense to me.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

NOTE:
Also, I was wondering if we can detect the graph_lock recursion case and
avoid doing anything bad, that way we enable more of the lockdep
functionality for NMI where possible. Not sure if the suggestion makes sense
though!

thanks,

 - Joel


> However, since look_up_lock_class() is lockless, we can find the class
> of a lock that has prior use and detect IN-NMI after USED, just not
> USED after IN-NMI.
> 
> NOTE: By shifting the lockdep_off() recursion count to bit-16, we can
> easily differentiate between actual recursion and off.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/lockdep.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 3 deletions(-)
> 
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
>  
>  void lockdep_off(void)
>  {
> -	current->lockdep_recursion++;
> +	current->lockdep_recursion += BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_off);
>  
>  void lockdep_on(void)
>  {
> -	current->lockdep_recursion--;
> +	current->lockdep_recursion -= BIT(16);
>  }
>  EXPORT_SYMBOL(lockdep_on);
>  
> @@ -575,6 +575,7 @@ static const char *usage_str[] =
>  #include "lockdep_states.h"
>  #undef LOCKDEP_STATE
>  	[LOCK_USED] = "INITIAL USE",
> +	[LOCK_USAGE_STATES] = "IN-NMI",
>  };
>  #endif
>  
> @@ -787,6 +788,7 @@ static int count_matching_names(struct l
>  	return count + 1;
>  }
>  
> +/* used from NMI context -- must be lockless */
>  static inline struct lock_class *
>  look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
>  {
> @@ -4463,6 +4465,34 @@ void lock_downgrade(struct lockdep_map *
>  }
>  EXPORT_SYMBOL_GPL(lock_downgrade);
>  
> +/* NMI context !!! */
> +static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock, int subclass)
> +{
> +	struct lock_class *class = look_up_lock_class(lock, subclass);
> +
> +	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
> +	if (!class)
> +		return;
> +
> +	if (!(class->usage_mask & LOCK_USED))
> +		return;
> +
> +	hlock->class_idx = class - lock_classes;
> +
> +	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
> +}
> +
> +static bool lockdep_nmi(void)
> +{
> +	if (current->lockdep_recursion & 0xFFFF)
> +		return false;
> +
> +	if (!in_nmi())
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * We are not always called with irqs disabled - do that here,
>   * and also avoid lockdep recursion:
> @@ -4473,8 +4503,25 @@ void lock_acquire(struct lockdep_map *lo
>  {
>  	unsigned long flags;
>  
> -	if (unlikely(current->lockdep_recursion))
> +	if (unlikely(current->lockdep_recursion)) {
> +		/* XXX allow trylock from NMI ?!? */
> +		if (lockdep_nmi() && !trylock) {
> +			struct held_lock hlock;
> +
> +			hlock.acquire_ip = ip;
> +			hlock.instance = lock;
> +			hlock.nest_lock = nest_lock;
> +			hlock.irq_context = 2; // XXX
> +			hlock.trylock = trylock;
> +			hlock.read = read;
> +			hlock.check = check;
> +			hlock.hardirqs_off = true;
> +			hlock.references = 0;
> +
> +			verify_lock_unused(lock, &hlock, subclass);
> +		}
>  		return;
> +	}
>  
>  	raw_local_irq_save(flags);
>  	check_flags(flags);
> 
> 
