From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Date: Wed, 12 Feb 2020 16:02:11 +0100
Message-ID: <20200212150211.GS14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.838108888@infradead.org>
 <20200212092417.04c3da8c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLPCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:02:37 -0500
Content-Disposition: inline
In-Reply-To: <20200212092417.04c3da8c@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 09:24:17AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:14 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because of the requirement that no tracing happens until after we've
> > incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
> > these functions as notrace.
> 
> I actually depend on these function being traced.

Why? They already have a tracepoint inside.

> We do have
> "preempt_enable_notrace()" and "preempt_disable_notrace()" for places
> that shouldn't be traced. Can't we use those? (or simply
> __preempt_count_add()) in the nmi_enter() code instead? (perhaps create
> a preempt_count_add_notrace()).

My initial patch has __preempt_count_add/sub() in, but then I figured
someone would go complain the tracepoint would go missing.
