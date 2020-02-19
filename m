From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove()
 notrace/NOKPROBE
Date: Wed, 19 Feb 2020 11:12:28 -0500
Message-ID: <20200219111228.44c2999b@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.604459293@infradead.org>
        <20200219103614.2299ff61@gandalf.local.home>
        <20200219154031.GE18400@hirez.programming.kicks-ass.net>
        <20200219155715.GD14946@hirez.programming.kicks-ass.net>
        <20200219160442.GE14946@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBSQMb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:12:31 -0500
In-Reply-To: <20200219160442.GE14946@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, 19 Feb 2020 17:04:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> > +		for (i = 0; i < count; i++) {
> > +			int idx = (dst <= src) ? i : count - i;  
> 
> That's an off-by-one for going backward; 'count - 1 - i' should work
> better, or I should just stop typing for today ;-)

Or, we could just cut and paste the current memmove and make a notrace
version too. Then we don't need to worry bout bugs like this.

-- Steve
