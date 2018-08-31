From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Fri, 31 Aug 2018 19:55:12 +0200
Message-ID: <20180831175512.GA3121@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 31, 2018 at 10:52:54AM -0400, Alan Stern wrote:
> On Fri, 31 Aug 2018, Andrea Parri wrote:
> 
> > On Thu, Aug 30, 2018 at 05:31:32PM -0400, Alan Stern wrote:
> > > On Thu, 30 Aug 2018, Andrea Parri wrote:
> > > 
> > > > > All the architectures supported by the Linux kernel (including RISC-V)
> > > > > do provide this ordering for locks, albeit for varying reasons.
> > > > > Therefore this patch changes the model in accordance with the
> > > > > developers' wishes.
> > > > > 
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > Reviewed-by: Will Deacon <will.deacon@arm.com>
> > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > 
> > > > Round 2 ;-), I guess...  Let me start from the uncontroversial points:
> > > > 
> > > >   1) being able to use the LKMM to reason about generic locking code
> > > >      is useful and desirable (paraphrasing Peter in [1]);
> > > > 
> > > >   2) strengthening the ordering requirements of such code isn't going
> > > >      to boost performance (that's "real maths").
> > > > 
> > > > This patch is taking (1) away from us and it is formalizing (2), with
> > > > almost _no_ reason (no reason at all, if we stick to the commit msg.).
> > > 
> > > That's not quite fair.  Generic code isn't always universally
> > > applicable; some of it is opt-in -- meant only for the architectures
> > > that can support it.  In general, the LKMM allows us to reason about
> > > higher abstractions (such as locking) at a higher level, without
> > > necessarily being able to verify the architecture-specific details of
> > > the implementations.
> > 
> > No, generic code is "universally applicable" by definition; see below
> > for more on this point.
> 
> Then perhaps we should be talking about "partially generic" code; i.e., 
> code that applies to many but not all architectures.

Perhaps.  I call this  "non-generic". ;-)


> 
> > > > In [2], Will wrote:
> > > > 
> > > >   "[...] having them [the RMWs] closer to RCsc[/to the semantics of
> > > >    locks] would make it easier to implement and reason about generic
> > > >    locking implementations (i.e. reduce the number of special ordering
> > > >    cases and/or magic barrier macros)"
> > > > 
> > > > "magic barrier macros" as in "mmh, if we accept this patch, we _should_
> > > > be auditing the various implementations/code to decide where to place a
> > > > 
> > > >   smp_barrier_promote_ordinary_release_acquire_to_unlock_lock()" ;-)
> > > > 
> > > > or the like, and "special ordering cases" as in "arrgh, (otherwise) we
> > > > are forced to reason on a per-arch basis while looking at generic code".
> > > 
> > > Currently the LKMM does not permit architecture-specific reasoning.  It 
> > > would have to be extended (in a different way for each architecture) 
> > > first.
> > 
> > Completely agreed; that's why I said that this patch is detrimental to
> > the applicability of the LKMM...
> 
> This ignores the attitude of the kernel developers who want locking to 
> have the stronger RCtso semantics.  From their point of view, the patch 
> enhances the LKMM's applicability.

Please stop.  We spent weeks discussing how to make such a transition
properly, and I suggested ways to do this above and in other threads.
(Again, your commit message says nothing about that "enhancement"...)


> 
> > > For example, one could use herd's POWER model combined with the POWER 
> > > compilation scheme and the POWER-specific implementation of spinlocks 
> > > for such reasoning.  The LKMM alone is not sufficient.
> > > 
> > > Sure, programming and reasoning about the kernel would be easier if all
> > > architectures were the same.  Unfortunately, we (and the kernel) have
> > > to live in the real world.
> > > 
> > > > (Remark: ordinary release/acquire are building blocks for code such as
> > > >  qspinlock, (q)rwlock, mutex, rwsem, ... and what else??).
> > > 
> > > But are these building blocks used the same way for all architectures?
> > 
> > The more, the better! (because then we have the LKMM tools) 
> > 
> > We already discussed the "fast path" example: the fast paths of the
> > above all resemble:
> > 
> >   *_lock(s):  atomic_cmpxchg_acquire(&s->val, UNLOCKED_VAL, LOCKED_VAL) ...
> >   *_unlock(s): ...  atomic_set_release(&s->val, UNLOCKED_VAL)
> > 
> > When I read this code, I think "Of course." (unless some arch. has
> > messed the implementation of cmpxchg_* up, which can happen...); but
> > then I read the subject line of this patch and I think "Wait, what?".
> > 
> > You can argue that this is not generic code, sure; but why on Earth
> > would you like to do so?!
> 
> Because the code might not work!  On RISC-V, for example, the
> implementation of ordinary release/acquire is currently not as strong
> as atomic release/acquire.

No doubt it "might not work". ;-)  Concerning the RISC-V implementation,
I almost (re)did that, so at least you know who to blame if what you are
saying turned out to be correct.


> 
> Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> should be correct on all existing architectures.  And Paul has invited 
> a patch to modify the LKMM accordingly.  If you feel that such a change 
> would be a useful enhancement to the LKMM's applicability, please write 
> it.

Hey, it's your patch that is introducing concerns!  "my patch" would
partially _but_ substantially revert yours (see earlier discussions):
I'm still hoping that we'll be able to find an agreement...

  Andrea


> 
> Alan
> 
