Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 04/20] mm: free_area_init: use maximal zone PFNs rather than zone sizes
Date: Wed, 29 Apr 2020 15:11:10 +0300
Message-ID: <20200429121126.17989-5-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121110.s9_XhOBbSzv0MC3721yyczZm2JhKsLCkLutE64lbBUw@z>

From: Mike Rapoport <rppt@linux.ibm.com>

Currently, architectures that use free_area_init() to initialize memory m=
ap
and node and zone structures need to calculate zone and hole sizes. We ca=
n
use free_area_init_nodes() instead and let it detect the zone boundaries
while the architectures will only have to supply the possible limits for
the zones.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/mm/init.c    | 16 ++++++----------
 arch/c6x/mm/init.c      |  8 +++-----
 arch/h8300/mm/init.c    |  6 +++---
 arch/hexagon/mm/init.c  |  6 +++---
 arch/m68k/mm/init.c     |  6 +++---
 arch/m68k/mm/mcfmmu.c   |  9 +++------
 arch/nds32/mm/init.c    | 11 ++++-------
 arch/nios2/mm/init.c    |  8 +++-----
 arch/openrisc/mm/init.c |  9 +++------
 arch/um/kernel/mem.c    | 12 ++++--------
 include/linux/mm.h      |  2 +-
 mm/page_alloc.c         |  5 ++---
 12 files changed, 38 insertions(+), 60 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 12e218d3792a..667cd21393b5 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -243,21 +243,17 @@ callback_init(void * kernel_end)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] =3D {0, };
-	unsigned long dma_pfn, high_pfn;
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
+	unsigned long dma_pfn;
=20
 	dma_pfn =3D virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
-	high_pfn =3D max_pfn =3D max_low_pfn;
+	max_pfn =3D max_low_pfn;
=20
-	if (dma_pfn >=3D high_pfn)
-		zones_size[ZONE_DMA] =3D high_pfn;
-	else {
-		zones_size[ZONE_DMA] =3D dma_pfn;
-		zones_size[ZONE_NORMAL] =3D high_pfn - dma_pfn;
-	}
+	max_zone_pfn[ZONE_DMA] =3D dma_pfn;
+	max_zone_pfn[ZONE_NORMAL] =3D max_pfn;
=20
 	/* Initialize mem_map[].  */
-	free_area_init(zones_size);
+	free_area_init(max_zone_pfn);
=20
 	/* Initialize the kernel's ZERO_PGE. */
 	memset((void *)ZERO_PGE, 0, PAGE_SIZE);
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 9b374393a8f4..a97e51a3e26d 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(empty_zero_page);
 void __init paging_init(void)
 {
 	struct pglist_data *pgdat =3D NODE_DATA(0);
-	unsigned long zones_size[MAX_NR_ZONES] =3D {0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
=20
 	empty_zero_page      =3D (unsigned long) memblock_alloc(PAGE_SIZE,
 							      PAGE_SIZE);
@@ -49,11 +49,9 @@ void __init paging_init(void)
 	/*
 	 * Define zones
 	 */
-	zones_size[ZONE_NORMAL] =3D (memory_end - PAGE_OFFSET) >> PAGE_SHIFT;
-	pgdat->node_zones[ZONE_NORMAL].zone_start_pfn =3D
-		__pa(PAGE_OFFSET) >> PAGE_SHIFT;
+	max_zone_pfn[ZONE_NORMAL] =3D memory_end >> PAGE_SHIFT;
=20
-	free_area_init(zones_size);
+	free_area_init(max_zone_pfn);
 }
=20
 void __init mem_init(void)
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 1eab16b1a0bc..27a0020e3771 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -83,10 +83,10 @@ void __init paging_init(void)
 		 start_mem, end_mem);
=20
 	{
-		unsigned long zones_size[MAX_NR_ZONES] =3D {0, };
+		unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
=20
-		zones_size[ZONE_NORMAL] =3D (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
-		free_area_init(zones_size);
+		max_zone_pfn[ZONE_NORMAL] =3D end_mem >> PAGE_SHIFT;
+		free_area_init(max_zone_pfn);
 	}
 }
=20
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index c961773a6fff..f2e6c868e477 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -91,7 +91,7 @@ void sync_icache_dcache(pte_t pte)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_sizes[MAX_NR_ZONES] =3D {0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D {0, };
=20
 	/*
 	 *  This is not particularly well documented anywhere, but
@@ -101,9 +101,9 @@ void __init paging_init(void)
 	 *  adjust accordingly.
 	 */
=20
-	zones_sizes[ZONE_NORMAL] =3D max_low_pfn;
+	max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
=20
-	free_area_init(zones_sizes);  /*  sets up the zonelists and mem_map  */
+	free_area_init(max_zone_pfn);  /*  sets up the zonelists and mem_map  *=
/
=20
 	/*
 	 * Start of high memory area.  Will probably need something more
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index b88d510d4fe3..6d3147662ff2 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -84,7 +84,7 @@ void __init paging_init(void)
 	 * page_alloc get different views of the world.
 	 */
 	unsigned long end_mem =3D memory_end & PAGE_MASK;
-	unsigned long zones_size[MAX_NR_ZONES] =3D { 0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0, };
=20
 	high_memory =3D (void *) end_mem;
=20
@@ -98,8 +98,8 @@ void __init paging_init(void)
 	 */
 	set_fs (USER_DS);
=20
-	zones_size[ZONE_DMA] =3D (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
-	free_area_init(zones_size);
+	max_zone_pfn[ZONE_DMA] =3D end_mem >> PAGE_SHIFT;
+	free_area_init(max_zone_pfn);
 }
=20
 #endif /* CONFIG_MMU */
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 0ea375607767..80064e6d064f 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -39,7 +39,7 @@ void __init paging_init(void)
 	pte_t *pg_table;
 	unsigned long address, size;
 	unsigned long next_pgtable, bootmem_end;
-	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
 	enum zone_type zone;
 	int i;
=20
@@ -80,11 +80,8 @@ void __init paging_init(void)
 	}
=20
 	current->mm =3D NULL;
-
-	for (zone =3D 0; zone < MAX_NR_ZONES; zone++)
-		zones_size[zone] =3D 0x0;
-	zones_size[ZONE_DMA] =3D num_pages;
-	free_area_init(zones_size);
+	max_zone_pfn[ZONE_DMA] =3D PFN_DOWN(_ramend);
+	free_area_init(max_zone_pfn);
 }
=20
 int cf_tlb_miss(struct pt_regs *regs, int write, int dtlb, int extension=
_word)
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 0be3833f6814..91147cca4b64 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -31,16 +31,13 @@ EXPORT_SYMBOL(empty_zero_page);
=20
 static void __init zone_sizes_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
=20
-	/* Clear the zone sizes */
-	memset(zones_size, 0, sizeof(zones_size));
-
-	zones_size[ZONE_NORMAL] =3D max_low_pfn;
+	max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
 #ifdef CONFIG_HIGHMEM
-	zones_size[ZONE_HIGHMEM] =3D max_pfn;
+	max_zone_pfn[ZONE_HIGHMEM] =3D max_pfn;
 #endif
-	free_area_init(zones_size);
+	free_area_init(max_zone_pfn);
=20
 }
=20
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 2c609c2516b2..9afca77d10b1 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -46,17 +46,15 @@ pgd_t *pgd_current;
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-
-	memset(zones_size, 0, sizeof(zones_size));
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
=20
 	pagetable_init();
 	pgd_current =3D swapper_pg_dir;
=20
-	zones_size[ZONE_NORMAL] =3D max_mapnr;
+	max_zone_pfn[ZONE_NORMAL] =3D max_mapnr;
=20
 	/* pass the memory from the bootmem allocator to the main allocator */
-	free_area_init(zones_size);
+	free_area_init(max_zone_pfn);
=20
 	flush_dcache_range((unsigned long)empty_zero_page,
 			(unsigned long)empty_zero_page + PAGE_SIZE);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index 1f87b524db78..f94fe6d3f499 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -45,17 +45,14 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
=20
 static void __init zone_sizes_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-
-	/* Clear the zone sizes */
-	memset(zones_size, 0, sizeof(zones_size));
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
=20
 	/*
 	 * We use only ZONE_NORMAL
 	 */
-	zones_size[ZONE_NORMAL] =3D max_low_pfn;
+	max_zone_pfn[ZONE_NORMAL] =3D max_low_pfn;
=20
-	free_area_init(zones_size);
+	free_area_init(max_zone_pfn);
 }
=20
 extern const char _s_kernel_ro[], _e_kernel_ro[];
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 30885d0b94ac..401b22f14743 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -158,8 +158,8 @@ static void __init fixaddr_user_init( void)
=20
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES], vaddr;
-	int i;
+	unsigned long max_zone_pfn[MAX_NR_ZONES] =3D { 0 };
+	unsigned long vaddr;
=20
 	empty_zero_page =3D (unsigned long *) memblock_alloc_low(PAGE_SIZE,
 							       PAGE_SIZE);
@@ -167,12 +167,8 @@ void __init paging_init(void)
 		panic("%s: Failed to allocate %lu bytes align=3D%lx\n",
 		      __func__, PAGE_SIZE, PAGE_SIZE);
=20
-	for (i =3D 0; i < ARRAY_SIZE(zones_size); i++)
-		zones_size[i] =3D 0;
-
-	zones_size[ZONE_NORMAL] =3D (end_iomem >> PAGE_SHIFT) -
-		(uml_physmem >> PAGE_SHIFT);
-	free_area_init(zones_size);
+	max_zone_pfn[ZONE_NORMAL] =3D end_iomem >> PAGE_SHIFT;
+	free_area_init(max_zone_pfn);
=20
 	/*
 	 * Fixed mappings, only the page table structure has to be
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5903bbbdb336..d9a256a97ac5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,7 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct=
 *mm, pud_t *pud)
 }
=20
 extern void __init pagecache_init(void);
-extern void free_area_init(unsigned long * zones_size);
+extern void free_area_init(unsigned long * max_zone_pfn);
 extern void __init free_area_init_node(int nid, unsigned long * zones_si=
ze,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4530e9cfd9f7..530701b38bc7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7700,11 +7700,10 @@ void __init set_dma_reserve(unsigned long new_dma=
_reserve)
 	dma_reserve =3D new_dma_reserve;
 }
=20
-void __init free_area_init(unsigned long *zones_size)
+void __init free_area_init(unsigned long *max_zone_pfn)
 {
 	init_unavailable_mem();
-	free_area_init_node(0, zones_size,
-			__pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
+	free_area_init_nodes(max_zone_pfn);
 }
=20
 static int page_alloc_cpu_dead(unsigned int cpu)
--=20
2.26.1
