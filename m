From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 2/2] sched: optimize cond_resched()
Date: Fri, 10 Jul 2009 12:12:49 -0500
Message-ID: <1247245969.21295.1057.camel@calx>
References: <20090710125755.559739294@chello.nl>
	 <20090710130125.160337304@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:51478 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbZGJROs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2009 13:14:48 -0400
In-Reply-To: <20090710130125.160337304@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu

On Fri, 2009-07-10 at 14:57 +0200, Peter Zijlstra wrote:
> plain text document attachment (sched_opt_cond_resched.patch)
> Optimize cond_resched() by removing one conditional.
> 
> Currently cond_resched() checks system_state ==
> SYSTEM_RUNNING in order to avoid scheduling before the
> scheduler is running.
> 
> We can however, as per suggestion of Matt, use
> PREEMPT_ACTIVE to accomplish that very same.

Pedantically, introducing should_resched should be its own patch, but
other than that, these two patches look good.

Acked-by: Matt Mackall <mpm@selenic.com>

> Suggested-by: Matt Mackall <mpm@selenic.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  include/linux/sched.h |    5 ++++-
>  kernel/sched.c        |   14 +++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6/include/linux/sched.h
> ===================================================================
> --- linux-2.6.orig/include/linux/sched.h
> +++ linux-2.6/include/linux/sched.h
> @@ -503,8 +503,11 @@ struct task_cputime {
>  /*
>   * Disable preemption until the scheduler is running.
>   * Reset by start_kernel()->sched_init()->init_idle().
> + *
> + * We include PREEMPT_ACTIVE to avoid cond_resched() from working
> + * before the scheduler is active -- see should_resched().
>   */
> -#define INIT_PREEMPT_COUNT	(1)
> +#define INIT_PREEMPT_COUNT	(1 + PREEMPT_ACTIVE)
>  
>  /**
>   * struct thread_group_cputimer - thread group interval timer counts
> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -6580,6 +6580,11 @@ SYSCALL_DEFINE0(sched_yield)
>  	return 0;
>  }
>  
> +static inline int should_resched(void)
> +{
> +	return need_resched() && !(preempt_count() & PREEMPT_ACTIVE);
> +}
> +
>  static void __cond_resched(void)
>  {
>  #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
> @@ -6599,8 +6604,7 @@ static void __cond_resched(void)
>  
>  int __sched _cond_resched(void)
>  {
> -	if (need_resched() && !(preempt_count() & PREEMPT_ACTIVE) &&
> -					system_state == SYSTEM_RUNNING) {
> +	if (should_resched()) {
>  		__cond_resched();
>  		return 1;
>  	}
> @@ -6618,12 +6622,12 @@ EXPORT_SYMBOL(_cond_resched);
>   */
>  int cond_resched_lock(spinlock_t *lock)
>  {
> -	int resched = need_resched() && system_state == SYSTEM_RUNNING;
> +	int resched = should_resched();
>  	int ret = 0;
>  
>  	if (spin_needbreak(lock) || resched) {
>  		spin_unlock(lock);
> -		if (resched && need_resched())
> +		if (resched)
>  			__cond_resched();
>  		else
>  			cpu_relax();
> @@ -6638,7 +6642,7 @@ int __sched cond_resched_softirq(void)
>  {
>  	BUG_ON(!in_softirq());
>  
> -	if (need_resched() && system_state == SYSTEM_RUNNING) {
> +	if (should_resched()) {
>  		local_bh_enable();
>  		__cond_resched();
>  		local_bh_disable();
> 

-- 
http://selenic.com : development and support for Mercurial and Linux
