From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 043/109] sched: add do_sched_yield() helper; remove
 in-kernel call to sched_yield()
Date: Thu, 29 Mar 2018 13:41:14 +0200
Message-ID: <20180329114114.GQ4082@hirez.programming.kicks-ass.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
 <20180329112426.23043-44-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329112426.23043-44-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 29, 2018 at 01:23:20PM +0200, Dominik Brodowski wrote:
> Using the sched-internal do_sched_yield() helper allows us to get rid of
> the sched-internal call to the sys_sched_yield() syscall.
> 
> This patch is part of a series which removes in-kernel calls to syscalls.
> On this basis, the syscall entry path can be streamlined. For details, see
> http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net
> 
> Cc: Ingo Molnar <mingo@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  kernel/sched/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e7c535eee0a6..8de4919c889a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4892,7 +4892,7 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
>   *
>   * Return: 0.
>   */
> -SYSCALL_DEFINE0(sched_yield)
> +static void do_sched_yield(void)
>  {
>  	struct rq_flags rf;
>  	struct rq *rq;
> @@ -4913,7 +4913,11 @@ SYSCALL_DEFINE0(sched_yield)
>  	sched_preempt_enable_no_resched();
>  
>  	schedule();
> +}
>  
> +SYSCALL_DEFINE0(sched_yield)
> +{
> +	do_sched_yield();
>  	return 0;
>  }
>  
> @@ -4997,7 +5001,7 @@ EXPORT_SYMBOL(__cond_resched_softirq);
>  void __sched yield(void)
>  {
>  	set_current_state(TASK_RUNNING);
> -	sys_sched_yield();
> +	do_sched_yield();
>  }
>  EXPORT_SYMBOL(yield);
>  
> -- 
> 2.16.3
> 
