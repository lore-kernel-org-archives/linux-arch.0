From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 13:19:00 -0700 (PDT)
Message-ID: <20090814.131900.229343660.davem@davemloft.net>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
	<20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
	<alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42759
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757161AbZHNUSu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 16:18:50 -0400
In-Reply-To: <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: heiko.carstens@de.ibm.com, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Aug 2009 11:08:16 -0700 (PDT)

> On Fri, 14 Aug 2009, Heiko Carstens wrote:
>> 
>> However quite a few of the additional function calls in networking code
>> come from uninlining:
>> 
>> c2aa270a [NET]: uninline skb_push, de-bloats a lot
>> 6be8ac2f [NET]: uninline skb_pull, de-bloats a lot
>> 419ae74e [NET]: uninline skb_trim, de-bloats
> 
> Hmm. Those functions are big only because of the stupid debugging, which 
> is almost certainly not worth it any more. I doubt people have seen enough 
> skb under/over-flows in the last years to merit the code.

We have found a few bugs in the past year or two because of
the check, but indeed not "a lot".

> I suspect we should remove the silly skb_under/over_panic functions, and 
> do
> 
>  - skb_put:
> 	-       if (unlikely(skb->tail > skb->end))
> 	-               skb_over_panic(skb, len, __builtin_return_address(0));
> 	+       BUG_ON(skb->tail > skb->end);
> 
>  - skb_push:
> 	-       if (unlikely(skb->data<skb->head))
> 	-               skb_under_panic(skb, len, __builtin_return_address(0));
> 	+       BUG_ON(skb->data < skb->head);
> 
> at which point it might be worthwhile to inline them again, because the 
> footprint of a BUG_ON() is really fairly small.

Maybe.  Although most people turn on verbose BUG's and that
expands to the same if not more code than what's there now
in these SKB inlines.
