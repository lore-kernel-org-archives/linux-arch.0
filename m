From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 15 Jul 2015 13:06:18 +1000
Message-ID: <1436929578.10956.3.camel@ellerman.id.au>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436826689.3948.233.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <michaele@au1.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2015-07-14 at 08:31 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2015-07-13 at 13:15 +0100, Will Deacon wrote:
> > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > into a full memory barrier.
> > 
> > However:
> > 
> >   - This ordering guarantee is already provided without the barrier on
> >     all architectures apart from PowerPC
> > 
> >   - The barrier only applies to UNLOCK + LOCK, not general
> >     RELEASE + ACQUIRE operations
> > 
> >   - Locks are generally assumed to offer SC ordering semantics, so
> >     having this additional barrier is error-prone and complicates the
> >     callers of LOCK/UNLOCK primitives
> > 
> >   - The barrier is not well used outside of RCU and, because it was
> >     retrofitted into the kernel, it's not clear whether other areas of
> >     the kernel are incorrectly relying on UNLOCK + LOCK implying a full
> >     barrier
> > 
> > This patch removes the barrier and instead requires architectures to
> > provide full barrier semantics for an UNLOCK + LOCK sequence.
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > This didn't go anywhere last time I posted it, but here it is again.
> > I'd really appreciate some feedback from the PowerPC guys, especially as
> > to whether this change requires them to add an additional barrier in
> > arch_spin_unlock and what the cost of that would be.
> 
> We'd have to turn the lwsync in unlock or the isync in lock into a full
> barrier. As it is, we *almost* have a full barrier semantic, but not
> quite, as in things can get mixed up inside spin_lock between the LL and
> the SC (things leaking in past LL and things leaking "out" up before SC
> and then getting mixed up in there).
> 
> Michael, at some point you were experimenting a bit with that and tried
> to get some perf numbers of the impact that would have, did that
> solidify ? Otherwise, I'll have a look when I'm back next week.

I was mainly experimenting with replacing the lwsync in lock with an isync.

But I think you're talking about making it a full sync in lock.

That was about +7% on p8, +25% on p7 and +88% on p6.

We got stuck deciding whether isync was safe to use as a memory barrier,
because the wording in the arch is a bit vague.

But if we're talking about a full sync then I think there is no question that's
OK and we should just do it.

cheers
