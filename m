Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57711 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPHxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 02:53:40 -0500
Date: Mon, 15 Jan 2018 23:53:38 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: consolidate swiotlb dma_map implementations
Message-ID: <20180116075338.GB12693@infradead.org>
References: <20180110080932.14157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180116075338.RZ-dKxecCFnBy9Msx_sN51fz1U-zNIDFNSUz2DPaz_c@z>

I've pulled this into the dma-mapping for-next tree, including the
missing free_pages noted.  I'd be fine to rebase another day or two
for additional reviews or important fixes.
