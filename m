From: David Rientjes <rientjes@google.com>
Subject: Re: [patch] arch: remove __GFP_REPEAT for order-0 allocations
Date: Tue, 28 Sep 2010 18:10:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1009281751170.15357@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1009280344280.11433@chino.kir.corp.google.com> <20100928143655.4282a001.akpm@linux-foundation.org> <alpine.DEB.2.00.1009281536390.24817@chino.kir.corp.google.com> <20100928155326.9ded5a92.akpm@linux-foundation.org>
 <alpine.DEB.2.00.1009281605180.24817@chino.kir.corp.google.com> <20100928164006.55c442b1.akpm@linux-foundation.org> <alpine.DEB.2.00.1009281644110.21757@chino.kir.corp.google.com> <20100928174147.41e48aef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:20798 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab0I2BLC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Sep 2010 21:11:02 -0400
Received: from kpbe17.cbf.corp.google.com (kpbe17.cbf.corp.google.com [172.25.105.81])
	by smtp-out.google.com with ESMTP id o8T1Aspm018532
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 18:10:54 -0700
Received: from pvg13 (pvg13.prod.google.com [10.241.210.141])
	by kpbe17.cbf.corp.google.com with ESMTP id o8T1Arat015827
	for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 18:10:53 -0700
Received: by pvg13 with SMTP id 13so117097pvg.24
        for <linux-arch@vger.kernel.org>; Tue, 28 Sep 2010 18:10:53 -0700 (PDT)
In-Reply-To: <20100928174147.41e48aef.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 28 Sep 2010, Andrew Morton wrote:

> What I care about is that very smart, experienced and hard-working
> Linux developers decided, a long time ago, that page-table allocations
> are special, and need special treatment.  This is information!
> 

Then they implemented it incorrectly since __GFP_REPEAT has never given 
any order-0 allocation special treatment.

> What I also care about is lazy MM developers who just rip stuff out
> without understanding it and without even bothering to make an
> *attempt* to understand it.
> 

I understand that __GFP_REPEAT does absolutely nothing in all the places 
that I removed it in this patch, but if you want to use a gfp flag as 
documentation instead of adding a comment to the PAGE_ALLOC_COSTLY_ORDER 
retry logic, then that's your call, but I would certainly suggest cleaning 
up the erroneous documentation in the tree that specifies its semantics.

> > So, given the fact that the PAGE_ALLOC_COSTLY_ORDER logic has existed 
> > since the same time, the semantics of __GFP_REPEAT have changed and are 
> > often misrepresented, and we don't even invoke the __GFP_REPEAT logic for 
> > any of the allocations in my patch since they are oom killable,
> 
> Probably this is because lazy ignorant MM developers broke earlier
> intentions without even knowing that they were doing so.
> 

The intention was that they loop forever, but since that's implicit for 
these order-0 allocations, I guess you allowed its semantics to change in 
a41f24ea without the same objections?
