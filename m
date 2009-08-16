From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Sun, 16 Aug 2009 11:45:33 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161143410.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain> <20090814171308.GA4906@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain> <20090814.131900.229343660.davem@davemloft.net>
 <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain> <alpine.LFD.2.01.0908141350420.3162@localhost.localdomain> <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39207 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbZHPSpw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 14:45:52 -0400
In-Reply-To: <20090816182733.GB5808@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com



On Sun, 16 Aug 2009, Heiko Carstens wrote:
> 
> An allyesconfig (CONFIG_FTRACE disabled) on x86_64 with gcc 4.3.2 results in
> the following vmlinux sizes:
> 
> 574152755 2009-08-16 20:05 vmlinux-orig
> 574862000 2009-08-16 20:13 vmlinux-skb-inline

It's more relevant to look at just code size. BUG_ON() has more of an 
impact on data sizes, because it does something like 10-12 bytes of 
exception data for each bug-on. But that exception data is out-of-line and 
not interesting.

If the code size blows up a lot, that's worse than if the data size 
expands a bit.

			Linus
