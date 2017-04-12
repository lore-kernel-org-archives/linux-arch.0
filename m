Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41405 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbdDLM0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 08:26:19 -0400
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 23/27] ia64: Remove redundant valid_mmap_phys_addr_range() from pci_mmap_page_range()
Date: Wed, 12 Apr 2017 13:26:12 +0100
Message-ID: <99e2b97a2cbf26b09b3317abe41605c6c3ed63ec.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170412122612.hziW3zKobZn6bymrS7B7Ex0FxaFMI_sQPEGPpuv04hI@z>

From: David Woodhouse <dwmw@amazon.co.uk>

We know we are within a valid MMIO BAR by the time this function gets called;
there's no need to check.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/ia64/pci/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 053c688..27020f3 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -439,9 +439,6 @@ pci_mmap_page_range (struct pci_dev *dev, int bar,
 		 */
 		return -EINVAL;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
-		return -EINVAL;
-
 	prot = phys_mem_access_prot(NULL, vma->vm_pgoff, size,
 				    vma->vm_page_prot);
 
-- 
2.9.3
