From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Thu, 20 Feb 2020 08:39:18 +0100
Message-ID: <20200220073918.GR18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
 <20200219173358.GP18400@hirez.programming.kicks-ass.net>
 <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:32872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgBTHkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 02:40:18 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Feb 19, 2020 at 02:12:13PM -0800, Andy Lutomirski wrote:
> On Wed, Feb 19, 2020 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Do you really want to create code that unwinds enough of nmi_enter() to
> > get you to a preemptible context? *shudder*
> 
> Well, there's another way to approach this:
> 
> void notrace nonothing do_machine_check(struct pt_regs *regs)
> {
>   if (user_mode(regs))
>     do_sane_machine_check(regs);
>   else
>     do_awful_machine_check(regs);
> }
> 
> void do_sane_machine_check(regs)
> {
>   nothing special here.  just a regular exception, more or less.
> }
> 
> void do_awful_macine_check(regs)
> {
>   basically an NMI.  No funny business, no recovery possible.
> task_work_add() not allowed.
> }

Right, that looks like major surgery to the current code though; I'd
much prefer someone that knows that code do that.

> I suppose the general consideration I'm trying to get at is: is
> task_work_add() actually useful at all here?  For the case when a
> kernel thread does memcpy_mcsafe() or similar, task work registered
> using task_work_add() will never run.

task_work isn't at all useful when we didn't come from userspace. In
that case irq_work is the best option, but that doesn't provide a
preemptible context.
