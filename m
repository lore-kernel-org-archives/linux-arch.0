From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 08/21] arm64: simplify detection of memory zone boundaries for
 UMA configs
Date: Sun, 12 Apr 2020 22:48:46 +0300
Message-ID: <20200412194859.12663-9-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/init.c | 54 --------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a650adb358ee..d54ad2250dce 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -192,8 +192,6 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 	return min(offset + (1ULL << zone_bits), memblock_end_of_DRAM());
 }
 
-#ifdef CONFIG_NUMA
-
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
@@ -209,58 +207,6 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	free_area_init(max_zone_pfns);
 }
 
-#else
-
-static void __init zone_sizes_init(unsigned long min, unsigned long max)
-{
-	struct memblock_region *reg;
-	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	unsigned long __maybe_unused max_dma, max_dma32;
-
-	memset(zone_size, 0, sizeof(zone_size));
-
-	max_dma = max_dma32 = min;
-#ifdef CONFIG_ZONE_DMA
-	max_dma = max_dma32 = PFN_DOWN(arm64_dma_phys_limit);
-	zone_size[ZONE_DMA] = max_dma - min;
-#endif
-#ifdef CONFIG_ZONE_DMA32
-	max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
-	zone_size[ZONE_DMA32] = max_dma32 - max_dma;
-#endif
-	zone_size[ZONE_NORMAL] = max - max_dma32;
-
-	memcpy(zhole_size, zone_size, sizeof(zhole_size));
-
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-#ifdef CONFIG_ZONE_DMA
-		if (start >= min && start < max_dma) {
-			unsigned long dma_end = min(end, max_dma);
-			zhole_size[ZONE_DMA] -= dma_end - start;
-			start = dma_end;
-		}
-#endif
-#ifdef CONFIG_ZONE_DMA32
-		if (start >= max_dma && start < max_dma32) {
-			unsigned long dma32_end = min(end, max_dma32);
-			zhole_size[ZONE_DMA32] -= dma32_end - start;
-			start = dma32_end;
-		}
-#endif
-		if (start >= max_dma32 && start < max) {
-			unsigned long normal_end = min(end, max);
-			zhole_size[ZONE_NORMAL] -= normal_end - start;
-		}
-	}
-
-	free_area_init_node(0, zone_size, min, zhole_size);
-}
-
-#endif /* CONFIG_NUMA */
-
 int pfn_valid(unsigned long pfn)
 {
 	phys_addr_t addr = pfn << PAGE_SHIFT;
-- 
2.25.1
