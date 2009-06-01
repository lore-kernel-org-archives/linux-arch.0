From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:14:05 +0100
Message-ID: <20090601101405.GA19806@flint.arm.linux.org.uk>
References: <20090601082943.GA5550@flint.arm.linux.org.uk> <20090601181723U.fujita.tomonori@lab.ntt.co.jp> <20090601092259.GB5550@flint.arm.linux.org.uk> <20090601183323V.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43770 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756353AbZFAKOR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:14:17 -0400
Content-Disposition: inline
In-Reply-To: <20090601183323V.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jun 01, 2009 at 06:32:44PM +0900, FUJITA Tomonori wrote:
> Can ARM replace the dmabounce with swiotlb?

We could, if there was some effort with swiotlb to make it safe on
non-cache coherent architectures.  As it stands, it sources its
memory from __get_free_pages() which is non-coherent on ARM.

There's nothing wrong with that per-se, provided we use the streaming
DMA mapping API on those pages and obey the buffer ownership rules.


Also, it needs cache flushing - one thing davem said to me a while
back is that the effects of DMA should be the same as far as the
cache is concerned no matter how it is performed.

In other words, from the external perspective:

	dma_map_single()
	hardware DMA happens
	dma_unmap_single()

should result in exactly the same situation on an architecture as
far as the buffer is concerned no matter what the underlying
implementation is.

So, on a non-DMA coherent cache architecture, when DMA is normally
performed the data ends up in RAM with the cache flushed for that
region.  If, instead dma_map_single uses a bounce buffer to do that
DMA, then the same needs to be true of the original buffer - the
data needs to be in RAM with the cache flushed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
