From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method to
 more generic alloc/free_attrs
Date: Mon, 20 Jun 2011 09:50:12 +0200
Message-ID: <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41112 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531Ab1FTHug (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 03:50:36 -0400
Received: from spt2.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LN2009F9WGACE@mailout1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 20 Jun 2011 08:50:34 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LN2005SKWG9O3@spt2.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 20 Jun 2011 08:50:34 +0100 (BST)
In-reply-to: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Introduce new alloc/free/mmap methods that take attributes argument.
alloc/free_coherent can be implemented on top of the new alloc/free
calls with NULL attributes. dma_alloc_non_coherent can be implemented
using DMA_ATTR_NONCOHERENT attribute, dma_alloc_writecombine can also
use separate DMA_ATTR_WRITECOMBINE attribute. This way the drivers will
get more generic, platform independent way of allocating dma memory
buffers with specific parameters.

One more attribute can be usefull: DMA_ATTR_NOKERNELVADDR. Buffers with
such attribute will not have valid kernel virtual address. They might be
usefull for drivers that only exports the DMA buffers to userspace (like
for example V4L2 or ALSA).

mmap method is introduced to let the drivers create a user space mapping
for a DMA buffer in generic, architecture independent way.

TODO: update all dma_map_ops clients for all architectures

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/dma-mapping.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ba8319a..08a6fa8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -16,10 +16,15 @@ enum dma_data_direction {
 };
 
 struct dma_map_ops {
-	void* (*alloc_coherent)(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, gfp_t gfp);
-	void (*free_coherent)(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t dma_handle);
+	void* (*alloc)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp,
+				struct dma_attrs *attrs);
+	void (*free)(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle,
+			      struct dma_attrs *attrs);
+	int (*mmap)(struct device *, struct vm_area_struct *,
+			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-- 
1.7.1.569.g6f426
