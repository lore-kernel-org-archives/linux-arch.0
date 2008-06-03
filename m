From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 03 Jun 2008 16:48:50 +1000
Message-ID: <1212475730.9496.30.camel@pasglop>
References: <1211852026.3286.36.camel@pasglop>
	 <200806031416.18195.nickpiggin@yahoo.com.au>
	 <1212467551.9496.23.camel@pasglop>
	 <200806031611.13817.nickpiggin@yahoo.com.au>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58898 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbYFCGue (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 02:50:34 -0400
In-Reply-To: <200806031611.13817.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com

On Tue, 2008-06-03 at 16:11 +1000, Nick Piggin wrote:
> >       - readl is synchronous (ie, makes the CPU think the
> >           data was actually used before executing subsequent
> >           instructions, thus waits for the data to come back,
> >           for example to ensure that a read used to push out
> >           post buffers followed by a delay will indeed happen
> >           with the right delay).
> 
> So your readl can pass an earlier cacheable store or earlier writel?

I forgot to mention that all MMIO are ordered vs. each other and I
do prevent readl from passing earlier cacheable stores too in my
current implementation but I'n not 100% we want to "guarantee" that,
unless we have stupid devices that trigger DMA's on reads with side
effects.. anyway, it is guaranteed in the current case.

Ben.
