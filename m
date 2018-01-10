Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47652 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933196AbeAJPfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jan 2018 10:35:19 -0500
Date: Wed, 10 Jan 2018 16:35:17 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/22] swiotlb: wire up ->dma_supported in
        swiotlb_dma_ops
Message-ID: <20180110153517.GF17790@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-9-hch@lst.de> <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180110153517.pA6dDOV6l1YVSoh81OqMo2VxCM5_9ESd337LdGsdnEc@z>

On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
> On 10/01/18 08:09, Christoph Hellwig wrote:
>> To properly reject too small DMA masks based on the addressability of the
>> bounce buffer.
>
> I reckon this is self-evident enough that it should simply be squashed into 
> the previous patch.

x86 didn't wire it up before, so I want a clear blaimpoint for this
change instead of mixing it up.
