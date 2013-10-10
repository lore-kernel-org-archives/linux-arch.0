From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 33/34] iommu/arm-smmu: handle pgtable_page_ctor() fail
Date: Thu, 10 Oct 2013 21:05:58 +0300
Message-ID: <1381428359-14843-34-git-send-email-kirill.shutemov@linux.intel.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 drivers/iommu/arm-smmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f417e89e1e..2b256a5075 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1211,7 +1211,10 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 		arm_smmu_flush_pgtable(smmu, page_address(table),
 				       ARM_SMMU_PTE_HWTABLE_SIZE);
-		pgtable_page_ctor(table);
+		if (!pgtable_page_ctor(table)) {
+			__free_page(table);
+			return -ENOMEM;
+		}
 		pmd_populate(NULL, pmd, table);
 		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
 	}
-- 
1.8.4.rc3
