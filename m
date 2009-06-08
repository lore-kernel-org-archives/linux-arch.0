From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 8 Jun 2009 10:03:58 +0200
Message-ID: <200906081003.59171.arnd@arndb.de>
References: <200906041235.34686.arnd@arndb.de> <200906041747.04310.arnd@arndb.de> <20090608144921R.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50115 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbZFHIED (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2009 04:04:03 -0400
In-Reply-To: <20090608144921R.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 08 June 2009, FUJITA Tomonori wrote:
> 
> > However, I don't think I have the energy to fix this problem, but
> > I agree that it should be fixed eventually. I can leave out
> > the declarations of dma_{free,alloc}_coherent from dma-mapping-linear.h
> > so that the broken code remains in the architecture specific
> > files, and change all references to dma_cache_sync to something
> > else. The best I can think of is __dma_cache_sync() with the same
> > calling conventions as dma_cache_sync(). Does that make sense?
> 
> Sorry, but it doesn't make sense to me because __dma_cache_sync() hack
> is against the goal of dma-mapping-linear.h, having a clean, ideal,
> unified header file.

Do you have any other suggestion? The operation that an architecture
performs to synchronize the DMA buffer after a DMA is just not generic
and needs to have some name that we can call from the generic file.
Right now we use one of dma_cache_sync, frv_cache_wback_inv,
mn10300_dcache_flush_inv or consistent_sync for this and I was just
looking for a new internal name for this operation.

	Arnd <><
