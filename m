Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50076 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726810AbeILAcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Sep 2018 20:32:39 -0400
Date: Tue, 11 Sep 2018 15:31:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180908095848.GA6272@andrea>
Message-ID: <Pine.LNX.4.44L0.1809111455420.1461-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Andrea Parri <parri.andrea@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20180911193153.XAvuSQPmIuPIQ17GpaNHO7jd5OQLpDMv7bPZjOv5guY@z>

On Thu, 12 Jul 2018, Paul E. McKenney wrote:

> > > Take for instance the pattern where RCU relies on RCsc locks, this is an
> > > entirely simple and straight forward use of locks, yet completely fails
> > > on this subtle point.
> > 
> > Do you happen to remember exactly where in the kernel source this 
> > occurs?
> 
> Look for the uses of raw_spin_lock_irq_rcu_node() and friends in
> kernel/rcu and include/linux/*rcu*, along with the explanation in
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html

I just now started looking at this for the first time, and I was struck
by the sloppy thinking displayed in the very first paragraph of the
HTML document!  For example, consider the third sentence:

	Similarly, any code that happens before the beginning of a 
	given RCU grace period is guaranteed to see the effects of all
	accesses following the end of that grace period that are within
	RCU read-side critical sections.

Is RCU now a time machine?  :-)

I think what you meant to write in the second and third sentences was 
something more like this:

	Any code in an RCU critical section that extends beyond the 
	end of a given RCU grace period is guaranteed to see the 
	effects of all accesses which were visible to the grace 
	period's CPU before the start of the grace period.  Similarly, 
	any code that follows an RCU grace period (on the grace 
	period's CPU) is guaranteed to see the effects of all accesses 
	which were visible to an RCU critical section that began
	before the start of the grace period.

Also, the document doesn't seem to explain how Tree RCU relies on the
lock-ordering guarantees of raw_spin_lock_rcu_node() and friends.  It
_says_ that these guarantees are used, but not how or where.  (Unless I 
missed something; I didn't read the document all that carefully.)

In any case, you should bear in mind that the lock ordering provided by
Peter's raw_spin_lock_rcu_node() and friends is not the same as what we
have been discussing for the LKMM:

	Peter's routines are meant for the case where you release
	one lock and then acquire another (for example, locks in 
	two different levels of the RCU tree).

	The LKMM patch applies only to cases where one CPU releases
	a lock and then that CPU or another acquires the _same_ lock 
	again.

As another difference, the litmus test given near the start of the
"Tree RCU Grace Period Memory Ordering Building Blocks" section would
not be forbidden by the LKMM, even with RCtso locks, if it didn't use
raw_spin_lock_rcu_node().  This is because the litmus test is forbidden
only when locks are RCsc, which is what raw_spin_lock_rcu_node()  
provides.

So I don't see how the RCU code can be held up as an example either for
or against requiring locks to be RCtso.

Alan
