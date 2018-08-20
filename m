Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:37144 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBwK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2018 21:52:10 -0400
Subject: Re: [PATCH v2 2/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <20180730162636.3556-3-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08C83D@us01wembx1.internal.synopsys.com>
 <1534180089.3962.68.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <81ddd506-1f7e-db82-4c77-ff08b1c15dd3@synopsys.com>
Date: Mon, 20 Aug 2018 15:34:31 -0700
MIME-Version: 1.0
In-Reply-To: <1534180089.3962.68.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Message-ID: <20180820223431.3unHYclPDF79Y49mL8_x_50VjNgC2KVYu_QLWj7WJDY@z>

On 08/13/2018 10:08 AM, Eugeniy Paltsev wrote:
> On Mon, 2018-08-13 at 16:24 +0000, Vineet Gupta wrote:
>> On 07/30/2018 09:26 AM, Eugeniy Paltsev wrote:
>>> @@ -1263,11 +1254,7 @@ void __init arc_cache_init_master(void)
>>>  	if (is_isa_arcv2() && ioc_enable)
>>>  		arc_ioc_setup();
>>>  
>>> -	if (is_isa_arcv2() && ioc_enable) {
>>> -		__dma_cache_wback_inv = __dma_cache_wback_inv_ioc;
>>> -		__dma_cache_inv = __dma_cache_inv_ioc;
>>> -		__dma_cache_wback = __dma_cache_wback_ioc;
>>> -	} else if (is_isa_arcv2() && l2_line_sz && slc_enable) {

For the casual reader I'd add a comment why this was deleted.

>>> +	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
>>>  		__dma_cache_wback_inv = __dma_cache_wback_inv_slc;
>>>  		__dma_cache_inv = __dma_cache_inv_slc;
>>>  		__dma_cache_wback = __dma_cache_wback_slc;

[snip]

>>>  
>>> -	/*
>>> -	 * IOC relies on all data (even coherent DMA data) being in cache
>>> -	 * Thus allocate normal cached memory
>>> -	 *
>>> -	 * The gains with IOC are two pronged:
>>> -	 *   -For streaming data, elides need for cache maintenance, saving
>>> -	 *    cycles in flush code, and bus bandwidth as all the lines of a
>>> -	 *    buffer need to be flushed out to memory
>>> -	 *   -For coherent data, Read/Write to buffers terminate early in cache
>>> -	 *   (vs. always going to memory - thus are faster)
>>> -	 */
>>> -	if ((is_isa_arcv2() && ioc_enable) ||
>>> -	    (attrs & DMA_ATTR_NON_CONSISTENT))
>>> +	if (attrs & DMA_ATTR_NON_CONSISTENT)
>>>  		need_coh = 0;
>>>  

[snip]

> Yep, I tested that.
> And it works fine with both @ioc_enable == 0 and @ioc_enable == 1
> Note that we check this variable in arch_setup_dma_ops() function now.
> 
> So this arch_dma_{alloc,free} are used ONLY in case of software assisted cache maintenance.
> That's why we had to do MMU mapping to enforce non-cachability regardless of @ioc_enable.

Reading kernel/dma/* I see what you mean. We check @ioc_enable at the time of
registering the dma op for coherent vs. non coherent case, so there's common vs.
ARC versions of alloc/free for coherent vs. noncoherent. But then I'm curious why
do we bother to check the following in new arch_dma_(alloc|free) at all.

	if (attrs & DMA_ATTR_NON_CONSISTENT)

Isn't it supposed to be NON_CONSISTENT always given the way new code works ?
