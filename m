Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:35258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262248AbUCAFrx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 00:47:53 -0500
Date: Sun, 29 Feb 2004 21:47:50 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: dma_mask semantic problems
Message-Id: <20040229214750.74c4ce36.davem@redhat.com>
In-Reply-To: <1078101455.10826.87.camel@gaston>
References: <1078101455.10826.87.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 01 Mar 2004 11:37:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

>  - dma_set_dma_mask : Get passed the mask of supported addresses the
> driven HW supports (that is output of dma_map_*). Failure means the
> arch cannot address those restrictions (doesn't provide a zoned
> allocator on non-iommu archs for addressing such a zone or the iommu
> code cannot enforce such a restriction).

OK, I'm fine with this of course.

>  - either the above is modified to _return_ the modified mask (as
> described in step 2) or we add a separate function
> dma_adjust_dma_mask(mask *). This is where the arch will actually
> provide a mask that tells the driver what kind of addresses will
> be supported on _input_ of dma_map_*. This is usually to be passed
> upstream to control bouncing etc... For example, an iommu arch would
> usually return the full 64 bits in there to indicate that any
> memory page can be mapped for DMA.

Hmmm, Ok I guess.

>  - dma_get_arch_limit() (or find a better name) is a _hinting_
> function that returns what kind of addresses will be produced by
> dma_map_* for this device. It can be used by a driver like some
> SCSI ones to disabled 64 bits addressing and thus win more queue
> space on iommu archs that will never generate a more than 32
> (or even 31) bits address.

This needs work.  What we want to say for what SCSI is doing is:

1) A way to say "I can map all of physical space into the 32-bit
   PCI BUS DMA addressing space, ie. iommu platform.

2) A way to say "I can map all of physical space using 64-bit
   addressing too"

I think the first thing is a seperate question.  Purely, the IOMMU exists
precisely to serve this purpose, map physical memory space (however large
bitness wise it is) into the 32-bit SAC PCI address space.

I would go so far as to propose a:

	int dma_can_use_iommu(dev);
	u64 dma_iommu_mask(dev);

so scsi could say:

	if (dma_can_use_iommu(dev) &&
            !(dma_iommu_mask(dev) & ~(u64)0xffffffff)) {
		/* do the 32-bit space saving trick... */
		dma_set_blah_mask(0xffffffff);
		... etc. ...
	}

Sound ok?
