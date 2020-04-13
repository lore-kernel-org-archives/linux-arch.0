Return-Path: <SRS0=XT2V=55=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Mon, 13 Apr 2020 22:53:03 +1000
Message-ID: <20200413125303.423864-5-npiggin@gmail.com>
In-Reply-To: <20200413125303.423864-1-npiggin@gmail.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200413125303.hRvbiPgbVOAlwXOEnLFGV518t9tDDfLoQP4AAPMin3g@z>

For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappin=
gs,
have vmalloc attempt to allocate PMD-sized pages first, before falling ba=
ck
to small pages. Allocations which use something other than PAGE_KERNEL
protections are not permitted to use huge pages yet, not all callers expe=
ct
this (e.g., module allocations vs strict module rwx).

This gives a 6x reduction in dTLB misses for a `git diff` (of linux), fro=
m
45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.

This can result in more internal fragmentation and memory overhead for a
given allocation. It can also cause greater NUMA unbalance on hashdist
allocations.

There may be other callers that expect small pages under vmalloc but use
PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
alternative would be a new function or flag which enables large mappings,
and use that in callers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/vmalloc.h |   2 +
 mm/vmalloc.c            | 135 +++++++++++++++++++++++++++++-----------
 2 files changed, 102 insertions(+), 35 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 291313a7e663..853b82eac192 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialize=
d */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory *=
/
+#define VM_HUGE_PAGES		0x00000100	/* may use huge pages */
=20
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLO=
C.
@@ -58,6 +59,7 @@ struct vm_struct {
 	unsigned long		size;
 	unsigned long		flags;
 	struct page		**pages;
+	unsigned int		page_order;
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
 	const void		*caller;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index c898d16ddd25..7b7e992c5ff1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -436,7 +436,7 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned =
long addr,
  *
  * Ie. pte at addr+N*PAGE_SIZE shall point to pfn corresponding to pages=
[N]
  */
-static int vmap_pages_range_noflush(unsigned long start, unsigned long e=
nd,
+static int vmap_small_pages_range_noflush(unsigned long start, unsigned =
long end,
 				   pgprot_t prot, struct page **pages)
 {
 	pgd_t *pgd;
@@ -457,13 +457,44 @@ static int vmap_pages_range_noflush(unsigned long s=
tart, unsigned long end,
 	return nr;
 }
=20
+static int vmap_pages_range_noflush(unsigned long start, unsigned long e=
nd,
+				    pgprot_t prot, struct page **pages,
+				    unsigned int page_shift)
+{
+	if (page_shift =3D=3D PAGE_SIZE) {
+		return vmap_small_pages_range_noflush(start, end, prot, pages);
+	} else {
+		unsigned long addr =3D start;
+		unsigned int i, nr =3D (end - start) >> page_shift;
+
+		for (i =3D 0; i < nr; i++) {
+			int err;
+
+			err =3D vmap_range_noflush(addr,
+					addr + (1UL << page_shift),
+					__pa(page_address(pages[i])), prot,
+					page_shift);
+			if (err)
+				return err;
+
+			addr +=3D 1UL << page_shift;
+		}
+
+		return 0;
+	}
+}
+
 static int vmap_pages_range(unsigned long start, unsigned long end,
-			   pgprot_t prot, struct page **pages)
+			    pgprot_t prot, struct page **pages,
+			    unsigned int page_shift)
 {
 	int ret;
=20
-	ret =3D vmap_pages_range_noflush(start, end, prot, pages);
+	BUG_ON(page_shift < PAGE_SHIFT);
+
+	ret =3D vmap_pages_range_noflush(start, end, prot, pages, page_shift);
 	flush_cache_vmap(start, end);
+
 	return ret;
 }
=20
@@ -2064,7 +2095,7 @@ void *vm_map_ram(struct page **pages, unsigned int =
count, int node, pgprot_t pro
=20
 	kasan_unpoison_vmalloc(mem, size);
=20
-	if (vmap_pages_range(addr, addr + size, prot, pages) < 0) {
+	if (vmap_pages_range(addr, addr + size, prot, pages, PAGE_SHIFT) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
@@ -2230,7 +2261,7 @@ void __init vmalloc_init(void)
 int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 			     pgprot_t prot, struct page **pages)
 {
-	return vmap_pages_range_noflush(addr, addr + size, prot, pages);
+	return vmap_pages_range_noflush(addr, addr + size, prot, pages, PAGE_SH=
IFT);
 }
=20
 /**
@@ -2277,7 +2308,7 @@ int map_vm_area(struct vm_struct *area, pgprot_t pr=
ot, struct page **pages)
 	unsigned long end =3D addr + get_vm_area_size(area);
 	int err;
=20
-	err =3D vmap_pages_range(addr, end, prot, pages);
+	err =3D vmap_pages_range(addr, end, prot, pages, PAGE_SHIFT);
=20
 	return err > 0 ? 0 : err;
 }
@@ -2325,9 +2356,11 @@ static struct vm_struct *__get_vm_area_node(unsign=
ed long size,
 	if (unlikely(!size))
 		return NULL;
=20
-	if (flags & VM_IOREMAP)
-		align =3D 1ul << clamp_t(int, get_count_order_long(size),
-				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
+	if (flags & VM_IOREMAP) {
+		align =3D max(align,
+			    1ul << clamp_t(int, get_count_order_long(size),
+					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
+	}
=20
 	area =3D kzalloc_node(sizeof(*area), gfp_mask & GFP_RECLAIM_MASK, node)=
;
 	if (unlikely(!area))
@@ -2534,7 +2567,7 @@ static void __vunmap(const void *addr, int dealloca=
te_pages)
 			struct page *page =3D area->pages[i];
=20
 			BUG_ON(!page);
-			__free_pages(page, 0);
+			__free_pages(page, area->page_order);
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
=20
@@ -2672,26 +2705,29 @@ void *vmap(struct page **pages, unsigned int coun=
t,
 EXPORT_SYMBOL(vmap);
=20
 static void *__vmalloc_node(unsigned long size, unsigned long align,
-			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, const void *caller);
+			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller);
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
-				 pgprot_t prot, int node)
+				 pgprot_t prot, unsigned int page_shift,
+				 int node)
 {
 	struct page **pages;
+	unsigned long addr =3D (unsigned long)area->addr;
+	unsigned long size =3D get_vm_area_size(area);
+	unsigned int page_order =3D page_shift - PAGE_SHIFT;
 	unsigned int nr_pages, array_size, i;
 	const gfp_t nested_gfp =3D (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
 	const gfp_t alloc_mask =3D gfp_mask | __GFP_NOWARN;
 	const gfp_t highmem_mask =3D (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
-					0 :
-					__GFP_HIGHMEM;
+					0 : __GFP_HIGHMEM;
=20
-	nr_pages =3D get_vm_area_size(area) >> PAGE_SHIFT;
+	nr_pages =3D size >> page_shift;
 	array_size =3D (nr_pages * sizeof(struct page *));
=20
 	/* Please note that the recursion is strictly bounded. */
 	if (array_size > PAGE_SIZE) {
 		pages =3D __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
-				PAGE_KERNEL, node, area->caller);
+				PAGE_KERNEL, 0, node, area->caller);
 	} else {
 		pages =3D kmalloc_node(array_size, nested_gfp, node);
 	}
@@ -2704,14 +2740,13 @@ static void *__vmalloc_area_node(struct vm_struct=
 *area, gfp_t gfp_mask,
=20
 	area->pages =3D pages;
 	area->nr_pages =3D nr_pages;
+	area->page_order =3D page_order;
=20
 	for (i =3D 0; i < area->nr_pages; i++) {
 		struct page *page;
=20
-		if (node =3D=3D NUMA_NO_NODE)
-			page =3D alloc_page(alloc_mask|highmem_mask);
-		else
-			page =3D alloc_pages_node(node, alloc_mask|highmem_mask, 0);
+		page =3D alloc_pages_node(node,
+				alloc_mask|highmem_mask, page_order);
=20
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vunmap() */
@@ -2725,8 +2760,9 @@ static void *__vmalloc_area_node(struct vm_struct *=
area, gfp_t gfp_mask,
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
=20
-	if (map_vm_area(area, prot, pages))
+	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0)
 		goto fail;
+
 	return area->addr;
=20
 fail:
@@ -2760,22 +2796,39 @@ void *__vmalloc_node_range(unsigned long size, un=
signed long align,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller)
 {
-	struct vm_struct *area;
+	struct vm_struct *area =3D NULL;
 	void *addr;
 	unsigned long real_size =3D size;
+	unsigned long real_align =3D align;
+	unsigned int shift =3D PAGE_SHIFT;
=20
 	size =3D PAGE_ALIGN(size);
 	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
 		goto fail;
=20
-	area =3D __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZ=
ED |
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP) &&
+			(vm_flags & VM_HUGE_PAGES)) {
+		unsigned long size_per_node;
+
+		size_per_node =3D size;
+		if (node =3D=3D NUMA_NO_NODE)
+			size_per_node /=3D num_online_nodes();
+		if (size_per_node >=3D PMD_SIZE)
+			shift =3D PMD_SHIFT;
+	}
+
+again:
+	align =3D max(real_align, 1UL << shift);
+	size =3D ALIGN(real_size, align);
+
+	area =3D __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
 				vm_flags, start, end, node, gfp_mask, caller);
 	if (!area)
 		goto fail;
=20
-	addr =3D __vmalloc_area_node(area, gfp_mask, prot, node);
+	addr =3D __vmalloc_area_node(area, gfp_mask, prot, shift, node);
 	if (!addr)
-		return NULL;
+		goto fail;
=20
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -2789,8 +2842,16 @@ void *__vmalloc_node_range(unsigned long size, uns=
igned long align,
 	return addr;
=20
 fail:
-	warn_alloc(gfp_mask, NULL,
+	if (shift > PAGE_SHIFT) {
+		shift =3D PAGE_SHIFT;
+		goto again;
+	}
+
+	if (!area) {
+		/* Warn for area allocation, page allocations already warn */
+		warn_alloc(gfp_mask, NULL,
 			  "vmalloc: allocation failure: %lu bytes", real_size);
+	}
 	return NULL;
 }
=20
@@ -2825,16 +2886,19 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_range);
  * Return: pointer to the allocated memory or %NULL on error
  */
 static void *__vmalloc_node(unsigned long size, unsigned long align,
-			    gfp_t gfp_mask, pgprot_t prot,
-			    int node, const void *caller)
+			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
+			int node, const void *caller)
 {
 	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
-				gfp_mask, prot, 0, node, caller);
+				gfp_mask, prot, vm_flags, node, caller);
 }
=20
 void *__vmalloc(unsigned long size, gfp_t gfp_mask, pgprot_t prot)
 {
-	return __vmalloc_node(size, 1, gfp_mask, prot, NUMA_NO_NODE,
+	unsigned long vm_flags =3D 0;
+	if (pgprot_val(prot) =3D=3D pgprot_val(PAGE_KERNEL))
+		vm_flags |=3D VM_HUGE_PAGES;
+	return __vmalloc_node(size, 1, gfp_mask, prot, vm_flags, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 EXPORT_SYMBOL(__vmalloc);
@@ -2842,7 +2906,7 @@ EXPORT_SYMBOL(__vmalloc);
 static inline void *__vmalloc_node_flags(unsigned long size,
 					int node, gfp_t flags)
 {
-	return __vmalloc_node(size, 1, flags, PAGE_KERNEL,
+	return __vmalloc_node(size, 1, flags, PAGE_KERNEL, VM_HUGE_PAGES,
 					node, __builtin_return_address(0));
 }
=20
@@ -2850,7 +2914,8 @@ static inline void *__vmalloc_node_flags(unsigned l=
ong size,
 void *__vmalloc_node_flags_caller(unsigned long size, int node, gfp_t fl=
ags,
 				  void *caller)
 {
-	return __vmalloc_node(size, 1, flags, PAGE_KERNEL, node, caller);
+	return __vmalloc_node(size, 1, flags, PAGE_KERNEL, VM_HUGE_PAGES,
+					node, caller);
 }
=20
 /**
@@ -2925,7 +2990,7 @@ EXPORT_SYMBOL(vmalloc_user);
  */
 void *vmalloc_node(unsigned long size, int node)
 {
-	return __vmalloc_node(size, 1, GFP_KERNEL, PAGE_KERNEL,
+	return __vmalloc_node(size, 1, GFP_KERNEL, PAGE_KERNEL, VM_HUGE_PAGES,
 					node, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_node);
@@ -3014,7 +3079,7 @@ void *vmalloc_exec(unsigned long size)
  */
 void *vmalloc_32(unsigned long size)
 {
-	return __vmalloc_node(size, 1, GFP_VMALLOC32, PAGE_KERNEL,
+	return __vmalloc_node(size, 1, GFP_VMALLOC32, PAGE_KERNEL, 0,
 			      NUMA_NO_NODE, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(vmalloc_32);
--=20
2.23.0
