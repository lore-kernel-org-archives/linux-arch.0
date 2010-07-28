From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 28/31] memblock: Export MEMBLOCK_ERROR again
Date: Tue, 27 Jul 2010 23:13:14 -0700
Message-ID: <4C4FCA7A.1020506@kernel.org>
References: <1280294128.1970.237.camel@pasglop>	<1280294376.1970.239.camel@pasglop>	<4C4FC5D1.3070708@zytor.com> <20100727.230120.43037767.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:24322 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0G1GPT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 02:15:19 -0400
In-Reply-To: <20100727.230120.43037767.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: hpa@zytor.com, benh@kernel.crashing.org, mingo@elte.hu, tglx@linutronix.de, akpm@linux-foundation.org, torvalds@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/27/2010 11:01 PM, David Miller wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> Date: Tue, 27 Jul 2010 22:53:21 -0700
> 
>> On 07/27/2010 10:19 PM, Benjamin Herrenschmidt wrote:
>>>
>>> Screw it, I don't like it but I'll just split your patch in two for now
>>> and keep 0. It's a bit fishy but memblock does mostly top-down
>>> allocations and so shouldn't hit 0, and in practice the region at 0 is,
>>> I beleive, reserved, but we need to be extra careful and might need to
>>> revisit that a bit.
>>>
>>> That's an area where I don't completely agree with Linus, ie, 0 is a
>>> perfectly valid physical address for memblock to return :-)
>>>
>>
>> On x86, physical address 0 contains the real-mode IVT and will thus be
>> reserved, at least for the forseeable future.  Other architectures may
>> very well have non-special RAM there.
> 
> 0 is very much possible on sparc64

So still keep MEMBLOCK_ERROR to (~(phys_addr_t)0) ?

We can change some variable from unsigned long to phys_addr_t that will be
 assigned by memblock_find_base().

that could avoid casting too.

Thanks

Yinghai
