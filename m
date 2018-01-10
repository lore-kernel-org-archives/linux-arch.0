Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47683 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933757AbeAJPkx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jan 2018 10:40:53 -0500
Date: Wed, 10 Jan 2018 16:40:50 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
        header
Message-ID: <20180110154050.GA18428@lst.de>
References: <20180110080027.13879-1-hch@lst.de> <20180110080027.13879-12-hch@lst.de> <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com> <20180110152617.GB17790@lst.de> <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0f90ed0-989f-4dc2-6f86-de8b4e486b55@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180110154050.BFmCHQfSMs5spxP6gVBnzDTJagjITUPk_JFZrds3km4@z>

On Wed, Jan 10, 2018 at 03:31:08PM +0000, Robin Murphy wrote:
> Yes indeed, modulo Vladimir's comments - it does seem prudent to fix the 
> obvious off-by-ones as we touch them. I've wanted to do something like this 
> for ages, but never got around to it myself.

I've fixed these now in a separate patch.  I'm taking this as an
Acked-by.
