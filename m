Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeHaUOj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Aug 2018 16:14:39 -0400
Date: Fri, 31 Aug 2018 17:06:40 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180831160640.GG30626@arm.com>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180831160640.ZZpqQDWI5SrUUNjzNBygGCgi8sbdLxr5nTE4dVnRQ_o@z>

On Fri, Aug 31, 2018 at 10:52:54AM -0400, Alan Stern wrote:
> On Fri, 31 Aug 2018, Andrea Parri wrote:
> > On Thu, Aug 30, 2018 at 05:31:32PM -0400, Alan Stern wrote:
> > > On Thu, 30 Aug 2018, Andrea Parri wrote:
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
> 
> Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> should be correct on all existing architectures.  And Paul has invited 
> a patch to modify the LKMM accordingly.  If you feel that such a change 
> would be a useful enhancement to the LKMM's applicability, please write 
> it.

Yes, please! That would be the "RmW" discussion which Andrea partially
quoted earlier on, so getting that going independently from this patch
sounds like a great idea to me.

Cheers,

Will
