From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Date: Fri, 14 Feb 2020 14:38:14 -0600
Message-ID: <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.312024711@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:41175
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730043AbgBNUiT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 15:38:19 -0500
In-Reply-To: <20200212210750.312024711@infradead.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On 2/12/20 3:01 PM, Peter Zijlstra wrote:
> Since perf is now able to deal with !rcu_is_watching() contexts,
> remove the restraint.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/trace/trace_event_perf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
>  {
>  	struct ftrace_ops *ops = &event->ftrace_ops;
>  
> -	ops->flags   = FTRACE_OPS_FL_RCU;
> +	ops->flags   = 0;
>  	ops->func    = perf_ftrace_function_call;
>  	ops->private = (void *)(unsigned long)nr_cpu_ids;

If this is the last user of the flag, should all remaining
FTRACE_OPS_FL_RCU references be removed, too?

Thanks,

Kim
