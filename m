Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42726 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeEKJLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 05:11:31 -0400
Date: Fri, 11 May 2018 10:11:15 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
Message-ID: <20180511091114.GA16141@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511075945.16548-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180511091115.kvpCEKsrlAKOoRDzmzSTWy8a_CUwxqCaXmNBQEi90fU@z>

On Fri, May 11, 2018 at 09:59:29AM +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation for
> the nommu dma map implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                |   1 +
>  arch/arm/Kconfig                |   4 +
>  arch/arm/mm/dma-mapping-nommu.c | 139 +++++---------------------------
>  3 files changed, 23 insertions(+), 121 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 89d47eac18b2..3a492a9aeaad 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -9,6 +9,7 @@
>  config ARC
>  	def_bool y
>  	select ARC_TIMERS
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c43f5bb55ac8..76ddd0064f87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -12,6 +12,8 @@ config ARM
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU if !MMU
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if !MMU
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> @@ -27,6 +29,8 @@ config ARM
>  	select CPU_PM if (SUSPEND || CPU_IDLE)
>  	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select DMA_DIRECT_OPS if !MMU
> +	select DMA_NONCOHERENT_OPS if !MMU
> +	select DMA_NONCOHERENT_MMAP if !MMU
>  	select EDAC_SUPPORT
>  	select EDAC_ATOMIC_SCRUB
>  	select GENERIC_ALLOCATOR
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f448a0663b10..a74ed6632982 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -12,6 +12,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/dma-direct.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/scatterlist.h>
>  
>  #include <asm/cachetype.h>
> @@ -26,18 +27,16 @@
>   *   - MMU/MPU is off
>   *   - cpu is v7m w/o cache support
>   *   - device is coherent
> - *  otherwise arm_nommu_dma_ops is used.
> + *  otherwise dma_noncoherent_ops is used.
>   *
> - *  arm_nommu_dma_ops rely on consistent DMA memory (please, refer to
> + *  dma_noncoherent_ops rely on consistent DMA memory (please, refer to
>   *  [1] on how to declare such memory).
>   *
>   *  [1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>   */
>  
> -static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
> -				 dma_addr_t *dma_handle, gfp_t gfp,
> -				 unsigned long attrs)
> -
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs)
>  {
>  	void *ret;
>  
> @@ -65,9 +64,8 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  	return ret;
>  }
>  
> -static void arm_nommu_dma_free(struct device *dev, size_t size,
> -			       void *cpu_addr, dma_addr_t dma_addr,
> -			       unsigned long attrs)
> +void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t dma_addr, unsigned long attrs)
>  {
>  	if (attrs & DMA_ATTR_NON_CONSISTENT) {
>  		dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
> @@ -81,9 +79,9 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
>  	return;
>  }
>  
> -static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> -			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -			      unsigned long attrs)
> +int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs)
>  {
>  	int ret;
>  
> @@ -93,9 +91,8 @@ static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>  	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
>  }
>  
> -
> -static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
> -				  enum dma_data_direction dir)
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)

Please no.  There is a lot of history of these (__dma_page_cpu_to_dev etc)
functions being abused by out of tree drivers, because they think they
know better.  This is stopped by making them static and ensuring that
drivers have no access to these functions.

Please do not re-expose these to the global kernel.

While it may make things easier for a cross-architecture point of view,
it makes it a lot easier for people to abuse these private APIs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
