From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Wed, 10 Jun 2015 14:01:40 +0100
Message-ID: <20150610130140.GD22973@arm.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
 <20150609124008.GA3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
 <20150610105840.GG3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53771 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933244AbbFJNBn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Jun 2015 09:01:43 -0400
Content-Disposition: inline
In-Reply-To: <20150610105840.GG3644@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Wed, Jun 10, 2015 at 11:58:40AM +0100, Peter Zijlstra wrote:
> On Wed, Jun 10, 2015 at 09:34:18AM +0000, Vineet Gupta wrote:
> > On Tuesday 09 June 2015 06:10 PM, Peter Zijlstra wrote:
> I think the most interesting part is the device side.
> 
> > >> +/*
> > >> + * DSYNC:
> > >> + *   - Waits for completion of all outstanding memory operations before any new
> > >> + *     operations can begin
> > >> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
> > >> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
> > >> + */
> > >> +#define mb()		asm volatile("dsync\n" : : : "memory")
> > > So mb() is supposed to order against things like DMA memory ops, is DMA
> > > part of point 1 or 3, if 3, this is not a suitable instruction.
> > 
> > Can u please explain the DMA case a bit more ? From what I understood and used in
> > say ethernet driver, it is more of a line drawn between say cpu updating a shared
> > buffer descriptor and kicking a MMIO register (which in turn could initiate a DMA)
> > but I'm not sure how mb() can possibly order with DMA per se (unless there's some
> > advanced form of IO-coherency)
> 
> I'm afraid I might not be the best of sources here, I tend to stay away
> from actual device stuff like that. I've Cc'ed Will Deacon who might be
> able to shed a bit more light on this aspect.

I'd definitely expect mb() to order arbitrary memory accesses against each
other (i.e. regardless of whether or not they're to RAM or MMIO devices).
Some drivers use it to "flush the writebuffer" but I don't think that makes
a whole lot of sense. Certainly, on ARM, if we want to know that something
reached an MMIO endpoint then we'll need a read-back as well as the barrier
for the general case.

You also need that guarantee in your readl/writel family of macros. It's
extremely heavy and rarely needed, which is why I added the _relaxed
versions to all architectures.

The "ordering against DMA" is something like reading an MMIO register to
determine whether the DMA has completed, then going off to read the contents
out of the DMA buffer. The comment you have about DSYNC makes it sound like
it's not sufficient for this case.

Will
