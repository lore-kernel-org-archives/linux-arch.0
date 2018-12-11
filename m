From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Tue, 11 Dec 2018 13:22:04 -0800
Message-ID: <20181211212204.GR4170@linux.ibm.com>
References: <20181211190801.GO4170@linux.ibm.com>
 <Pine.LNX.4.44L0.1812111446150.1538-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1812111446150.1538-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 11, 2018 at 03:09:33PM -0500, Alan Stern wrote:
> On Tue, 11 Dec 2018, Paul E. McKenney wrote:
> 
> > > Rewriting the litmus test in these terms gives:
> > > 
> > >         P0      P1      P2      P3      P4      P5
> > >         Wa=2    Wb=2    Wc=2    [mb23]  [mb14]  [mb05]
> > >         mb0s    mb1s    mb2s    Wd=2    We=2    Wf=2
> > >         mb0e    mb1e    mb2e    Re=0    Rf=0    Ra=0
> > >         Rb=0    Rc=0    Rd=0
> > > 
> > > Here the brackets in "[mb23]", "[mb14]", and "[mb05]" mean that the
> > > positions of these barriers in their respective threads' program
> > > orderings is undetermined; they need not come at the top as shown.
> > > 
> > > (Also, in case David is unfamiliar with it, the "Wa=2" notation is
> > > shorthand for "Write 2 to a" and "Rb=0" is short for "Read 0 from b".)
> > > 
> > > Finally, here are a few facts which may be well known and obvious, but
> > > I'll state them anyway:
> > > 
> > > 	A CPU cannot reorder instructions across a memory barrier.
> > > 	If x is po-after a barrier then x executes after the barrier
> > > 	is finished.
> > > 
> > > 	If a store is po-before a barrier then the store propagates
> > > 	to every CPU before the barrier finishes.
> > > 
> > > 	If a store propagates to some CPU before a load on that CPU
> > > 	reads from the same location, then the load will obtain the
> > > 	value from that store or a co-later store.  This implies that
> > > 	if a load obtains a value co-earlier than some store then the
> > > 	load must have executed before the store propagated to the
> > > 	load's CPU.
> > > 
> > > The proof consists of three main stages, each requiring three steps.
> > > Using the facts that b - f are all read as 0, I'll show that P1
> > > executes Rc before P3 executes Re, then that P0 executes Rb before P4
> > > executes Rf, and lastly that P5's Ra must obtain 2, not 0.  This will
> > > demonstrate that the litmus test is not allowed.
> > > 
> > > 1.	Suppose that mb23 ends up coming po-later than Wd in P3.
> > > 	Then we would have:
> > > 
> > > 		Wd propagates to P2 < mb23 < mb2e < Rd,
> > > 
> > > 	and so Rd would obtain 2, not 0.  Hence mb23 must come
> > > 	po-before Wd (as shown in the listing):  mb23 < Wd.
> > > 
> > > 2.	Since mb23 therefore occurs po-before Re and instructions
> > > 	cannot be reordered across barriers,  mb23 < Re.
> > > 
> > > 3.	Since Rc obtains 0, we must have:
> > > 
> > > 		Rc < Wc propagates to P1 < mb2s < mb23 < Re.
> > > 
> > > 	Thus Rc < Re.
> > > 
> > > 4.	Suppose that mb14 ends up coming po-later than We in P4.
> > > 	Then we would have:
> > > 
> > > 		We propagates to P3 < mb14 < mb1e < Rc < Re,
> > > 
> > > 	and so Re would obtain 2, not 0.  Hence mb14 must come
> > > 	po-before We (as shown in the listing):  mb14 < We.
> > > 
> > > 5.	Since mb14 therefore occurs po-before Rf and instructions
> > > 	cannot be reordered across barriers,  mb14 < Rf.
> > > 
> > > 6.	Since Rb obtains 0, we must have:
> > > 
> > > 		Rb < Wb propagates to P0 < mb1s < mb14 < Rf.
> > > 
> > > 	Thus Rb < Rf.
> > > 
> > > 7.	Suppose that mb05 ends up coming po-later than Wf in P5.
> > > 	Then we would have:
> > > 
> > > 		Wf propagates to P4 < mb05 < mb0e < Rb < Rf,
> > > 
> > > 	and so Rf would obtain 2, not 0.  Hence mb05 must come
> > > 	po-before Wf (as shown in the listing):  mb05 < Wf.
> > > 
> > > 8.	Since mb05 therefore occurs po-before Ra and instructions
> > > 	cannot be reordered across barriers,  mb05 < Ra.
> > > 
> > > 9.	Now we have:
> > > 
> > > 		Wa propagates to P5 < mb0s < mb05 < Ra,
> > > 
> > > 	and so Ra must obtain 2, not 0.  QED.
> > 
> > Like this, then, with maximal reordering of P3-P5's reads?
> > 
> >          P0      P1      P2      P3      P4      P5
> >          Wa=2
> >          mb0s
> >                                                  [mb05]
> >          mb0e                                    Ra=0
> >          Rb=0    Wb=2
> >                  mb1s
> >                                          [mb14]
> >                  mb1e                    Rf=0
> >                  Rc=0    Wc=2                    Wf=2
> >                          mb2s
> >                                  [mb23]
> >                          mb2e    Re=0
> >                          Rd=0            We=2
> >                                  Wd=2
> 
> Yes, that's right.  This shows how P5's Ra must obtain 2 instead of 0.
> 
> > But don't the sys_membarrier() calls affect everyone, especially given
> > the shared-variable communication?
> 
> They do, but the other effects are irrelevant for this proof.

If I understand correctly, the shared-variable communication within
sys_membarrier() is included in your proof in the form of ordering
between memory barriers in the mainline sys_membarrier() code and
in the IPI handlers.

> >  If so, why wouldn't this more strict
> > variant hold?
> > 
> >          P0      P1      P2      P3      P4      P5
> >          Wa=2
> >          mb0s
> >                                  [mb05]  [mb05]  [mb05]
> 
> You have misunderstood the naming scheme.  mb05 is the barrier injected 
> by P0's sys_membarrier call into P5.  So the three barriers above 
> should be named "mb03", "mb04", and "mb05".  And you left out mb01 and 
> mb02.

The former is a copy-and-paste error on my part, the latter was
intentional because the IPIs among P0, P1, and P2 don't seem to
strengthen the ordering.

> >          mb0e
> >          Rb=0    Wb=2
> >                  mb1s
> >                                  [mb14]  [mb14]  [mb14]
> >                  mb1e
> >                  Rc=0    Wc=2
> >                          mb2s
> >                                  [mb23]  [mb23]  [mb23]
> >                          mb2e    Re=0    Rf=0    Ra=0
> >                          Rd=0            We=2    Wf=2
> >                                  Wd=2
> 
> Yes, this does hold.  But since it doesn't affect the end result, 
> there's no point in mentioning all those other barriers.
> 
> > In which case, wouldn't this cycle be forbidden even if it had only one
> > sys_membarrier() call?
> 
> No, it wouldn't.  I don't understand why you might think it would.  

Because I hadn't yet thought of the scenario I showed below.

> This is just like RCU, if you imagine a tiny critical section between 
> each adjacent pair of instructions.  You wouldn't expect RCU to enforce 
> ordering among six CPUs with only one synchronize_rcu call.

Yes, I do now agree in light of the scenario shown below.

> > Ah, but the IPIs are not necessarily synchronized across the CPUs,
> > so that the following could happen:
> > 
> >          P0      P1      P2      P3      P4      P5
> >          Wa=2
> >          mb0s
> >                                  [mb05]  [mb05]  [mb05]
> >          mb0e                                    Ra=0
> >          Rb=0    Wb=2
> >                  mb1s
> >                                  [mb14]  [mb14]
> >                                          Rf=0
> >                                                  Wf=2
> >                                                  [mb14]
> >                  mb1e
> >                  Rc=0    Wc=2
> >                          mb2s
> >                                  [mb23]
> >                                  Re=0
> >                                          We=2
> >                                          [mb23]  [mb23]
> >                          mb2e
> >                          Rd=0
> >                                  Wd=2
> 
> Yes it could.  But even in this execution you would end up with Ra=2 
> instead of Ra=0.

Agreed.  Or I should have said that the above execution is forbidden,
either way.

> > I guess in light of this post in 2001, I really don't have an excuse,
> > do I?  ;-)
> > 
> > 	https://lists.gt.net/linux/kernel/223555
> > 
> > Or am I still missing something here?
> 
> You tell me...

I think I am on board.  ;-)

							Thanx, Paul
