From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 05/16] x86, memblock: Add get_free_all_memory_range()
Date: Tue, 27 Jul 2010 22:41:38 -0700
Message-ID: <4C4FC312.4010503@kernel.org>
References: <1279824241-17582-1-git-send-email-yinghai@kernel.org>	 <1279824241-17582-6-git-send-email-yinghai@kernel.org> <1280293338.1970.235.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:37156 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab0G1Fmb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 01:42:31 -0400
In-Reply-To: <1280293338.1970.235.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jan Beulich <jbeulich@novell.com>

On 07/27/2010 10:02 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2010-07-22 at 11:43 -0700, Yinghai Lu wrote:
>>
>> +       /* Take out region array itself at first*/
>> +       if (memblock.reserved.regions != memblock_reserved_init_regions)
>> +               memblock_free(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
>> +
> 
> More of that horror. Don't.
> 
> Another option from what i proposed earlier is to actually have a function
> inside mm/memblock to free it (memblock_free_arrays()) that does nothing
> if memblock is to survive init.
> 
> I hate exporting variables or data structures like that. Functions are
> semantically a lot cleaner.

ok, will check if can change that to function instead.
but it will be with add-on patch.

Thanks

Yinghai
