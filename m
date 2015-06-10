From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Wed, 10 Jun 2015 12:58:40 +0200
Message-ID: <20150610105840.GG3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
 <20150609124008.GA3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43133 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbFJK6t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 06:58:49 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Will Deacon <will.deacon@arm.com>

On Wed, Jun 10, 2015 at 09:34:18AM +0000, Vineet Gupta wrote:
> On Tuesday 09 June 2015 06:10 PM, Peter Zijlstra wrote:
> > On Tue, Jun 09, 2015 at 05:18:20PM +0530, Vineet Gupta wrote:
> >
> > A description of how your hardware works; or a reference to the platform
> > documentation would not go amiss.
> 
> Honestly the docs group is working on a publicly sharable version of PRM
> (Programmer's Reference Manual) but it might take some more time. 

Good news that. I appreciate these things can take some time.

> I'm sure kernel
> developers including you don't like to sign an NDA.... 

It might also be a question on your company vs my company. But yes, I
generally prefer not to do NDAs.

> The information I have in
> comments is pretty much what we have in there w.r.t. the barrier instructions. But
> I will capture the the weak memory ordering and other details as part of changelog
> here too.

Right, so I think we all understand weak (ARM, PPC etc..) and we all
understand load/load, store/store and load-store/load-store barriers.

Although explicitly mentioning it never hurt anybody ;-)

I think the most interesting part is the device side.

> >> +/*
> >> + * DSYNC:
> >> + *   - Waits for completion of all outstanding memory operations before any new
> >> + *     operations can begin
> >> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
> >> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
> >> + */
> >> +#define mb()		asm volatile("dsync\n" : : : "memory")
> > So mb() is supposed to order against things like DMA memory ops, is DMA
> > part of point 1 or 3, if 3, this is not a suitable instruction.
> 
> Can u please explain the DMA case a bit more ? From what I understood and used in
> say ethernet driver, it is more of a line drawn between say cpu updating a shared
> buffer descriptor and kicking a MMIO register (which in turn could initiate a DMA)
> but I'm not sure how mb() can possibly order with DMA per se (unless there's some
> advanced form of IO-coherency)

I'm afraid I might not be the best of sources here, I tend to stay away
from actual device stuff like that. I've Cc'ed Will Deacon who might be
able to shed a bit more light on this aspect.
