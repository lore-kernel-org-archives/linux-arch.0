From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: LMB bits
Date: Sat, 10 Jul 2010 13:53:55 -0700
Message-ID: <4C38DDE3.9010303@kernel.org>
References: <20100709.172050.112604881.davem@davemloft.net>	<20100709.205544.48508808.davem@davemloft.net>	<1278759719.28659.155.camel@pasglop> <20100710.131418.246532639.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:31400 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab0GJU6E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jul 2010 16:58:04 -0400
In-Reply-To: <20100710.131418.246532639.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@elte.hu, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On 07/10/2010 01:14 PM, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sat, 10 Jul 2010 21:01:59 +1000
> 
>> On Fri, 2010-07-09 at 20:55 -0700, David Miller wrote:
>>> A quick update, I'm still chipping away to find the culprit,
>>> I know so far that things are ok at least 14 patches into the
>>> series.
>>>
>>> I'll work more to try and track down the exact problem tomorrow. 
>>
>> Thanks Dave !
> 
> The first guilty commit seems to be:
> 
> --------------------
>>From 869146ec57f449a5dd4bb5d939361841f4f7f3c6 Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 6 Jul 2010 15:39:08 -0700
> Subject: [PATCH 01/12] memblock: Make memblock_find_region() out of memblock_alloc_region()
> 
> This function will be used to locate a free area to put the new memblock
> arrays when attempting to resize them. memblock_alloc_region() is gone,
> the two callsites now call memblock_add_region().
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --------------------
> 
> I wonder if there is some subtle way you've changed behavior here?
> Previously if alloc block fails to do the add, it continues and
> keeps trying.
> 
> Whereas now this add call happens a level higher and it's immediately
> signalled as a hard failure.
> 
> Oh I see, your conversion of membase_alloc_nid_region() is buggy.
> Instead of passing in "ret" as the base address to memblock_add_region(),
> you're passing in the original value, "start".
> 
> The other conversion was done correctly, which is why you didn't see
> this problem obviously :)
> 
> I'll make this fix and see how much further I can get.

Ben/David, 

can you fold in following patch in your patchset too?

also please use -v2 [PATCH] lmb: rename to memblock
that is removing one wrong change with microblaze dts

Thanks

Yinghai


Subject: [PATCH] memblock: memblock_find_base() should return MEMBLOCK_ERROR on failing path

all callees assume it return MEMBLOCK_ERROR when it fail to find a range

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 mm/memblock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/mm/memblock.c
===================================================================
--- linux-2.6.orig/mm/memblock.c
+++ linux-2.6/mm/memblock.c
@@ -154,7 +154,7 @@ static phys_addr_t __init memblock_find_
 		if (found != MEMBLOCK_ERROR)
 			return found;
 	}
-	return 0;
+	return MEMBLOCK_ERROR;
 }
 
 static void memblock_remove_region(struct memblock_type *type, unsigned long r)
