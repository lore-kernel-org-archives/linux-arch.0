Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:6591 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262195AbUCAArX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 29 Feb 2004 19:47:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i210dfUn024589
	for <linux-arch@vger.kernel.org>; Sun, 29 Feb 2004 18:39:43 -0600
Subject: dma_mask semantic problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1078101455.10826.87.camel@gaston>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 11:37:36 +1100
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi !

Time to bring out another one... 

There is, I think, a problem with the exact semantics of *_set_dma_mask,
and the way it's used (especially the result code) in various drivers.

It's mixing a lot of different things that are unrelated, and the whole
stuff only works by luck imho on some archs.

So here are the different kind of "informations" that are beeing
exchanged between the driver and the arch:

 - The mask that gets actually passed by the driver to *_set_dma_mask.
This mask indicates what the HW support as addresses to DMA to. That
means this is an indication of what is supported as an _output_ of
pci_map_* (or dma_map_*).

 - On archs without an iommu, that is also putting a constraint on the
_input_ of pci/dma_map_* though. Of course, nothing in the kernel does
properly the differenciation between those. There are various
assumptions, like network drivers assuming a failing result code when
passsing a 64 bits mask means no HIGHDMA, which is only half-related
(and arch specific assumption in the driver).
On arch with an iommu, the constraint is only on the iommu's own virtual
space allocator, which may or may not be able to address "zoned"
allocations...
What I think we need here is the arch to pass back up the mask of
addresses it can get on input of pci_map_* to address the driver
requirements. Typically, a non-iommu platform would just pass back
the driver's mask (eventually cropped if the arch has additional
restrictions on useable DMA addresses). Then the driver can use
that mask to either pass up to the BIO / network driver to control
allocation/bouncing of buffers, or it's own allocation scheme for
drivers not under control of an upper layer.

 - Finally, some SCSI drivers are "using" the result code of
pci_set_dma_mask() in a weird way. They assume that a failing
set_dma_mask for a 64 bits mask means they won't ever get 64 bits
addresses, and uses that as an indication so they can "optimize" the
HW to not have to use 64 bits addressing, thus in some cases, increasing
the max possible request queue depth. Because of that, some archs with
an iommu play the trick of failing 64 bits mask passed to set_dma_mask,
which doesn't make sense imho. The driver passes the mask of addresses
the HW supports. If the arch always generate addresses that do fit in
that mask (and 32 bits addresses _do_ fit in a 64 bits mask), then the
function should not fail. What we need here is completely different,
we need to pass back _up_ to the driver the mask of addresses we'll
actually generate so it can use that as a "hint" for its optimisations.

So, resuming it, I think we need to differenciate those 3 things:

 - dma_set_dma_mask : Get passed the mask of supported addresses the
driven HW supports (that is output of dma_map_*). Failure means the
arch cannot address those restrictions (doesn't provide a zoned
allocator on non-iommu archs for addressing such a zone or the iommu
code cannot enforce such a restriction).

 - either the above is modified to _return_ the modified mask (as
described in step 2) or we add a separate function
dma_adjust_dma_mask(mask *). This is where the arch will actually
provide a mask that tells the driver what kind of addresses will
be supported on _input_ of dma_map_*. This is usually to be passed
upstream to control bouncing etc... For example, an iommu arch would
usually return the full 64 bits in there to indicate that any
memory page can be mapped for DMA.

 - dma_get_arch_limit() (or find a better name) is a _hinting_
function that returns what kind of addresses will be produced by
dma_map_* for this device. It can be used by a driver like some
SCSI ones to disabled 64 bits addressing and thus win more queue
space on iommu archs that will never generate a more than 32
(or even 31) bits address.


Any comments ? Better ideas ?

The current stuff is wrong in some cases, it happens to work
because both archs and drivers are cheating... It gets even worse
when DAC gets into the picture...

Ben.
 
