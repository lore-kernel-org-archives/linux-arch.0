Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20974 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481Ab2CWM0M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Mar 2012 08:26:12 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Date: Fri, 23 Mar 2012 13:26:01 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] ARM: dma-mapping: Fix mmap support for coherent buffers
In-reply-to: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
Message-ID: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120323122601.EbfLCxpTNMb35D6MHnGom_1F6v3HshKCj9ebSGXsD1Q@z>

Hello,

This patchset contains patches to fix broken mmap operation for memory
buffers allocated from 'dma_declare_coherent' pool after applying my dma
mapping redesign patches [1]. These issues have been reported by Subash
Patel.

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/12819 

Patch summary:

Marek Szyprowski (2):
  common: add dma_mmap_from_coherent() function
  arm: dma-mapping: use dma_mmap_from_coherent()

 arch/arm/mm/dma-mapping.c          |    3 ++
 drivers/base/dma-coherent.c        |   42 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/dma-coherent.h |    4 ++-
 3 files changed, 48 insertions(+), 1 deletions(-)

-- 
1.7.1.569.g6f426

