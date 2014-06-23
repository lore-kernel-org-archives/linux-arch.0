Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:43025 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756231AbaFWNwZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jun 2014 09:52:25 -0400
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 86E3611A442
	for <linux-arch@vger.kernel.org>; Mon, 23 Jun 2014 13:42:44 +0000 (UTC)
From: Joe Perches <joe@perches.com>
Subject: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Mon, 23 Jun 2014 06:41:29 -0700
Message-ID: <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
In-Reply-To: <cover.1403530604.git.joe@perches.com>
References: <cover.1403530604.git.joe@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20140623134129.mHeZZeV7Rs7JHySbtobsSNOv5W8LhsHbLzEN_GJj0Dg@z>

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

