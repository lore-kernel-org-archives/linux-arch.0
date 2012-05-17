From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv10 02/11] ARM: dma-mapping: use dma_mmap_from_coherent()
Date: Thu, 17 May 2012 15:13:52 +0200
Message-ID: <1337260441-8121-3-git-send-email-m.szyprowski@samsung.com>
References: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14282 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645Ab2EQNQB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 09:16:01 -0400
Received: from euspt2 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M4600JVW4R1EW@mailout1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 17 May 2012 14:13:49 +0100 (BST)
Received: from ubuntu.arm.acom ([106.210.236.191])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M46005864TPC2@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Thu, 17 May 2012 14:15:57 +0100 (BST)
In-reply-to: <1337260441-8121-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..7ec0863 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -401,6 +401,9 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long user_size, kern_size;
 	struct arm_vmregion *c;
 
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
 	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
 	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
-- 
1.7.10.1
