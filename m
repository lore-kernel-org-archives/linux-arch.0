Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:56793 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752974AbeEKN4g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 May 2018 09:56:36 -0400
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-5-hch@lst.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <73603c68-da05-22bd-efab-d0387a98225d@huawei.com>
Date: Fri, 11 May 2018 14:56:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180511075945.16548-5-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180511135616.v4seetyc7iCNBTwf1EpR138eCdwufQ_PcT7LGmpmSqM@z>

On 11/05/2018 08:59, Christoph Hellwig wrote:
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

I guess that this arc change is here by accident, no? And isn't 
ARCH_HAS_SYNC_DMA_FOR_DEVICE already selected (by 3/20)?

>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c43f5bb55ac8..76ddd0064f87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
