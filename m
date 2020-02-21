From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Date: Fri, 21 Feb 2020 21:22:46 +0100
Message-ID: <20200221202246.GA14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 15:23:15 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, Feb 21, 2020 at 11:05:36AM -0800, Andy Lutomirski wrote:

> > -       /*
> > -        * Use ist_enter despite the fact that we don't use an IST stack.
> > -        * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> > -        * mode or even during context tracking state changes.
> > -        *
> > -        * This means that we can't schedule.  That's okay.
> > -        */
> > -       ist_enter(regs);
> > +       nmi_enter();
> 
> I agree with the change, but some commentary might be nice.  Maybe
> copy from here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=061eaa900b4f63601ab6381ab431fcef8dfd84be

Fair enough; I'll add something to #DB and #BP for that.
