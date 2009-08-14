From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 13:45:37 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908141345000.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain> <20090814171308.GA4906@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.01.0908141105230.3162@localhost.localdomain> <20090814.131900.229343660.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35670 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962AbZHNUqK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Aug 2009 16:46:10 -0400
In-Reply-To: <20090814.131900.229343660.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: heiko.carstens@de.ibm.com, akpm@linux-foundation.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, arnd@arndb.de, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com



On Fri, 14 Aug 2009, David Miller wrote:
> 
> Maybe.  Although most people turn on verbose BUG's and that
> expands to the same if not more code than what's there now
> in these SKB inlines.

But not inline in the code, though. So yeah, it has a memory footprint, 
but shouldn't have a cache footprint.

			Linus
