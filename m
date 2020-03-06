Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbgCFPeu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 10:34:50 -0500
Date: Fri, 6 Mar 2020 16:34:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't kick
 isolated cpus
Message-ID: <20200306153446.GC8590@lenoir>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20200306153447.NZkvVMTsIB8ukxGfKxUox7jPx9H9LH4WDqK_XT5F14M@z>

On Wed, Mar 04, 2020 at 04:15:24PM +0000, Alex Belits wrote:
> From: Yuri Norov <ynorov@marvell.com>
> 
> Make sure that kick_all_cpus_sync() does not call CPUs that are running
> isolated tasks.
> 
> Signed-off-by: Alex Belits <abelits@marvell.com>
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
