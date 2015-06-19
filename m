From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Fri, 19 Jun 2015 18:43:02 +0530
Message-ID: <5584155E.9060601@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com> <1433850508-26317-21-git-send-email-vgupta@synopsys.com> <20150609124008.GA3644@twins.programming.kicks-ass.net> <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com> <20150610105840.GG3644@twins.programming.kicks-ass.net> <20150610130140.GD22973@arm.com> <C2D7FE5348E1B147BCA15975FBA23075665A526F@IN01WEMBXB.internal.synopsys.com> <20150611133952.GA29425@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:42105 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752405AbbFSNOk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jun 2015 09:14:40 -0400
In-Reply-To: <20150611133952.GA29425@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Thursday 11 June 2015 07:09 PM, Will Deacon wrote:
> On Thu, Jun 11, 2015 at 01:13:28PM +0100, Vineet Gupta wrote:
>> On Wednesday 10 June 2015 06:31 PM, Will Deacon wrote:
>>> On Wed, Jun 10, 2015 at 11:58:40AM +0100, Peter Zijlstra wrote:
>>>> On Wed, Jun 10, 2015 at 09:34:18AM +0000, Vineet Gupta wrote:
>>>>> On Tuesday 09 June 2015 06:10 PM, Peter Zijlstra wrote:
>>>> I think the most interesting part is the device side.
>>>>
>>>>>>> +/*
>>>>>>> + * DSYNC:
>>>>>>> + *   - Waits for completion of all outstanding memory operations before any new
>>>>>>> + *     operations can begin
>>>>>>> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
>>>>>>> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
>>>>>>> + */
>>>>>>> +#define mb()		asm volatile("dsync\n" : : : "memory")
>>>>>> So mb() is supposed to order against things like DMA memory ops, is DMA
>>>>>> part of point 1 or 3, if 3, this is not a suitable instruction.
>>>>> Can u please explain the DMA case a bit more ? From what I understood and used in
>>>>> say ethernet driver, it is more of a line drawn between say cpu updating a shared
>>>>> buffer descriptor and kicking a MMIO register (which in turn could initiate a DMA)
>>>>> but I'm not sure how mb() can possibly order with DMA per se (unless there's some
>>>>> advanced form of IO-coherency)
>>>> I'm afraid I might not be the best of sources here, I tend to stay away
>>>> from actual device stuff like that. I've Cc'ed Will Deacon who might be
>>>> able to shed a bit more light on this aspect.
>>> I'd definitely expect mb() to order arbitrary memory accesses against each
>>> other (i.e. regardless of whether or not they're to RAM or MMIO devices).
>>> Some drivers use it to "flush the writebuffer" but I don't think that makes
>>> a whole lot of sense. Certainly, on ARM, if we want to know that something
>>> reached an MMIO endpoint then we'll need a read-back as well as the barrier
>>> for the general case.
>>>
>>> You also need that guarantee in your readl/writel family of macros. It's
>>> extremely heavy and rarely needed, which is why I added the _relaxed
>>> versions to all architectures.
>>
>> Wow - adding that to these accessors will really be heavy - given that a whole
>> bunch of drivers still use the stock API (or perhaps don't know / care whether
>> they need the readl or the relaxed api. And it is practically impossible to switch
>> them over - after if ain't broken how can u fix it. So far we've been testing this
>> implementation (readl/writel - w/o any explicit barrier) on slower FPGA builds and
>> this includes a whole bunch of designware IP - mmc, eth, gpio.... and don't see
>> any ill effects - do you reckon we still need to add it.
> 
> Unfortunately, yes, as that's effectively what the kernel requires:
> 
>   http://marc.info/?l=linux-kernel&m=121192394430581&w=2
>   http://thread.gmane.org/gmane.linux.ide/46414

Oh great - thx for those !


> The conclusion is that x86 *does* provide this ordering in its accessors
> and drivers are written to assume that, so either you go round fixing all
> the drivers by adding the missing barriers or you implement it in your
> accessors (like we have done on ARM). Subtle I/O ordering issues are no
> fun to debug.
> 
> That's also the reason I added the _relaxed versions, so you can port
> drivers one-by-one to the weaker semantics whilst having the potentially
> broken drivers continue to work.
> 

OK, so given that regular/mmio is also weakly ordered, it would seem that we need
full mb() *before* and *after* the IO access in the non relaxed API. ARM code
seems to put a rmb() after the readl and wmb() before the writel. Is that based on
how h/w provides for some ?

In one of the links you posted above, Catalin posed the same question, but I
didn't see response to that.

| If we are to make the writel/readl on ARM fully ordered with both IO
| (enforced by hardware) and uncached memory, do we add barriers on each
| side of the writel/readl etc.? The common cases would require a barrier
| before writel (write buffer flushing) and a barrier after readl (in case
| of polling for a "DMA complete" state).
|
| So if io_wmb() just orders to IO writes (writel_relaxed), does it mean
| that we still need a mighty wmb() that orders any type of accesses (i.e.
| uncached memory vs IO)? Can drivers not use the strict writel() and no
| longer rely on wmb() (wondering whether we could simplify it on ARM with
| fully ordered IO accessors)?

Further readl/writel would be no different than ioread32/iowrite32 ?

FWIW, h/w folks tell me that DMB guarentess local barrier semantics so we don't
need to use DSYNC. Latter only provides full r+w+TLB/BPU stuff while DMB allows
finer grained r/w/r+w. But if we need full mb then using one vs. other becomes a
moot point.

-Vineet


>>> The "ordering against DMA" is something like reading an MMIO register to
>>> determine whether the DMA has completed, then going off to read the contents
>>> out of the DMA buffer. The comment you have about DSYNC makes it sound like
>>> it's not sufficient for this case.
>>
>> IMHO this use case is slightly pedantic - since DMA completion will typically
>> follow up with an interrupt (I understand it's still possible to poll a dma status
>> reg). at any rate when it comes to dwaring a line between memory accesses -
>> regular or mmio, DSYNC is all we got in the ISA so ARCV2 mb() has to use it -
>> there's no better option.
> 
> Does taking an interrupt ensure visibility of the data on your
> architecture? Most non-pci device architectures allow that to race, so
> you end up relying on the readX in the irq handler to order the buffer
> access.
> 
> If you don't have an instruction for this, then I don't understand how
> you can perform DMA to/from regions of memory that are mapped as weakly
> ordered by the CPU (e.g. how would you write a data buffer then tell the
> device to go read from it?).
> 
> Will
> 
