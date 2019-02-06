From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 6 Feb 2019 16:15:05 +0100
Message-ID: <20190206151505.GA31065@lst.de>
References: <20190129163415.GA14529@lst.de> <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de> <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de> <20190201080456.GA15456@lst.de> <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 06, 2019 at 02:45:34PM +0100, Christian Zigotzky wrote:
> I patched the source code from the Git 'powerpc-dma.6' with your patch 
> today. Unfortunately the P.A. Semi Ethernet doesn't work with the patched 
> Git kernel.
>
> After that I tried it with the patch applied over the working setup again 
> (powerpc/dma: use the dma_direct mapping routines). Unfortunately after 
> compiling
> and booting, the P.A. Semi Ethernet doesn't work either.

The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
remember correctly.  powerpc/dma: use the dma_direct mapping routines
was the one that you said makes the pasemi ethernet stop working.

Can you post the dmesg from the failing runs?
