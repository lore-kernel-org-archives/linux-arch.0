From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 14/31] arm64: DMA mapping API
Date: Wed, 15 Aug 2012 16:16:00 +0000
Message-ID: <201208151616.01114.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-15-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49957 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab2HOQQG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 12:16:06 -0400
In-Reply-To: <1344966752-16102-15-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +static struct dma_map_ops arm64_swiotlb_dma_ops = {
> +       .alloc = arm64_swiotlb_alloc_coherent,
> +       .free = arm64_swiotlb_free_coherent,
> +       .map_page = arm64_swiotlb_map_page,
> +       .unmap_page = arm64_swiotlb_unmap_page,
> +       .map_sg = arm64_swiotlb_map_sg_attrs,
> +       .unmap_sg = arm64_swiotlb_unmap_sg_attrs,
> +       .sync_single_for_cpu = arm64_swiotlb_sync_single_for_cpu,
> +       .sync_single_for_device = arm64_swiotlb_sync_single_for_device,
> +       .sync_sg_for_cpu = arm64_swiotlb_sync_sg_for_cpu,
> +       .sync_sg_for_device = arm64_swiotlb_sync_sg_for_device,
> +       .dma_supported = swiotlb_dma_supported,
> +       .mapping_error = swiotlb_dma_mapping_error,
> +};
> +
> +void __init swiotlb_init_with_default_size(size_t default_size, int verbose);
> +
> +void __init arm64_swiotlb_init(size_t max_size)
> +{
> +       dma_ops = &arm64_swiotlb_dma_ops;
> +       swiotlb_init_with_default_size(min((size_t)SZ_64M, max_size), 1);
> +}

Why is swiotlb the default? I would expect that most devices can in fact
use the entire 64 bit address space, so you can use a simple linear
implementation for those.

	Arnd
