From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Date: Mon, 24 Feb 2020 11:47:54 -0500
Message-ID: <20200224114754.0fb798c1@gandalf.local.home>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.328642621@infradead.org>
        <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
        <20200221202246.GA14897@hirez.programming.kicks-ass.net>
        <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
        <20200224112708.4f307ba3@gandalf.local.home>
        <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgBXQr6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 11:47:58 -0500
In-Reply-To: <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Mon, 24 Feb 2020 17:34:09 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Looking at nmi_enter(), that leaves trace_hardirq_enter(), since we know
> we marked rcu_nmi_enter() as NOKPROBES, per the patches elsewhere in
> this series.

Maybe this was addressed already in the series, but I'm just looking at
Linus's master branch we have:

#define nmi_enter()                                             \
        do {                                                    \
                arch_nmi_enter();                               \
                printk_nmi_enter();                             \
                lockdep_off();                                  \
                ftrace_nmi_enter();                             \
                BUG_ON(in_nmi());                               \
                preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET); \
                rcu_nmi_enter();                                \
                trace_hardirq_enter();                          \
        } while (0)


Just want to confirm that printk_nmi_enter(), lockdep_off(),
and ftrace_nmi_enter() are all marked fully with NOKPROBE.

-- Steve
