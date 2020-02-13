From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Thu, 13 Feb 2020 17:40:31 +0100
Message-ID: <20200213164031.GH14914@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgBMQk4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 11:40:56 -0500
Content-Disposition: inline
In-Reply-To: <20200213135138.GB2935@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Thu, Feb 13, 2020 at 05:51:38AM -0800, Paul E. McKenney wrote:

> The reason for the irq argument is to avoid invoking
> rcu_prepare_for_idle() and rcu_dynticks_task_enter() from NMI context
> from rcu_nmi_exit_common().  Similarly, we need to avoid invoking
> rcu_dynticks_task_exit() and rcu_cleanup_after_idle() from NMI context
> from rcu_nmi_enter_common().

Aaah, I see. I didn't grep hard enough earlier today (I only found
stubs). Yes, those take locks, we mustn't call them from NMI context.

> It might well be that I could make these functions be NMI-safe, but
> rcu_prepare_for_idle() in particular would be a bit ugly at best.
> So, before looking into that, I have a question.  Given these proposed
> changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> to just use in_nmi()?

That _should_ already be the case today. That is, if we end up in a
tracer and in_nmi() is unreliable we're already screwed anyway.
