From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Date: Thu, 10 Jan 2019 23:46:22 +0100
Message-ID: <20190110224622.GA3701@andrea>
References: <20190110143137.GJ1215@linux.ibm.com>
 <Pine.LNX.4.44L0.1901101039360.1497-100000@iolanthe.rowland.org>
 <20190110163126.GS1215@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110163126.GS1215@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 10, 2019 at 08:31:26AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 10, 2019 at 10:41:23AM -0500, Alan Stern wrote:
> > On Thu, 10 Jan 2019, Paul E. McKenney wrote:
> > 
> > > On Thu, Jan 10, 2019 at 09:40:24AM +0100, Andrea Parri wrote:
> > > > > > > > It seems that
> > > > > > > > 
> > > > > > > >   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > > > > > >   
> > > > > > > > from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> > > > > > > > considered that, IIRC, you introduced the primitive and RCU is currently
> > > > > > > > its only user.)
> > > > > > > 
> > > > > > > That commit is in -tip:
> > > > > > > 
> > > > > > > 4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
> > > > > > > 
> > > > > > > So it has already left my -rcu tree.  ;-)
> > > > > > 
> > > > > > Oh, you're right: now I see the commit (e.g., with "git show"), but I
> > > > > > don't see the corresponding changes applied to the tree.
> > > > > > 
> > > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=4607abbcf464ea2be14da444215d05c73025cf6e
> > > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/memory-model/linux-kernel.bell?h=locking/core
> > > > > > 
> > > > > > Is this expected?
> > > > > 
> > > > > Are you asking why it is in -tip but not in mainline?  I am not sure,
> > > > > but given that the merge window was over the holiday season and that
> > > > > the length of the merge window proved to be shorter than many people
> > > > > expected it to be, I am not too surprised.  ;-)
> > > > 
> > > > Mmh, let me try again:
> > > > 
> > > >   $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > > >   $ cd tip
> > > >   $ git checkout -b locking/core origin/locking/core
> > > > 
> > > >   $ git show 4607abbcf464
> > > >   commit 4607abbcf464ea2be14da444215d05c73025cf6e
> > > >   Author: Andrea Parri <andrea.parri@amarulasolutions.com>
> > > >   Date:   Mon Dec 3 15:04:49 2018 -0800
> > > > 
> > > >       tools/memory-model: Model smp_mb__after_unlock_lock()
> > > > 
> > > >   $ cd tools/memory-model
> > > >   $ herd7 -conf linux-kernel.cfg after-unlock-lock-same-cpu.litmus
> > > >   File "after-unlock-lock-same-cpu.litmus": Unknown macro smp_mb__after_unlock_lock (User error)
> > > > 
> > > >   [aka, linux-kernel.def in tip:locking/core does not have the
> > > >    smp_mb__after_unlock_lock() added by 4607abbcf464]
> > > 
> > > Color me confused:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > $ git checkout 4607abbcf464Checking out files: 100% (18397/18397), done.
> > > Previous HEAD position was 4e284b1bf15a rcu: Remove wrapper definitions for obsolete RCU update functions
> > > HEAD is now at 4607abbcf464 tools/memory-model: Model smp_mb__after_unlock_lock()
> > > $ grep smp_mb__after_unlock_lock tools/memory-model/linux-kernel.def 
> > > smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > In addition, it handles this litmus test just fine:
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > C MP+polocks
> > > 
> > > (*
> > >  * Result: Never
> > >  *
> > >  * This litmus test demonstrates how lock acquisitions and releases can
> > >  * stand in for smp_load_acquire() and smp_store_release(), respectively.
> > >  * In other words, when holding a given lock (or indeed after releasing a
> > >  * given lock), a CPU is not only guaranteed to see the accesses that other
> > >  * CPUs made while previously holding that lock, it is also guaranteed
> > >  * to see all prior accesses by those other CPUs.
> > >  *)
> > > 
> > > {}
> > > 
> > > P0(int *x, int *y, spinlock_t *mylock)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	spin_lock(mylock);
> > > 	smp_mb__after_unlock_lock();
> > > 	WRITE_ONCE(*y, 1);
> > > 	spin_unlock(mylock);
> > > }
> > > 
> > > P1(int *x, int *y, spinlock_t *mylock)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 
> > > 	spin_lock(mylock);
> > > 	r0 = READ_ONCE(*y);
> > > 	spin_unlock(mylock);
> > > 	r1 = READ_ONCE(*x);
> > > }
> > > 
> > > exists (1:r0=1 /\ 1:r1=0)
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > Again, color me confused.
> > 
> > Andrea's point is that while the 1b52d0186177 commit is present in the
> > tip repository, it isn't in the locking/core branch.
> 
> That commit is still in tip/master, so it has not been lost or
> forgotten.  ;-)

Sounds reassuring!  ;-)

So, up to today, I've been using tip:locking/core as a reference for our
"almost/tentative-upstream" LKMM changes; well, your reply suggests that
I should have known better... thank you for the patience,

  Andrea


> 
> 							Thanx, Paul
> 
