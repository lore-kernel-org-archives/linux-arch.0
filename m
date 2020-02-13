From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Date: Thu, 13 Feb 2020 13:38:25 -0500
Message-ID: <20200213183825.GA207225@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
 <20200212232830.GB170680@google.com>
 <20200213082951.GK14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40767 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgBMSi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:38:27 -0500
Received: by mail-qv1-f66.google.com with SMTP id q9so2160556qvu.7
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 10:38:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200213082951.GK14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, "Steven Rostedt (VMware)" <rosted@goodmis.org>

On Thu, Feb 13, 2020 at 09:29:51AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:28:30PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> > > The tracepoint interface will stop providing regular RCU context; make
> > > sure we do it ourselves, since perf makes use of regular RCU protected
> > > data.
> > > 
> > > Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> > > Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/events/core.c |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
> > >  {
> > >  	struct perf_sample_data data;
> > >  	struct perf_event *event;
> > > +	unsigned long rcu_flags;
> > 
> > The flags are not needed I guess, if you agree on not using in_nmi() in
> > trace_rcu_enter().
> 
> Even then we need to store the state: 'didn't do nothing' vs 'did call
> rcu_needs_to_wake_up_and_pay_attention_noaw'. That is, we only need to
> do something (expensive!) when !rcu_is_watching().

You are right, that sounds good. I was talking to Paul and we chatted that if
in_nmi() is safe (which I believe it is as we are not calling RCU before you
update the preempt counts), then in RCU we can replace the @irq with
!in_nmi() and simplify that code.  Then we can simplify this bit as well
(keep rcu_flags but only call rcu_irq_enter_irqsave() instead of
rcu_nmi_enter(). May be you can do the RCU internal bits in your v3 or should
those be separate patches? Whatever Paul and you want to do.

thanks,

 - Joel

 - Joel
