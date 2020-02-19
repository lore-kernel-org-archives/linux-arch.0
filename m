From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Date: Wed, 19 Feb 2020 08:46:38 -0800
Message-ID: <20200219164638.GE2935@paulmck-ThinkPad-P72>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
 <20200219160442.GE14946@hirez.programming.kicks-ass.net>
 <20200219111228.44c2999b@gandalf.local.home>
 <20200219162747.GX2935@paulmck-ThinkPad-P72>
 <20200219163409.GI18400@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgBSQqj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:46:39 -0500
Content-Disposition: inline
In-Reply-To: <20200219163409.GI18400@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

On Wed, Feb 19, 2020 at 05:34:09PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:27:47AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 11:12:28AM -0500, Steven Rostedt wrote:
> > > On Wed, 19 Feb 2020 17:04:42 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > > -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> > > > > +		for (i = 0; i < count; i++) {
> > > > > +			int idx = (dst <= src) ? i : count - i;  
> > > > 
> > > > That's an off-by-one for going backward; 'count - 1 - i' should work
> > > > better, or I should just stop typing for today ;-)
> > > 
> > > Or, we could just cut and paste the current memmove and make a notrace
> > > version too. Then we don't need to worry bout bugs like this.
> > 
> > OK, I will bite...
> > 
> > Can we just make the core be an inline function and make a notrace and
> > a trace caller?  Possibly going one step further and having one call
> > the other?  (Presumably the traceable version invoking the notrace
> > version, but it has been one good long time since I have looked at
> > function preambles.)
> 
> One complication is that GCC (and others) are prone to stick their own
> implementation of memmove() (and other string functions) in at 'random'.
> That is, it is up to the compiler's discretion wether or not to put a
> call to memmove() in or just emit some random giberish they feel has the
> same effect.
> 
> So if we go play silly games like that, we need be careful (or just call
> __memmove I suppose, which is supposed to avoid that IIRC).

Urgh, good point.  :-/

							Thanx, Paul
