From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Tue, 11 Dec 2018 11:21:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1812111115020.1538-100000@iolanthe.rowland.org>
References: <20181210182516.GV4170@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210182516.GV4170@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 10 Dec 2018, Paul E. McKenney wrote:

> On Mon, Dec 10, 2018 at 11:22:31AM -0500, Alan Stern wrote:
> > On Thu, 6 Dec 2018, Paul E. McKenney wrote:
> > 
> > > Hello, David,
> > > 
> > > I took a crack at extending LKMM to accommodate what I think would
> > > support what you have in your paper.  Please see the very end of this
> > > email for a patch against the "dev" branch of my -rcu tree.
> > > 
> > > This gives the expected result for the following three litmus tests,
> > > but is probably deficient or otherwise misguided in other ways.  I have
> > > added the LKMM maintainers on CC for their amusement.  ;-)
> > > 
> > > Thoughts?
> > 
> > Since sys_membarrier() provides a heavyweight barrier comparable to 
> > synchronize_rcu(), the memory model should treat the two in the same 
> > way.  That's what this patch does.
> > 
> > The corresponding critical section would be any region of code bounded
> > by compiler barriers.  Since the LKMM doesn't currently handle plain
> > accesses, the effect is the same as if a compiler barrier were present
> > between each pair of instructions.  Basically, each instruction acts as
> > its own critical section.  Therefore the patch below defines memb-rscsi
> > as the trivial identity relation.  When plain accesses and compiler 
> > barriers are added to the memory model, a different definition will be 
> > needed.
> > 
> > This gives the correct results for the three C-Goldblat-memb-* litmus 
> > tests in Paul's email.
> 
> Yow!!!
> 
> My first reaction was that this cannot possibly be correct because
> sys_membarrier(), which is probably what we should call it, does not
> wait for anything.  But your formulation has the corresponding readers
> being "id", which as you say above is just a single event.
> 
> But what makes this work for the following litmus test?
> 
> ------------------------------------------------------------------------
> 
> C membrcu
> 
> {
> }
> 
> P0(intptr_t *x0, intptr_t *x1)
> {
> 	WRITE_ONCE(*x0, 2);
> 	smp_memb();
> 	intptr_t r2 = READ_ONCE(*x1);
> }
> 
> 
> P1(intptr_t *x1, intptr_t *x2)
> {
> 	WRITE_ONCE(*x1, 2);
> 	smp_memb();
> 	intptr_t r2 = READ_ONCE(*x2);
> }
> 
> 
> P2(intptr_t *x2, intptr_t *x3)
> {
> 	WRITE_ONCE(*x2, 2);
> 	smp_memb();
> 	intptr_t r2 = READ_ONCE(*x3);
> }
> 
> 
> P3(intptr_t *x3, intptr_t *x4)
> {
> 	rcu_read_lock();
> 	WRITE_ONCE(*x3, 2);
> 	intptr_t r2 = READ_ONCE(*x4);
> 	rcu_read_unlock();
> }
> 
> 
> P4(intptr_t *x4, intptr_t *x5)
> {
> 	rcu_read_lock();
> 	WRITE_ONCE(*x4, 2);
> 	intptr_t r2 = READ_ONCE(*x5);
> 	rcu_read_unlock();
> }
> 
> 
> P5(intptr_t *x0, intptr_t *x5)
> {
> 	rcu_read_lock();
> 	WRITE_ONCE(*x5, 2);
> 	intptr_t r2 = READ_ONCE(*x0);
> 	rcu_read_unlock();
> }
> 
> exists
> (5:r2=0 /\ 0:r2=0 /\ 1:r2=0 /\ 2:r2=0 /\ 3:r2=0 /\ 4:r2=0)
> 
> ------------------------------------------------------------------------
> 
> For this, herd gives "Never".  Of course, if I reverse the write and
> read in any of P3(), P4(), or P5(), I get "Sometimes", which does make
> sense.  But what is preserving the order between P3() and P4() and
> between P4() and P5()?  I am not immediately seeing how the analogy
> with RCU carries over to this case.

That isn't how it works.  Nothing preserves the orders you mentioned.
It's more like: the order between P1 and P4 is preserved, as is the
order between P0 and P5.  You'll see below...

(I readily agree that this result is not simple or obvious.  It took me
quite a while to formulate the following analysis.)

To begin with, since there aren't any synchronize_rcu calls in the
test, the rcu_read_lock and rcu_read_unlock calls do nothing.  They
can be eliminated.

Also, I find the variable names "x0" - "x5" to be a little hard to
work with.  If you don't mind, I'll replace them with "a" - "f".

Now, a little digression on how sys_membarrier works.  It starts by
executing a full memory barrier.  Then it injects memory barriers into
the instruction streams of all the other CPUs and waits for them all
to complete.  Then it executes an ending memory barrier.

These barriers are ordered as described.  Therefore we have

	mb0s < mb05 < mb0e,
	mb1s < mb14 < mb1e,  and
	mb2s < mb23 < mb2e,

where mb0s is the starting barrier of the sys_memb call on P0, mb05 is
the barrier that it injects into P5, mb0e is the ending barrier of the
call, and similarly for the other sys_memb calls.  The '<' signs mean
that the thing on their left finishes before the thing on their right
does.

Rewriting the litmus test in these terms gives:

        P0      P1      P2      P3      P4      P5
        Wa=2    Wb=2    Wc=2    [mb23]  [mb14]  [mb05]
        mb0s    mb1s    mb2s    Wd=2    We=2    Wf=2
        mb0e    mb1e    mb2e    Re=0    Rf=0    Ra=0
        Rb=0    Rc=0    Rd=0

Here the brackets in "[mb23]", "[mb14]", and "[mb05]" mean that the
positions of these barriers in their respective threads' program
orderings is undetermined; they need not come at the top as shown.

(Also, in case David is unfamiliar with it, the "Wa=2" notation is
shorthand for "Write 2 to a" and "Rb=0" is short for "Read 0 from b".)

Finally, here are a few facts which may be well known and obvious, but
I'll state them anyway:

	A CPU cannot reorder instructions across a memory barrier.
	If x is po-after a barrier then x executes after the barrier
	is finished.

	If a store is po-before a barrier then the store propagates
	to every CPU before the barrier finishes.

	If a store propagates to some CPU before a load on that CPU
	reads from the same location, then the load will obtain the
	value from that store or a co-later store.  This implies that
	if a load obtains a value co-earlier than some store then the
	load must have executed before the store propagated to the
	load's CPU.

The proof consists of three main stages, each requiring three steps.
Using the facts that b - f are all read as 0, I'll show that P1
executes Rc before P3 executes Re, then that P0 executes Rb before P4
executes Rf, and lastly that P5's Ra must obtain 2, not 0.  This will
demonstrate that the litmus test is not allowed.

1.	Suppose that mb23 ends up coming po-later than Wd in P3.
	Then we would have:

		Wd propagates to P2 < mb23 < mb2e < Rd,

	and so Rd would obtain 2, not 0.  Hence mb23 must come
	po-before Wd (as shown in the listing):  mb23 < Wd.

2.	Since mb23 therefore occurs po-before Re and instructions
	cannot be reordered across barriers,  mb23 < Re.

3.	Since Rc obtains 0, we must have:

		Rc < Wc propagates to P1 < mb2s < mb23 < Re.

	Thus Rc < Re.

4.	Suppose that mb14 ends up coming po-later than We in P4.
	Then we would have:

		We propagates to P3 < mb14 < mb1e < Rc < Re,

	and so Re would obtain 2, not 0.  Hence mb14 must come
	po-before We (as shown in the listing):  mb14 < We.

5.	Since mb14 therefore occurs po-before Rf and instructions
	cannot be reordered across barriers,  mb14 < Rf.

6.	Since Rb obtains 0, we must have:

		Rb < Wb propagates to P0 < mb1s < mb14 < Rf.

	Thus Rb < Rf.

7.	Suppose that mb05 ends up coming po-later than Wf in P5.
	Then we would have:

		Wf propagates to P4 < mb05 < mb0e < Rb < Rf,

	and so Rf would obtain 2, not 0.  Hence mb05 must come
	po-before Wf (as shown in the listing):  mb05 < Wf.

8.	Since mb05 therefore occurs po-before Ra and instructions
	cannot be reordered across barriers,  mb05 < Ra.

9.	Now we have:

		Wa propagates to P5 < mb0s < mb05 < Ra,

	and so Ra must obtain 2, not 0.  QED.

Alan
