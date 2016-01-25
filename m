From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] mm/debug_pagealloc: Ask users for default setting of
 debug_pagealloc
Date: Mon, 25 Jan 2016 12:10:15 +0100
Message-ID: <56A60297.4050501@de.ibm.com>
References: <1453713588-119602-1-git-send-email-borntraeger@de.ibm.com>
 <20160125094132.GA4298@osiris> <56A5EECE.90607@de.ibm.com>
 <20160125100248.GB4298@osiris> <56A5F3C8.4050202@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp08.uk.ibm.com ([195.75.94.104]:53288 "EHLO
	e06smtp08.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbcAYLKW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2016 06:10:22 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Jan 2016 11:10:20 -0000
In-Reply-To: <56A5F3C8.4050202@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 01/25/2016 11:07 AM, Christian Borntraeger wrote:
> On 01/25/2016 11:02 AM, Heiko Carstens wrote:
>> On Mon, Jan 25, 2016 at 10:45:50AM +0100, Christian Borntraeger wrote:
>>>>> +	  By default this option will be almost for free and can be activated
>>>>> +	  in distribution kernels. The overhead and the debugging can be enabled
>>>>> +	  by DEBUG_PAGEALLOC_ENABLE_DEFAULT or the debug_pagealloc command line
>>>>> +	  parameter.
>>>>
>>>> Sorry, but it's not almost for free and should not be used by distribution
>>>> kernels. If we have DEBUG_PAGEALLOC enabled, at least on s390 we will not
>>>> make use of 2GB and 1MB pagetable entries for the identy mapping anymore.
>>>> Instead we will only use 4K mappings.
>>>
>>> Hmmm, can we change these code areas to use debug_pagealloc_enabled? I guess
>>> this evaluated too late?
>>
>> Yes, that should be possible. "debug_pagealloc" is an early_param, which
>> will be evaluated before we call paging_init() (both in
>> arch/s390/kernel/setup.c).
>>
>> So it looks like this can be trivially changed. (replace the ifdefs in
>> arch/s390/mm/vmem.c with debug_pagealloc_enabled()).
>>
>>>> I assume this is true for all architectures since freeing pages can happen
>>>> in any context and therefore we can't allocate memory in order to split
>>>> page tables.
>>>>
>>>> So enabling this will cost memory and put more pressure on the TLB.
>>>
>>> So I will change the description and drop the "if unsure" statement.
>>
>> Well, given that we can change it like above... I don't care anymore ;)
> 
> Ok, I will give it a try, and come back with a rewording or an s390 patch.

I have a patch for x86 and s390. powerpc should also be possible.

Now it seems that sparc already defines the TSB very early in head.S. 
Unless we find a solution for sparc to use debug_pagealloc_enabled()
I will modify the patch description and resend the patch.
