From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Date: Thu, 13 Feb 2020 09:29:51 +0100
Message-ID: <20200213082951.GK14897@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
 <20200212232830.GB170680@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMIaM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 03:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20200212232830.GB170680@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, "Steven Rostedt (VMware)" <rosted@goodmis.org>

On Wed, Feb 12, 2020 at 06:28:30PM -0500, Joel Fernandes wrote:
> On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> > The tracepoint interface will stop providing regular RCU context; make
> > sure we do it ourselves, since perf makes use of regular RCU protected
> > data.
> > 
> > Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
> >  {
> >  	struct perf_sample_data data;
> >  	struct perf_event *event;
> > +	unsigned long rcu_flags;
> 
> The flags are not needed I guess, if you agree on not using in_nmi() in
> trace_rcu_enter().

Even then we need to store the state: 'didn't do nothing' vs 'did call
rcu_needs_to_wake_up_and_pay_attention_noaw'. That is, we only need to
do something (expensive!) when !rcu_is_watching().
