Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbeKNSZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 13:25:51 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: use generic DMA mapping code in powerpc V4
Date: Wed, 14 Nov 2018 09:22:40 +0100
Message-ID: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181114082240.oEfX8oPSeirmwWQxL-UGUmapfMAT3FNt_AbpwgVrQPE@z>

Hi all,

this series switches the powerpc port to use the generic swiotlb and
noncoherent dma ops, and to use more generic code for the coherent
direct mapping, as well as removing a lot of dead code.

As this series is very large and depends on the dma-mapping tree I've
also published a git tree:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.4

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4

Changes since v3:
 - rebase on the powerpc fixes tree
 - add a new patch to actually make the baseline amigaone config
   configure without warnings
 - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
   always present
 - fix compile in mem.c for one configuration
 - drop the full npu removal for now, will be resent separately
 - a few git bisection fixes

The changes since v1 are to big to list and v2 was not posted in public.
