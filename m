From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 09/20] csky: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:15 +0300
Message-ID: <20200429121126.17989-10-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
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
 arch/csky/kernel/setup.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 819a9a7bf786..0481f4e34538 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -26,7 +26,9 @@ struct screen_info screen_info = {
 
 static void __init csky_memblock_init(void)
 {
-	unsigned long zone_size[MAX_NR_ZONES];
+	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
+	unsigned long sseg_size = PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET);
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 	signed long size;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
@@ -36,28 +38,22 @@ static void __init csky_memblock_init(void)
 
 	memblock_dump_all();
 
-	memset(zone_size, 0, sizeof(zone_size));
-
 	min_low_pfn = PFN_UP(memblock_start_of_DRAM());
 	max_low_pfn = max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
 	size = max_pfn - min_low_pfn;
 
-	if (size <= PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET))
-		zone_size[ZONE_NORMAL] = size;
-	else if (size < PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET)) {
-		zone_size[ZONE_NORMAL] =
-				PFN_DOWN(SSEG_SIZE - PHYS_OFFSET_OFFSET);
-		max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
-	} else {
-		zone_size[ZONE_NORMAL] =
-				PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
-		max_low_pfn = min_low_pfn + zone_size[ZONE_NORMAL];
+	if (size >= lowmem_size) {
+		max_low_pfn = min_low_pfn + lowmem_size;
 		write_mmu_msa1(read_mmu_msa0() + SSEG_SIZE);
+	} else if (size > sseg_size) {
+		max_low_pfn = min_low_pfn + sseg_size;
 	}
 
+	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
+
 #ifdef CONFIG_HIGHMEM
-	zone_size[ZONE_HIGHMEM] = max_pfn - max_low_pfn;
+	max_zone_pfn[ZONE_HIGHMEM] = max_pfn;
 
 	highstart_pfn = max_low_pfn;
 	highend_pfn   = max_pfn;
@@ -66,7 +62,7 @@ static void __init csky_memblock_init(void)
 
 	dma_contiguous_reserve(0);
 
-	free_area_init_node(0, zone_size, min_low_pfn, NULL);
+	free_area_init(max_zone_pfn);
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.26.1
