From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 13:39:02 +1000
Message-ID: <1211859542.3286.46.camel@pasglop>
References: <1211852026.3286.36.camel@pasglop>
	 <20080526.184047.88207142.davem@davemloft.net>
	 <1211854540.3286.42.camel@pasglop>
	 <20080526.192812.184590464.davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42393 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206AbYE0Djf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 May 2008 23:39:35 -0400
In-Reply-To: <20080526.192812.184590464.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com


On Mon, 2008-05-26 at 19:28 -0700, David Miller wrote:
> > But heh, it's you who was telling me that it would be a bad
> engineering
> > decision and we had to make everybody look like x86 & fully
> ordered :-)
> > I decided to agree back then and stuck all those nasty heavy
> barriers
> > in the powerpc variants of readl/writel/...
> 
> I still believe this.
> 
> It's just another complicated thing for driver authors to get wrong.
> The other side of the coin is of course the cost.
> 
> The only thing I am absolutely sure of is that we should make a
> decision fast, document it, and just stick to it.

Yes. As it is today, tg3 for example is potentially broken on all archs
with newer gcc unless we either add "memory" clobber to readl/writel or
stick some wmb's in there (just a random driver I picked).

So Linus, what is your take on that matter ?

Cheers,
Ben.
