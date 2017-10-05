From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Date: Thu, 5 Oct 2017 18:46:09 -0400
Message-ID: <20171005184609.44185ce1@gandalf.local.home>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
        <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
        <20171005121250.prr5ff5kf3lxq6hx@hirez.programming.kicks-ass.net>
        <312162.31738.1507219326334.JavaMail.zimbra@efficios.com>
        <20171005220214.GA7140@andrea>
        <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbdJEWqP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Oct 2017 18:46:15 -0400
In-Reply-To: <206890579.32344.1507241955010.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>, David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>P

On Thu, 5 Oct 2017 22:19:15 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> AFAIU the scheduler rq->lock is held while preemption is disabled.
> synchronize_sched() is used here to ensure that all pre-existing
> preempt-off critical sections have completed.
> 
> So saying that we use synchronize_sched() to synchronize with rq->lock
> would be stretching the truth a bit. It's actually only true because the
> scheduler holding the rq->lock is surrounded by a preempt-off
> critical section.

Not only is preemption disabled (which is true for all spinlocks, at
least with non PREEMPT_RT), but the rq->lock must also only be taken
with interrupts disabled (for PREEMPT_RT as well). Because it can also
be taken in interrupt context.

-- Steve
