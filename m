From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 20/20] rcu: Make CPU_DYING_IDLE an explicit call
Date: Sat, 27 Feb 2016 08:47:41 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602270840510.3638@nanos>
References: <20160226164321.657646833@linutronix.de> <20160226182341.870167933@linutronix.de> <20160227021429.GN3522@linux.vnet.ibm.com> <20160227022308.GA3959@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35339 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbcB0HtM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 02:49:12 -0500
In-Reply-To: <20160227022308.GA3959@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Fri, 26 Feb 2016, Paul E. McKenney wrote:
> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -762,6 +762,7 @@ void cpuhp_report_idle_dead(void)
> > >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > >  	st->state = CPUHP_AP_IDLE_DEAD;
> > >  	complete(&st->done);
> > 
> > What prevents the other CPU from killing this CPU at this point, so
> > that this CPU does not tell RCU that it is dead?
> >
> > I agree that the odds should be low, but there are all manner of things
> > that might delay a CPU for just a little bit too long...
> > 
> > Or am I missing something subtle here?

No. The reason why I moved the rcu call past the complete is, that otherwise
complete() complains about rcu being dead already. Hmm, but you are right. In
theory the other side could allow physical removal before it actually told rcu
that it's gone.

> Just in case I am not missing anything...
> 
> One approach is to go back to the spinning, but to do rcu_report_dead()
> just before kicking the other CPU.  This would also fix some issues with
> use of RCU of the offline path, so would definitely be better than my
> earlier approach of notifying RCU from within the idle loop.
> 
> This assumes that all the offline paths have been consolidated into
> this path.  (Yes, I was too lazy and cowardly to consolidate them all
> last I touched this code, but perhaps that has happened elsewise?)

The question is whether the rcu dead notification has to happen
instantaniously and needs to be done on the dead cpu. If we can avoid both,
then there is a very simple solution.

Thanks,

	tglx
