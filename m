From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
Date: Fri, 14 Feb 2020 17:48:45 -0500
Message-ID: <20200214174845.715de27b@gandalf.local.home>
References: <20200212210139.382424693@infradead.org>
        <20200212210750.312024711@infradead.org>
        <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNWst (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 17:48:49 -0500
In-Reply-To: <121a6b11-2fe1-6d9b-2861-a8ef8b42c452@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Fri, 14 Feb 2020 14:38:14 -0600
Kim Phillips <kim.phillips@amd.com> wrote:

> On 2/12/20 3:01 PM, Peter Zijlstra wrote:
> > Since perf is now able to deal with !rcu_is_watching() contexts,
> > remove the restraint.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/trace/trace_event_perf.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/trace/trace_event_perf.c
> > +++ b/kernel/trace/trace_event_perf.c
> > @@ -477,7 +477,7 @@ static int perf_ftrace_function_register
> >  {
> >  	struct ftrace_ops *ops = &event->ftrace_ops;
> >  
> > -	ops->flags   = FTRACE_OPS_FL_RCU;
> > +	ops->flags   = 0;
> >  	ops->func    = perf_ftrace_function_call;
> >  	ops->private = (void *)(unsigned long)nr_cpu_ids;  
> 
> If this is the last user of the flag, should all remaining
> FTRACE_OPS_FL_RCU references be removed, too?

Let's wait till Peter's patches goes through a merge cycle or two. I
want to make sure there's no other RCU issues that pop up before we
remove this infrastructure.

-- Steve
