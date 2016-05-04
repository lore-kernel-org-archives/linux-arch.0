Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:36229 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcEDOB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 10:01:59 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: kmap_atomic and preemption
Date: Wed, 4 May 2016 14:01:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4EA0647@us01wembx1.internal.synopsys.com>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
 <20160504155345.5fdd366e@free-electrons.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160504140152.Uo1hPtvYlxpY-8aDuMtvKt2Dn5D4Gb0oudFUlpfuPQc@z>

On Wednesday 04 May 2016 07:23 PM, Thomas Petazzoni wrote:
> Hello,
>
> On Wed, 4 May 2016 15:47:29 +0200, Peter Zijlstra wrote:
>
>> static inline void *kmap_atomic(struct page *page)
>> {
>> 	preempt_disable();
>> 	pagefault_disable();
>> 	if (!PageHighMem(page))
>> 		return page_address(page);
>>
>> 	return __kmap_atomic(page);
>> }
> This is essentially what has been done on ARM in commit
> 9ff0bb5ba60638a688a46e93df8c5009896672eb, showing a pretty significant
> improvement in network workloads.

ARC already has that semantically - only not inline ! I really want to avoid 2
needless LD-ADD-ST for the disabling of preemption and page fault for the low mem
pages by returning early !

static inline void *kmap_atomic(struct page *page)
{
        if (!PageHighMem(page))
		return page_address(page);

	preempt_disable();
	pagefault_disable();
	
	return __kmap_atomic(page);

}

>
> Best regards,
>
> Thomas

