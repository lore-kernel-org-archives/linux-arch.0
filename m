Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:8355 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266512AbUFVB2F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Jun 2004 21:28:05 -0400
Subject: Extension to the DMA API for on chip memory
From: James Bottomley <James.Bottomley@SteelEye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 21 Jun 2004 20:28:03 -0500
Message-Id: <1087867684.1797.128.camel@mulgrave>
Mime-Version: 1.0
To: linux-arch@vger.kernel.org
Cc: greg@kroah.com
List-ID: <linux-arch.vger.kernel.org>

Well, I thought about it some more and I think I can come up with an API
that will give the ARM people everything they want and still be
generally useful to every other architecture.  I thought I'd let you all
rip it apart first before getting people's hopes up on lkml.

The new API would be

int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
dma_addr_t device_addr, int flags)

This API basically declares a region of memory to be handed out by
dma_alloc_coherent when it's asked for coherent memory for this device.

bus_addr is the physical address to which the memory is currently
assigned in the bus responding region

device_addr is the physical address the device needs to be programmed
with actually to address this memory.

The flags is where all the magic is.  They can be or'd together and are

DMA_MEMORY_MAP - request that the memory returned from
dma_alloc_coherent() be directly writeable.

DMA_MEMORY_IO - request that the memory returned from
dma_alloc_coherent() be addressable using read/write/memcpy_toio etc.

One or both of these flags must be present

DMA_MEMORY_INCLUDES_CHILDREN - make the declared memory be allocated by
dma_alloc_coherent of any child devices of this one (for memory residing
on a bridge).

DMA_MEMORY_EXCLUSIVE - only allocate memory from the declared regions. 
Do not allow dma_alloc_coherent() to fall back to system memory when
it's out of memory in the declared region.

The return value would be either DMA_MEMORY_MAP or DMA_MEMORY_IO and
must correspond to a passed in flag (i.e. no returning DMA_MEMORY_IO if
only DMA_MEMORY_MAP were passed in) or zero for failure.

I think also, it's reasonable only to have a single declared region per
device.

Implementation details

Obviously, the big change is that dma_alloc_coherent() may now be
handing out memory that can't be directly written to (in the case of a
DMA_MEMORY_IO return).

I envisage implementing an internal per device resource allocator in
drivers/base into which each platform allocator can plug do do the heavy
allocation lifting (they'd still get to do the platform magic to make
the returned region visible as memory if necessary).

The API would be platform optional, with platforms not wishing to
implement it simply hard coding a return 0.

If it stands the linux-arch test, I'll look at doing reference
implementations for x86 and parisc.

So let the shredding begin...

James
