From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] remove the ->mapping_error method from dma_map_ops
Date: Mon, 19 Nov 2018 14:55:00 +0100
Message-ID: <20181119135459.GB16334@lst.de>
References: <20181109084632.22848-1-hch@lst.de> <20181109.151234.2231390463846593374.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109.151234.2231390463846593374.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: hch@lst.de, iommu@lists.linux-foundation.org, torvalds@linux-foundation.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 09, 2018 at 03:12:34PM -0800, David Miller wrote:
> But patch #2 on the other hand, not so much.
> 
> I hate seeing values returned by reference, it adds cost especially
> on cpus where all argments and return values fit in registers (we end
> up forcing a stack slot and memory references).
> 
> And we don't need it here.
> 
> DMA addresses are like pointers, and therefore we can return errors and
> valid success values in the same dma_addr_t just fine.  PTR_ERR() --> DMA_ERR(),
> IS_PTR_ERR() --> IS_DMA_ERR, etc.

In the end this is an inline function, so with a decently smart
compiler the generated code shouldn't change too much.  The big problem
that prompted me to come up with this patch is that not handling failure
from dma_map* in a swiotlb setup can lead to grave data corruption, and
we have no easy way to force error checking on these return values.

I've added a few of the static typechecking suspect if they have a
better idea on how to make the return value of dma_map_single/pages
in a way that we get warnings if dma_mapping_error isn't called on them.
But I can't really think of a good way.
