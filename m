Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:6512 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab0I1WsM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2010 18:48:12 -0400
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com [172.25.105.76])
	by smtp-out.google.com with ESMTP id o8SMm7jd022126
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 15:48:07 -0700
Received: from pxi4 (pxi4.prod.google.com [10.243.27.4])
	by kpbe12.cbf.corp.google.com with ESMTP id o8SMlifD020769
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 15:48:06 -0700
Received: by pxi4 with SMTP id 4so51606pxi.36
        for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 15:48:06 -0700 (PDT)
Date: Tue, 28 Sep 2010 15:47:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] arch: remove __GFP_REPEAT for order-0 allocations
In-Reply-To: <20100928143655.4282a001.akpm@linux-foundation.org>
Message-ID: <alpine.DEB.2.00.1009281536390.24817@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1009280344280.11433@chino.kir.corp.google.com> <20100928143655.4282a001.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20100928224757.Pelgzwr4fZMnRYAeGWnjazlyVJ9y-29qNq2X68dr1FI@z>

On Tue, 28 Sep 2010, Andrew Morton wrote:

> > Order-0 allocations, including quicklist_alloc(),  are always under 
> > PAGE_ALLOC_COSTLY_ORDER, so they loop endlessly in the page allocator
> > already without the need for __GFP_REPEAT.
> 
> That's only true for the current implementation of the page allocator.
> 

Yes, but in this case it's irrelevant since we're talking about order-0 
allocations.  The page allocator will never be changed so that order-0 
allocations immediately fail if there's no available memory, otherwise 
we'd only use direct reclaim and the oom killer for high-order allocs or 
add __GFP_NOFAIL everywhere and that's quite pointless.

> If we were to change the page allocator behaviour to not do that (and
> we change it daily!) then all those callsites which wanted __GFP_REPEAT
> behaviour will get broken.  So someone would need to go back and work
> out how to unbreak them, if we remembered.
> 
> Plus there's presumably some documentary benefit in leaving the
> __GFP_REPEATs in there.
> 

The documentation is one of the problems here, __GFP_REPEAT isn't sanely 
defined by any of it and it leaves the user guessing as to its behavior 
unless you peruse the implementation.

Intiution would suggest that __GFP_REPEAT would repeat the allocation 
attempt once it failed.  After all, we have __GFP_NOFAIL to try 
indefinitely.  That's not what it does, however.

include/linux/gfp.h:
 * __GFP_REPEAT: Try hard to allocate the memory, but the allocation attempt
 * _might_ fail.  This depends upon the particular VM implementation.

Try hard in what way?  Sure, it depends on the implementation but does 
that mean we only reclaim if we have __GFP_REPEAT?  This definition also 
does allow us to change its meaning, so saying it has a specific 
importance for order-0 allocations in arch code isn't really that 
compelling.

include/linux/slab.h:
 * %__GFP_REPEAT - If allocation fails initially, try once more before failing.

Nope, that's not what it does either.  (And, if it did, why would that 
possibly be helpful unless we know there's something being freed?)

The reality is that __GFP_REPEAT continues the allocation until we've 
reclaimed at least the number of pages we're looking for.  For order-0 
allocations, it would only repeat if we failed to reclaim any pages.  But, 
if that's the case, the oom killer would have killed something and we 
implicitly loop anyway in that situation (otherwise, we would have 
needlessly killed a task!) without even looking at the retry logic.

So we can definitely remove __GFP_REPEAT for any order-0 allocation and 
it's based on its implementation -- poorly defined as it may be -- and the 
inherit design of any sane page allocator that retries such an allocation 
if it's going to use reclaim in the first place.
