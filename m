Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:19850 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751259AbbJGTRH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Oct 2015 15:17:07 -0400
Subject: Re: [PATCH 4/4] dma-debug: Allow poisoning nonzero allocations
References: <cover.1443178314.git.robin.murphy@arm.com>
 <0405c6131def5aa179ff4ba5d4201ebde89cede3.1443178314.git.robin.murphy@arm.com>
 <20150925124447.GO21513@n2100.arm.linux.org.uk> <560585EB.3060908@arm.com>
 <20150929142727.e95a2d2ebff65dda86315248@linux-foundation.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56156FAF.9020002@arm.com>
Date: Wed, 7 Oct 2015 20:17:03 +0100
MIME-Version: 1.0
In-Reply-To: <20150929142727.e95a2d2ebff65dda86315248@linux-foundation.org>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "sakari.ailus@iki.fi" <sakari.ailus@iki.fi>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Message-ID: <20151007191703.n77_IL135sHb6_d5XC_qE7lpjwr-j6BQl6hK0QfhSh0@z>

On 29/09/15 22:27, Andrew Morton wrote:
[...]
> If I'm understanding things correctly, some allocators zero the memory
> by default and others do not.  And we have an unknown number of drivers
> which are assuming that the memory is zeroed.
>
> Correct?

That's precisely the motivation here, yes.

> If so, our options are
>
> a) audit all callers, find the ones which expect zeroed memory but
>     aren't passing __GFP_ZERO and fix them.
>
> b) convert all allocators to zero the memory by default.
>
> Obviously, a) is better.  How big a job is it?

This I'm not so sure of, hence the very tentative first step. For a very 
crude guess at an an upper bound:

$ git grep -E '(dma|pci)_alloc_co(her|nsist)ent' drivers/ | wc -l
1148

vs.

$ git grep -E '(dma|pci)_zalloc_co(her|nsist)ent' drivers/ | wc -l
234

noting that the vast majority of the former are still probably benign, 
but picking out those which aren't from the code alone without knowledge 
of and/or access to the hardware might be non-trivial.

> This patch will help the process, if people use it.
>
>>>> +	if (IS_ENABLED(CONFIG_DMA_API_DEBUG_POISON) && !(flags & __GFP_ZERO))
>>>> +		memset(virt, DMA_ALLOC_POISON, size);
>>>> +
>>>
>>> This is likely to be slow in the case of non-cached memory and large
>>> allocations.  The config option should come with a warning.
>>
>> It depends on DMA_API_DEBUG, which already has a stern performance
>> warning, is additionally hidden behind EXPERT, and carries a slightly
>> flippant yet largely truthful warning that actually using it could break
>> pretty much every driver in your system; is that not enough?
>
> It might be helpful to provide a runtime knob as well - having to
> rebuild&reinstall just to enable/disable this feature is a bit painful.

Good point - there's always the global DMA debug disable knob, but this 
particular feature probably does warrant finer-grained control to be 
really practical. Having thought about it some more, it's also probably 
wrong that this doesn't respect the dma_debug_driver filter, given that 
it is actually invasive; in fixing that, how about if it also *only* 
applied when a specific driver is filtered? Then there would be no 
problematic "break anything and everything" mode, and the existing 
debugfs controls should suffice.

Robin.

