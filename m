Return-Path: <SRS0=W8sI=6N=kvack.org=owner-linux-mm@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 03/20] mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option
Date: Wed, 29 Apr 2020 15:11:09 +0300
Message-ID: <20200429121126.17989-4-rppt@kernel.org>
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, Hoan Tran <Hoan@os.amperecomputing.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>, Ley Foon Tan <ley.foon.tan@intel.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@kernel.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>, Qian Cai <cai@lca.pw>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Tony Luck <tony.luck@intel.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429121109.GynqbDBs_kchxb5LG_LXJ4ii45jMRz6Y3NoWv8_oL3Y@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The CONFIG_HAVE_MEMBLOCK_NODE_MAP is used to differentiate initialization
of nodes and zones structures between the systems that have region to nod=
e
mapping in memblock and those that don't.

Currently all the NUMA architectures enable this option and for the
non-NUMA systems we can presume that all the memory belongs to node 0 and
therefore the compile time configuration option is not required.

The remaining few architectures that use DISCONTIGMEM without NUMA are
easily updated to use memblock_add_node() instead of memblock_add() and
thus have proper correspondence of memblock regions to NUMA nodes.

Still, free_area_init_node() must have a backward compatible version
because its semantics with and without CONFIG_HAVE_MEMBLOCK_NODE_MAP is
different. Once all the architectures will use the new semantics, the
entire compatibility layer can be dropped.

To avoid addition of extra run time memory to store node id for
architectures that keep memblock but have only a single node, the node id
field of the memblock_region is guarded by CONFIG_NEED_MULTIPLE_NODES and
the corresponding accessors presume that in those cases it is always 0.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 .../vm/numa-memblock/arch-support.txt         |  34 ------
 arch/alpha/mm/numa.c                          |   4 +-
 arch/arm64/Kconfig                            |   1 -
 arch/ia64/Kconfig                             |   1 -
 arch/m68k/mm/motorola.c                       |   4 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/mips/Kconfig                             |   1 -
 arch/powerpc/Kconfig                          |   1 -
 arch/riscv/Kconfig                            |   1 -
 arch/s390/Kconfig                             |   1 -
 arch/sh/Kconfig                               |   1 -
 arch/sparc/Kconfig                            |   1 -
 arch/x86/Kconfig                              |   1 -
 include/linux/memblock.h                      |   8 +-
 include/linux/mm.h                            |  12 +-
 include/linux/mmzone.h                        |   2 +-
 mm/Kconfig                                    |   3 -
 mm/memblock.c                                 |  11 +-
 mm/memory_hotplug.c                           |   4 -
 mm/page_alloc.c                               | 103 ++++++++++--------
 20 files changed, 74 insertions(+), 121 deletions(-)
 delete mode 100644 Documentation/features/vm/numa-memblock/arch-support.=
txt

diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/D=
ocumentation/features/vm/numa-memblock/arch-support.txt
deleted file mode 100644
index 3004beb0fd71..000000000000
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Feature name:          numa-memblock
-#         Kconfig:       HAVE_MEMBLOCK_NODE_MAP
-#         description:   arch supports NUMA aware memblocks
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: |  ..  |
-    |         arm: |  ..  |
-    |       arm64: |  ok  |
-    |         c6x: |  ..  |
-    |        csky: |  ..  |
-    |       h8300: |  ..  |
-    |     hexagon: |  ..  |
-    |        ia64: |  ok  |
-    |        m68k: |  ..  |
-    |  microblaze: |  ok  |
-    |        mips: |  ok  |
-    |       nds32: | TODO |
-    |       nios2: |  ..  |
-    |    openrisc: |  ..  |
-    |      parisc: |  ..  |
-    |     powerpc: |  ok  |
-    |       riscv: |  ok  |
-    |        s390: |  ok  |
-    |          sh: |  ok  |
-    |       sparc: |  ok  |
-    |          um: |  ..  |
-    |   unicore32: |  ..  |
-    |         x86: |  ok  |
-    |      xtensa: |  ..  |
-    -----------------------
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index d0b73371e985..a24cd13e71cb 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -144,8 +144,8 @@ setup_memory_node(int nid, void *kernel_end)
 	if (!nid && (node_max_pfn < end_kernel_pfn || node_min_pfn > start_kern=
el_pfn))
 		panic("kernel loaded out of ram");
=20
-	memblock_add(PFN_PHYS(node_min_pfn),
-		     (node_max_pfn - node_min_pfn) << PAGE_SHIFT);
+	memblock_add_node(PFN_PHYS(node_min_pfn),
+			  (node_max_pfn - node_min_pfn) << PAGE_SHIFT, nid);
=20
 	/* Zone start phys-addr must be 2^(MAX_ORDER-1) aligned.
 	   Note that we round this down, not up - node memory
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..957151013d10 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -156,7 +156,6 @@ config ARM64
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
-	select HAVE_MEMBLOCK_NODE_MAP if NUMA
 	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bab7cd878464..88b05b5256a9 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -31,7 +31,6 @@ config IA64
 	select HAVE_FUNCTION_TRACER
 	select TTY
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select DMA_NONCOHERENT_MMAP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index fc16190ec2d6..84ab5963cabb 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -386,7 +386,7 @@ void __init paging_init(void)
=20
 	min_addr =3D m68k_memory[0].addr;
 	max_addr =3D min_addr + m68k_memory[0].size;
-	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
 	for (i =3D 1; i < m68k_num_memory;) {
 		if (m68k_memory[i].addr < min_addr) {
 			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n=
",
@@ -397,7 +397,7 @@ void __init paging_init(void)
 				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
 			continue;
 		}
-		memblock_add(m68k_memory[i].addr, m68k_memory[i].size);
+		memblock_add_node(m68k_memory[i].addr, m68k_memory[i].size, i);
 		addr =3D m68k_memory[i].addr + m68k_memory[i].size;
 		if (addr > max_addr)
 			max_addr =3D addr;
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 9606c244b5b8..d262ac0c8714 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -32,7 +32,6 @@ config MICROBLAZE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_OPROFILE
 	select HAVE_PCI
 	select IRQ_DOMAIN
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 690718b3701a..94a91b5b7759 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -72,7 +72,6 @@ config MIPS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_OPROFILE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a9260..5f86b22b7d2c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -210,7 +210,6 @@ config PPC
 	select HAVE_KRETPROBES
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI				if PERF_EVENTS || (PPC64 && PPC_BOOK3S)
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if (PPC64 && PPC_BOOK3S)
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62f7bfeb709e..e22858e8f88e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,7 +32,6 @@ config RISCV
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_PERF_EVENTS
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2167bce993ff..d6dc6933adc2 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -162,7 +162,6 @@ config S390
 	select HAVE_LIVEPATCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
 	select MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index b4f0e37b83eb..be7c4f699113 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -9,7 +9,6 @@ config SUPERH
 	select CLKDEV_LOOKUP
 	select DMA_DECLARE_COHERENT
 	select HAVE_IDE if HAS_IOPORT_MAP
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_OPROFILE
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_PERF_EVENTS
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index da515fdad83d..795206b7b552 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -65,7 +65,6 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1197b5596d5a..f8bf218a169c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -190,7 +190,6 @@ config X86
 	select HAVE_KRETPROBES
 	select HAVE_KVM
 	select HAVE_LIVEPATCH			if X86_64
-	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_MOVE_PMD
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6bc37a731d27..45abfc54da37 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -50,7 +50,7 @@ struct memblock_region {
 	phys_addr_t base;
 	phys_addr_t size;
 	enum memblock_flags flags;
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	int nid;
 #endif
 };
@@ -215,7 +215,6 @@ static inline bool memblock_is_nomap(struct memblock_=
region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pf=
n,
@@ -234,7 +233,6 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned=
 long *out_start_pfn,
 #define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		\
 	for (i =3D -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >=3D 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
=20
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
@@ -310,10 +308,10 @@ void __next_mem_pfn_range_in_zone(u64 *idx, struct =
zone *zone,
 	for_each_mem_range_rev(i, &memblock.memory, &memblock.reserved,	\
 			       nid, flags, p_start, p_end, p_nid)
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int memblock_set_node(phys_addr_t base, phys_addr_t size,
 		      struct memblock_type *type, int nid);
=20
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 static inline void memblock_set_region_node(struct memblock_region *r, i=
nt nid)
 {
 	r->nid =3D nid;
@@ -332,7 +330,7 @@ static inline int memblock_get_region_node(const stru=
ct memblock_region *r)
 {
 	return 0;
 }
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
+#endif /* CONFIG_NEED_MULTIPLE_NODES */
=20
 /* Flags for memblock allocation APIs */
 #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a404026d14d4..5903bbbdb336 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2344,9 +2344,8 @@ static inline unsigned long get_num_physpages(void)
 	return phys_pages;
 }
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 /*
- * With CONFIG_HAVE_MEMBLOCK_NODE_MAP set, an architecture may initialis=
e its
+ * Using memblock node mappings, an architecture may initialise its
  * zones, allocate the backing mem_map and account for memory holes in a=
 more
  * architecture independent manner. This is a substitute for creating th=
e
  * zone_sizes[] and zholes_size[] arrays and passing them to
@@ -2367,9 +2366,6 @@ static inline unsigned long get_num_physpages(void)
  * registered physical page range.  Similarly
  * sparse_memory_present_with_active_regions() calls memory_present() fo=
r
  * each range when SPARSEMEM is enabled.
- *
- * See mm/page_alloc.c for more information on each function exposed by
- * CONFIG_HAVE_MEMBLOCK_NODE_MAP.
  */
 extern void free_area_init_nodes(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
@@ -2384,13 +2380,9 @@ extern void free_bootmem_with_active_regions(int n=
id,
 						unsigned long max_low_pfn);
 extern void sparse_memory_present_with_active_regions(int nid);
=20
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
-
-#if !defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) && \
-    !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID)
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 static inline int early_pfn_to_nid(unsigned long pfn)
 {
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
 	return 0;
 }
 #else
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7b5b6eba402f..ffc2a3d6036b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -874,7 +874,7 @@ extern int movable_zone;
 #ifdef CONFIG_HIGHMEM
 static inline int zone_movable_is_highmem(void)
 {
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	return movable_zone =3D=3D ZONE_HIGHMEM;
 #else
 	return (ZONE_MOVABLE - 1) =3D=3D ZONE_HIGHMEM;
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..aaa5bdaa1c8a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -126,9 +126,6 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.
=20
-config HAVE_MEMBLOCK_NODE_MAP
-	bool
-
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
=20
diff --git a/mm/memblock.c b/mm/memblock.c
index 43e2fd3006c1..743659d88fc4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -620,7 +620,7 @@ static int __init_memblock memblock_add_range(struct =
memblock_type *type,
 		 * area, insert that portion.
 		 */
 		if (rbase > base) {
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 			WARN_ON(nid !=3D memblock_get_region_node(rgn));
 #endif
 			WARN_ON(flags !=3D rgn->flags);
@@ -1197,7 +1197,6 @@ void __init_memblock __next_mem_range_rev(u64 *idx,=
 int nid,
 	*idx =3D ULLONG_MAX;
 }
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 /*
  * Common iterator interface used to define for_each_mem_pfn_range().
  */
@@ -1247,6 +1246,7 @@ void __init_memblock __next_mem_pfn_range(int *idx,=
 int nid,
 int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size=
,
 				      struct memblock_type *type, int nid)
 {
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	int start_rgn, end_rgn;
 	int i, ret;
=20
@@ -1258,9 +1258,10 @@ int __init_memblock memblock_set_node(phys_addr_t =
base, phys_addr_t size,
 		memblock_set_region_node(&type->regions[i], nid);
=20
 	memblock_merge_regions(type);
+#endif
 	return 0;
 }
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /**
  * __next_mem_pfn_range_in_zone - iterator for for_each_*_range_in_zone(=
)
@@ -1799,7 +1800,6 @@ bool __init_memblock memblock_is_map_memory(phys_ad=
dr_t addr)
 	return !memblock_is_nomap(&memblock.memory.regions[i]);
 }
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 int __init_memblock memblock_search_pfn_nid(unsigned long pfn,
 			 unsigned long *start_pfn, unsigned long *end_pfn)
 {
@@ -1814,7 +1814,6 @@ int __init_memblock memblock_search_pfn_nid(unsigne=
d long pfn,
=20
 	return memblock_get_region_node(&type->regions[mid]);
 }
-#endif
=20
 /**
  * memblock_is_region_memory - check if a region is a subset of memory
@@ -1905,7 +1904,7 @@ static void __init_memblock memblock_dump(struct me=
mblock_type *type)
 		size =3D rgn->size;
 		end =3D base + size - 1;
 		flags =3D rgn->flags;
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 		if (memblock_get_region_node(rgn) !=3D MAX_NUMNODES)
 			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
 				 memblock_get_region_node(rgn));
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fc0aad0bc1f5..e67dc501576a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1372,11 +1372,7 @@ check_pages_isolated_cb(unsigned long start_pfn, u=
nsigned long nr_pages,
=20
 static int __init cmdline_parse_movable_node(char *p)
 {
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	movable_node_enabled =3D true;
-#else
-	pr_warn("movable_node parameter depends on CONFIG_HAVE_MEMBLOCK_NODE_MA=
P to work properly\n");
-#endif
 	return 0;
 }
 early_param("movable_node", cmdline_parse_movable_node);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a802ee47e715..4530e9cfd9f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -335,7 +335,6 @@ static unsigned long nr_kernel_pages __initdata;
 static unsigned long nr_all_pages __initdata;
 static unsigned long dma_reserve __initdata;
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 static unsigned long arch_zone_lowest_possible_pfn[MAX_NR_ZONES] __initd=
ata;
 static unsigned long arch_zone_highest_possible_pfn[MAX_NR_ZONES] __init=
data;
 static unsigned long required_kernelcore __initdata;
@@ -348,7 +347,6 @@ static bool mirrored_kernelcore __meminitdata;
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from =
*/
 int movable_zone;
 EXPORT_SYMBOL(movable_zone);
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
=20
 #if MAX_NUMNODES > 1
 unsigned int nr_node_ids __read_mostly =3D MAX_NUMNODES;
@@ -1499,8 +1497,7 @@ void __free_pages_core(struct page *page, unsigned =
int order)
 	__free_pages(page, order);
 }
=20
-#if defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID) || \
-	defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP)
+#ifdef CONFIG_NEED_MULTIPLE_NODES
=20
 static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
=20
@@ -1542,7 +1539,7 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
=20
 	return nid;
 }
-#endif
+#endif /* CONFIG_NEED_MULTIPLE_NODES */
=20
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES
 /* Only safe to use early in boot when initialisation is single-threaded=
 */
@@ -5924,7 +5921,6 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
 static bool __meminit
 overlap_memmap_init(unsigned long zone, unsigned long *pfn)
 {
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
 	static struct memblock_region *r;
=20
 	if (mirrored_kernelcore && zone =3D=3D ZONE_MOVABLE) {
@@ -5940,7 +5936,6 @@ overlap_memmap_init(unsigned long zone, unsigned lo=
ng *pfn)
 			return true;
 		}
 	}
-#endif
 	return false;
 }
=20
@@ -6323,8 +6318,6 @@ void __meminit init_currently_empty_zone(struct zon=
e *zone,
 	zone->initialized =3D 1;
 }
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-
 /**
  * free_bootmem_with_active_regions - Call memblock_free_early_nid for e=
ach active range
  * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are free=
d.
@@ -6575,8 +6568,7 @@ static unsigned long __init zone_absent_pages_in_no=
de(int nid,
 	return nr_absent;
 }
=20
-#else /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
-static inline unsigned long __init zone_spanned_pages_in_node(int nid,
+static inline unsigned long __init compat_zone_spanned_pages_in_node(int=
 nid,
 					unsigned long zone_type,
 					unsigned long node_start_pfn,
 					unsigned long node_end_pfn,
@@ -6595,7 +6587,7 @@ static inline unsigned long __init zone_spanned_pag=
es_in_node(int nid,
 	return zones_size[zone_type];
 }
=20
-static inline unsigned long __init zone_absent_pages_in_node(int nid,
+static inline unsigned long __init compat_zone_absent_pages_in_node(int =
nid,
 						unsigned long zone_type,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn,
@@ -6607,13 +6599,12 @@ static inline unsigned long __init zone_absent_pa=
ges_in_node(int nid,
 	return zholes_size[zone_type];
 }
=20
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
-
 static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 						unsigned long node_start_pfn,
 						unsigned long node_end_pfn,
 						unsigned long *zones_size,
-						unsigned long *zholes_size)
+						unsigned long *zholes_size,
+						bool compat)
 {
 	unsigned long realtotalpages =3D 0, totalpages =3D 0;
 	enum zone_type i;
@@ -6621,17 +6612,38 @@ static void __init calculate_node_totalpages(stru=
ct pglist_data *pgdat,
 	for (i =3D 0; i < MAX_NR_ZONES; i++) {
 		struct zone *zone =3D pgdat->node_zones + i;
 		unsigned long zone_start_pfn, zone_end_pfn;
+		unsigned long spanned, absent;
 		unsigned long size, real_size;
=20
-		size =3D zone_spanned_pages_in_node(pgdat->node_id, i,
-						  node_start_pfn,
-						  node_end_pfn,
-						  &zone_start_pfn,
-						  &zone_end_pfn,
-						  zones_size);
-		real_size =3D size - zone_absent_pages_in_node(pgdat->node_id, i,
-						  node_start_pfn, node_end_pfn,
-						  zholes_size);
+		if (compat) {
+			spanned =3D compat_zone_spanned_pages_in_node(
+						pgdat->node_id, i,
+						node_start_pfn,
+						node_end_pfn,
+						&zone_start_pfn,
+						&zone_end_pfn,
+						zones_size);
+			absent =3D compat_zone_absent_pages_in_node(
+						pgdat->node_id, i,
+						node_start_pfn,
+						node_end_pfn,
+						zholes_size);
+		} else {
+			spanned =3D zone_spanned_pages_in_node(pgdat->node_id, i,
+						node_start_pfn,
+						node_end_pfn,
+						&zone_start_pfn,
+						&zone_end_pfn,
+						zones_size);
+			absent =3D zone_absent_pages_in_node(pgdat->node_id, i,
+						node_start_pfn,
+						node_end_pfn,
+						zholes_size);
+		}
+
+		size =3D spanned;
+		real_size =3D size - absent;
+
 		if (size)
 			zone->zone_start_pfn =3D zone_start_pfn;
 		else
@@ -6931,10 +6943,8 @@ static void __ref alloc_node_mem_map(struct pglist=
_data *pgdat)
 	 */
 	if (pgdat =3D=3D NODE_DATA(0)) {
 		mem_map =3D NODE_DATA(0)->node_mem_map;
-#if defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) || defined(CONFIG_FLATMEM)
 		if (page_to_pfn(mem_map) !=3D pgdat->node_start_pfn)
 			mem_map -=3D offset;
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 	}
 #endif
 }
@@ -6951,9 +6961,10 @@ static inline void pgdat_set_deferred_range(pg_dat=
a_t *pgdat)
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
 #endif
=20
-void __init free_area_init_node(int nid, unsigned long *zones_size,
-				   unsigned long node_start_pfn,
-				   unsigned long *zholes_size)
+static void __init __free_area_init_node(int nid, unsigned long *zones_s=
ize,
+					 unsigned long node_start_pfn,
+					 unsigned long *zholes_size,
+					 bool compat)
 {
 	pg_data_t *pgdat =3D NODE_DATA(nid);
 	unsigned long start_pfn =3D 0;
@@ -6965,16 +6976,16 @@ void __init free_area_init_node(int nid, unsigned=
 long *zones_size,
 	pgdat->node_id =3D nid;
 	pgdat->node_start_pfn =3D node_start_pfn;
 	pgdat->per_cpu_nodestats =3D NULL;
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-	get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
-	pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
-		(u64)start_pfn << PAGE_SHIFT,
-		end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
-#else
-	start_pfn =3D node_start_pfn;
-#endif
+	if (!compat) {
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
+			(u64)start_pfn << PAGE_SHIFT,
+			end_pfn ? ((u64)end_pfn << PAGE_SHIFT) - 1 : 0);
+	} else {
+		start_pfn =3D node_start_pfn;
+	}
 	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size);
+				  zones_size, zholes_size, compat);
=20
 	alloc_node_mem_map(pgdat);
 	pgdat_set_deferred_range(pgdat);
@@ -6982,6 +6993,14 @@ void __init free_area_init_node(int nid, unsigned =
long *zones_size,
 	free_area_init_core(pgdat);
 }
=20
+void __init free_area_init_node(int nid, unsigned long *zones_size,
+				unsigned long node_start_pfn,
+				unsigned long *zholes_size)
+{
+	__free_area_init_node(nid, zones_size, node_start_pfn, zholes_size,
+			      true);
+}
+
 #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
 /*
  * Initialize all valid struct pages in the range [spfn, epfn) and mark =
them
@@ -7065,8 +7084,6 @@ static inline void __init init_unavailable_mem(void=
)
 }
 #endif /* !CONFIG_FLAT_NODE_MEM_MAP */
=20
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-
 #if MAX_NUMNODES > 1
 /*
  * Figure out the number of possible node ids.
@@ -7495,8 +7512,8 @@ void __init free_area_init_nodes(unsigned long *max=
_zone_pfn)
 	init_unavailable_mem();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat =3D NODE_DATA(nid);
-		free_area_init_node(nid, NULL,
-				find_min_pfn_for_node(nid), NULL);
+		__free_area_init_node(nid, NULL,
+				      find_min_pfn_for_node(nid), NULL, false);
=20
 		/* Any memory on that node */
 		if (pgdat->node_present_pages)
@@ -7561,8 +7578,6 @@ static int __init cmdline_parse_movablecore(char *p=
)
 early_param("kernelcore", cmdline_parse_kernelcore);
 early_param("movablecore", cmdline_parse_movablecore);
=20
-#endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
-
 void adjust_managed_page_count(struct page *page, long count)
 {
 	atomic_long_add(count, &page_zone(page)->managed_pages);
--=20
2.26.1
