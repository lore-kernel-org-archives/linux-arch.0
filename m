From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Date: Wed, 12 Feb 2020 16:39:46 +0100
Message-ID: <20200212153946.GX14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094107.894657838@infradead.org>
 <20200212092539.135934e1@gandalf.local.home>
 <20200212150440.GT14897@hirez.programming.kicks-ass.net>
 <20200212101826.23d394eb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBLPkH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 10:40:07 -0500
Content-Disposition: inline
In-Reply-To: <20200212101826.23d394eb@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, Feb 12, 2020 at 10:18:26AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 16:04:40 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > This entire file is notrace:
> > > 
> > >  arch/x86/kernel/cpu/Makefile:
> > > 
> > >    CFLAGS_REMOVE_common.o = -pg  
> > 
> > Urgh, I hate it that that annotation is so hard to find :/ Also, there
> > seem to be various flavours of that Makefile magic around.
> > 
> >   CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> > 
> > is another variant I encountered.
> 
> Actually, that should be the only variant. That was added for various
> archs, and should be used consistently throughout.
> 
> There's a clean up series for you ;-) (or whoever)

If I'm going to clean this up I'd remove the Makefile rules entirely.
I hate these Makefile rules, they make it entirely non-obvious what is
and is not being traced.
