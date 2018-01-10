Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47532 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeAJP0U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jan 2018 10:26:20 -0500
Date: Wed, 10 Jan 2018 16:26:17 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
        header
Message-ID: <20180110152617.GB17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-12-hch@lst.de> <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180110152617.V0NKmQAMVCpNNoSwH6S5fcmBGbVddzi41Ot4aZwwDwY@z>

On Wed, Jan 10, 2018 at 02:56:01PM +0000, Robin Murphy wrote:
> I took a look at these, and it seems their phys_to_dma() usage is doing the 
> thing which we subsequently formalised as dma_map_resource(). I've had a 
> crack at a quick patch to update the CESA driver; qcom_nandc looks slightly 
> more complex in that the changes probably need to span the BAM dmaengine 
> driver as well.

Sounds great, although probably something for the next merge window.

In the meantime does this patch looks good to you?
