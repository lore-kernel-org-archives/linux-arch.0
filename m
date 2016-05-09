Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:38538 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcEIQzJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2016 12:55:09 -0400
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv6 2/8] dma-debug: add support for resource mappings
Date: Mon,  9 May 2016 18:44:01 +0200
Message-ID: <1462812247-3414-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462812247-3414-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160509164401.kUU2hPA89PNnXvKTa0CoiF8FXIl5uQqGKpgzAKtEl5k@z>

A MMIO mapped resource can not be represented by a struct page so a new
debug type is needed to handle this. This patch add such type and
functionality to add/remove entries and how to translate them to a
physical address.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/linux/dma-debug.h | 19 +++++++++++++++++
 lib/dma-debug.c           | 52 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..c7d844f 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -56,6 +56,13 @@ extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
 
+extern void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
+				   size_t size, int direction,
+				   dma_addr_t dma_addr);
+
+extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
+				     size_t size, int direction);
+
 extern void debug_dma_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dma_handle, size_t size,
 					  int direction);
@@ -141,6 +148,18 @@ static inline void debug_dma_free_coherent(struct device *dev, size_t size,
 {
 }
 
+static inline void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
+					  size_t size, int direction,
+					  dma_addr_t dma_addr)
+{
+}
+
+static inline void debug_dma_unmap_resource(struct device *dev,
+					    dma_addr_t dma_addr, size_t size,
+					    int direction)
+{
+}
+
 static inline void debug_dma_sync_single_for_cpu(struct device *dev,
 						 dma_addr_t dma_handle,
 						 size_t size, int direction)
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 4a1515f..fb12d5c 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -43,6 +43,7 @@ enum {
 	dma_debug_page,
 	dma_debug_sg,
 	dma_debug_coherent,
+	dma_debug_resource,
 };
 
 enum map_err_types {
@@ -150,8 +151,9 @@ static const char *const maperr2str[] = {
 	[MAP_ERR_CHECKED] = "dma map error checked",
 };
 
-static const char *type2name[4] = { "single", "page",
-				    "scather-gather", "coherent" };
+static const char *type2name[5] = { "single", "page",
+				    "scather-gather", "coherent",
+				    "resource" };
 
 static const char *dir2name[4] = { "DMA_BIDIRECTIONAL", "DMA_TO_DEVICE",
 				   "DMA_FROM_DEVICE", "DMA_NONE" };
@@ -397,6 +399,9 @@ static void hash_bucket_del(struct dma_debug_entry *entry)
 
 static unsigned long long phys_addr(struct dma_debug_entry *entry)
 {
+	if (entry->type == dma_debug_resource)
+		return PHYS_PFN(entry->pfn) + entry->offset;
+
 	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
 }
 
@@ -1493,6 +1498,49 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 }
 EXPORT_SYMBOL(debug_dma_free_coherent);
 
+void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
+			    int direction, dma_addr_t dma_addr)
+{
+	struct dma_debug_entry *entry;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	entry = dma_entry_alloc();
+	if (!entry)
+		return;
+
+	entry->type		= dma_debug_resource;
+	entry->dev		= dev;
+	entry->pfn		= __phys_to_pfn(addr);
+	entry->offset		= addr - PHYS_PFN(entry->pfn);
+	entry->size		= size;
+	entry->dev_addr		= dma_addr;
+	entry->direction	= direction;
+	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
+
+	add_dma_entry(entry);
+}
+EXPORT_SYMBOL(debug_dma_map_resource);
+
+void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
+			      size_t size, int direction)
+{
+	struct dma_debug_entry ref = {
+		.type           = dma_debug_resource,
+		.dev            = dev,
+		.dev_addr       = dma_addr,
+		.size           = size,
+		.direction      = direction,
+	};
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_unmap(&ref);
+}
+EXPORT_SYMBOL(debug_dma_unmap_resource);
+
 void debug_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 				   size_t size, int direction)
 {
-- 
2.8.2

