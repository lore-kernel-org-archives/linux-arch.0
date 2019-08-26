Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46343 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbfHZHGh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 03:06:37 -0400
Date: Mon, 26 Aug 2019 09:06:33 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 10/11] arm64: edit zone_dma_bits to fine tune
 dma-direct min mask
Message-ID: <20190826070633.GB11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-11-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-11-nsaenzjulienne@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org, eric@anholt.net, mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org, frowand.list@gmail.com, m.szyprowski@samsung.com
Message-ID: <20190826070633.jrG9R4SMoRGm11ZFPK3yM9sfyM1fDmgvaznHWY-8Qrs@z>

On Tue, Aug 20, 2019 at 04:58:18PM +0200, Nicolas Saenz Julienne wrote:
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
>  		arm64_dma_phys_limit = max_zone_dma_phys();
> +		zone_dma_bits = ilog2((arm64_dma_phys_limit - 1) & GENMASK_ULL(31, 0)) + 1;

This adds a way too long line.  I also find the use of GENMASK_ULL
horribly obsfucating, but I know that opinion is't shared by everyone.
