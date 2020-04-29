Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 05/20] mm: use free_area_init() instead of free_area_init_nodes()
Date: Wed, 29 Apr 2020 15:11:11 +0300
Message-ID: <20200429121126.17989-6-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121111.gQVAH4NtT1NhSe4Ig-jEg9FmbFhbPn3ClNQ3zeKWg_c@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() has effectively became a wrapper for
free_area_init_nodes() and there is no point of keeping it. Still
free_area_init() name is shorter and more general as it does not imply
necessity to initialize multiple nodes.

Rename free_area_init_nodes() to free_area_init(), update the callers and
drop old version of free_area_init().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/init.c             |  2 +-
 arch/ia64/mm/contig.c            |  2 +-
 arch/ia64/mm/discontig.c         |  2 +-
 arch/microblaze/mm/init.c        |  2 +-
 arch/mips/loongson64/numa.c      |  2 +-
 arch/mips/mm/init.c              |  2 +-
 arch/mips/sgi-ip27/ip27-memory.c |  2 +-
 arch/powerpc/mm/mem.c            |  2 +-
 arch/riscv/mm/init.c             |  2 +-
 arch/s390/mm/init.c              |  2 +-
 arch/sh/mm/init.c                |  2 +-
 arch/sparc/mm/init_64.c          |  2 +-
 arch/x86/mm/init.c               |  2 +-
 include/linux/mm.h               |  7 +++----
 mm/page_alloc.c                  | 10 ++--------
 15 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e42727e3568e..a650adb358ee 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -206,7 +206,7 @@ static void __init zone_sizes_init(unsigned long min,=
 unsigned long max)
 #endif
 	max_zone_pfns[ZONE_NORMAL] =3D max;
=20
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 #else
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 5b00dc3898e1..8786fa5c7612 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -210,6 +210,6 @@ paging_init (void)
 		printk("Virtual mem_map starts at 0x%p\n", mem_map);
 	}
 #endif /* !CONFIG_VIRTUAL_MEM_MAP */
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 	zero_page_memmap_ptr =3D virt_to_page(ia64_imva(empty_zero_page));
 }
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 4f33f6e7e206..dd8284bcbf16 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -627,7 +627,7 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA32] =3D max_dma;
 #endif
 	max_zone_pfns[ZONE_NORMAL] =3D max_pfn;
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
=20
 	zero_page_memmap_ptr =3D virt_to_page(ia64_imva(empty_zero_page));
 }
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 1ffbfa96b9b8..dcaa53d11339 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -112,7 +112,7 @@ static void __init paging_init(void)
 #endif
=20
 	/* We don't have holes in memory map */
-	free_area_init_nodes(zones_size);
+	free_area_init(zones_size);
 }
=20
 void __init setup_memory(void)
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 1ae072df4831..901f5be5ee76 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -247,7 +247,7 @@ void __init paging_init(void)
 	zones_size[ZONE_DMA32] =3D MAX_DMA32_PFN;
 #endif
 	zones_size[ZONE_NORMAL] =3D max_low_pfn;
-	free_area_init_nodes(zones_size);
+	free_area_init(zones_size);
 }
=20
 void __init mem_init(void)
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 79684000de0e..19719e8b41a5 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -418,7 +418,7 @@ void __init paging_init(void)
 	}
 #endif
=20
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-m=
emory.c
index a45691e6ab90..1213215ea965 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -419,7 +419,7 @@ void __init paging_init(void)
=20
 	pagetable_init();
 	zones_size[ZONE_NORMAL] =3D max_low_pfn;
-	free_area_init_nodes(zones_size);
+	free_area_init(zones_size);
 }
=20
 void __init mem_init(void)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 041ed7cfd341..0fcea21f26b4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -271,7 +271,7 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_HIGHMEM] =3D max_pfn;
 #endif
=20
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
=20
 	mark_nonram_nosave();
 }
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b55be44ff9bd..f2ceab77b8e6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -39,7 +39,7 @@ static void __init zone_sizes_init(void)
 #endif
 	max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
=20
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 static void setup_zero_page(void)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 87b2d024e75a..b11bcf4da531 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -122,7 +122,7 @@ void __init paging_init(void)
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 	max_zone_pfns[ZONE_DMA] =3D PFN_DOWN(MAX_DMA_ADDRESS);
 	max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 void mark_rodata_ro(void)
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 8d2a68aea1fc..628f461b8993 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -334,7 +334,7 @@ void __init paging_init(void)
=20
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 	max_zone_pfns[ZONE_NORMAL] =3D max_low_pfn;
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 unsigned int mem_init_done =3D 0;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 1cf0d666dea3..79d3c5e0802e 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2488,7 +2488,7 @@ void __init paging_init(void)
=20
 		max_zone_pfns[ZONE_NORMAL] =3D end_pfn;
=20
-		free_area_init_nodes(max_zone_pfns);
+		free_area_init(max_zone_pfns);
 	}
=20
 	printk("Booting Linux...\n");
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1bba16c5742b..4016f2bf5d87 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -949,7 +949,7 @@ void __init zone_sizes_init(void)
 	max_zone_pfns[ZONE_HIGHMEM]	=3D max_pfn;
 #endif
=20
-	free_area_init_nodes(max_zone_pfns);
+	free_area_init(max_zone_pfns);
 }
=20
 __visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) =
=3D {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d9a256a97ac5..1c2ecb42e043 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2272,7 +2272,6 @@ static inline spinlock_t *pud_lock(struct mm_struct=
 *mm, pud_t *pud)
 }
=20
 extern void __init pagecache_init(void);
-extern void free_area_init(unsigned long * max_zone_pfn);
 extern void __init free_area_init_node(int nid, unsigned long * zones_si=
ze,
 		unsigned long zone_start_pfn, unsigned long *zholes_size);
 extern void free_initmem(void);
@@ -2353,21 +2352,21 @@ static inline unsigned long get_num_physpages(voi=
d)
  *
  * An architecture is expected to register range of page frames backed b=
y
  * physical memory with memblock_add[_node]() before calling
- * free_area_init_nodes() passing in the PFN each zone ends at. At a bas=
ic
+ * free_area_init() passing in the PFN each zone ends at. At a basic
  * usage, an architecture is expected to do something like
  *
  * unsigned long max_zone_pfns[MAX_NR_ZONES] =3D {max_dma, max_normal_pf=
n,
  * 							 max_highmem_pfn};
  * for_each_valid_physical_page_range()
  * 	memblock_add_node(base, size, nid)
- * free_area_init_nodes(max_zone_pfns);
+ * free_area_init(max_zone_pfns);
  *
  * free_bootmem_with_active_regions() calls free_bootmem_node() for each
  * registered physical page range.  Similarly
  * sparse_memory_present_with_active_regions() calls memory_present() fo=
r
  * each range when SPARSEMEM is enabled.
  */
-extern void free_area_init_nodes(unsigned long *max_zone_pfn);
+void free_area_init(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
 unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
 						unsigned long end_pfn);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 530701b38bc7..7f6a3081edb8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7428,7 +7428,7 @@ static void check_for_memory(pg_data_t *pgdat, int =
nid)
 }
=20
 /**
- * free_area_init_nodes - Initialise all pg_data_t and zone data
+ * free_area_init - Initialise all pg_data_t and zone data
  * @max_zone_pfn: an array of max PFNs for each zone
  *
  * This will call free_area_init_node() for each active node in the syst=
em.
@@ -7440,7 +7440,7 @@ static void check_for_memory(pg_data_t *pgdat, int =
nid)
  * starts where the previous one ended. For example, ZONE_DMA32 starts
  * at arch_max_dma_pfn.
  */
-void __init free_area_init_nodes(unsigned long *max_zone_pfn)
+void __init free_area_init(unsigned long *max_zone_pfn)
 {
 	unsigned long start_pfn, end_pfn;
 	int i, nid;
@@ -7700,12 +7700,6 @@ void __init set_dma_reserve(unsigned long new_dma_=
reserve)
 	dma_reserve =3D new_dma_reserve;
 }
=20
-void __init free_area_init(unsigned long *max_zone_pfn)
-{
-	init_unavailable_mem();
-	free_area_init_nodes(max_zone_pfn);
-}
-
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
=20
--=20
2.26.1
