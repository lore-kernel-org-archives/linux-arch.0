From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH -mm 0/6] remove unnecessary sync_single_range_* in
	dma_map_ops
Date: Mon, 10 May 2010 10:29:09 +0100
Message-ID: <20100510092909.GA11675@flint.arm.linux.org.uk>
References: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45409 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab0EJJ3l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2010 05:29:41 -0400
Content-Disposition: inline
In-Reply-To: <1272371140-6085-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 27, 2010 at 09:25:34PM +0900, FUJITA Tomonori wrote:
> This patchset removes useless sync_single_range_for_cpu and
> sync_single_range_for_device hooks in dma_map_ops. These hooks were
> for dma_sync_single_range_* DMA API, however, the API became obsolete
> (the description in DMA API docs was removed too). Architecutres
> should use sync_single_for_cpu and sync_single_for_device hooks
> instead (as DMA API docs say, they need to support a partial sync).

If you're going to do this, then please catch all instances - compare
the number of places which contain "dma_sync_single_range" with your
diffstat and you'll notice you've missed a _lot_ of places.

$ git grep -l '\<dma_sync_single_range'
arch/arm/include/asm/dma-mapping.h
arch/avr32/include/asm/dma-mapping.h
arch/blackfin/include/asm/dma-mapping.h
arch/cris/include/asm/dma-mapping.h
arch/frv/include/asm/dma-mapping.h
arch/m68k/include/asm/dma-mapping.h
arch/mips/include/asm/dma-mapping.h
arch/mips/mm/dma-default.c
arch/mn10300/include/asm/dma-mapping.h
arch/parisc/include/asm/dma-mapping.h
arch/xtensa/include/asm/dma-mapping.h
include/asm-generic/dma-mapping-broken.h
include/asm-generic/dma-mapping-common.h
include/linux/ssb/ssb.h

vs.

>  arch/ia64/kernel/pci-swiotlb.c           |    2 -
>  arch/powerpc/kernel/dma-swiotlb.c        |    4 +-
>  arch/powerpc/kernel/dma.c                |   12 +++++-----
>  arch/x86/kernel/pci-swiotlb.c            |    2 -
>  include/asm-generic/dma-mapping-common.h |   20 +-----------------
>  include/linux/dma-mapping.h              |   10 ---------
>  include/linux/swiotlb.h                  |   10 ---------
>  lib/swiotlb.c                            |   31 ------------------------------
>  8 files changed, 10 insertions(+), 81 deletions(-)

It seems there's users of this API in linux/ssb/ssb.h.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
