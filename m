From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH/RFC] ARM: Exynos4: Integrate IOMMU aware DMA-mapping
Date: Wed, 11 Apr 2012 16:36:43 +0200
Message-ID: <1334155004-5700-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55780 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab2DKOgx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Apr 2012 10:36:53 -0400
Received: from euspt2 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M2B00HLIKLCGS@mailout2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 11 Apr 2012 15:36:48 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M2B008I9KLDFD@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Wed, 11 Apr 2012 15:36:50 +0100 (BST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>

Hi!

This is an example of the IOMMU aware DMA-mapping implementation usage
on a Samsung Exynos4 based NURI board. The ARM DMA-mapping IOMMU aware
implementation is available in the [1] thread: 

This patch essentially registers DMA-mmaping/IOMMU support for FIMC and
MFC devices and performs some tweaks in clocks hierarchy to get SYSMMU
driver working correctly.

The drivers have been tested with mainline V4L2 drivers for FIMC and MFC
hardware.

For easier testing I've created a separate kernel branch with all
required prerequisite patches. It is based on lastest kgene/for-next
branch and is available on my git repository:

git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git 3.4-rc2-arm-dma-v8-samsung

This patch requires the following items:
1. ARM DMA-mapping patches [1]
2. Exynos SYSMMU driver v12 [2]
3. Exynos SYSMMU driver runtime pm fixes
4. Exynos4 gen_pd power domain driver fixes

Runtime pm and power domain patches are required on Samsung Nuri board,
but might be optional on boards where bootloader doesn't disable all
devices on boot.

[1] http://www.spinics.net/lists/linux-arch/msg17331.html
[2] https://lkml.org/lkml/2012/3/15/51

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Marek Szyprowski (1):
  ARM: Exynos4: integrate SYSMMU driver with DMA-mapping interface

 arch/arm/mach-exynos/Kconfig               |    1 +
 arch/arm/mach-exynos/clock-exynos4.c       |   64 +++++++++++++++-------------
 arch/arm/mach-exynos/dev-sysmmu.c          |   44 +++++++++++++++++++
 arch/arm/mach-exynos/include/mach/sysmmu.h |    3 +
 drivers/iommu/Kconfig                      |    1 +
 5 files changed, 84 insertions(+), 29 deletions(-)

-- 
1.7.1.569.g6f426
