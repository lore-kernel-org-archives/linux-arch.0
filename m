From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 3/4] alpha: remove dma64_addr_t usage
Date: Tue, 12 Oct 2010 12:13:14 +0900
Message-ID: <1286853195-32202-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-alpha-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

dma_addr_t is always 64 bit on alpha. So let's use dma_addr_t instead.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/pci_iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index d1dbd9a..022c274 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -223,7 +223,7 @@ iommu_arena_free(struct pci_iommu_arena *arena, long ofs, long n)
  */
 static int pci_dac_dma_supported(struct pci_dev *dev, u64 mask)
 {
-	dma64_addr_t dac_offset = alpha_mv.pci_dac_offset;
+	dma_addr_t dac_offset = alpha_mv.pci_dac_offset;
 	int ok = 1;
 
 	/* If this is not set, the machine doesn't support DAC at all.  */
@@ -756,7 +756,7 @@ static void alpha_pci_unmap_sg(struct device *dev, struct scatterlist *sg,
 	spin_lock_irqsave(&arena->lock, flags);
 
 	for (end = sg + nents; sg < end; ++sg) {
-		dma64_addr_t addr;
+		dma_addr_t addr;
 		size_t size;
 		long npages, ofs;
 		dma_addr_t tend;
-- 
1.7.1

