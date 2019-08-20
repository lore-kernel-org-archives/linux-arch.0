From: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 02/11] arm: use generic dma_zone_size
Date: Tue, 20 Aug 2019 16:58:10 +0200
Message-ID: <20190820145821.27214-3-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: catalin.marinas-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, wahrenst-hi6Y0CQ0nG0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: phill-FnsA7b+Nu9XCNwmyUqMw6A@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, mbrugger-IBi9RG/b67k@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org
List-Id: linux-arch.vger.kernel.org

'dma_zone_size' was created as a generic replacement to
'arm_dma_zone_size'. Use it accordingly.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
---

Changes in v2: None

 arch/arm/include/asm/dma.h |  8 +++++---
 arch/arm/mm/init.c         | 12 ++++--------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..52d19ffd92b4 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -2,16 +2,18 @@
 #ifndef __ASM_ARM_DMA_H
 #define __ASM_ARM_DMA_H
 
+#include <asm-generic/dma.h>
+
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
+#undef MAX_DMA_ADDRESS
 #ifndef CONFIG_ZONE_DMA
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
 #define MAX_DMA_ADDRESS	({ \
-	extern phys_addr_t arm_dma_zone_size; \
-	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
-		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
+	dma_zone_size && dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
+		(PAGE_OFFSET + dma_zone_size) : 0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 16d373d587c4..95680bad245a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -79,10 +79,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 }
 
 #ifdef CONFIG_ZONE_DMA
-
-phys_addr_t arm_dma_zone_size __read_mostly;
-EXPORT_SYMBOL(arm_dma_zone_size);
-
 /*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
@@ -109,8 +105,8 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 {
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
-		arm_dma_zone_size = mdesc->dma_zone_size;
-		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
+		dma_zone_size = mdesc->dma_zone_size;
+		arm_dma_limit = PHYS_OFFSET + dma_zone_size - 1;
 	} else
 		arm_dma_limit = 0xffffffff;
 	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
@@ -164,9 +160,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	if (arm_dma_zone_size)
+	if (dma_zone_size)
 		arm_adjust_dma_zone(zone_size, zhole_size,
-			arm_dma_zone_size >> PAGE_SHIFT);
+			dma_zone_size >> PAGE_SHIFT);
 #endif
 
 	free_area_init_node(0, zone_size, min, zhole_size);
-- 
2.22.0
