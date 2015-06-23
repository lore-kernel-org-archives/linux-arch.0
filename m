From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 13:32:17 +0530
Message-ID: <55891289.5070909@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com> <1433850508-26317-21-git-send-email-vgupta@synopsys.com> <20150609124008.GA3644@twins.programming.kicks-ass.net> <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com> <20150610105840.GG3644@twins.programming.kicks-ass.net> <20150610130140.GD22973@arm.com> <C2D7FE5348E1B147BCA15975FBA23075665A526F@IN01WEMBXB.internal.synopsys.com> <20150611133952.GA29425@arm.com> <5584155E.9060601@synopsys.com> <20150622133656.GG1583@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:39980 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932615AbbFWICf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2015 04:02:35 -0400
In-Reply-To: <20150622133656.GG1583@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Monday 22 June 2015 07:06 PM, Will Deacon wrote:
>> OK, so given that regular/mmio is also weakly ordered, it would seem that we need
>> > full mb() *before* and *after* the IO access in the non relaxed API. ARM code
>> > seems to put a rmb() after the readl and wmb() before the writel. Is that based on
>> > how h/w provides for some ?
> We figured that you'd likely be doing something like:
> 
> <writel_relaxed DMA buffer>
> <writel MMIO "go" reg>
> 
> or:
> 
> <readl MMIO "status" reg>
> <readl_relaxed DMA buffer>
> 
> so ended up with writel doing {wmb(); writel_relaxed} and readl doing
> {readl_relaxed; rmb()}.
> 
>> > In one of the links you posted above, Catalin posed the same question, but I
>> > didn't see response to that.
>> > 
>> > | If we are to make the writel/readl on ARM fully ordered with both IO
>> > | (enforced by hardware) and uncached memory, do we add barriers on each
>> > | side of the writel/readl etc.? The common cases would require a barrier
>> > | before writel (write buffer flushing) and a barrier after readl (in case
>> > | of polling for a "DMA complete" state).
>> > |
>> > | So if io_wmb() just orders to IO writes (writel_relaxed), does it mean
>> > | that we still need a mighty wmb() that orders any type of accesses (i.e.
>> > | uncached memory vs IO)? Can drivers not use the strict writel() and no
>> > | longer rely on wmb() (wondering whether we could simplify it on ARM with
>> > | fully ordered IO accessors)?
>> > 
>> > Further readl/writel would be no different than ioread32/iowrite32 ?
> ioread32/iowrite32 can be used with port addresses and dispatch to the
> relevant accessors depending on that. The memory ordering semantics should
> be the same as readl/writel.
> 
>> > FWIW, h/w folks tell me that DMB guarentess local barrier semantics so we don't
>> > need to use DSYNC. Latter only provides full r+w+TLB/BPU stuff while DMB allows
>> > finer grained r/w/r+w. But if we need full mb then using one vs. other becomes a
>> > moot point.
> I'd say go with what we do on ARM/arm64, then at least we have consistency
> in the use of barriers.

Thx for very helpful review/feedback Will. I've posted a v2 !

-Vineet
