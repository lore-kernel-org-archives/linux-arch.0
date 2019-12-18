From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from low memory
Date: Wed, 18 Dec 2019 15:05:09 +1100 (AEDT)
Message-ID: <47d1cj4B0Fz9sRc@ozlabs.org>
References: <20191204123524.22919-1-rppt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204123524.22919-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>, mad skateman <madskateman@gmail.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
List-Id: linux-arch.vger.kernel.org

On Wed, 2019-12-04 at 12:35:24 UTC, Mike Rapoport wrote:
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

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8fabc623238e68b3ac63c0dd1657bf86c1fa33af

cheers
