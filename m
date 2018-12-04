Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46499 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeLDWd5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Dec 2018 17:33:57 -0500
Date: Tue, 4 Dec 2018 23:33:55 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/23] dma-mapping: provide a generic DMA_MAPPING_ERROR
Message-ID: <20181204223355.GA12534@lst.de>
References: <20181130132231.16512-1-hch@lst.de> <20181130132231.16512-2-hch@lst.de> <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653ca801-63a1-3c19-ee09-ade19fa2bbb8@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20181204223355.v7YmZNTfrvIocXiYphpbpd1njhTQxQGPYSXU5yHMtyw@z>

On Tue, Dec 04, 2018 at 04:41:34PM +0000, Robin Murphy wrote:
> I'd have been inclined to put the default check here, i.e.
>
> -	return 0
> +	return dma_addr == DMA_MAPPING_ERROR
>
> such that the callback retains full precedence and we don't have to deal 
> with the non-trivial removals immediately if it comes to it. Not that it 
> makes a vast difference though, so either way,

Ok, I've switched it around.
