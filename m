Return-Path: <hch@lst.de>
Date: Wed, 4 Dec 2019 14:56:32 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from
 low memory
Message-ID: <20191204135632.GA31262@lst.de>
References: <20191204123524.22919-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christoph Hellwig <hch@lst.de>, Darren Stevens <darren@stevens-zone.net>, mad skateman <madskateman@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Paul Mackerras <paulus@samba.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191204135632.U2I8bDW5Ye8CwNFtZLcL7fhP2-JVo3BfEScPJMoKhic@z>

On Wed, Dec 04, 2019 at 02:35:24PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
> 
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
> 
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
