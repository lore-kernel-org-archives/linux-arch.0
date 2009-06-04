From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Thu, 4 Jun 2009 14:42:52 +0100
Message-ID: <200906041442.53170.arnd@arndb.de>
References: <200905282104.55818.arnd@arndb.de> <200906041235.34686.arnd@arndb.de> <20090604125119.GB24491@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53892 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbZFDNnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 09:43:07 -0400
In-Reply-To: <20090604125119.GB24491@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 04 June 2009, Russell King wrote:
> And here we go promoting dma-mask-is-not-a-mask-but-a-limit (which I
> brought up in the KS thread on linux-arch.)
> 
> It's fine if your DMA-able memory starts at physical address 0 and ends
> somewhere else, but this is no longer the case with embedded platforms.
> As pointed out in the other thread, there are platforms which have two
> separate banks of memory, the one at the lower physical address is not
> DMA capable.

The dma-mapping-linear.h only cares about the platforms that have a
linear contigous mapping between DMA and phys addresses. Other
platforms will have to do something more fancy in their dma mapping
implementation.

The device sets a mask (really a limit) of the address ranges it can
handle. Basically every user in the kernel currently passes DMA_BIT_MASK()
limit into {dma,pci}_set_mask,  and I am not aware of any driver
that needs something more fancy. If you know one, please tell us.

The DMA-capable addresses of the platform are a completely different
issue and these should not be confused. Some architecture solve this
by bus-specific mapping operations, which sounds like what you would
need here as well. The bus is the only instance in the system that knows
how the device-visible DMA space maps into the physical memory space,
and it needs to be the instance checking the mask.

The only place where the mask is really used later is dma_alloc_coherent,
which can also be bus specific, and should know how to interpret the
mask.

	Arnd <><
