Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56131 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbeGaJnl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Jul 2018 05:43:41 -0400
Date: Tue, 31 Jul 2018 10:08:57 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/4] ARC: don't check for HIGHMEM pages in
        arch_dma_alloc
Message-ID: <20180731080857.GB23303@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Message-ID: <20180731080857.GZ3gZuyRJZrCqqDIQgDAaSaqJQNsGgUrSXnSZf6d1_w@z>

On Mon, Jul 30, 2018 at 07:26:36PM +0300, Eugeniy Paltsev wrote:
> __GFP_HIGHMEM flag is cleared by upper layer functions
> (in include/linux/dma-mapping.h) so we'll never get a
> __GFP_HIGHMEM flag in arch_dma_alloc gfp argument.
> That's why alloc_pages will never return highmem page
> here.
> 
> Get rid of highmem pages handling and cleanup arch_dma_alloc
> and arch_dma_free functions.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
