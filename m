From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: [PATCH v1 2/2] dma-mapping-common: add DMA attribute - DMA_ATTR_IOMMU_BYPASS
Date: Sun, 25 Oct 2015 09:07:04 -0700
Message-ID: <1445789224-28032-2-git-send-email-shamir.rabinovitch@oracle.com>
References: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:16611 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbJYQHS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 25 Oct 2015 12:07:18 -0400
In-Reply-To: <1445789224-28032-1-git-send-email-shamir.rabinovitch@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org

For systems with IOMMU it is assumed all DMA translations use the IOMMU.
There are, however, cases when IOMMU might map only limited range of the
memory or when the cost of setting IOMMU dma mapping is too big. For those
cases, this flag can be used to request the DMA-mapping subsystem to bypass
the IOMMU if applicable.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 Documentation/DMA-attributes.txt |    9 +++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 18dc52c..1174afc 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -100,3 +100,12 @@ allocated by dma_alloc_attrs() function from individual pages if it can
 be mapped as contiguous chunk into device dma address space. By
 specifying this attribute the allocated buffer is forced to be contiguous
 also in physical memory.
+
+DMA_ATTR_IOMMU_BYPASS
+---------------------
+
+For systems with IOMMU it is assumed all DMA translations use the IOMMU.
+There are, however, cases when IOMMU might map only limited range of the
+memory or when the cost of setting IOMMU dma mapping is too big. For those
+cases, this flag can be used to request the DMA-mapping subsystem to bypass
+the IOMMU if applicable.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index c8e1831..7c78691 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -18,6 +18,7 @@ enum dma_attr {
 	DMA_ATTR_NO_KERNEL_MAPPING,
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
+	DMA_ATTR_IOMMU_BYPASS,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.1
