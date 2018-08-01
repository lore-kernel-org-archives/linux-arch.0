Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeHAIZc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 04:25:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Jul 2018 23:41:23 -0700
From: okaya@codeaurora.org
Subject: Re: [PATCH] ia64: fix barrier placement for write* / dma mapping
In-Reply-To: <20180731172031.4447-2-hch@lst.de>
References: <20180731172031.4447-1-hch@lst.de>
 <20180731172031.4447-2-hch@lst.de>
Message-ID: <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, okaya@kernel.org
Message-ID: <20180801064123.0h1DaoJTELVyTaPmcTberHRCADTUl78AdbGqm1IXNTY@z>

+ my new email

On 2018-07-31 10:20, Christoph Hellwig wrote:
> memory-barriers.txt has been updated with the following requirement.
> 
> "When using writel(), a prior wmb() is not needed to guarantee that the
> cache coherent memory writes have completed before writing to the MMIO
> region."
> 
> The current writeX() and iowriteX() implementations on ia64 are not
> satisfying this requirement as the barrier is after the register write.
> 

I asked this question to Tony Luck before. If I remember right,
his answer was:

CPU guarantees outstanding writes to be flushed when a register write
instruction is executed and an additional barrier instruction is not
needed.

> This adds the missing memory barriers, and instead drops them from the
> dma sync routine where they are misplaced (and were missing in the
> more important map/unmap cases anyway).
> 
> All this doesn't affect the SN2 platform, which already has barrier
> in the I/O accessors, and none in dma mapping (but then again
> swiotlb doesn't have any either).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
