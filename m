From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 18/20] mm: clean up free_area_init_node() and its helpers
Date: Wed, 29 Apr 2020 15:11:24 +0300
Message-ID: <20200429121126.17989-19-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
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

The free_area_init_node() now always uses memblock info and the zone PFN
limits so it does not need the backwards compatibility functions to
calculate the zone spanned and absent pages. The removal of the compat_
versions of zone_{abscent,spanned}_pages_in_node() in turn, makes zone_size
and zhole_size parameters unused.

The node_start_pfn is determined by get_pfn_range_for_nid(), so there is no
need to pass it to free_area_init_node().

As the result, the only required parameter to free_area_init_node() is the
node ID, all the rest are removed along with no longer used
compat_zone_{abscent,spanned}_pages_in_node() helpers.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/numa.c |   2 +-
 include/linux/mm.h |   7 +--
 mm/page_alloc.c    | 110 +++++++++------------------------------------
 3 files changed, 24 insertions(+), 95 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index fe024b2ac796..0e1b99f491e4 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -742,7 +742,7 @@ static void __init init_memory_less_node(int nid)
 
 	/* Allocate and initialize node data. Memory-less node is now online.*/
 	alloc_node_data(nid);
-	free_area_init_node(nid, zones_size, 0, zholes_size);
+	free_area_init_node(nid);
 
 	/*
 	 * All zonelists will be built later in start_kernel() after per cpu
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c2ecb42e043..2c0d42b11f3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,8 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 }
 
 extern void __init pagecache_init(void);
-extern void __init free_area_init_node(int nid, unsigned long * zones_size,
-		unsigned long zone_start_pfn, unsigned long *zholes_size);
+extern void __init free_area_init_node(int nid);
 extern void free_initmem(void);
 
 /*
@@ -2346,9 +2345,7 @@ static inline unsigned long get_num_physpages(void)
 /*
  * Using memblock node mappings, an architecture may initialise its
  * zones, allocate the backing mem_map and account for memory holes in a more
- * architecture independent manner. This is a substitute for creating the
- * zone_sizes[] and zholes_size[] arrays and passing them to
- * free_area_init_node()
+ * architecture independent manner.
  *
  * An architecture is expected to register range of page frames backed by
  * physical memory with memblock_add[_node]() before calling
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 98a47f90065a..30d171451d4c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6420,8 +6420,7 @@ static unsigned long __init zone_spanned_pages_in_node(int nid,
 					unsigned long node_start_pfn,
 					unsigned long node_end_pfn,
 					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn,
-					unsigned long *ignored)
+					unsigned long *zone_end_pfn)
 {
 	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
@@ -6485,8 +6484,7 @@ unsigned long __init absent_pages_in_range(unsigned long start_pfn,
 static unsigned long __init zone_absent_pages_in_node(int nid,
 					unsigned long zone_type,
 					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *ignored)
+					unsigned long node_end_pfn)
 {
 	unsigned long zone_low = arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high = arch_zone_highest_possible_pfn[zone_type];
@@ -6533,43 +6531,9 @@ static unsigned long __init zone_absent_pages_in_node(int nid,
 	return nr_absent;
 }
 
-static inline unsigned long __init compat_zone_spanned_pages_in_node(int nid,
-					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn,
-					unsigned long *zones_size)
-{
-	unsigned int zone;
-
-	*zone_start_pfn = node_start_pfn;
-	for (zone = 0; zone < zone_type; zone++)
-		*zone_start_pfn += zones_size[zone];
-
-	*zone_end_pfn = *zone_start_pfn + zones_size[zone_type];
-
-	return zones_size[zone_type];
-}
-
-static inline unsigned long __init compat_zone_absent_pages_in_node(int nid,
-						unsigned long zone_type,
-						unsigned long node_start_pfn,
-						unsigned long node_end_pfn,
-						unsigned long *zholes_size)
-{
-	if (!zholes_size)
-		return 0;
-
-	return zholes_size[zone_type];
-}
-
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
-						unsigned long node_end_pfn,
-						unsigned long *zones_size,
-						unsigned long *zholes_size,
-						bool compat)
+						unsigned long node_end_pfn)
 {
 	unsigned long realtotalpages = 0, totalpages = 0;
 	enum zone_type i;
@@ -6580,31 +6544,14 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 		unsigned long spanned, absent;
 		unsigned long size, real_size;
 
-		if (compat) {
-			spanned = compat_zone_spanned_pages_in_node(
-						pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						&zone_start_pfn,
-						&zone_end_pfn,
-						zones_size);
-			absent = compat_zone_absent_pages_in_node(
-						pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						zholes_size);
-		} else {
-			spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						&zone_start_pfn,
-						&zone_end_pfn,
-						zones_size);
-			absent = zone_absent_pages_in_node(pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						zholes_size);
-		}
+		spanned = zone_spanned_pages_in_node(pgdat->node_id, i,
+						     node_start_pfn,
+						     node_end_pfn,
+						     &zone_start_pfn,
+						     &zone_end_pfn);
+		absent = zone_absent_pages_in_node(pgdat->node_id, i,
+						   node_start_pfn,
+						   node_end_pfn);
 
 		size = spanned;
 		real_size = size - absent;
@@ -6926,10 +6873,7 @@ static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
 #endif
 
-static void __init __free_area_init_node(int nid, unsigned long *zones_size,
-					 unsigned long node_start_pfn,
-					 unsigned long *zholes_size,
-					 bool compat)
+void __init free_area_init_node(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long start_pfn = 0;
@@ -6938,19 +6882,16 @@ static void __init __free_area_init_node(int nid, unsigned long *zones_size,
 	/* pg_data_t should be reset to zero when it's allocated */
 	WARN_ON(pgdat->nr_zones || pgdat->kswapd_classzone_idx);
 
+	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+
 	pgdat->node_id = nid;
-	pgdat->node_start_pfn = node_start_pfn;
+	pgdat->node_start_pfn = start_pfn;
 	pgdat->per_cpu_nodestats = NULL;
-	if (!compat) {
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-			(u64)start_pfn << PAGE_SHIFT,
-			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
-	} else {
-		start_pfn = node_start_pfn;
-	}
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size, compat);
+
+	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
+		(u64)start_pfn << PAGE_SHIFT,
+		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
 
 	alloc_node_mem_map(pgdat);
 	pgdat_set_deferred_range(pgdat);
@@ -6958,14 +6899,6 @@ static void __init __free_area_init_node(int nid, unsigned long *zones_size,
 	free_area_init_core(pgdat);
 }
 
-void __init free_area_init_node(int nid, unsigned long *zones_size,
-				unsigned long node_start_pfn,
-				unsigned long *zholes_size)
-{
-	__free_area_init_node(nid, zones_size, node_start_pfn, zholes_size,
-			      true);
-}
-
 #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
  * Initialize all valid struct pages in the range [spfn, epfn) and mark them
@@ -7491,8 +7424,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	init_unavailable_mem();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
-		__free_area_init_node(nid, NULL,
-				      find_min_pfn_for_node(nid), NULL, false);
+		free_area_init_node(nid);
 
 		/* Any memory on that node */
 		if (pgdat->node_present_pages)
-- 
2.26.1
