From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 5/5] openrisc: use the generic in-place uncached DMA
 allocator
Date: Tue, 25 Feb 2020 19:09:42 +0900
Message-ID: <20200225100942.GB7926@lianli.shorne-pla.net>
References: <20200224194446.690816-1-hch@lst.de>
 <20200224194446.690816-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38167 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbgBYKJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 05:09:47 -0500
Content-Disposition: inline
In-Reply-To: <20200224194446.690816-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, openrisc@lists.librecores.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:44:45AM -0800, Christoph Hellwig wrote:
> Switch openrisc to use the dma-direct allocator and just provide the
> hooks for setting memory uncached or cached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stafford Horne <shorne@gmail.com>

I also test booted this series with linux 5.5 on my OpenRISC target.  There are
no issues.  Note, I had an issue with patch 3/5 not cleanly applying with 'git am'
but it worked fine using just patch, I didn't get any other details.

-Stafford
