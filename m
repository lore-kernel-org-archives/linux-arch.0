From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dma-mapping: fix calculation of iova bitmap size
Date: Fri, 09 Mar 2012 15:53:32 +0100
Message-ID: <1331304812-10386-1-git-send-email-m.szyprowski@samsung.com>
References: <011701ccfc83$78030180$68090480$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <011701ccfc83$78030180$68090480$%szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Chunsang Jeong <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Fix calculation of iova address space for IOMMU-aware dma mapping.

Reported-by: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ea5a0ad..f0f600a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1601,11 +1601,14 @@ struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 			 int order)
 {
-	unsigned int count = (size >> PAGE_SHIFT) - order;
+	unsigned int count = size >> (PAGE_SHIFT + order);
 	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
 	int err = -ENOMEM;
 
+	if (!count)
+		return ERR_PTR(-EINVAL);
+
 	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
 	if (!mapping)
 		goto err;
-- 
1.7.1.569.g6f426
