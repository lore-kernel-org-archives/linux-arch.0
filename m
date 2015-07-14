From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 11:16:59 +0100
Message-ID: <20150714101659.GA16213@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <1436826689.3948.233.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33493 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbbGNKRG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 06:17:06 -0400
Content-Disposition: inline
In-Reply-To: <1436826689.3948.233.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <michaele@au1.ibm.com>

On Mon, Jul 13, 2015 at 11:31:29PM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2015-07-13 at 13:15 +0100, Will Deacon wrote:
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

Thanks, Ben.

> Michael, at some point you were experimenting a bit with that and tried
> to get some perf numbers of the impact that would have, did that
> solidify ? Otherwise, I'll have a look when I'm back next week.

These numbers would be really interesting...

Will
