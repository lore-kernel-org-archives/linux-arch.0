Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 18/20] mm: clean up free_area_init_node() and its helpers
Date: Wed, 29 Apr 2020 15:11:24 +0300
Message-ID: <20200429121126.17989-19-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121124.Z-Jb8oC_0K0USws6ADkBnJ20hJVCLLbKcMEMvp2dEmg@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init_node() now always uses memblock info and the zone PFN
limits so it does not need the backwards compatibility functions to
calculate the zone spanned and absent pages. The removal of the compat_
versions of zone_{abscent,spanned}_pages_in_node() in turn, makes zone_si=
ze
and zhole_size parameters unused.

The node_start_pfn is determined by get_pfn_range_for_nid(), so there is =
no
need to pass it to free_area_init_node().

As the result, the only required parameter to free_area_init_node() is th=
e
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
=20
 	/* Allocate and initialize node data. Memory-less node is now online.*/
 	alloc_node_data(nid);
-	free_area_init_node(nid, zones_size, 0, zholes_size);
+	free_area_init_node(nid);
=20
 	/*
 	 * All zonelists will be built later in start_kernel() after per cpu
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1c2ecb42e043..2c0d42b11f3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,8 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct=
 *mm, pud_t *pud)
 }
=20
 extern void __init pagecache_init(void);
-extern void __init free_area_init_node(int nid, unsigned long * zones_si=
ze,
-		unsigned long zone_start_pfn, unsigned long *zholes_size);
+extern void __init free_area_init_node(int nid);
 extern void free_initmem(void);
=20
 /*
@@ -2346,9 +2345,7 @@ static inline unsigned long get_num_physpages(void)
 /*
  * Using memblock node mappings, an architecture may initialise its
  * zones, allocate the backing mem_map and account for memory holes in a=
 more
- * architecture independent manner. This is a substitute for creating th=
e
- * zone_sizes[] and zholes_size[] arrays and passing them to
- * free_area_init_node()
+ * architecture independent manner.
  *
  * An architecture is expected to register range of page frames backed b=
y
  * physical memory with memblock_add[_node]() before calling
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 98a47f90065a..30d171451d4c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6420,8 +6420,7 @@ static unsigned long __init zone_spanned_pages_in_n=
ode(int nid,
 					unsigned long node_start_pfn,
 					unsigned long node_end_pfn,
 					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn,
-					unsigned long *ignored)
+					unsigned long *zone_end_pfn)
 {
 	unsigned long zone_low =3D arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high =3D arch_zone_highest_possible_pfn[zone_type];
@@ -6485,8 +6484,7 @@ unsigned long __init absent_pages_in_range(unsigned=
 long start_pfn,
 static unsigned long __init zone_absent_pages_in_node(int nid,
 					unsigned long zone_type,
 					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *ignored)
+					unsigned long node_end_pfn)
 {
 	unsigned long zone_low =3D arch_zone_lowest_possible_pfn[zone_type];
 	unsigned long zone_high =3D arch_zone_highest_possible_pfn[zone_type];
@@ -6533,43 +6531,9 @@ static unsigned long __init zone_absent_pages_in_n=
ode(int nid,
 	return nr_absent;
 }
=20
-static inline unsigned long __init compat_zone_spanned_pages_in_node(int=
 nid,
-					unsigned long zone_type,
-					unsigned long node_start_pfn,
-					unsigned long node_end_pfn,
-					unsigned long *zone_start_pfn,
-					unsigned long *zone_end_pfn,
-					unsigned long *zones_size)
-{
-	unsigned int zone;
-
-	*zone_start_pfn =3D node_start_pfn;
-	for (zone =3D 0; zone < zone_type; zone++)
-		*zone_start_pfn +=3D zones_size[zone];
-
-	*zone_end_pfn =3D *zone_start_pfn + zones_size[zone_type];
-
-	return zones_size[zone_type];
-}
-
-static inline unsigned long __init compat_zone_absent_pages_in_node(int =
nid,
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
 	unsigned long realtotalpages =3D 0, totalpages =3D 0;
 	enum zone_type i;
@@ -6580,31 +6544,14 @@ static void __init calculate_node_totalpages(stru=
ct pglist_data *pgdat,
 		unsigned long spanned, absent;
 		unsigned long size, real_size;
=20
-		if (compat) {
-			spanned =3D compat_zone_spanned_pages_in_node(
-						pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						&zone_start_pfn,
-						&zone_end_pfn,
-						zones_size);
-			absent =3D compat_zone_absent_pages_in_node(
-						pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						zholes_size);
-		} else {
-			spanned =3D zone_spanned_pages_in_node(pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						&zone_start_pfn,
-						&zone_end_pfn,
-						zones_size);
-			absent =3D zone_absent_pages_in_node(pgdat->node_id, i,
-						node_start_pfn,
-						node_end_pfn,
-						zholes_size);
-		}
+		spanned =3D zone_spanned_pages_in_node(pgdat->node_id, i,
+						     node_start_pfn,
+						     node_end_pfn,
+						     &zone_start_pfn,
+						     &zone_end_pfn);
+		absent =3D zone_absent_pages_in_node(pgdat->node_id, i,
+						   node_start_pfn,
+						   node_end_pfn);
=20
 		size =3D spanned;
 		real_size =3D size - absent;
@@ -6926,10 +6873,7 @@ static inline void pgdat_set_deferred_range(pg_dat=
a_t *pgdat)
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
 #endif
=20
-static void __init __free_area_init_node(int nid, unsigned long *zones_s=
ize,
-					 unsigned long node_start_pfn,
-					 unsigned long *zholes_size,
-					 bool compat)
+void __init free_area_init_node(int nid)
 {
 	pg_data_t *pgdat =3D NODE_DATA(nid);
 	unsigned long start_pfn =3D 0;
@@ -6938,19 +6882,16 @@ static void __init __free_area_init_node(int nid,=
 unsigned long *zones_size,
 	/* pg_data_t should be reset to zero when it's allocated */
 	WARN_ON(pgdat->nr_zones || pgdat->kswapd_classzone_idx);
=20
+	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+
 	pgdat->node_id =3D nid;
-	pgdat->node_start_pfn =3D node_start_pfn;
+	pgdat->node_start_pfn =3D start_pfn;
 	pgdat->per_cpu_nodestats =3D NULL;
-	if (!compat) {
-		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-			(u64)start_pfn << PAGE_SHIFT,
-			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
-	} else {
-		start_pfn =3D node_start_pfn;
-	}
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size, compat);
+
+	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
+		(u64)start_pfn << PAGE_SHIFT,
+		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	calculate_node_totalpages(pgdat, start_pfn, end_pfn);
=20
 	alloc_node_mem_map(pgdat);
 	pgdat_set_deferred_range(pgdat);
@@ -6958,14 +6899,6 @@ static void __init __free_area_init_node(int nid, =
unsigned long *zones_size,
 	free_area_init_core(pgdat);
 }
=20
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
  * Initialize all valid struct pages in the range [spfn, epfn) and mark =
them
@@ -7491,8 +7424,7 @@ void __init free_area_init(unsigned long *max_zone_=
pfn)
 	init_unavailable_mem();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat =3D NODE_DATA(nid);
-		__free_area_init_node(nid, NULL,
-				      find_min_pfn_for_node(nid), NULL, false);
+		free_area_init_node(nid);
=20
 		/* Any memory on that node */
 		if (pgdat->node_present_pages)
--=20
2.26.1
