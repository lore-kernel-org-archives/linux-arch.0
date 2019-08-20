From: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 07/11] arm64: re-introduce max_zone_dma_phys()
Date: Tue, 20 Aug 2019 16:58:15 +0200
Message-ID: <20190820145821.27214-8-nsaenzjulienne@suse.de>
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
Cc: phill-FnsA7b+Nu9XCNwmyUqMw6A@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, mbrugger-IBi9RG/b67k@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Some devices might have multiple interconnects with different DMA
addressing limitations. This function provides the higher physical
address accessible by all peripherals on the SoC. If such limitation
doesn't exist it'll return the maximum physical address of the 32 bit
addressable area.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>
---

Changes in v2:
- Update function's behavior to fit new dma zones split
- Use dma_zone_size
- Take into account devices with a hardcoded DMA offset

 arch/arm64/mm/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8956c22634dd..bc7999020c71 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -174,6 +174,17 @@ static phys_addr_t __init max_zone_dma32_phys(void)
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
 }
 
+static phys_addr_t __init max_zone_dma_phys(void)
+
+{
+	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
+
+	if (dma_zone_size)
+		return min(offset + dma_zone_size, memblock_end_of_DRAM());
+	else
+		return max_zone_dma32_phys();
+}
+
 #ifdef CONFIG_NUMA
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
-- 
2.22.0
