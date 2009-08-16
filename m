From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Sun, 16 Aug 2009 22:36:50 +0200
Message-ID: <20090816203650.GB27764@elte.hu>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain> <20090814171308.GA4906@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain> <20090814.131900.229343660.davem@davemloft.net> <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain> <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain> <20090816182733.GB5808@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908161143410.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46796 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755884AbZHPUhI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 16:37:08 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908161143410.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 16 Aug 2009, Heiko Carstens wrote:
> > 
> > An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 
> > 4.3.2 results in the following vmlinux sizes:
> > 
> > 574152755 2009-08-16 20:05 vmlinux-orig
> > 574862000 2009-08-16 20:13 vmlinux-skb-inline
> 
> It's more relevant to look at just code size. BUG_ON() has more of 
> an impact on data sizes, because it does something like 10-12 
> bytes of exception data for each bug-on. But that exception data 
> is out-of-line and not interesting.
> 
> If the code size blows up a lot, that's worse than if the data 
> size expands a bit.

Also, allyesconfig isnt really relevant to inlining cost in general 
as it enables everything. The defconfigs are better (at least on 
x86) because they tend to be some distro-alike config - i.e. they 
are closer to what most Linux users will run in the end.

	Ingo
