From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low memory
Date: Mon, 09 Dec 2019 16:43:17 +1100
Message-ID: <87h82aqcju.fsf@mpe.ellerman.id.au>
References: <20191204123524.22919-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Darren Stevens <darren@stevens-zone.net>, mad skateman <madskateman@gmail.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Paul Mackerras <paulus@samba.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-arch.vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
>
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
>
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de

This wasn't bisected, but I thought it was a regression. Do we know what
commit caused it?

Was it 25078dc1f74b ("powerpc: use mm zones more sensibly") ?

Or was that a red herring?

cheers

> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darren Stevens <darren@stevens-zone.net>
> Cc: mad skateman <madskateman@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index be941d382c8d..14c2c53e3f9e 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -260,6 +260,14 @@ void __init mem_init(void)
>  	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
>  
>  #ifdef CONFIG_SWIOTLB
> +	/*
> +	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
> +	 * 4G. We force memblock to bottom-up mode to ensure that the
> +	 * memory allocated in swiotlb_init() is DMA-able.
> +	 * As it's the last memblock allocation, no need to reset it
> +	 * back to to-down.
> +	 */
> +	memblock_set_bottom_up(true);
>  	swiotlb_init(0);
>  #endif
>  
> -- 
> 2.24.0
