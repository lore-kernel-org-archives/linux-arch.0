From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Wed, 15 Jul 2015 11:44:20 +0100
Message-ID: <20150715104420.GD1005@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38314 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbbGOKoY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jul 2015 06:44:24 -0400
Content-Disposition: inline
In-Reply-To: <1436929578.10956.3.camel@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <michaele@au1.ibm.com>

Hi Michael,

On Wed, Jul 15, 2015 at 04:06:18AM +0100, Michael Ellerman wrote:
> On Tue, 2015-07-14 at 08:31 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2015-07-13 at 13:15 +0100, Will Deacon wrote:
> > > This didn't go anywhere last time I posted it, but here it is again.
> > > I'd really appreciate some feedback from the PowerPC guys, especially as
> > > to whether this change requires them to add an additional barrier in
> > > arch_spin_unlock and what the cost of that would be.
> > 
> > We'd have to turn the lwsync in unlock or the isync in lock into a full
> > barrier. As it is, we *almost* have a full barrier semantic, but not
> > quite, as in things can get mixed up inside spin_lock between the LL and
> > the SC (things leaking in past LL and things leaking "out" up before SC
> > and then getting mixed up in there).
> > 
> > Michael, at some point you were experimenting a bit with that and tried
> > to get some perf numbers of the impact that would have, did that
> > solidify ? Otherwise, I'll have a look when I'm back next week.
> 
> I was mainly experimenting with replacing the lwsync in lock with an isync.
> 
> But I think you're talking about making it a full sync in lock.
> 
> That was about +7% on p8, +25% on p7 and +88% on p6.

Ok, so that's overhead incurred by moving from isync -> lwsync? The numbers
look quite large...

> We got stuck deciding whether isync was safe to use as a memory barrier,
> because the wording in the arch is a bit vague.
> 
> But if we're talking about a full sync then I think there is no question that's
> OK and we should just do it.

Is this because there's a small overhead from lwsync -> sync? Just want to
make sure I follow your reasoning.

If you went the way of sync in unlock, could you remove the conditional
SYNC_IO stuff?

Will
