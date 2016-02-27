From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 20/20] rcu: Make CPU_DYING_IDLE an explicit call
Date: Sat, 27 Feb 2016 08:33:07 -0800
Message-ID: <20160227163307.GS3522@linux.vnet.ibm.com>
References: <20160226164321.657646833@linutronix.de>
 <20160226182341.870167933@linutronix.de>
 <20160227021429.GN3522@linux.vnet.ibm.com>
 <20160227022308.GA3959@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1602270840510.3638@nanos>
 <20160227110528.GR3522@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1602271228570.3638@nanos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:36577 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbcB0QdM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 11:33:12 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 27 Feb 2016 11:33:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602271228570.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Sat, Feb 27, 2016 at 12:30:33PM +0100, Thomas Gleixner wrote:
> On Sat, 27 Feb 2016, Paul E. McKenney wrote:
> > On Sat, Feb 27, 2016 at 08:47:41AM +0100, Thomas Gleixner wrote:
> > > On Fri, 26 Feb 2016, Paul E. McKenney wrote:
> > > > > > --- a/kernel/cpu.c
> > > > > > +++ b/kernel/cpu.c
> > > > > > @@ -762,6 +762,7 @@ void cpuhp_report_idle_dead(void)
> > > > > >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > > > > >  	st->state = CPUHP_AP_IDLE_DEAD;
> > > > > >  	complete(&st->done);
> > > > > 
> > > > > What prevents the other CPU from killing this CPU at this point, so
> > > > > that this CPU does not tell RCU that it is dead?
> > > > >
> > > > > I agree that the odds should be low, but there are all manner of things
> > > > > that might delay a CPU for just a little bit too long...
> > > > > 
> > > > > Or am I missing something subtle here?
> > > 
> > > No. The reason why I moved the rcu call past the complete is, that otherwise
> > > complete() complains about rcu being dead already. Hmm, but you are right. In
> > > theory the other side could allow physical removal before it actually told rcu
> > > that it's gone.
> > 
> > There is one case where this is OK, and that is where the outgoing CPU
> > puts itself to sleep (or whatever) without help from the other CPU.
> 
> That's the case. It's the last call before the outgoing CPU goes into
> arch_cpu_idle_dead(). There is no involvement of the controlling CPU at this
> point. It just wants to know, that the outgoing one is dead finally.

Ah, so you have gotten rid of all the things like arm's and xtensa's
platform_cpu_kill(), where the surviving CPU does things like stopping
the outgoing CPU's clock?  That would make things simpler!

							Thanx, Paul
