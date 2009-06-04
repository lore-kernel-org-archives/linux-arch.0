From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Thu, 4 Jun 2009 13:45:17 +0100
Message-ID: <20090604124516.GA24491@flint.arm.linux.org.uk>
References: <200905282104.55818.arnd@arndb.de> <20090601130319A.fujita.tomonori@lab.ntt.co.jp> <200906011111.28521.arnd@arndb.de> <20090604165703N.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48146 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbZFDMph (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 08:45:37 -0400
Content-Disposition: inline
In-Reply-To: <20090604165703N.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, lethal@linux-sh.org, chris@zankel.net

On Thu, Jun 04, 2009 at 04:57:12PM +0900, FUJITA Tomonori wrote:
> ? Why we don't need to remove stale cache after DMA_FROM_DEVICE
> transfer?

Think about a CPU which does speculative prefetches into the cache (which
later ARMs do).

The result is that, for a DMA_FROM_DEVICE transfer, you need to:

1. ensure that no cache writebacks occur to the region while DMA is
   being performed
2. ensure that any data which is present in the cache for the region
   is invalidated once DMA has completed

If you don't have speculative prefetches, then (1) and (2) can be (and
are at present) combined into the initial mapping setup or whenever the
buffer is handed from the CPUs ownership to the DMA device's ownership.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
