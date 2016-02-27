From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [patch 20/20] rcu: Make CPU_DYING_IDLE an explicit call
Date: Sat, 27 Feb 2016 03:05:28 -0800
Message-ID: <20160227110528.GR3522@linux.vnet.ibm.com>
References: <20160226164321.657646833@linutronix.de>
 <20160226182341.870167933@linutronix.de>
 <20160227021429.GN3522@linux.vnet.ibm.com>
 <20160227022308.GA3959@linux.vnet.ibm.com>
 <alpine.DEB.2.11.1602270840510.3638@nanos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:60966 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176AbcB0LFe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 06:05:34 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sat, 27 Feb 2016 04:05:33 -0700
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602270840510.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Sat, Feb 27, 2016 at 08:47:41AM +0100, Thomas Gleixner wrote:
> On Fri, 26 Feb 2016, Paul E. McKenney wrote:
> > > > --- a/kernel/cpu.c
> > > > +++ b/kernel/cpu.c
> > > > @@ -762,6 +762,7 @@ void cpuhp_report_idle_dead(void)
> > > >  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> > > >  	st->state = CPUHP_AP_IDLE_DEAD;
> > > >  	complete(&st->done);
> > > 
> > > What prevents the other CPU from killing this CPU at this point, so
> > > that this CPU does not tell RCU that it is dead?
> > >
> > > I agree that the odds should be low, but there are all manner of things
> > > that might delay a CPU for just a little bit too long...
> > > 
> > > Or am I missing something subtle here?
> 
> No. The reason why I moved the rcu call past the complete is, that otherwise
> complete() complains about rcu being dead already. Hmm, but you are right. In
> theory the other side could allow physical removal before it actually told rcu
> that it's gone.

There is one case where this is OK, and that is where the outgoing CPU
puts itself to sleep (or whatever) without help from the other CPU.

> > Just in case I am not missing anything...
> > 
> > One approach is to go back to the spinning, but to do rcu_report_dead()
> > just before kicking the other CPU.  This would also fix some issues with
> > use of RCU of the offline path, so would definitely be better than my
> > earlier approach of notifying RCU from within the idle loop.
> > 
> > This assumes that all the offline paths have been consolidated into
> > this path.  (Yes, I was too lazy and cowardly to consolidate them all
> > last I touched this code, but perhaps that has happened elsewise?)
> 
> The question is whether the rcu dead notification has to happen
> instantaniously and needs to be done on the dead cpu. If we can avoid both,
> then there is a very simple solution.

Hmmm...

The rcu_cleanup_dying_idle_cpu() can be invoked from the surviving CPU,
-as- -long- -as- nothing in the intervening code path waits for a grace
period.  The wakeup path itself had better not wait for a grace period,
of course.  The concern would be that the task running on the surviving
CPU might be waiting for a grace period before sleeping -- which used to
be possible due to the CPU-hotplug notifiers that it might be executing
before getting to RCU's CPU-hotplug notifiers.

The rcu_report_exp_rdp() is considerably more scary.  At first glance,
it looks OK, but I will need to stare at it for a bit.

Of course, if the task running on the surviving CPU can be waiting for a
grace period, one of two problems can happen:

o	RCU times out the outgoing CPU before it has really left.
	This is the current state, and needs to change.  The dying idle
	stuff was half of the needed change, the other half being on
	the incoming side.

o	Deadlock -- the outgoing CPU won't respond to RCU, so the
	task running on the surviving CPU never wakes up from its
	wait on a grace period.

So if rcu_report_exp_rdp() turns out to be OK -and- if the outgoing
task never waits on a grace period during the CPU-shutdown process,
this might work.

Of course, my ability to test this sufficiently viciously is currently
blocked by the lost-wakeup problem I am currently chasing.  (Hey, at
least I finally get ftrace output!  Completely baffling output, but so
it goes...)  :-/

							Thanx, Paul
