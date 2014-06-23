From: Joe Perches <joe@perches.com>
Subject: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Mon, 23 Jun 2014 06:41:29 -0700
Message-ID: <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
References: <cover.1403530604.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1403530604.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Add this helper for consistency with pci_zalloc_coherent
and the ability to remove unnecessary memset(,0,) uses.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/asm-generic/pci-dma-compat.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/pci-dma-compat.h b/include/asm-generic/pci-dma-compat.h
index 1437b7d..c110843 100644
--- a/include/asm-generic/pci-dma-compat.h
+++ b/include/asm-generic/pci-dma-compat.h
@@ -19,6 +19,14 @@ pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
 	return dma_alloc_coherent(hwdev == NULL ? NULL : &hwdev->dev, size, dma_handle, GFP_ATOMIC);
 }
 
+static inline void *
+pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
+		      dma_addr_t *dma_handle)
+{
+	return dma_zalloc_coherent(hwdev == NULL ? NULL : &hwdev->dev,
+				   size, dma_handle, GFP_ATOMIC);
+}
+
 static inline void
 pci_free_consistent(struct pci_dev *hwdev, size_t size,
 		    void *vaddr, dma_addr_t dma_handle)
-- 
1.8.1.2.459.gbcd45b4.dirty
