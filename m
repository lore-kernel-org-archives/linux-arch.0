From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Wed, 12 Dec 2018 14:49:31 -0800
Message-ID: <20181212224931.GD4170@linux.ibm.com>
References: <20181212215245.GC4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812121710350.1543-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812121710350.1543-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 12, 2018 at 05:12:18PM -0500, Alan Stern wrote:
> On Wed, 12 Dec 2018, Paul E. McKenney wrote:
> 
> > > > I believe that this ordering forbids the cycle:
> > > > 
> > > > 	Wa=1 > membs -> [m01] -> Rc=0 -> Wc=2 -> rcu_read_unlock() ->
> > > > 		return from synchronize_rcu() -> Ra
> > > > 
> > > > Does this make sense, or am I missing something?
> > > 
> > > It's hard to tell.  What you have written here isn't justified by the
> > > litmus test source code, since the position of m01 in P1's program
> > > order is undetermined.  How do you justify m01 -> Rc, for example?
> > 
> > ... justifies Rc=0 following [m01].
> > 
> > > Write it this way instead, using the relations defined in the 
> > > sys_membarrier patch for linux-kernel.cat:
> > > 
> > > 	memb ->memb-gp memb ->rcu-link Rc ->memb-rscsi Rc ->rcu-link
> > > 		
> > > 		rcu_read_unlock ->rcu-rscsi rcu_read_lock ->rcu-link 
> > > 
> > > 		synchronize_rcu ->rcu-gp synchronize_rcu ->rcu-link memb
> > > 
> > > Recall that:
> > > 
> > > 	memb-gp is the identity relation on sys_membarrier events,
> > > 
> > > 	rcu-link includes (po? ; fre ; po),
> > > 
> > > 	memb-rscsi is the identity relation on all events,
> > > 
> > > 	rcu-rscsi links unlocks to their corresponding locks, and
> > > 
> > > 	rcu-gp is the identity relation on synchronize_rcu events.
> > > 
> > > These facts justify the cycle above.
> > > 
> > > Leaving off the final rcu-link step, the sequence matches the
> > > definition of rcu-fence (the relations are memb-gp, memb-rscsi, 
> > > rcu-rscsi, rcu-gp with rcu-links in between).  Therefore the cycle is 
> > > forbidden.
> > 
> > Understood, but that would be using the model to check the model.  ;-)
> 
> Well, what are you trying to accomplish?  Do you want to find an 
> argument similar to the one I posted for the 6-CPU test to show that 
> this test should be forbidden?

I am trying to check odd corner cases.  Your sys_membarrier() model
is quite nice and certainly fits nicely with the rest of the model,
but where I come from, that is actually reason for suspicion.  ;-)

All kidding aside, your argument for the 6-CPU test was extremely
valuable, as it showed me a way to think of that test from an
implementation viewpoint.  Then the question is whether or not that
viewpoint actually matches the model, which seems to be the case thus far.

A good next step would be to automatically generate random tests along
with an automatically generated prediction, like I did for RCU a few
years back.  I should be able to generalize my time-based cheat for RCU to
also cover SRCU, though sys_membarrier() will require a bit more thought.
(The time-based cheat was to have fixed duration RCU grace periods and
RCU read-side critical sections, with the grace period duration being
slightly longer than that of the critical sections.  The number of
processes is of course limited by the chosen durations, but that limit
can easily be made insanely large.)

I guess that I still haven't gotten over being a bit surprised that the
RCU counting rule also applies to sys_membarrier().  ;-)

							Thanx, Paul
