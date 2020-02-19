From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 18:33:58 +0100
Message-ID: <20200219173358.GP18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSReX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:34:23 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Wed, Feb 19, 2020 at 09:21:48AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 19, 2020 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> > > Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
> >
> > x86/mce: ...
> >
> > > It is an abomination; and in prepration of removing the whole
> > > ist_enter() thing, it needs to go.
> > >
> > > Convert #MC over to using task_work_add() instead; it will run the
> > > same code slightly later, on the return to user path of the same
> > > exception.
> >
> > That's fine because the error happened in userspace.
> 
> Unless there is a signal pending and the signal setup code is about to
> hit the same failed memory.  I suppose we can just treat cases like
> this as "oh well, time to kill the whole system".
> 
> But we should genuinely agree that we're okay with deferring this handling.

It doesn't delay much. The moment it does that local_irq_enable() it's
subject to preemption, just like it is on the return to user path.

Do you really want to create code that unwinds enough of nmi_enter() to
get you to a preemptible context? *shudder*
