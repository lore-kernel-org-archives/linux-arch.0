Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from georges.telenet-ops.be ([195.130.137.68]:57516 "EHLO
	georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3AMKpG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jan 2013 05:45:06 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 9/9] xtensa: Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 13 Jan 2013 11:44:50 +0100
Message-ID: <1358073890-3610-9-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-xtensa@linux-xtensa.org
Message-ID: <20130113104450.mAJgF0pdQAHq4mpAsKNqeQVRy6xir8d1J3auHQG0lSU@z>

xtensa/allmodconfig:

drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_mmap’:
drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit declaration of function ‘dma_mmap_coherent’
drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_get_base_sgt’:
drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit declaration of function ‘dma_get_sgtable’

For architectures using dma_map_ops, dma_mmap_coherent() and
dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.

Xtensa does not use dma_map_ops, hence it should implement them as inline
stubs using dma_common_mmap() and dma_common_get_sgtable().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/include/asm/dma-mapping.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 4acb5fe..9b778fc 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -170,4 +170,14 @@ dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	consistent_sync(vaddr, size, direction);
 }
 
+/* drivers/base/dma-mapping.c */
+extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
+			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
+extern int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
+				  void *cpu_addr, dma_addr_t dma_addr,
+				  size_t size);
+
+#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h, s)
+#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t, v, h, s)
+
 #endif	/* _XTENSA_DMA_MAPPING_H */
-- 
1.7.0.4

