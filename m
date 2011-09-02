From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH/RFC 0/8 v2] ARM: DMA-mapping framework redesign
Date: Fri, 02 Sep 2011 15:53:12 +0200
Message-ID: <1314971599-14428-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:53507 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1IBNx1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2011 09:53:27 -0400
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LQW006Y4EL0LC20@mailout3.w1.samsung.com> for
 linux-arch@vger.kernel.org; Fri, 02 Sep 2011 14:53:24 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LQW00JA6EL0J9@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Fri, 02 Sep 2011 14:53:24 +0100 (BST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>

Hello,

This is a snapshot of my work-in-progress on DMA-mapping framework
redesign. All these works are a preparation for adding support for IOMMU
controllers.

DMA-mapping patches have been rebased onto Linux v3.1-rc4 kernel, what
required resolving a bunch of confilcts in the code. The patches have
been heavily tested and all bugs found in the initial version have been
fixed.

Here is the link to the initial version of the DMA-mapping redesign patches:
http://www.spinics.net/lists/linux-mm/msg21241.html

TODO: 
- merge the patches with CMA patches and respective changes in
  DMA-mapping framework
- start the discussion about chaning alloc_coherent into alloc_attrs in
dma_map_ops structure.

The proof-of-concept IOMMU mapper for DMA-mapping will follow. In next 2
weeks I will be on holidays, so I decided not to delay these patch
anymore longer.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (7):
  ARM: dma-mapping: remove offset parameter to prepare for generic
    dma_ops
  ARM: dma-mapping: use asm-generic/dma-mapping-common.h
  ARM: dma-mapping: implement dma sg methods on top of any generic dma
    ops
  ARM: dma-mapping: move all dma bounce code to separate dma ops
    structure
  ARM: dma-mapping: remove redundant code and cleanup
  common: dma-mapping: change alloc/free_coherent method to more
    generic alloc/free_attrs
  ARM: dma-mapping: use alloc, mmap, free from dma_ops

 arch/arm/Kconfig                   |    1 +
 arch/arm/common/dmabounce.c        |   78 ++++++--
 arch/arm/include/asm/device.h      |    1 +
 arch/arm/include/asm/dma-mapping.h |  401 ++++++++++--------------------------
 arch/arm/mm/dma-mapping.c          |  269 +++++++++++++-----------
 include/linux/dma-attrs.h          |    1 +
 include/linux/dma-mapping.h        |   13 +-
 7 files changed, 325 insertions(+), 439 deletions(-)

-- 
1.7.1.569.g6f426
