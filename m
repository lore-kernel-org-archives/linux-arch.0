From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 11:08:16 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain>
References: <20090812183934.777715527@de.ibm.com> <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain> <20090814123439.GB4959@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
 <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41350 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796AbZHNSJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 14:09:00 -0400
In-Reply-To: <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>



On Fri, 14 Aug 2009, Heiko Carstens wrote:
> 
> However quite a few of the additional function calls in networking code
> come from uninlining:
> 
> c2aa270a [NET]: uninline skb_push, de-bloats a lot
> 6be8ac2f [NET]: uninline skb_pull, de-bloats a lot
> 419ae74e [NET]: uninline skb_trim, de-bloats

Hmm. Those functions are big only because of the stupid debugging, which 
is almost certainly not worth it any more. I doubt people have seen enough 
skb under/over-flows in the last years to merit the code.

I suspect we should remove the silly skb_under/over_panic functions, and 
do

 - skb_put:
	-       if (unlikely(skb->tail > skb->end))
	-               skb_over_panic(skb, len, __builtin_return_address(0));
	+       BUG_ON(skb->tail > skb->end);

 - skb_push:
	-       if (unlikely(skb->data<skb->head))
	-               skb_under_panic(skb, len, __builtin_return_address(0));
	+       BUG_ON(skb->data < skb->head);

at which point it might be worthwhile to inline them again, because the 
footprint of a BUG_ON() is really fairly small.

If this is a big deal on s390, it might be worth it.

			Linus
