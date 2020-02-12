From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Date: Wed, 12 Feb 2020 10:18:26 -0500
Message-ID: <20200212101826.23d394eb@gandalf.local.home>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.894657838@infradead.org>
        <20200212092539.135934e1@gandalf.local.home>
        <20200212150440.GT14897@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBLPS3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 10:18:29 -0500
In-Reply-To: <20200212150440.GT14897@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com

On Wed, 12 Feb 2020 16:04:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > This entire file is notrace:
> > 
> >  arch/x86/kernel/cpu/Makefile:
> > 
> >    CFLAGS_REMOVE_common.o = -pg  
> 
> Urgh, I hate it that that annotation is so hard to find :/ Also, there
> seem to be various flavours of that Makefile magic around.
> 
>   CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> 
> is another variant I encountered.

Actually, that should be the only variant. That was added for various
archs, and should be used consistently throughout.

There's a clean up series for you ;-) (or whoever)

-- Steve
