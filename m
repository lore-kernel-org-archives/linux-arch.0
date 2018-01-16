Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46014 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeAPI23 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jan 2018 03:28:29 -0500
Date: Tue, 16 Jan 2018 09:28:27 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: consolidate swiotlb dma_map implementations
Message-ID: <20180116082827.GA9211@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180116075338.GB12693@infradead.org> <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: christian.koenig@amd.com
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180116082827.PgQt7aoIuwPg4zY18uF_gnxRgkqITH2jvzCkREz0Tu8@z>

On Tue, Jan 16, 2018 at 09:22:52AM +0100, Christian König wrote:
> Hi Konrad,
>
> can you send the first patch to Linus for inclusion in 4.15 if you haven't 
> already done so?

It's in the 4.16 queue with a cc to stable.  I guess we're ok with
a duplicate commit if we have to.
