Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965004AbeAJIKY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 03:10:24 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 15/22] ia64: remove an ifdef around the content of pci-dma.c
Date: Wed, 10 Jan 2018 09:09:25 +0100
Message-ID: <20180110080932.14157-16-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180110080925.er6JMg_JzFp-cjWJbt3-PBE8wZA6ne5EzYOwnVGS0IM@z>

The file is only compiled if CONFIG_INTEL_IOMMU is set to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 35e0cad33b7d..b5df084c0af4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -12,12 +12,7 @@
 #include <asm/iommu.h>
 #include <asm/machvec.h>
 #include <linux/dma-mapping.h>
-
-
-#ifdef CONFIG_INTEL_IOMMU
-
 #include <linux/kernel.h>
-
 #include <asm/page.h>
 
 dma_addr_t bad_dma_address __read_mostly;
@@ -115,5 +110,3 @@ void __init pci_iommu_alloc(void)
 	}
 #endif /* CONFIG_SWIOTLB */
 }
-
-#endif
-- 
2.14.2
