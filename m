Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeLAAc3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Nov 2018 19:32:29 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: remove the ->mapping_error method from dma_map_ops V3
Date: Fri, 30 Nov 2018 14:22:08 +0100
Message-ID: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181130132208.Q5nfE4r5SmFwEqpeB1hGygSYY1TOT_yxIw10EtkiMrY@z>

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

The 0 return doesn't work for direct mappings that have ram at address
zero and a lot of IOMMUs that start allocating bus space from address
zero, so we can't consolidate on that, but I think we can move everyone
to all-Fs, which the patch here does.  The reason for that is that
there is only one way to ever get this address: by doing a 1-byte long,
1-byte aligned mapping, but all our mappings are not only longer but
generally aligned, and the mappings have to keep at least the basic
alignment.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git dma-mapping-error.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mapping-error.3

Changes since v2:
 - fix a compile error in the ia64 sba_iommu driver
 - return an errno value from dma_mapping_error

Changes since v1:
 - dropped the signature change
 - split into multiple patches
 - fixed the iova allocator return check in amd-iommu
 - remove EMERGENCY_PAGES in amd_gart and calgary
