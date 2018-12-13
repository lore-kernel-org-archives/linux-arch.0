From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Thu, 13 Dec 2018 10:49:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1812131026570.1586-100000@iolanthe.rowland.org>
References: <20181212224931.GD4170@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212224931.GD4170@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 12 Dec 2018, Paul E. McKenney wrote:

> > Well, what are you trying to accomplish?  Do you want to find an 
> > argument similar to the one I posted for the 6-CPU test to show that 
> > this test should be forbidden?
> 
> I am trying to check odd corner cases.  Your sys_membarrier() model
> is quite nice and certainly fits nicely with the rest of the model,
> but where I come from, that is actually reason for suspicion.  ;-)
> 
> All kidding aside, your argument for the 6-CPU test was extremely
> valuable, as it showed me a way to think of that test from an
> implementation viewpoint.  Then the question is whether or not that
> viewpoint actually matches the model, which seems to be the case thus far.

It should, since I formulated the reasoning behind that viewpoint 
directly from the model.  The basic idea is this:

	By induction, show that whenever we have A ->rcu-fence B then
	anything po-before A executes before anything po-after B, and
	furthermore, any write which propagates to A's CPU before A
	executes will propagate to every CPU before B finishes (i.e.,
	before anything po-after B executes).

	Using this, show that whenever X ->rb Y holds then X must
	execute before Y.

That's what the 6-CPU argument did.  In that litmus test we have
mb2 ->rcu-fence mb23, Rc ->rb Re, mb1 ->rcu-fence mb14, Rb ->rb Rf,
mb0 ->rcu-fence mb05, and lastly Ra ->rb Ra.  The last one is what 
shows that the test is forbidden.

> A good next step would be to automatically generate random tests along
> with an automatically generated prediction, like I did for RCU a few
> years back.  I should be able to generalize my time-based cheat for RCU to
> also cover SRCU, though sys_membarrier() will require a bit more thought.
> (The time-based cheat was to have fixed duration RCU grace periods and
> RCU read-side critical sections, with the grace period duration being
> slightly longer than that of the critical sections.  The number of
> processes is of course limited by the chosen durations, but that limit
> can easily be made insanely large.)

Imagine that each sys_membarrier call takes a fixed duration and each 
other instruction takes slightly less (the idea being that each 
instruction is a critical section).  Instructions can be reordered 
(although not across a sys_membarrier call), but no matter how the 
reordering is done, the result is disallowed.

> I guess that I still haven't gotten over being a bit surprised that the
> RCU counting rule also applies to sys_membarrier().  ;-)

Why not?  They are both synchronization mechanisms with heavy-weight
write sides and light-weight read sides, and most importantly, they
provide the same Guarantee.

Alan
