From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 06/21] alpha: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:44 +0300
Message-ID: <20200412194859.12663-7-rppt@kernel.org>
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
 arch/alpha/mm/numa.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index a24cd13e71cb..5ad6087de1d6 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -202,8 +202,7 @@ setup_memory(void *kernel_end)
 
 void __init paging_init(void)
 {
-	unsigned int    nid;
-	unsigned long   zones_size[MAX_NR_ZONES] = {0, };
+	unsigned long   max_zone_pfn[MAX_NR_ZONES] = {0, };
 	unsigned long	dma_local_pfn;
 
 	/*
@@ -215,19 +214,10 @@ void __init paging_init(void)
 	 */
 	dma_local_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-	for_each_online_node(nid) {
-		unsigned long start_pfn = NODE_DATA(nid)->node_start_pfn;
-		unsigned long end_pfn = start_pfn + NODE_DATA(nid)->node_present_pages;
+	max_zone_pfn[ZONE_DMA] = dma_local_pfn;
+	max_zone_pfn[ZONE_NORMAL] = max_pfn;
 
-		if (dma_local_pfn >= end_pfn - start_pfn)
-			zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		else {
-			zones_size[ZONE_DMA] = dma_local_pfn;
-			zones_size[ZONE_NORMAL] = (end_pfn - start_pfn) - dma_local_pfn;
-		}
-		node_set_state(nid, N_NORMAL_MEMORY);
-		free_area_init_node(nid, zones_size, start_pfn, NULL);
-	}
+	free_area_init(max_zone_pfn);
 
 	/* Initialize the kernel's ZERO_PGE. */
 	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
-- 
2.25.1
