From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Date: Fri, 14 Feb 2020 11:28:39 +0900
Message-ID: <20200214022839.GG36551@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.312024711@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37530 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBNC2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 21:28:43 -0500
Content-Disposition: inline
In-Reply-To: <20200212210750.312024711@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On (20/02/12 22:01), Peter Zijlstra wrote:
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

FTRACE_OPS_FL_ENABLED?

	-ss
