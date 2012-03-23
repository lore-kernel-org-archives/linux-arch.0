Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20974 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758491Ab2CWM0N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Mar 2012 08:26:13 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Date: Fri, 23 Mar 2012 13:26:03 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] arm: dma-mapping: use dma_mmap_from_coherent()
In-reply-to: <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1332505563-17646-3-git-send-email-m.szyprowski@samsung.com>
References: <08af01cd08ee$2fd04770$8f70d650$%szyprowski@samsung.com>
 <1332505563-17646-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120323122603.th_afwcdXVf8XDDnaVe2ljP7HZ3497v3gM1P9Vz9eRI@z>

Use dma_mmap_from_coherent() to fix broken mapping of the coherent buffers
to userspace.

Reported-by: Subash Patel <subashrp@gmail.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6c24218..0cee054 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -511,6 +511,9 @@ int arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 			    pgprot_writecombine(vma->vm_page_prot) :
 			    pgprot_dmacoherent(vma->vm_page_prot);
 
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
 	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
 	if (c) {
 		unsigned long off = vma->vm_pgoff;
-- 
1.7.1.569.g6f426

