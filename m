From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] arch: remove __GFP_REPEAT for order-0 allocations
Date: Tue, 28 Sep 2010 16:12:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1009281605180.24817@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1009280344280.11433@chino.kir.corp.google.com> <20100928143655.4282a001.akpm@linux-foundation.org> <alpine.DEB.2.00.1009281536390.24817@chino.kir.corp.google.com> <20100928155326.9ded5a92.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:20739 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab0I1XMg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2010 19:12:36 -0400
Received: from kpbe14.cbf.corp.google.com (kpbe14.cbf.corp.google.com [172.25.105.78])
	by smtp-out.google.com with ESMTP id o8SNCZlT019248
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 16:12:35 -0700
Received: from pxi10 (pxi10.prod.google.com [10.243.27.10])
	by kpbe14.cbf.corp.google.com with ESMTP id o8SNCXAF031951
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 16:12:34 -0700
Received: by pxi10 with SMTP id 10so57181pxi.33
        for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 16:12:33 -0700 (PDT)
In-Reply-To: <20100928155326.9ded5a92.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 28 Sep 2010, Andrew Morton wrote:

> > So we can definitely remove __GFP_REPEAT for any order-0 allocation and 
> > it's based on its implementation -- poorly defined as it may be -- and the 
> > inherit design of any sane page allocator that retries such an allocation 
> > if it's going to use reclaim in the first place.
> 
> Why was __GFP_REPEAT used in those callsites?  What were people trying
> to achieve?
> 

I can't predict what they were trying to achieve since the documentation 
varies on the semantics of __GFP_REPEAT, but the actual implementation 
would suggest that we want to ensure that reclaim actually frees memory 
before we fail the allocation, and that was probably done before it was 
decided to implicitly loop already for order-3 and smaller allocations and 
prehaps even predates the oom killer.

With the oom killer, which would be used iff direct reclaim failed for the 
allocs touched in this patch, we can't report how much memory may be freed 
when that killed task exits, so we implicitly loop forever regardless of 
__GFP_REPEAT (and for a reason other than PAGE_ALLOC_COSTLY_ORDER: if the 
oom killer kills or finds a task that has already been killed but yet to 
exit, it automatically retries the allocation waiting for that free memory 
without even looking at should_alloc_retry()).
