Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:38097 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262258AbUCAGeR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 01:34:17 -0500
Date: Sun, 29 Feb 2004 22:34:12 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: dma_mask semantic problems
Message-Id: <20040229223412.493e3f32.davem@redhat.com>
In-Reply-To: <1078120287.21575.12.camel@gaston>
References: <1078101455.10826.87.camel@gaston>
	<20040229214750.74c4ce36.davem@redhat.com>
	<1078120287.21575.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 01 Mar 2004 16:51:28 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > I would go so far as to propose a:
> > 
> > 	int dma_can_use_iommu(dev);
> > 	u64 dma_iommu_mask(dev);
> 
> What about 32 bits archs without iommu ?

They do not return true for the first function, which means
the second function may not be called.

> Well... Assuming we fix that, then what if we can do both 64 bit
> addresses and 32 bits addresses, who decides what to use ? like we
> support DAC. Who decides wether to use it or not ?

Good question.

Long ago we decided that the way we handle this on sparc64 is to
only support 32-bit stuff via the dma interfaces, you have to use
the explicit pci_dac_*() stuff to get at the 64-bit addresses and
these interfaces are extremely frowned upon except in very specific
kinds of drivers.  See the section entitled "DAC Addressing for
Address Space Hungry Devices".

So on sparc64 we define dma_addr_t as a u32.  We want to use the
IOMMU for everything normal because unless you use the IOMMU you
don't get the PCI controller DMA cache usage (which does prefetching
for reads and coalescing for writes to encourage cacheline sized
transactions on the system bus).

On the other side in SCSI we are talking about a driver specific
issue in terms of performance.  Basically what they want to know,
in our terms, is: "If 32-bit vs 64-bit DMA address spacing has
roughly the same performance, and gets access to the whole range
of physical memory, let me use 32-bit."

Maybe that more precise question leads more directly to a more useful
dma_*() interface name and semantics? :-)

You're right, my original suggestion does not handle this properly.
