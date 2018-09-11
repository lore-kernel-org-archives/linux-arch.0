From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Tue, 11 Sep 2018 13:03:28 -0700
Message-ID: <20180911200328.GA4225@linux.vnet.ibm.com>
References: <20180908095848.GA6272@andrea>
 <Pine.LNX.4.44L0.1809111455420.1461-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809111455420.1461-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Andrea Parri <parri.andrea@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 11, 2018 at 03:31:53PM -0400, Alan Stern wrote:
> On Thu, 12 Jul 2018, Paul E. McKenney wrote:
> 
> > > > Take for instance the pattern where RCU relies on RCsc locks, this is an
> > > > entirely simple and straight forward use of locks, yet completely fails
> > > > on this subtle point.
> > > 
> > > Do you happen to remember exactly where in the kernel source this 
> > > occurs?
> > 
> > Look for the uses of raw_spin_lock_irq_rcu_node() and friends in
> > kernel/rcu and include/linux/*rcu*, along with the explanation in
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> 
> I just now started looking at this for the first time, and I was struck
> by the sloppy thinking displayed in the very first paragraph of the
> HTML document!  For example, consider the third sentence:
> 
> 	Similarly, any code that happens before the beginning of a 
> 	given RCU grace period is guaranteed to see the effects of all
> 	accesses following the end of that grace period that are within
> 	RCU read-side critical sections.
> 
> Is RCU now a time machine?  :-)

Why not?  ;-)

> I think what you meant to write in the second and third sentences was 
> something more like this:
> 
> 	Any code in an RCU critical section that extends beyond the 
> 	end of a given RCU grace period is guaranteed to see the 
> 	effects of all accesses which were visible to the grace 
> 	period's CPU before the start of the grace period.  Similarly, 
> 	any code that follows an RCU grace period (on the grace 
> 	period's CPU) is guaranteed to see the effects of all accesses 
> 	which were visible to an RCU critical section that began
> 	before the start of the grace period.

That looks to me to be an improvement, other than that the "(on the
grace period's CPU)" seems a bit restrictive -- you could for example
have a release-acquire chain starting after the grace period, right?

> Also, the document doesn't seem to explain how Tree RCU relies on the
> lock-ordering guarantees of raw_spin_lock_rcu_node() and friends.  It
> _says_ that these guarantees are used, but not how or where.  (Unless I 
> missed something; I didn't read the document all that carefully.)

The closest is this sentence: "But the only part of rcu_prepare_for_idle()
that really matters for this discussion are lines 37–39", which
refers to this code:

37     raw_spin_lock_rcu_node(rnp);
38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
39     raw_spin_unlock_rcu_node(rnp);

I could add a sentence explaining the importance of the
smp_mb__after_unlock_lock() -- is that what you are getting at?

> In any case, you should bear in mind that the lock ordering provided by
> Peter's raw_spin_lock_rcu_node() and friends is not the same as what we
> have been discussing for the LKMM:
> 
> 	Peter's routines are meant for the case where you release
> 	one lock and then acquire another (for example, locks in 
> 	two different levels of the RCU tree).
> 
> 	The LKMM patch applies only to cases where one CPU releases
> 	a lock and then that CPU or another acquires the _same_ lock 
> 	again.
> 
> As another difference, the litmus test given near the start of the
> "Tree RCU Grace Period Memory Ordering Building Blocks" section would
> not be forbidden by the LKMM, even with RCtso locks, if it didn't use
> raw_spin_lock_rcu_node().  This is because the litmus test is forbidden
> only when locks are RCsc, which is what raw_spin_lock_rcu_node()  
> provides.

Agreed.

> So I don't see how the RCU code can be held up as an example either for
> or against requiring locks to be RCtso.

Agreed again.  The use of smp_mb__after_unlock_lock() instead
provides RCsc.  But this use case is deemed sufficiently rare that
smp_mb__after_unlock_lock() is defined within RCU.

							Thanx, Paul
