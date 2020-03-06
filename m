From: Frederic Weisbecker <frederic-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't kick
 isolated cpus
Date: Fri, 6 Mar 2020 16:34:47 +0100
Message-ID: <20200306153446.GC8590@lenoir>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: "rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prasun Kapoor <pkapoor-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 04, 2020 at 04:15:24PM +0000, Alex Belits wrote:
> From: Yuri Norov <ynorov-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> Make sure that kick_all_cpus_sync() does not call CPUs that are running
> isolated tasks.
> 
> Signed-off-by: Alex Belits <abelits-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
>  kernel/smp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 3a8bcbdd4ce6..d9b4b2fedfed 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -731,9 +731,21 @@ static void do_nothing(void *unused)
>   */
>  void kick_all_cpus_sync(void)
>  {
> +	struct cpumask mask;
> +
>  	/* Make sure the change is visible before we kick the cpus */
>  	smp_mb();
> -	smp_call_function(do_nothing, NULL, 1);
> +
> +	preempt_disable();
> +#ifdef CONFIG_TASK_ISOLATION
> +	cpumask_clear(&mask);
> +	task_isolation_cpumask(&mask);
> +	cpumask_complement(&mask, &mask);
> +#else
> +	cpumask_setall(&mask);
> +#endif
> +	smp_call_function_many(&mask, do_nothing, NULL, 1);
> +	preempt_enable();
>  }

That looks very dangerous, the callers of kick_all_cpus_sync() want to
sync all CPUs for a reason. You will rather need to fix the callers.

Thanks.

>  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
>  
> -- 
> 2.20.1
> 
