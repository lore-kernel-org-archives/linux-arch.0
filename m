Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbeHARtV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Aug 2018 13:49:21 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/9] ia64: remove the kern_mem_attribute export
Date: Wed,  1 Aug 2018 18:02:44 +0200
Message-ID: <20180801160252.25629-2-hch@lst.de>
In-Reply-To: <20180801160252.25629-1-hch@lst.de>
References: <20180801160252.25629-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Message-ID: <20180801160244.GiycsowlDG6gVnRuYXKEJhvViLr1uW50Tvr9ux_U3YQ@z>

No actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 9c09bf390cce..f77d80edddfe 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -842,7 +842,6 @@ kern_mem_attribute (unsigned long phys_addr, unsigned long size)
 	} while (md);
 	return 0;	/* never reached */
 }
-EXPORT_SYMBOL(kern_mem_attribute);
 
 int
 valid_phys_addr_range (phys_addr_t phys_addr, unsigned long size)
-- 
2.18.0
