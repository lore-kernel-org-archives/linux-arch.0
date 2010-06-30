From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -mm 1/2] scsi: remove dma_is_consistent usage in 53c700
Date: Wed, 30 Jun 2010 11:39:12 +0900
Message-ID: <20100630113548K.fujita.tomonori@lab.ntt.co.jp>
References: <1277736958.10879.43.camel@mulgrave.site>
	<20100629150201C.fujita.tomonori@lab.ntt.co.jp>
	<1277818655.4379.5.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:41473 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab0F3Cjz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Jun 2010 22:39:55 -0400
In-Reply-To: <1277818655.4379.5.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James.Bottomley@HansenPartnership.com
Cc: fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, grundler@parisc-linux.org, lethal@linux-sh.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 29 Jun 2010 08:37:35 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > How about using ARCH_KMALLOC_MINALIGN instead of L1_CACHE_BYTES?

(snip)

> Actually, I'd rather not do this.  The reason is that L1_CACHE_ALIGN is
> quite a big performance optimisation on x86 for the driver.  Without it,
> it's functionally correct, but the DMA use of the mailboxes really
> thrashes the cache which damages performance (x86 has
> ARCH_KMALLOC_MINALIGN set to 8 ... the default)

Ah, I see.

If slab.h doesn't define ARCH_KMALLOC_MINALIGN for architectures that
don't define it, the driver could do something like:

#ifdef ARCH_KMALLOC_MINALIGN
#define DMA_ALIGN(x) ALIGN(x, ARCH_KMALLOC_MINALIGN)
#else
#define DMA_ALIGN(x) ALIGN(x, L1_CACHE_BYTES)
#endif

Seems that it's better to rename ARCH_KMALLOC_MINALIGN to something
like ARCH_DMA_MINALIGN and make ARCH_KMALLOC_MINALIGN the slab
internal thing.


> The only correctness problem, which the BUG is checking for is mismatch
> in dma alignment ... as I said, I'm happy just to rely on that being
> correct on every incoherent platform the driver operates on.

Ok, it's fine by me too. let's simply remove the BUG_ON.

I think that you want to document that dma_get_cache_alignment()
cannot be greater than the L1 cache stride. However, seems that
dma_get_cache_alignment() is greater than L1_CACHE_BYTES on some
architectures (they have some reasons, I assume). So I'll just remove
the BUG_ON.
