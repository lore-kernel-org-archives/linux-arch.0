Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:16255 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759903Ab2BJTKc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Feb 2012 14:10:32 -0500
Date: Fri, 10 Feb 2012 19:58:37 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv6 0/7] ARM: DMA-mapping framework redesign
Message-ID: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20120210185837.0sVL8LWED5-T8wneavLm3lNp70J_PdthrT7OZ8ZSbaU@z>

Hello,

This is another update on my works DMA-mapping framework redesign for
ARM architecture. It includes a few minor cleanup and fixes since the
last version posted by the end of December 2011. This patch series is
now based on the generic, cross-arch dma-mapping redesign patches posted
in the "[PATCH 00/14] DMA-mapping framework redesign preparation"
thread: http://www.spinics.net/lists/linux-sh/msg09777.html

All patches have been now rebased onto v3.3-rc2 kernel.

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
  ARM: dma-mapping: use alloc, mmap, free from dma_ops
  ARM: dma-mapping: add support for IOMMU mapper

 arch/arm/Kconfig                   |    9 +
 arch/arm/common/dmabounce.c        |   78 +++-
 arch/arm/include/asm/device.h      |    4 +
 arch/arm/include/asm/dma-iommu.h   |   34 ++
 arch/arm/include/asm/dma-mapping.h |  404 +++++------------
 arch/arm/mm/dma-mapping.c          |  897 ++++++++++++++++++++++++++++++------
 arch/arm/mm/vmregion.h             |    2 +-
 7 files changed, 980 insertions(+), 448 deletions(-)
 create mode 100644 arch/arm/include/asm/dma-iommu.h

-- 
1.7.1.569.g6f426

