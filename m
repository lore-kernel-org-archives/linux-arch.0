Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Mar 2005 22:58:33 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: no-arch-specific-mem_map-init
Message-Id: <20050309225833.6d80fc42.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


Everyone OK with this?


From: Dave Hansen <haveblue@us.ibm.com>

So, this patch started out with me trying to keep from passing contiguous,
node-specific mem_map into free_area_init_node() and cousins.  Instead, I
relied on some calls to pfn_to_page().

This works fine and dandy when all you need is the pgdat->node_mem_map to
do pfn_to_page().  However, the non-NUMA/DISCONTIG architectures use the
real, global mem_map[] instead of a node_mem_map in the pfn_to_page()
calculation.  So, I ended up effectively trying to initialize mem_map from
itself, when it was NULL.  That was bad, and caused some very pretty colors
on someone's screen when he tested it.

So, I had to make sure to initialize the global mem_map[] before calling
into free_area_init_node().  Then, I realized how many architectures do
this on their own, and have comments like this:

        /* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
        mem_map = NODE_DATA(0)->node_mem_map;

The following patch does what my first one did (don't pass mem_map into the
init functions), incorporates Jesse Barnes' ia64 fixes on top of that, and
gets rid of all but one of the global mem_map initializations (parisc is
weird).  It also magically removes more code than it adds.  It could be
smaller, but I shamelessly added some comments.  

Boot-tested on ppc64, i386 (NUMAQ, plain SMP, laptop), UML (i386).

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/arm/mm/init.c           |    4 ----
 25-akpm/arch/arm26/mm/init.c         |    2 --
 25-akpm/arch/cris/arch-v10/mm/init.c |    1 -
 25-akpm/arch/ia64/mm/contig.c        |    2 +-
 25-akpm/arch/m32r/mm/init.c          |    2 --
 25-akpm/arch/ppc64/mm/init.c         |    1 -
 25-akpm/arch/sh/mm/init.c            |    2 --
 25-akpm/arch/sh64/mm/init.c          |    3 ---
 25-akpm/arch/sparc/mm/srmmu.c        |    1 -
 25-akpm/arch/sparc/mm/sun4c.c        |    1 -
 25-akpm/arch/sparc64/mm/init.c       |    1 -
 25-akpm/arch/um/kernel/physmem.c     |    1 -
 25-akpm/arch/v850/kernel/setup.c     |    1 -
 25-akpm/mm/page_alloc.c              |   22 ++++++++++++++++------
 14 files changed, 17 insertions(+), 27 deletions(-)

diff -puN arch/arm26/mm/init.c~no-arch-specific-mem_map-init arch/arm26/mm/init.c
--- 25/arch/arm26/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/arm26/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -309,8 +309,6 @@ void __init paging_init(struct meminfo *
 	free_area_init_node(0, pgdat, zone_size,
 			bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 
-	mem_map = NODE_DATA(0)->node_mem_map;
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -puN arch/arm/mm/init.c~no-arch-specific-mem_map-init arch/arm/mm/init.c
--- 25/arch/arm/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/arm/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -501,10 +501,6 @@ void __init paging_init(struct meminfo *
 				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
 	}
 
-#ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
-#endif
-
 	/*
 	 * finish off the bad pages once
 	 * the mem_map is initialised
diff -puN arch/cris/arch-v10/mm/init.c~no-arch-specific-mem_map-init arch/cris/arch-v10/mm/init.c
--- 25/arch/cris/arch-v10/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/cris/arch-v10/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -184,7 +184,6 @@ paging_init(void)
 	 */
 
 	free_area_init_node(0, &contig_page_data, zones_size, PAGE_OFFSET >> PAGE_SHIFT, 0);
-	mem_map = contig_page_data.node_mem_map;
 }
 
 /* Initialize remaps of some I/O-ports. It is important that this
diff -puN arch/ia64/mm/contig.c~no-arch-specific-mem_map-init arch/ia64/mm/contig.c
--- 25/arch/ia64/mm/contig.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/ia64/mm/contig.c	Mon Mar  7 16:43:24 2005
@@ -280,7 +280,7 @@ paging_init (void)
 		vmem_map = (struct page *) vmalloc_end;
 		efi_memmap_walk(create_mem_map_page_table, NULL);
 
-		mem_map = contig_page_data.node_mem_map = vmem_map;
+		NODE_DATA(0)->node_mem_map = vmem_map;
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    0, zholes_size);
 
diff -puN arch/m32r/mm/init.c~no-arch-specific-mem_map-init arch/m32r/mm/init.c
--- 25/arch/m32r/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/m32r/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -121,8 +121,6 @@ unsigned long __init zone_sizes_init(voi
 
 	free_area_init_node(0, NODE_DATA(0), zones_size, start_pfn, 0);
 
-	mem_map = contig_page_data.node_mem_map;
-
 	return 0;
 }
 #else	/* CONFIG_DISCONTIGMEM */
diff -puN arch/ppc64/mm/init.c~no-arch-specific-mem_map-init arch/ppc64/mm/init.c
--- 25/arch/ppc64/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/ppc64/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -664,7 +664,6 @@ void __init paging_init(void)
 
 	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
-	mem_map = contig_page_data.node_mem_map;
 }
 #endif /* CONFIG_DISCONTIGMEM */
 
diff -puN arch/sh64/mm/init.c~no-arch-specific-mem_map-init arch/sh64/mm/init.c
--- 25/arch/sh64/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/sh64/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -124,9 +124,6 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA] = MAX_LOW_PFN - START_PFN;
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
 
 void __init mem_init(void)
diff -puN arch/sh/mm/init.c~no-arch-specific-mem_map-init arch/sh/mm/init.c
--- 25/arch/sh/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/sh/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -216,8 +216,6 @@ void __init paging_init(void)
 #endif
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node(0, NODE_DATA(0), zones_size, __MEMORY_START >> PAGE_SHIFT, 0);
-	/* XXX: MRB-remove - this doesn't seem sane, should this be done somewhere else ?*/
-	mem_map = NODE_DATA(0)->node_mem_map;
 
 #ifdef CONFIG_DISCONTIGMEM
 	/*
diff -puN arch/sparc64/mm/init.c~no-arch-specific-mem_map-init arch/sparc64/mm/init.c
--- 25/arch/sparc64/mm/init.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/sparc64/mm/init.c	Mon Mar  7 16:43:24 2005
@@ -1513,7 +1513,6 @@ void __init paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    phys_base >> PAGE_SHIFT, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	device_scan();
diff -puN arch/sparc/mm/srmmu.c~no-arch-specific-mem_map-init arch/sparc/mm/srmmu.c
--- 25/arch/sparc/mm/srmmu.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/sparc/mm/srmmu.c	Mon Mar  7 16:43:24 2005
@@ -1343,7 +1343,6 @@ void __init srmmu_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 }
 
diff -puN arch/sparc/mm/sun4c.c~no-arch-specific-mem_map-init arch/sparc/mm/sun4c.c
--- 25/arch/sparc/mm/sun4c.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/sparc/mm/sun4c.c	Mon Mar  7 16:43:24 2005
@@ -2117,7 +2117,6 @@ void __init sun4c_paging_init(void)
 
 		free_area_init_node(0, &contig_page_data, zones_size,
 				    pfn_base, zholes_size);
-		mem_map = contig_page_data.node_mem_map;
 	}
 
 	cnt = 0;
diff -puN arch/um/kernel/physmem.c~no-arch-specific-mem_map-init arch/um/kernel/physmem.c
--- 25/arch/um/kernel/physmem.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/um/kernel/physmem.c	Mon Mar  7 16:43:24 2005
@@ -294,7 +294,6 @@ int init_maps(unsigned long physmem, uns
 		INIT_LIST_HEAD(&p->lru);
 	}
 
-	mem_map = map;
 	max_mapnr = total_pages;
 	return(0);
 }
diff -puN arch/v850/kernel/setup.c~no-arch-specific-mem_map-init arch/v850/kernel/setup.c
--- 25/arch/v850/kernel/setup.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/arch/v850/kernel/setup.c	Mon Mar  7 16:43:24 2005
@@ -283,5 +283,4 @@ init_mem_alloc (unsigned long ram_start,
 	NODE_DATA(0)->node_mem_map = NULL;
 	free_area_init_node (0, NODE_DATA(0), zones_size,
 			     ADDR_TO_PAGE (PAGE_OFFSET), 0);
-	mem_map = NODE_DATA(0)->node_mem_map;
 }
diff -puN mm/page_alloc.c~no-arch-specific-mem_map-init mm/page_alloc.c
--- 25/mm/page_alloc.c~no-arch-specific-mem_map-init	Mon Mar  7 16:43:24 2005
+++ 25-akpm/mm/page_alloc.c	Mon Mar  7 16:43:24 2005
@@ -1712,14 +1712,25 @@ static void __init free_area_init_core(s
 	}
 }
 
-void __init node_alloc_mem_map(struct pglist_data *pgdat)
+static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 {
 	unsigned long size;
 
-	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
-	pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+	/* Skip empty nodes */
+	if (!pgdat->node_spanned_pages)
+		return;
+
+	/* ia64 gets its own node_mem_map, before this, without bootmem */
+	if (!pgdat->node_mem_map) {
+		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+		pgdat->node_mem_map = alloc_bootmem_node(pgdat, size);
+	}
 #ifndef CONFIG_DISCONTIGMEM
-	mem_map = contig_page_data.node_mem_map;
+	/*
+	 * With no DISCONTIG, the global mem_map is just set as node 0's
+	 */
+	if (pgdat == NODE_DATA(0))
+		mem_map = NODE_DATA(0)->node_mem_map;
 #endif
 }
 
@@ -1731,8 +1742,7 @@ void __init free_area_init_node(int nid,
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
 
-	if (!pfn_to_page(node_start_pfn))
-		node_alloc_mem_map(pgdat);
+	alloc_node_mem_map(pgdat);
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
 }
_
