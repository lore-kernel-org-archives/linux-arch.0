From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Date: Tue, 18 Feb 2020 12:18:06 -0800
Message-ID: <20200218201806.GI2935@paulmck-ThinkPad-P72>
References: <20200213163800.5c51a5f1@gandalf.local.home>
 <20200213215004.GM2935@paulmck-ThinkPad-P72>
 <20200213170451.690c4e5c@gandalf.local.home>
 <20200213223918.GN2935@paulmck-ThinkPad-P72>
 <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
 <20200215145934.GD2935@paulmck-ThinkPad-P72>
 <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
 <20200217163112.GM2935@paulmck-ThinkPad-P72>
 <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
 <20200218124609.1a33f868@gandalf.local.home>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgBRUSH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 15:18:07 -0500
Content-Disposition: inline
In-Reply-To: <20200218124609.1a33f868@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Tue, Feb 18, 2020 at 12:46:09PM -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2020 13:33:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Mon, 17 Feb 2020 08:31:12 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > BTW, if you consider the x86 specific code is in the generic file,
> > > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > > > (Sorry, I've hit this idea right now)  
> > > 
> > > Might this affect other architectures with NMIs and probe-like things?
> > > If so, it might make sense to leave it where it is.  
> > 
> > Yes, git grep shows that arm64 is using rcu_nmi_enter() in
> > debug_exception_enter().
> > OK, let's keep it, but maybe it is good to update the comment for
> > arm64 too. What about following?
> > 
> > +/*
> > + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
> > + * marked NOKPROBE before kprobes handler is called.
> > + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
> > + * before kprobes handle happens to call rcu_nmi_enter() which means
> > + * that rcu_nmi_enter() must be marked NOKRPOBE.
> > + */
> > 
> 
> Ah, why don't we just say...
> 
> /*
>  * All functions called in the breakpoint trap handler (e.g. do_int3()
>  * on x86), must not allow kprobes until the kprobe breakpoint handler
>  * is called, otherwise it can cause an infinite recursion.
>  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
>  * before the kprobe breakpoint handler is called, thus it must be
>  * marked as NOKPROBE.
>  */
> 
> And that way we don't make this an arch specific comment.

That looks good to me.  Masami, does this work for you?

							Thanx, Paul
