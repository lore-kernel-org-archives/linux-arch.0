From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Thu, 16 Jul 2015 12:00:28 +1000
Message-ID: <1437012028.28475.2.camel@ellerman.id.au>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
	 <1436929578.10956.3.camel@ellerman.id.au> <20150715104420.GD1005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150715104420.GD1005@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2015-07-15 at 11:44 +0100, Will Deacon wrote:
> Hi Michael,
> 
> On Wed, Jul 15, 2015 at 04:06:18AM +0100, Michael Ellerman wrote:
> > On Tue, 2015-07-14 at 08:31 +1000, Benjamin Herrenschmidt wrote:
> > > On Mon, 2015-07-13 at 13:15 +0100, Will Deacon wrote:
> > > > This didn't go anywhere last time I posted it, but here it is again.
> > > > I'd really appreciate some feedback from the PowerPC guys, especially as
> > > > to whether this change requires them to add an additional barrier in
> > > > arch_spin_unlock and what the cost of that would be.
> > > 
> > > We'd have to turn the lwsync in unlock or the isync in lock into a full
> > > barrier. As it is, we *almost* have a full barrier semantic, but not
> > > quite, as in things can get mixed up inside spin_lock between the LL and
> > > the SC (things leaking in past LL and things leaking "out" up before SC
> > > and then getting mixed up in there).
> > > 
> > > Michael, at some point you were experimenting a bit with that and tried
> > > to get some perf numbers of the impact that would have, did that
> > > solidify ? Otherwise, I'll have a look when I'm back next week.
> > 
> > I was mainly experimenting with replacing the lwsync in lock with an isync.
> > 
> > But I think you're talking about making it a full sync in lock.
> > 
> > That was about +7% on p8, +25% on p7 and +88% on p6.
> 
> Ok, so that's overhead incurred by moving from isync -> lwsync? The numbers
> look quite large...

Sorry no.

Currently we use lwsync in lock. You'll see isync in the code
(PPC_ACQUIRE_BARRIER), but on most modern CPUs that is patched at runtime to
lwsync.

I benchmarked lwsync (current), isync (proposed at the time) and sync (just for
comparison).

The numbers above are going from lwsync -> sync, as I thought that was what Ben
was talking about.

Going from lwsync to isync was actually a small speedup on power8, which was
surprising.

> > We got stuck deciding whether isync was safe to use as a memory barrier,
> > because the wording in the arch is a bit vague.
> > 
> > But if we're talking about a full sync then I think there is no question that's
> > OK and we should just do it.
> 
> Is this because there's a small overhead from lwsync -> sync? Just want to
> make sure I follow your reasoning.

No I mean that sync is clearly a memory barrier. The issue with switching to
isync in lock was that it's not a memory barrier per se, so we were not 100%
confident in it.

> If you went the way of sync in unlock, could you remove the conditional
> SYNC_IO stuff?

Yeah we could, it's just a conditional sync in unlock when mmio has been done.

That would fix the problem with smp_mb__after_unlock_lock(), but not the
original worry we had about loads happening before the SC in lock.

cheers
