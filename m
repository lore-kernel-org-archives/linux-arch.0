From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Tue, 29 May 2018 16:49:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
References: <20180529190332.GO3803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529190332.GO3803@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org, torvalds@linux-foundation.org, roman.penyaev@profitbricks.com
List-Id: linux-arch.vger.kernel.org

On Tue, 29 May 2018, Paul E. McKenney wrote:

> On Tue, May 29, 2018 at 02:35:34PM -0400, Alan Stern wrote:
> > On Mon, 28 May 2018, Paul E. McKenney wrote:
> > 
> > > Hello!
> > > 
> > > The litmus test below is a first attempt to model Roman's rcu-rr
> > > round-robin RCU-protected linked list.  His test code, which includes
> > > the algorithm under test, may be found here:
> > > 
> > > https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c
> > > 
> > > The P0() process below roughly corresponds to remove_conn_from_arr(),
> > > with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
> > > Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
> > > that the algorithm is safe, and also claims that it becomes unsafe if
> > > either synchronize_rcu() is removed.
> > 
> > This algorithm (the one in the litmus test; I haven't looked at Roman's
> > code) does seem valid.  In addition to removing either
> > synchronize_rcu(), interchanging the order of the stores in P0 (c
> > first, then w) would also invalidate it.
> > 
> > This is a little unusual in that c is written by more than one thread 
> > with no protection.  It works because the writes are all stores of a 
> > single pointer.
> > 
> > Why does the litmus test use smp_store_release() in three places?  
> > There doesn't seem to be any need; WRITE_ONCE() would be sufficient.
> 
> Because the algorithm did.  A bit of a stretch for kfree, but... ;-)
> 
> Let's try removing them, please see below.
> 
> > Alan
> > 
> > > Does this in fact realistically model Roman's algorithm?  Either way,
> > > is there a better approach?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C C-RomanPenyaev-list-rcu-rr
> > > 
> > > {
> > > 	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
> > > 	int *y=z;
> > > 	int *x=y;
> > > 	int *w=x;
> > > 	int *v=w; (* List head is v. *)
> > > 	int *c=w; (* Cache, emulating ppcpu_con. *)
> > > }
> > > 
> > > P0(int *c, int *v, int *w, int *x, int *y)
> > > {
> > > 	rcu_assign_pointer(*w, y); /* Remove x from list. */
> 
> No change when converting this to WRITE_ONCE();
> 
> > > 	synchronize_rcu();
> > > 	r1 = READ_ONCE(*c);
> > > 	if (r1 == x) {
> > > 		WRITE_ONCE(*c, 0); /* Invalidate cache. */
> > > 		synchronize_rcu();
> > > 	}
> > > 	smp_store_release(x, 0);  /* Emulate kfree(x). */
> 
> Converting this one to WRITE_ONCE() does have an effect:
> 
> 	Test C-RomanPenyaev-list-rcu-rr Allowed
> 	States 8
> 	0:r1=0; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=0; c=0; v=w; w=y; x=0; y=z;
> 	0:r1=w; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=w; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=0; v=w; w=y; x=0; y=z;
> 	0:r1=x; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=y; 1:r1=w; 1:r2=x; 1:r3=x; 1:r4=y; c=y; v=w; w=y; x=0; y=z;
> 	0:r1=y; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	0:r1=z; 1:r1=w; 1:r2=y; 1:r3=y; 1:r4=z; c=z; v=w; w=y; x=0; y=z;
> 	Ok
> 	Witnesses
> 	Positive: 1 Negative: 7
> 	Condition exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0)
> 	Observation C-RomanPenyaev-list-rcu-rr Sometimes 1 7
> 	Time C-RomanPenyaev-list-rcu-rr 0.40
> 	Hash=2ec66290a6622117b9877436950e6a08
> 
> Maybe reordered with READ_ONCE(*c) when r1 != x?

Probably.  This points out a weakness in the memory model.  Even though
the memory model allows that reordering, no compiler would reorder the
two statements and no CPU would execute the store before the load.

The general pattern is this: Suppose we have

	A;
	if (B)
		C;
	D;

where A is a load, B depends on A, D is a store, and C contains a
memory barrier or something else that orders D after A in the case
where B is true.  Furthermore, assume that B sometimes really is true
(i.e., the compiler can't prove that B is always false).  Then the
compiler is not allowed to move D up before A or B, and consequently
even when B is false, the CPU can't execute D before A.

Putting this into herd would be extremely difficult, if not impossible, 
because it involves analyzing code that was not executed.

Alan
