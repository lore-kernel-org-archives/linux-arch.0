From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv7 0/9] ARM: DMA-mapping framework redesign
Date: Wed, 29 Feb 2012 16:04:13 +0100
Message-ID: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65123 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031080Ab2B2PEr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 10:04:47 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Hello,

This is yet another update on my works DMA-mapping framework redesign
for ARM architecture. It includes a few minor cleanup and fixes reported
by Konrad Rzeszutek Wilk and Krishna Reddy.

This version uses vmalloc for allocating page pointers array if it is
larger than PAGE_SIZE. The chained allocation which fits inside a set of
PAGE_SIZE units will be added later, once the base patches are merged.

Like the previous version, this patchset is also based on the generic,
cross-arch dma-mapping redesign patches posted in the "[PATCH 00/14]
DMA-mapping framework redesign preparation" thread:
http://www.spinics.net/lists/linux-sh/msg09777.html

All patches have been now rebased onto v3.3-rc5 kernel.

All the code has been tested on Samsung Exynos4 'UniversalC210' board
with IOMMU driver posted by KyongHo Cho.


History of the development:

v1: (initial version of the DMA-mapping redesign patches):
http://www.spinics.net/lists/linux-mm/msg21241.html

v2:
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000571.html
http://lists.linaro.org/pipermail/linaro-mm-sig/2011-September/000577.html

v3:
http://www.spinics.net/lists/linux-mm/msg25490.html

v4 and v5:
http://www.spinics.net/lists/arm-kernel/msg151147.html
http://www.spinics.net/lists/arm-kernel/msg154889.html

v6:
http://www.spinics.net/lists/linux-mm/msg29903.html

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (9):
  ARM: dma-mapping: introduce ARM_DMA_ERROR constant
  ARM: dma-mapping: use pr_* instread of printk
  ARM: dma-mapping: remove offset parameter to prepare for generic
    dma_ops
  ARM: dma-mapping: use asm-generic/dma-mapping-common.h
  ARM: dma-mapping: implement dma sg methods on top of any generic dma
    ops
  ARM: dma-mapping: move all dma bounce code to separate dma ops
    structure
  ARM: dma-mapping: remove redundant code and cleanup
  ARM: dma-mapping: use alloc, mmap, free from dma_ops
  ARM: dma-mapping: add support for IOMMU mapper

 arch/arm/Kconfig                   |    9 +
 arch/arm/common/dmabounce.c        |   84 +++-
 arch/arm/include/asm/device.h      |    4 +
 arch/arm/include/asm/dma-iommu.h   |   34 ++
 arch/arm/include/asm/dma-mapping.h |  407 ++++-----------
 arch/arm/mm/dma-mapping.c          | 1013 ++++++++++++++++++++++++++++++------
 arch/arm/mm/vmregion.h             |    2 +-
 7 files changed, 1088 insertions(+), 465 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
1.7.1.569.g6f426
