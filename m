Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFLcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 06:32:02 -0500
Date: Fri, 6 Mar 2020 12:31:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306113135.GA8787@worktop.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306104335.GF3348@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, alexei.starovoitov@gmail.com
Message-ID: <20200306113135.1CbwIFYi0PV54LBblybqoyugNIgMNhl1ibQ4PoQjeBY@z>

On Fri, Mar 06, 2020 at 11:43:35AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 02:34:32PM +0100, Peter Zijlstra wrote:
> > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > taught perf how to deal with not having an RCU context provided.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/tracepoint.h |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > -			rcu_irq_enter_irqsave();			\
> > -		}							\
> >  									\
> >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> >  									\
> > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> >  			} while ((++it_func_ptr)->func);		\
> >  		}							\
> >  									\
> > -		if (rcuidle) {						\
> > -			rcu_irq_exit_irqsave();				\
> > +		if (rcuidle)						\
> >  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > -		}							\
> >  									\
> >  		preempt_enable_notrace();				\
> >  	} while (0)
> 
> So what happens when BPF registers for these tracepoints? BPF very much
> wants RCU on AFAIU.

I suspect we needs something like this...

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a2f15222f205..67a39dbce0ce 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1475,11 +1475,13 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+	int rcu_flags = trace_rcu_enter();
 	rcu_read_lock();
 	preempt_disable();
 	(void) BPF_PROG_RUN(prog, args);
 	preempt_enable();
 	rcu_read_unlock();
+	trace_rcu_exit(rcu_flags);
 }
 
 #define UNPACK(...)			__VA_ARGS__
