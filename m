Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:36287 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262251AbUCAGBe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 01:01:34 -0500
Subject: Re: dma_mask semantic problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040229214750.74c4ce36.davem@redhat.com>
References: <1078101455.10826.87.camel@gaston>
	 <20040229214750.74c4ce36.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1078120287.21575.12.camel@gaston>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 16:51:28 +1100
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2004-03-01 at 16:47, David S. Miller wrote:

> 1) A way to say "I can map all of physical space into the 32-bit
>    PCI BUS DMA addressing space, ie. iommu platform.
> 
> 2) A way to say "I can map all of physical space using 64-bit
>    addressing too"
> 
> I think the first thing is a seperate question.  Purely, the IOMMU exists
> precisely to serve this purpose, map physical memory space (however large
> bitness wise it is) into the 32-bit SAC PCI address space.
> 
> I would go so far as to propose a:
> 
> 	int dma_can_use_iommu(dev);
> 	u64 dma_iommu_mask(dev);

What about 32 bits archs without iommu ?

> so scsi could say:
> 
> 	if (dma_can_use_iommu(dev) &&
>             !(dma_iommu_mask(dev) & ~(u64)0xffffffff)) {
> 		/* do the 32-bit space saving trick... */
> 		dma_set_blah_mask(0xffffffff);
> 		... etc. ...
> 	}
> 
> Sound ok?

Except for 32 bits archs without iommu ...

Well... Assuming we fix that, then what if we can do both 64 bit
addresses and 32 bits addresses, who decides what to use ? like we
support DAC. Who decides wether to use it or not ?

If it's the pci_map_* code that will either go through the iommu or
not, on what bases does it make that decision ?

Once the above example you pasted did return that we can indeed get
only 32 bits addresses, we do a dma_set_dma_mask(32bits) to force
pci_map_sg() to only return us addresses in the low 32 bits mask,
that's fine, just make it clear that this dma_set_blah_mask is
actually the real & good old dma/pci_set_dma_mask()...

Ben.
