Return-Path: <SRS0=bqXs=4A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgBLPjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:39:04 -0500
Date: Wed, 12 Feb 2020 16:38:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Message-ID: <20200212153823.GW14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.838108888@infradead.org>
 <20200212092417.04c3da8c@gandalf.local.home>
 <20200212150211.GS14897@hirez.programming.kicks-ass.net>
 <20200212101415.3615d66c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212101415.3615d66c@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Message-ID: <20200212153823.iEpWIlgGbCYSlFY3hlZPUyRBIZhs8zbqfBMT0jmeYEU@z>

On Wed, Feb 12, 2020 at 10:14:15AM -0500, Steven Rostedt wrote:
> > My initial patch has __preempt_count_add/sub() in, but then I figured
> > someone would go complain the tracepoint would go missing.
> 
> Fine, but what bug are you trying to fix? I haven't seen one mentioned
> yet. Function tracing has recursion protection, and tracing
> preempt_count in nmi_enter() causes no problems. What's the problem you
> are trying to solve?

The same one as yesterday; if we hit a tracer in NMI context, when
!rcu_is_watching() and in_nmi() is still 0, we're fucked.
