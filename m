From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 04 Jun 2008 08:26:58 +1000
Message-ID: <1212532018.9496.49.camel@pasglop>
References: <1211852026.3286.36.camel@pasglop>
	 <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	 <20080602072403.GA20222@flint.arm.linux.org.uk>
	 <200806031416.18195.nickpiggin@yahoo.com.au>
	 <Pine.LNX.4.64.0806031154050.3242@t2.domain.actdsltmp>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34908 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbYFCW1p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jun 2008 18:27:45 -0400
In-Reply-To: <Pine.LNX.4.64.0806031154050.3242@t2.domain.actdsltmp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Trent Piepho <tpiepho@freescale.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk+lkml@arm.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org

On Tue, 2008-06-03 at 12:43 -0700, Trent Piepho wrote:
> 
> Byte-swapping vs not byte-swapping is not usually what the programmer wants. 
> Usually your device's registers are defined as being big-endian or
> little-endian and you want whatever is needed to give you that.

Yes, which is why I (and some other archs) have writel_be/readl_be.

The standard writel/readl being LE.

However, the "raw" variants are defined to be native endian, which is of
some use to -some- archs apparently where they have SoC device whose
endianness follow the core.

> I believe that on some archs that can be either byte order, some built-in
> devices will change their registers to match, and so you want "native endian"
> or no swapping for these.  Though that's definitely in the minority.
> 
> An accessors that always byte-swaps regardless of the endianness of the host
> is never something I've seen a driver want.
> 
> IOW, there are four ways one can defined endianness/swapping:
> 1) Little-endian
> 2) Big-endian
> 3) Native-endian aka non-byte-swapping
> 4) Foreign-endian aka byte-swapping
> 
> 1 and 2 are by far the most used.  Some code wants 3.  No one wants 4.  Yet
> our API is providing 3 & 4, the two which are the least useful.

No, we don't provide 4, it was something unclear with nick.

We provide 1. (writel/readl and __variants), some archs provide 2
(writel_be/readl_be, tho I don't have __variants, I suppose I could),
and everybody provides 3. though in some cases (like us) only in the
form of __variants (ie, non ordered, like __raw_readl/__raw_writel).

Nick's proposal is to plug those gaps, though it's, I believe, missing
the _be variants.

> Is it enough to provide only "all or none" for ordering strictness?  For
> instance on powerpc, one can get a speedup by dropping strict ordering for IO
> vs cacheable memory, but still keeping ordering for IO vs IO and IO vs locks. 
> This is much easier to program for than no ordering at all.  In fact, if one
> doesn't use coherent DMA, it's basically the same as fully strict ordering.

Ben.
