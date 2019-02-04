Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47312 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfBDH4S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Feb 2019 02:56:18 -0500
Date: Mon, 4 Feb 2019 08:56:16 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190204075616.GA5408@lst.de>
References: <20190128162256.GA11737@lst.de> <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de> <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de> <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de> <20190201080456.GA15456@lst.de> <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190204075616.rBwsPqWb_jiUkqUB3CuAx8taZwvygQ_VNhYFfVJYhHk@z>

On Sun, Feb 03, 2019 at 05:49:02PM +0100, Christian Zigotzky wrote:
> OK, next step: b50f42f0fe12965ead395c76bcb6a14f00cdf65b (powerpc/dma: use 
> the dma_direct mapping routines)
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> git checkout b50f42f0fe12965ead395c76bcb6a14f00cdf65b
>
> Results: The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet 
> doesn't work.

Are there any interesting messages in the boot log?  Can you send me
the dmesg?
