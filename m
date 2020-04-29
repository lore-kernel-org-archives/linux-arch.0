From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 01/20] mm: memblock: replace dereferences of
 memblock_region.nid with API calls
Date: Wed, 29 Apr 2020 15:11:07 +0300
Message-ID: <20200429121126.17989-2-rppt@kernel.org>
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

There are several places in the code that directly dereference
memblock_region.nid despite this field being defined only when
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y.

Replace these with calls to memblock_get_region_nid() to improve code
robustness and to avoid possible breakage when
CONFIG_HAVE_MEMBLOCK_NODE_MAP will be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/numa.c | 9 ++++++---
 arch/x86/mm/numa.c   | 6 ++++--
 mm/memblock.c        | 8 +++++---
 mm/page_alloc.c      | 4 ++--
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 4decf1659700..aafcee3e3f7e 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -350,13 +350,16 @@ static int __init numa_register_nodes(void)
 	struct memblock_region *mblk;
 
 	/* Check that valid nid is set to memblks */
-	for_each_memblock(memory, mblk)
-		if (mblk->nid == NUMA_NO_NODE || mblk->nid >= MAX_NUMNODES) {
+	for_each_memblock(memory, mblk) {
+		int mblk_nid = memblock_get_region_node(mblk);
+
+		if (mblk_nid == NUMA_NO_NODE || mblk_nid >= MAX_NUMNODES) {
 			pr_warn("Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-				mblk->nid, mblk->base,
+				mblk_nid, mblk->base,
 				mblk->base + mblk->size - 1);
 			return -EINVAL;
 		}
+	}
 
 	/* Finally register nodes. */
 	for_each_node_mask(nid, numa_nodes_parsed) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..fe024b2ac796 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -517,8 +517,10 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	 *   reserve specific pages for Sandy Bridge graphics. ]
 	 */
 	for_each_memblock(reserved, mb_region) {
-		if (mb_region->nid != MAX_NUMNODES)
-			node_set(mb_region->nid, reserved_nodemask);
+		int nid = memblock_get_region_node(mb_region);
+
+		if (nid != MAX_NUMNODES)
+			node_set(nid, reserved_nodemask);
 	}
 
 	/*
diff --git a/mm/memblock.c b/mm/memblock.c
index c79ba6f9920c..43e2fd3006c1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1207,13 +1207,15 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 {
 	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
+	int r_nid;
 
 	while (++*idx < type->cnt) {
 		r = &type->regions[*idx];
+		r_nid = memblock_get_region_node(r);
 
 		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
 			continue;
-		if (nid == MAX_NUMNODES || nid == r->nid)
+		if (nid == MAX_NUMNODES || nid == r_nid)
 			break;
 	}
 	if (*idx >= type->cnt) {
@@ -1226,7 +1228,7 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 	if (out_end_pfn)
 		*out_end_pfn = PFN_DOWN(r->base + r->size);
 	if (out_nid)
-		*out_nid = r->nid;
+		*out_nid = r_nid;
 }
 
 /**
@@ -1810,7 +1812,7 @@ int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 	*start_pfn = PFN_DOWN(type->regions[mid].base);
 	*end_pfn = PFN_DOWN(type->regions[mid].base + type->regions[mid].size);
 
-	return type->regions[mid].nid;
+	return memblock_get_region_node(&type->regions[mid]);
 }
 #endif
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69827d4fa052..0d012eda1694 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7208,7 +7208,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			if (!memblock_is_hotpluggable(r))
 				continue;
 
-			nid = r->nid;
+			nid = memblock_get_region_node(r);
 
 			usable_startpfn = PFN_DOWN(r->base);
 			zone_movable_pfn[nid] = zone_movable_pfn[nid] ?
@@ -7229,7 +7229,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			if (memblock_is_mirror(r))
 				continue;
 
-			nid = r->nid;
+			nid = memblock_get_region_node(r);
 
 			usable_startpfn = memblock_region_memory_base_pfn(r);
 
-- 
2.26.1
