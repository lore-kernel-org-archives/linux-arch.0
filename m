Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47576 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933435AbeAJPaU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jan 2018 10:30:20 -0500
Date: Wed, 10 Jan 2018 16:30:17 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 27/33] dma-direct: use node local allocations for
        coherent memory
Message-ID: <20180110153017.GD17790@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-28-hch@lst.de> <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180110153017.FhjqEuKJd0frJtensuwzJhsnykXenurWQYJNgCQJjek@z>

On Wed, Jan 10, 2018 at 12:06:22PM +0000, Robin Murphy wrote:
> On 10/01/18 08:00, Christoph Hellwig wrote:
>> To preserve the x86 behavior.
>
> And combined with patch 10/22 of the SWIOTLB refactoring, this means 
> SWIOTLB allocations will also end up NUMA-aware, right? Great, that's what 
> we want on arm64 too :)

Well, only for swiotlb allocations that can be satisfied by
dma_direct_alloc.  If we actually have to fall back to the swiotlb
buffers there is not node affinity yet.
