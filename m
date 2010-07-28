From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 03/16] x86, memblock: Add memblock_x86_to_bootmem()
Date: Tue, 27 Jul 2010 22:40:27 -0700
Message-ID: <4C4FC2CB.6040200@kernel.org>
References: <1279824241-17582-1-git-send-email-yinghai@kernel.org>	 <1279824241-17582-4-git-send-email-yinghai@kernel.org> <1280293236.1970.234.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:37140 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0G1Fma (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 01:42:30 -0400
In-Reply-To: <1280293236.1970.234.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/27/2010 10:00 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-22 at 11:43 -0700, Yinghai Lu wrote:
>> memblock_x86_to_bootmem() will reserve memblock.reserved.region in bootmem after bootmem is
> 
>> +#ifndef CONFIG_NO_BOOTMEM
>> +void __init memblock_x86_to_bootmem(u64 start, u64 end)
>> +{
>> +	int count;
>> +	u64 final_start, final_end;
>> +	struct memblock_region *r;
>> +
>> +	/* Take out region array itself */
>> +	if (memblock.reserved.regions != memblock_reserved_init_regions)
>> +		memblock_free(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
> 
> So that's why you export memblock_reserved_init_regions...
> 
> I really -really- don't like it. First of all, it's really gross to
> free the array then walk it. We know it won't race but still ...
> especially since you re-do the above every time
> memblock_x86_to_bootmem() is called. Is it called more than once ? If
> yes, then it's bogus. If not, then why have start,end ?

only one time for x86.

> 
> If you really want to free it, maybe best is to stick something in
> mm/memblock.c that kicks in at late init time and does the freeing ?
> 
> I'm going to keep the exporting out of my branch for now. If you really
> want it, you can always add it to this specific patch, but it sucks.

Actually the last patch remove this bootmem support for x86, so this function get removed later.

Thanks

Yinghai
