From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Thu, 11 Jun 2015 12:13:28 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A526F@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
 <20150609124008.GA3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
 <20150610105840.GG3644@twins.programming.kicks-ass.net>
 <20150610130140.GD22973@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39478 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbFKMNe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jun 2015 08:13:34 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Wednesday 10 June 2015 06:31 PM, Will Deacon wrote:
> On Wed, Jun 10, 2015 at 11:58:40AM +0100, Peter Zijlstra wrote:
>> On Wed, Jun 10, 2015 at 09:34:18AM +0000, Vineet Gupta wrote:
>>> On Tuesday 09 June 2015 06:10 PM, Peter Zijlstra wrote:
>> I think the most interesting part is the device side.
>>
>>>>> +/*
>>>>> + * DSYNC:
>>>>> + *   - Waits for completion of all outstanding memory operations before any new
>>>>> + *     operations can begin
>>>>> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
>>>>> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
>>>>> + */
>>>>> +#define mb()		asm volatile("dsync\n" : : : "memory")
>>>> So mb() is supposed to order against things like DMA memory ops, is DMA
>>>> part of point 1 or 3, if 3, this is not a suitable instruction.
>>> Can u please explain the DMA case a bit more ? From what I understood and used in
>>> say ethernet driver, it is more of a line drawn between say cpu updating a shared
>>> buffer descriptor and kicking a MMIO register (which in turn could initiate a DMA)
>>> but I'm not sure how mb() can possibly order with DMA per se (unless there's some
>>> advanced form of IO-coherency)
>> I'm afraid I might not be the best of sources here, I tend to stay away
>> from actual device stuff like that. I've Cc'ed Will Deacon who might be
>> able to shed a bit more light on this aspect.
> I'd definitely expect mb() to order arbitrary memory accesses against each
> other (i.e. regardless of whether or not they're to RAM or MMIO devices).
> Some drivers use it to "flush the writebuffer" but I don't think that makes
> a whole lot of sense. Certainly, on ARM, if we want to know that something
> reached an MMIO endpoint then we'll need a read-back as well as the barrier
> for the general case.
>
> You also need that guarantee in your readl/writel family of macros. It's
> extremely heavy and rarely needed, which is why I added the _relaxed
> versions to all architectures.

Wow - adding that to these accessors will really be heavy - given that a whole
bunch of drivers still use the stock API (or perhaps don't know / care whether
they need the readl or the relaxed api. And it is practically impossible to switch
them over - after if ain't broken how can u fix it. So far we've been testing this
implementation (readl/writel - w/o any explicit barrier) on slower FPGA builds and
this includes a whole bunch of designware IP - mmc, eth, gpio.... and don't see
any ill effects - do you reckon we still need to add it.


> The "ordering against DMA" is something like reading an MMIO register to
> determine whether the DMA has completed, then going off to read the contents
> out of the DMA buffer. The comment you have about DSYNC makes it sound like
> it's not sufficient for this case.

IMHO this use case is slightly pedantic - since DMA completion will typically
follow up with an interrupt (I understand it's still possible to poll a dma status
reg). at any rate when it comes to dwaring a line between memory accesses -
regular or mmio, DSYNC is all we got in the ISA so ARCV2 mb() has to use it -
there's no better option.

-Vineet

> Will
>
