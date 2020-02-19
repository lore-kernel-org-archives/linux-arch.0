From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 09/22] sched,rcu,tracing: Avoid tracing before
 in_nmi() is correct
Date: Wed, 19 Feb 2020 10:50:34 -0500
Message-ID: <20200219105034.40915c50@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.888917422@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBSPuh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:50:37 -0500
In-Reply-To: <20200219150744.888917422@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, "Steven Rostedt (VMware)" <rosted@goodmis.org>

On Wed, 19 Feb 2020 15:47:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If we call into a tracer before in_nmi() becomes true, the tracer can
> no longer detect it is called from NMI context and behave correctly.
> 
> Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
> as the normal preempt_count_{add,sub}() have a (desired) function
> trace entry.
> 
> This fixes a potential issue with current code; AFAICT when the
> function-tracer has stack-tracing enabled __trace_stack() will
> malfunction when it hits the preempt_count_add() function entry from
> NMI context.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve
