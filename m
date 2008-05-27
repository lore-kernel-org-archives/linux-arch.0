From: David Miller <davem@davemloft.net>
Subject: Re: MMIO and gcc re-ordering issue
Date: Mon, 26 May 2008 19:28:12 -0700 (PDT)
Message-ID: <20080526.192812.184590464.davem@davemloft.net>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60717
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753288AbYE0C2Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 May 2008 22:28:16 -0400
In-Reply-To: <1211854540.3286.42.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, tpiepho@freescale.com

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 27 May 2008 12:15:40 +1000

> Some of them. USB comes to mind. I'd be happy to make it "the rule" and
> document that MMIO vs. coherent access aren't implicitely ordered. I
> would still keep them ordered on powerpc for a little while tho until
> I'm happy enough with driver auditing.
> 
> But heh, it's you who was telling me that it would be a bad engineering
> decision and we had to make everybody look like x86 & fully ordered :-)
> I decided to agree back then and stuck all those nasty heavy barriers
> in the powerpc variants of readl/writel/...

I still believe this.

It's just another complicated thing for driver authors to get wrong.
The other side of the coin is of course the cost.

The only thing I am absolutely sure of is that we should make a
decision fast, document it, and just stick to it.
