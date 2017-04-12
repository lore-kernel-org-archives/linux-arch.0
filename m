Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48489 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753552AbdDLM0T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 08:26:19 -0400
From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 17/27] unicore: Use generic pci_mmap_resource_range()
Date: Wed, 12 Apr 2017 13:26:06 +0100
Message-ID: <96c9ec19826d30648041cf6de17e4ef62c4479a5.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
In-Reply-To: <cover.1491999859.git.dwmw2@infradead.org>
References: <cover.1491999859.git.dwmw2@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170412122606.15IpzueR-HhE6n9wn3lN5gtHUHHuk7K1ZQhk_xwWRCM@z>

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/unicore32/include/asm/pci.h |  1 +
 arch/unicore32/kernel/pci.c      | 24 ------------------------
 2 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
index a5129086..ac5acdf 100644
--- a/arch/unicore32/include/asm/pci.h
+++ b/arch/unicore32/include/asm/pci.h
@@ -17,6 +17,7 @@
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
 #define HAVE_PCI_MMAP
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index 1b43885..1053bca 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -356,27 +356,3 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	}
 	return 0;
 }
-
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	unsigned long phys;
-
-	if (mmap_state == pci_mmap_io)
-		return -EINVAL;
-
-	phys = vma->vm_pgoff;
-
-	/*
-	 * Mark this as IO
-	 */
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (remap_pfn_range(vma, vma->vm_start, phys,
-			     vma->vm_end - vma->vm_start,
-			     vma->vm_page_prot))
-		return -EAGAIN;
-
-	return 0;
-}
-- 
2.9.3
