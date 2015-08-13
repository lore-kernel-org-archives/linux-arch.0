From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Thu, 13 Aug 2015 11:49:28 +0100
Message-ID: <20150813104928.GC10280@arm.com>
References: <20150714141202.GN16213@arm.com>
 <20150714193144.GP3717@linux.vnet.ibm.com>
 <20150715013820.GA21971@linux.vnet.ibm.com>
 <20150715105135.GE1005@arm.com>
 <20150715131221.GY3717@linux.vnet.ibm.com>
 <20150724113101.GE30410@arm.com>
 <20150724153046.GJ3717@linux.vnet.ibm.com>
 <20150812134415.GC23540@arm.com>
 <20150812154346.GR3895@linux.vnet.ibm.com>
 <20150812175938.GA27985@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150812175938.GA27985@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 12, 2015 at 06:59:38PM +0100, Paul E. McKenney wrote:
> On Wed, Aug 12, 2015 at 08:43:46AM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 12, 2015 at 02:44:15PM +0100, Will Deacon wrote:
> > > The generic relaxed atomics are now queued in -tip, so it would be really
> > > good to see this Documentation update land in 4.3 if at all possible. I
> > > appreciate it's late in the cycle, but it's always worth asking.
> > 
> > Can't hurt to give it a try.  I have set -rcu's rcu/next branch to this
> > commit, and if it passes a few day's worth of testing, I will see what
> > Ingo has to say about a pull request.
> > 
> > This commit also privatizes smp_mb__after_unlock_lock() as well as
> > updating documentation.  Looks like we need to strengthen powerpc's
> > locking primitives, then get rid of smp_mb__after_unlock_lock() entirely.
> > Or did that already happen and I just missed it?
> 
> And just for completeness, here is the current version of that commit.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/Documentation/memory-barriers.txt   |   71 +---------------------------------
>  b/arch/powerpc/include/asm/spinlock.h |    2 
>  b/include/linux/spinlock.h            |   10 ----
>  b/kernel/rcu/tree.h                   |   12 +++++
>  4 files changed, 16 insertions(+), 79 deletions(-)
> 
> commit 12d560f4ea87030667438a169912380be00cea4b
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Jul 14 18:35:23 2015 -0700
> 
>     rcu,locking: Privatize smp_mb__after_unlock_lock()
>     
>     RCU is the only thing that uses smp_mb__after_unlock_lock(), and is
>     likely the only thing that ever will use it, so this commit makes this
>     macro private to RCU.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>     Cc: Will Deacon <will.deacon@arm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Acked-by: Will Deacon <will.deacon@arm.com>

I don't think the PowerPC spinlock change is queued anywhere (I sent it
out as a diff for discussion, but that was it). This patch doesn't rely
on that though, right?

Will
