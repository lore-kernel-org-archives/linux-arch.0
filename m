From: Christoph Hellwig <hch@lst.de>
Subject: [RFC] remove the ->mapping_error method from dma_map_ops
Date: Fri,  9 Nov 2018 09:46:30 +0100
Message-ID: <20181109084632.22848-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Error reporting for the dma_map_single and dma_map_page operations is
currently a mess.  Both APIs directly return the dma_addr_t to be used for
the DMA, with a magic error escape that is specific to the instance and
checked by another method provided.  This has a few downsides:

 - the error check is easily forgotten and a __must_check marker doesn't
   help as the value always is consumed anyway
 - the error checking requires another indirect call, which have gotten
   incredibly expensive
 - a lot of code is wasted on implementing these methods

The historical reason for this is that people thought DMA mappings would
not fail when the API was created, which sounds like a really bad
assumption in retrospective, and then we tried to cram error handling
onto it later on.

There basically are two variants:  the error code is 0 because the
implementation will never return 0 as a valid DMA address, or the error
code is all-F as the implementation won't ever return an address that
high.  The old AMD GART is the only one not falling into these two camps
as it picks sort of a relative zero relative to where it is mapped.

The 0 return doesn't work for a lot of IOMMUs that start allocating
bus space from address zero, so we can't consolidate on that, but I think
we can move everyone to all-Fs, which the patch here does.  The reason
for that is that there is only one way to ever get this address: by
doing a 1-byte long, 1-byte aligned mapping, but all our mappings
are not only longer but generally aligned, and the mappings have to
keep at least the basic alignment.  Please try to poke holes into this
idea as it would simplify our logic a lot, and also allow to change
at least the not so commonly used yet dma_map_single_attrs and
dma_map_page_attrs to actually return an error code and further improve
the error handling flow in the drivers.
