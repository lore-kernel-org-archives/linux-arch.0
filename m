Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2042 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007AbbGYCoT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jul 2015 22:44:19 -0400
Subject: [PATCH v2 07/25] intel_iommu: fix leaked ioremap mapping
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 24 Jul 2015 22:38:37 -0400
Message-ID: <20150725023837.8664.41845.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, toshi.kani@hp.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, hch@lst.de, linux-arm-kernel@lists.infradead.org
Message-ID: <20150725023837.0DsUcVqfG4DNftqRSHgrcsJkxlS0og0I3wD2mQsVWjY@z>

iommu_load_old_irte() appears to leak the old_irte mapping after use.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/iommu/intel_irq_remapping.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f15692a410c7..27cdfa84ec5b 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -426,6 +426,8 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 			bitmap_set(iommu->ir_table->bitmap, i, 1);
 	}
 
+	iounmap(old_ir_table);
+
 	return 0;
 }
 

