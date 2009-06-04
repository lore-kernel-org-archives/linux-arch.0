From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Thu, 4 Jun 2009 13:51:19 +0100
Message-ID: <20090604125119.GB24491@flint.arm.linux.org.uk>
References: <200905282104.55818.arnd@arndb.de> <200906011111.28521.arnd@arndb.de> <20090604165703N.fujita.tomonori@lab.ntt.co.jp> <200906041235.34686.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49325 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872AbZFDMvh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 08:51:37 -0400
Content-Disposition: inline
In-Reply-To: <200906041235.34686.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Jun 04, 2009 at 12:35:34PM +0000, Arnd Bergmann wrote:
> static inline int
> dma_supported(struct device *dev, u64 mask)
> {
> 	/*
> 	 * dma_supported means that dma_alloc_{non,}coherent
> 	 * will succeed in finding an addressable page.
> 	 */
> 	u64 zone_dma_max_pfn;
> 	struct pgdat *pgdat;
> 	struct zone *zone;
> 
> 	for_each_online_pgdat(pgdat) {
> 		/* the first zone on each node is most likely to fit in the mask */
> 		zone = pgdat->node_zones[0];
> 		if (populated_zone(zone) {
> 			max_dma_pfn = zone->zone_start_pfn + zone->spanned_pages);
> 			/* max_dma_pfn is actually constant, we could store it
> 			    somewhere instead of looking it up every time. */
> 			if (mask < (max_dma_pfn << PAGE_SHIFT))

And here we go promoting dma-mask-is-not-a-mask-but-a-limit (which I
brought up in the KS thread on linux-arch.)

It's fine if your DMA-able memory starts at physical address 0 and ends
somewhere else, but this is no longer the case with embedded platforms.
As pointed out in the other thread, there are platforms which have two
separate banks of memory, the one at the lower physical address is not
DMA capable.

This means that treating the DMA mask as a limit does not work for these
platforms (and, sometimes, treating it as a real mask also doesn't work.)

A good step forward would be to get a concensus on this stupid DMA mask
thing.  Is it a _mask_, or is it a _limit_?  If it's a mask then let's
start treating it as such throughout the kernel code.  If it's a limit,
let's rename the damned thing so everyone knows that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
