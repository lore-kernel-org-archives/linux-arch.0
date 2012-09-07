Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34227 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab2IGQ1w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:52 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 05/31] arm64: MMU initialisation
Date: Fri,  7 Sep 2012 17:26:40 +0100
Message-ID: <1347035226-18649-6-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162640.so39KKvtFEkZeqUQXMRpgnWvr56nMgnDKNV2y7iBTdM@z>

This patch contains the initialisation of the memory blocks, MMU
attributes and the memory map. Only five memory types are defined:
Device nGnRnE (equivalent to Strongly Ordered), Device nGnRE (classic
Device memory), Device GRE, Normal Non-cacheable and Normal Cacheable.
Cache policies are supported via the memory attributes register
(MAIR_EL1) and only affect the Normal Cacheable mappings.

This patch also adds the SPARSEMEM_VMEMMAP initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/memblock.h |   21 ++
 arch/arm64/mm/init.c              |  416 +++++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/mmu.c               |  395 +++++++++++++++++++++++++++++++++=
++
 3 files changed, 832 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/memblock.h
 create mode 100644 arch/arm64/mm/init.c
 create mode 100644 arch/arm64/mm/mmu.c

diff --git a/arch/arm64/include/asm/memblock.h b/arch/arm64/include/asm/mem=
block.h
new file mode 100644
index 0000000..6afeed2
--- /dev/null
+++ b/arch/arm64/include/asm/memblock.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_MEMBLOCK_H
+#define __ASM_MEMBLOCK_H
+
+extern void arm64_memblock_init(void);
+
+#endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
new file mode 100644
index 0000000..31428ca
--- /dev/null
+++ b/arch/arm64/mm/init.c
@@ -0,0 +1,416 @@
+/*
+ * Based on arch/arm/mm/init.c
+ *
+ * Copyright (C) 1995-2005 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/swap.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/mman.h>
+#include <linux/nodemask.h>
+#include <linux/initrd.h>
+#include <linux/gfp.h>
+#include <linux/memblock.h>
+#include <linux/sort.h>
+#include <linux/of_fdt.h>
+
+#include <asm/prom.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/sizes.h>
+#include <asm/tlb.h>
+
+#include "mm.h"
+
+static unsigned long phys_initrd_start __initdata =3D 0;
+static unsigned long phys_initrd_size __initdata =3D 0;
+
+phys_addr_t memstart_addr __read_mostly =3D 0;
+
+void __init early_init_dt_setup_initrd_arch(unsigned long start,
+=09=09=09=09=09    unsigned long end)
+{
+=09phys_initrd_start =3D start;
+=09phys_initrd_size =3D end - start;
+}
+
+static int __init early_initrd(char *p)
+{
+=09unsigned long start, size;
+=09char *endp;
+
+=09start =3D memparse(p, &endp);
+=09if (*endp =3D=3D ',') {
+=09=09size =3D memparse(endp + 1, NULL);
+
+=09=09phys_initrd_start =3D start;
+=09=09phys_initrd_size =3D size;
+=09}
+=09return 0;
+}
+early_param("initrd", early_initrd);
+
+#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+
+static void __init zone_sizes_init(unsigned long min, unsigned long max)
+{
+=09unsigned long zone_size[MAX_NR_ZONES];
+=09unsigned long max_dma32 =3D min;
+
+=09memset(zone_size, 0, sizeof(zone_size));
+
+=09zone_size[0] =3D max - min;
+#ifdef CONFIG_ZONE_DMA32
+=09/* 4GB maximum for 32-bit only capable devices */
+=09max_dma32 =3D min(max, MAX_DMA32_PFN);
+=09zone_size[ZONE_DMA32] =3D max_dma32 - min;
+#endif
+=09zone_size[ZONE_NORMAL] =3D max - max_dma32;
+
+=09free_area_init(zone_size);
+}
+
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+int pfn_valid(unsigned long pfn)
+{
+=09return memblock_is_memory(pfn << PAGE_SHIFT);
+}
+EXPORT_SYMBOL(pfn_valid);
+#endif
+
+#ifndef CONFIG_SPARSEMEM
+static void arm64_memory_present(void)
+{
+}
+#else
+static void arm64_memory_present(void)
+{
+=09struct memblock_region *reg;
+
+=09for_each_memblock(memory, reg)
+=09=09memory_present(0, memblock_region_memory_base_pfn(reg),
+=09=09=09       memblock_region_memory_end_pfn(reg));
+}
+#endif
+
+void __init arm64_memblock_init(void)
+{
+=09u64 *reserve_map, base, size;
+
+=09/* Register the kernel text, kernel data and initrd with memblock */
+=09memblock_reserve(__pa(_text), _end - _text);
+#ifdef CONFIG_BLK_DEV_INITRD
+=09if (phys_initrd_size) {
+=09=09memblock_reserve(phys_initrd_start, phys_initrd_size);
+
+=09=09/* Now convert initrd to virtual addresses */
+=09=09initrd_start =3D __phys_to_virt(phys_initrd_start);
+=09=09initrd_end =3D initrd_start + phys_initrd_size;
+=09}
+#endif
+
+=09/*
+=09 * Reserve the page tables.  These are already in use,
+=09 * and can only be in node 0.
+=09 */
+=09memblock_reserve(__pa(swapper_pg_dir), SWAPPER_DIR_SIZE);
+=09memblock_reserve(__pa(idmap_pg_dir), IDMAP_DIR_SIZE);
+
+=09/* Reserve the dtb region */
+=09memblock_reserve(virt_to_phys(initial_boot_params),
+=09=09=09 be32_to_cpu(initial_boot_params->totalsize));
+
+=09/*
+=09 * Process the reserve map.  This will probably overlap the initrd
+=09 * and dtb locations which are already reserved, but overlapping
+=09 * doesn't hurt anything
+=09 */
+=09reserve_map =3D ((void*)initial_boot_params) +
+=09=09=09be32_to_cpu(initial_boot_params->off_mem_rsvmap);
+=09while (1) {
+=09=09base =3D be64_to_cpup(reserve_map++);
+=09=09size =3D be64_to_cpup(reserve_map++);
+=09=09if (!size)
+=09=09=09break;
+=09=09memblock_reserve(base, size);
+=09}
+
+=09memblock_allow_resize();
+=09memblock_dump_all();
+}
+
+void __init bootmem_init(void)
+{
+=09unsigned long min, max;
+
+=09min =3D PFN_UP(memblock_start_of_DRAM());
+=09max =3D PFN_DOWN(memblock_end_of_DRAM());
+
+=09/*
+=09 * Sparsemem tries to allocate bootmem in memory_present(), so must be
+=09 * done after the fixed reservations.
+=09 */
+=09arm64_memory_present();
+
+=09sparse_init();
+=09zone_sizes_init(min, max);
+
+=09high_memory =3D __va((max << PAGE_SHIFT) - 1) + 1;
+=09max_pfn =3D max_low_pfn =3D max;
+}
+
+static inline int free_area(unsigned long pfn, unsigned long end, char *s)
+{
+=09unsigned int pages =3D 0, size =3D (end - pfn) << (PAGE_SHIFT - 10);
+
+=09for (; pfn < end; pfn++) {
+=09=09struct page *page =3D pfn_to_page(pfn);
+=09=09ClearPageReserved(page);
+=09=09init_page_count(page);
+=09=09__free_page(page);
+=09=09pages++;
+=09}
+
+=09if (size && s)
+=09=09pr_info("Freeing %s memory: %dK\n", s, size);
+
+=09return pages;
+}
+
+/*
+ * Poison init memory with an undefined instruction (0x0).
+ */
+static inline void poison_init_mem(void *s, size_t count)
+{
+=09memset(s, 0, count);
+}
+
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+static inline void free_memmap(unsigned long start_pfn, unsigned long end_=
pfn)
+{
+=09struct page *start_pg, *end_pg;
+=09unsigned long pg, pgend;
+
+=09/*
+=09 * Convert start_pfn/end_pfn to a struct page pointer.
+=09 */
+=09start_pg =3D pfn_to_page(start_pfn - 1) + 1;
+=09end_pg =3D pfn_to_page(end_pfn - 1) + 1;
+
+=09/*
+=09 * Convert to physical addresses, and round start upwards and end
+=09 * downwards.
+=09 */
+=09pg =3D (unsigned long)PAGE_ALIGN(__pa(start_pg));
+=09pgend =3D (unsigned long)__pa(end_pg) & PAGE_MASK;
+
+=09/*
+=09 * If there are free pages between these, free the section of the
+=09 * memmap array.
+=09 */
+=09if (pg < pgend)
+=09=09free_bootmem(pg, pgend - pg);
+}
+
+/*
+ * The mem_map array can get very big. Free the unused area of the memory =
map.
+ */
+static void __init free_unused_memmap(void)
+{
+=09unsigned long start, prev_end =3D 0;
+=09struct memblock_region *reg;
+
+=09for_each_memblock(memory, reg) {
+=09=09start =3D __phys_to_pfn(reg->base);
+
+#ifdef CONFIG_SPARSEMEM
+=09=09/*
+=09=09 * Take care not to free memmap entries that don't exist due
+=09=09 * to SPARSEMEM sections which aren't present.
+=09=09 */
+=09=09start =3D min(start, ALIGN(prev_end, PAGES_PER_SECTION));
+#endif
+=09=09/*
+=09=09 * If we had a previous bank, and there is a space between the
+=09=09 * current bank and the previous, free it.
+=09=09 */
+=09=09if (prev_end && prev_end < start)
+=09=09=09free_memmap(prev_end, start);
+
+=09=09/*
+=09=09 * Align up here since the VM subsystem insists that the
+=09=09 * memmap entries are valid from the bank end aligned to
+=09=09 * MAX_ORDER_NR_PAGES.
+=09=09 */
+=09=09prev_end =3D ALIGN(start + __phys_to_pfn(reg->size),
+=09=09=09=09 MAX_ORDER_NR_PAGES);
+=09}
+
+#ifdef CONFIG_SPARSEMEM
+=09if (!IS_ALIGNED(prev_end, PAGES_PER_SECTION))
+=09=09free_memmap(prev_end, ALIGN(prev_end, PAGES_PER_SECTION));
+#endif
+}
+#endif=09/* !CONFIG_SPARSEMEM_VMEMMAP */
+
+/*
+ * mem_init() marks the free areas in the mem_map and tells us how much me=
mory
+ * is free.  This is done after various parts of the system have claimed t=
heir
+ * memory after the kernel image.
+ */
+void __init mem_init(void)
+{
+=09unsigned long reserved_pages, free_pages;
+=09struct memblock_region *reg;
+
+#if CONFIG_SWIOTLB
+=09extern void __init arm64_swiotlb_init(size_t max_size);
+=09arm64_swiotlb_init(max_pfn << (PAGE_SHIFT - 1));
+#endif
+
+=09max_mapnr   =3D pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
+
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+=09/* this will put all unused low memory onto the freelists */
+=09free_unused_memmap();
+#endif
+
+=09totalram_pages +=3D free_all_bootmem();
+
+=09reserved_pages =3D free_pages =3D 0;
+
+=09for_each_memblock(memory, reg) {
+=09=09unsigned int pfn1, pfn2;
+=09=09struct page *page, *end;
+
+=09=09pfn1 =3D __phys_to_pfn(reg->base);
+=09=09pfn2 =3D pfn1 + __phys_to_pfn(reg->size);
+
+=09=09page =3D pfn_to_page(pfn1);
+=09=09end  =3D pfn_to_page(pfn2 - 1) + 1;
+
+=09=09do {
+=09=09=09if (PageReserved(page))
+=09=09=09=09reserved_pages++;
+=09=09=09else if (!page_count(page))
+=09=09=09=09free_pages++;
+=09=09=09page++;
+=09=09} while (page < end);
+=09}
+
+=09/*
+=09 * Since our memory may not be contiguous, calculate the real number
+=09 * of pages we have in this system.
+=09 */
+=09pr_info("Memory:");
+=09num_physpages =3D 0;
+=09for_each_memblock(memory, reg) {
+=09=09unsigned long pages =3D memblock_region_memory_end_pfn(reg) -
+=09=09=09memblock_region_memory_base_pfn(reg);
+=09=09num_physpages +=3D pages;
+=09=09printk(" %ldMB", pages >> (20 - PAGE_SHIFT));
+=09}
+=09printk(" =3D %luMB total\n", num_physpages >> (20 - PAGE_SHIFT));
+
+=09pr_notice("Memory: %luk/%luk available, %luk reserved\n",
+=09=09  nr_free_pages() << (PAGE_SHIFT-10),
+=09=09  free_pages << (PAGE_SHIFT-10),
+=09=09  reserved_pages << (PAGE_SHIFT-10));
+
+#define MLK(b, t) b, t, ((t) - (b)) >> 10
+#define MLM(b, t) b, t, ((t) - (b)) >> 20
+#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
+
+=09pr_notice("Virtual kernel memory layout:\n"
+=09=09  "    vmalloc : 0x%16lx - 0x%16lx   (%6ld MB)\n"
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+=09=09  "    vmemmap : 0x%16lx - 0x%16lx   (%6ld MB)\n"
+#endif
+=09=09  "    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n"
+=09=09  "    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n"
+=09=09  "      .init : 0x%p" " - 0x%p" "   (%6ld kB)\n"
+=09=09  "      .text : 0x%p" " - 0x%p" "   (%6ld kB)\n"
+=09=09  "      .data : 0x%p" " - 0x%p" "   (%6ld kB)\n",
+=09=09  MLM(VMALLOC_START, VMALLOC_END),
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+=09=09  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
+=09=09      (unsigned long)virt_to_page(high_memory)),
+#endif
+=09=09  MLM(MODULES_VADDR, MODULES_END),
+=09=09  MLM(PAGE_OFFSET, (unsigned long)high_memory),
+
+=09=09  MLK_ROUNDUP(__init_begin, __init_end),
+=09=09  MLK_ROUNDUP(_text, _etext),
+=09=09  MLK_ROUNDUP(_sdata, _edata));
+
+#undef MLK
+#undef MLM
+#undef MLK_ROUNDUP
+
+=09/*
+=09 * Check boundaries twice: Some fundamental inconsistencies can be
+=09 * detected at build time already.
+=09 */
+#ifdef CONFIG_COMPAT
+=09BUILD_BUG_ON(TASK_SIZE_32=09=09=09> TASK_SIZE_64);
+#endif
+=09BUILD_BUG_ON(TASK_SIZE_64=09=09=09> MODULES_VADDR);
+=09BUG_ON(TASK_SIZE_64=09=09=09=09> MODULES_VADDR);
+
+=09if (PAGE_SIZE >=3D 16384 && num_physpages <=3D 128) {
+=09=09extern int sysctl_overcommit_memory;
+=09=09/*
+=09=09 * On a machine this small we won't get anywhere without
+=09=09 * overcommit, so turn it on by default.
+=09=09 */
+=09=09sysctl_overcommit_memory =3D OVERCOMMIT_ALWAYS;
+=09}
+}
+
+void free_initmem(void)
+{
+=09poison_init_mem(__init_begin, __init_end - __init_begin);
+=09totalram_pages +=3D free_area(__phys_to_pfn(__pa(__init_begin)),
+=09=09=09=09    __phys_to_pfn(__pa(__init_end)),
+=09=09=09=09    "init");
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+
+static int keep_initrd;
+
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+=09if (!keep_initrd) {
+=09=09poison_init_mem((void *)start, PAGE_ALIGN(end) - start);
+=09=09totalram_pages +=3D free_area(__phys_to_pfn(__pa(start)),
+=09=09=09=09=09    __phys_to_pfn(__pa(end)),
+=09=09=09=09=09    "initrd");
+=09}
+}
+
+static int __init keepinitrd_setup(char *__unused)
+{
+=09keep_initrd =3D 1;
+=09return 1;
+}
+
+__setup("keepinitrd", keepinitrd_setup);
+#endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
new file mode 100644
index 0000000..d2dd438
--- /dev/null
+++ b/arch/arm64/mm/mmu.c
@@ -0,0 +1,395 @@
+/*
+ * Based on arch/arm/mm/mmu.c
+ *
+ * Copyright (C) 1995-2005 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/mman.h>
+#include <linux/nodemask.h>
+#include <linux/memblock.h>
+#include <linux/fs.h>
+
+#include <asm/cputype.h>
+#include <asm/sections.h>
+#include <asm/setup.h>
+#include <asm/sizes.h>
+#include <asm/tlb.h>
+#include <asm/mmu_context.h>
+
+#include "mm.h"
+
+/*
+ * Empty_zero_page is a special page that is used for zero-initialized dat=
a
+ * and COW.
+ */
+struct page *empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+
+pgprot_t pgprot_default;
+EXPORT_SYMBOL(pgprot_default);
+
+static pmdval_t prot_sect_kernel;
+
+struct cachepolicy {
+=09const char=09policy[16];
+=09u64=09=09mair;
+=09u64=09=09tcr;
+};
+
+static struct cachepolicy cache_policies[] __initdata =3D {
+=09{
+=09=09.policy=09=09=3D "uncached",
+=09=09.mair=09=09=3D 0x44,=09=09=09/* inner, outer non-cacheable */
+=09=09.tcr=09=09=3D TCR_IRGN_NC | TCR_ORGN_NC,
+=09}, {
+=09=09.policy=09=09=3D "writethrough",
+=09=09.mair=09=09=3D 0xaa,=09=09=09/* inner, outer write-through, read-all=
ocate */
+=09=09.tcr=09=09=3D TCR_IRGN_WT | TCR_ORGN_WT,
+=09}, {
+=09=09.policy=09=09=3D "writeback",
+=09=09.mair=09=09=3D 0xee,=09=09=09/* inner, outer write-back, read-alloca=
te */
+=09=09.tcr=09=09=3D TCR_IRGN_WBnWA | TCR_ORGN_WBnWA,
+=09}
+};
+
+/*
+ * These are useful for identifying cache coherency problems by allowing t=
he
+ * cache or the cache and writebuffer to be turned off. It changes the Nor=
mal
+ * memory caching attributes in the MAIR_EL1 register.
+ */
+static int __init early_cachepolicy(char *p)
+{
+=09int i;
+=09u64 tmp;
+
+=09for (i =3D 0; i < ARRAY_SIZE(cache_policies); i++) {
+=09=09int len =3D strlen(cache_policies[i].policy);
+
+=09=09if (memcmp(p, cache_policies[i].policy, len) =3D=3D 0)
+=09=09=09break;
+=09}
+=09if (i =3D=3D ARRAY_SIZE(cache_policies)) {
+=09=09pr_err("ERROR: unknown or unsupported cache policy: %s\n", p);
+=09=09return 0;
+=09}
+
+=09flush_cache_all();
+
+=09/*
+=09 * Modify MT_NORMAL attributes in MAIR_EL1.
+=09 */
+=09asm volatile(
+=09"=09mrs=09%0, mair_el1\n"
+=09"=09bfi=09%0, %1, #%2, #8\n"
+=09"=09msr=09mair_el1, %0\n"
+=09"=09isb\n"
+=09: "=3D&r" (tmp)
+=09: "r" (cache_policies[i].mair), "i" (MT_NORMAL * 8));
+
+=09/*
+=09 * Modify TCR PTW cacheability attributes.
+=09 */
+=09asm volatile(
+=09"=09mrs=09%0, tcr_el1\n"
+=09"=09bic=09%0, %0, %2\n"
+=09"=09orr=09%0, %0, %1\n"
+=09"=09msr=09tcr_el1, %0\n"
+=09"=09isb\n"
+=09: "=3D&r" (tmp)
+=09: "r" (cache_policies[i].tcr), "r" (TCR_IRGN_MASK | TCR_ORGN_MASK));
+
+=09flush_cache_all();
+
+=09return 0;
+}
+early_param("cachepolicy", early_cachepolicy);
+
+/*
+ * Adjust the PMD section entries according to the CPU in use.
+ */
+static void __init init_mem_pgprot(void)
+{
+=09pteval_t default_pgprot;
+=09int i;
+
+=09default_pgprot =3D PTE_ATTRINDX(MT_NORMAL);
+=09prot_sect_kernel =3D PMD_TYPE_SECT | PMD_SECT_AF | PMD_ATTRINDX(MT_NORM=
AL);
+
+#ifdef CONFIG_SMP
+=09/*
+=09 * Mark memory with the "shared" attribute for SMP systems
+=09 */
+=09default_pgprot |=3D PTE_SHARED;
+=09prot_sect_kernel |=3D PMD_SECT_S;
+#endif
+
+=09for (i =3D 0; i < 16; i++) {
+=09=09unsigned long v =3D pgprot_val(protection_map[i]);
+=09=09protection_map[i] =3D __pgprot(v | default_pgprot);
+=09}
+
+=09pgprot_default =3D __pgprot(PTE_TYPE_PAGE | PTE_AF | default_pgprot);
+}
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+=09=09=09      unsigned long size, pgprot_t vma_prot)
+{
+=09if (!pfn_valid(pfn))
+=09=09return pgprot_noncached(vma_prot);
+=09else if (file->f_flags & O_SYNC)
+=09=09return pgprot_writecombine(vma_prot);
+=09return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
+
+static void __init *early_alloc(unsigned long sz)
+{
+=09void *ptr =3D __va(memblock_alloc(sz, sz));
+=09memset(ptr, 0, sz);
+=09return ptr;
+}
+
+static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
+=09=09=09=09  unsigned long end, unsigned long pfn)
+{
+=09pte_t *pte;
+
+=09if (pmd_none(*pmd)) {
+=09=09pte =3D early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+=09=09__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
+=09}
+=09BUG_ON(pmd_bad(*pmd));
+
+=09pte =3D pte_offset_kernel(pmd, addr);
+=09do {
+=09=09set_pte(pte, pfn_pte(pfn, PAGE_KERNEL_EXEC));
+=09=09pfn++;
+=09} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);
+}
+
+static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
+=09=09=09=09  unsigned long end, phys_addr_t phys)
+{
+=09pmd_t *pmd;
+=09unsigned long next;
+
+=09/*
+=09 * Check for initial section mappings in the pgd/pud and remove them.
+=09 */
+=09if (pud_none(*pud) || pud_bad(*pud)) {
+=09=09pmd =3D early_alloc(PTRS_PER_PMD * sizeof(pmd_t));
+=09=09pud_populate(&init_mm, pud, pmd);
+=09}
+
+=09pmd =3D pmd_offset(pud, addr);
+=09do {
+=09=09next =3D pmd_addr_end(addr, end);
+=09=09/* try section mapping first */
+=09=09if (((addr | next | phys) & ~SECTION_MASK) =3D=3D 0)
+=09=09=09set_pmd(pmd, __pmd(phys | prot_sect_kernel));
+=09=09else
+=09=09=09alloc_init_pte(pmd, addr, next, __phys_to_pfn(phys));
+=09=09phys +=3D next - addr;
+=09} while (pmd++, addr =3D next, addr !=3D end);
+}
+
+static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
+=09=09=09=09  unsigned long end, unsigned long phys)
+{
+=09pud_t *pud =3D pud_offset(pgd, addr);
+=09unsigned long next;
+
+=09do {
+=09=09next =3D pud_addr_end(addr, end);
+=09=09alloc_init_pmd(pud, addr, next, phys);
+=09=09phys +=3D next - addr;
+=09} while (pud++, addr =3D next, addr !=3D end);
+}
+
+/*
+ * Create the page directory entries and any necessary page tables for the
+ * mapping specified by 'md'.
+ */
+static void __init create_mapping(phys_addr_t phys, unsigned long virt,
+=09=09=09=09  phys_addr_t size)
+{
+=09unsigned long addr, length, end, next;
+=09pgd_t *pgd;
+
+=09if (virt < VMALLOC_START) {
+=09=09pr_warning("BUG: not creating mapping for 0x%016llx at 0x%016lx - ou=
tside kernel range\n",
+=09=09=09   phys, virt);
+=09=09return;
+=09}
+
+=09addr =3D virt & PAGE_MASK;
+=09length =3D PAGE_ALIGN(size + (virt & ~PAGE_MASK));
+
+=09pgd =3D pgd_offset_k(addr);
+=09end =3D addr + length;
+=09do {
+=09=09next =3D pgd_addr_end(addr, end);
+=09=09alloc_init_pud(pgd, addr, next, phys);
+=09=09phys +=3D next - addr;
+=09} while (pgd++, addr =3D next, addr !=3D end);
+}
+
+static void __init map_mem(void)
+{
+=09struct memblock_region *reg;
+
+=09/* map all the memory banks */
+=09for_each_memblock(memory, reg) {
+=09=09phys_addr_t start =3D reg->base;
+=09=09phys_addr_t end =3D start + reg->size;
+
+=09=09if (start >=3D end)
+=09=09=09break;
+
+=09=09create_mapping(start, __phys_to_virt(start), end - start);
+=09}
+}
+
+/*
+ * paging_init() sets up the page tables, initialises the zone memory
+ * maps and sets up the zero page.
+ */
+void __init paging_init(void)
+{
+=09void *zero_page;
+
+=09/*
+=09 * Maximum PGDIR_SIZE addressable via the initial direct kernel
+=09 * mapping in swapper_pg_dir.
+=09 */
+=09memblock_set_current_limit((PHYS_OFFSET & PGDIR_MASK) + PGDIR_SIZE);
+
+=09init_mem_pgprot();
+=09map_mem();
+
+=09/*
+=09 * Finally flush the caches and tlb to ensure that we're in a
+=09 * consistent state.
+=09 */
+=09flush_cache_all();
+=09flush_tlb_all();
+
+=09/* allocate the zero page. */
+=09zero_page =3D early_alloc(PAGE_SIZE);
+
+=09bootmem_init();
+
+=09empty_zero_page =3D virt_to_page(zero_page);
+=09__flush_dcache_page(NULL, empty_zero_page);
+
+=09/*
+=09 * TTBR0 is only used for the identity mapping at this stage. Make it
+=09 * point to zero page to avoid speculatively fetching new entries.
+=09 */
+=09cpu_set_reserved_ttbr0();
+=09flush_tlb_all();
+}
+
+/*
+ * Enable the identity mapping to allow the MMU disabling.
+ */
+void setup_mm_for_reboot(void)
+{
+=09cpu_switch_mm(idmap_pg_dir, &init_mm);
+=09flush_tlb_all();
+}
+
+/*
+ * Check whether a kernel address is valid (derived from arch/x86/).
+ */
+int kern_addr_valid(unsigned long addr)
+{
+=09pgd_t *pgd;
+=09pud_t *pud;
+=09pmd_t *pmd;
+=09pte_t *pte;
+
+=09if ((((long)addr) >> VA_BITS) !=3D -1UL)
+=09=09return 0;
+
+=09pgd =3D pgd_offset_k(addr);
+=09if (pgd_none(*pgd))
+=09=09return 0;
+
+=09pud =3D pud_offset(pgd, addr);
+=09if (pud_none(*pud))
+=09=09return 0;
+
+=09pmd =3D pmd_offset(pud, addr);
+=09if (pmd_none(*pmd))
+=09=09return 0;
+
+=09pte =3D pte_offset_kernel(pmd, addr);
+=09if (pte_none(*pte))
+=09=09return 0;
+
+=09return pfn_valid(pte_pfn(*pte));
+}
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_ARM64_64K_PAGES
+int __meminit vmemmap_populate(struct page *start_page,
+=09=09=09       unsigned long size, int node)
+{
+=09return vmemmap_populate_basepages(start_page, size, node);
+}
+#else=09/* !CONFIG_ARM64_64K_PAGES */
+int __meminit vmemmap_populate(struct page *start_page,
+=09=09=09       unsigned long size, int node)
+{
+=09unsigned long addr =3D (unsigned long)start_page;
+=09unsigned long end =3D (unsigned long)(start_page + size);
+=09unsigned long next;
+=09pgd_t *pgd;
+=09pud_t *pud;
+=09pmd_t *pmd;
+
+=09do {
+=09=09next =3D pmd_addr_end(addr, end);
+
+=09=09pgd =3D vmemmap_pgd_populate(addr, node);
+=09=09if (!pgd)
+=09=09=09return -ENOMEM;
+
+=09=09pud =3D vmemmap_pud_populate(pgd, addr, node);
+=09=09if (!pud)
+=09=09=09return -ENOMEM;
+
+=09=09pmd =3D pmd_offset(pud, addr);
+=09=09if (pmd_none(*pmd)) {
+=09=09=09void *p =3D NULL;
+
+=09=09=09p =3D vmemmap_alloc_block_buf(PMD_SIZE, node);
+=09=09=09if (!p)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09set_pmd(pmd, __pmd(__pa(p) | prot_sect_kernel));
+=09=09} else
+=09=09=09vmemmap_verify((pte_t *)pmd, node, addr, next);
+=09} while (addr =3D next, addr !=3D end);
+
+=09return 0;
+}
+#endif=09/* CONFIG_ARM64_64K_PAGES */
+#endif=09/* CONFIG_SPARSEMEM_VMEMMAP */

