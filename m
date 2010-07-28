From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 31/31] memblock: Add memblock_find_in_range()
Date: Tue, 27 Jul 2010 23:08:31 -0700
Message-ID: <4C4FC95F.6040806@kernel.org>
References: <1279822864-17154-1-git-send-email-yinghai@kernel.org>	 <1279822864-17154-32-git-send-email-yinghai@kernel.org> <1280295415.1970.245.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:25734 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab0G1GJZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 02:09:25 -0400
In-Reply-To: <1280295415.1970.245.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/27/2010 10:36 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-22 at 11:21 -0700, Yinghai Lu wrote:
>> it is a wrapper for memblock_find_base
>>
>> make it more easy for x86 to use memblock. ( rebase )
>> x86 early_res is using find/reserve pattern instead of alloc.
>>
>> keep it in weak version, so later We can use x86 own version if needed.
>> also We need it in mm/memblock.c, so one caller mm/page_alloc.c could get compiled
>>
>> -v2: Change name to memblock_find_in_range() according to Michael Ellerman
>> -v3: Add generic weak version __memblock_find_in_range()
>>      so keep the path for fallback to x86 version that handle from low
>> -v4: use 0 for failing path
>> -v5: use MEMBLOCK_ERROR again
>> -v6: remove __memblock_find_in_range()
> 
> It's very gross to have this weak and not memblock_find_base()... IE. 
> 
> You create a new function defined as a wrapper on an existing one to
> provide an easier set of arguments ... but also make it weak so the
> arch can completely change its semantics without actually changing
> the semantics of the function it wraps.
> 
> This is going to cause confusion and bugs. I'm adding the patch without
> the weak bit to my branch for now, we need to discuss what is the best
> approach for x86 here. Might be to use a different function. I don't
> understand yet -why- x86 needs to override it, maybe the right way is
> to reserve things more intelligently on x86 ?

again there is a difference between low/high to high/low.

for example: 
high/low allocation, from first kernel to kexec second kernel, always work fine except system with Qlogic card.
because Qlogic card is using main RAM as EFT etc for card's FW log trace. second kernel have not idea that those RAM
 is used by first kernel for that purpose. that the CARD still use that between two kernels.
second kernel could have crash it try to use those ram.

low/high allocation seems to be safe,  second kernel can slip to boot fine.

Thanks

Yinghai
