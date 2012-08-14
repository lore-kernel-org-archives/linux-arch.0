Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55086 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815Ab2HNRxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:08 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 09/31] arm64: Cache maintenance routines
Date: Tue, 14 Aug 2012 18:52:10 +0100
Message-ID: <1344966752-16102-10-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175210.R7eMmI93t7ZWYflu6d7KZBkEzfdoD8XvewZlm4zGsoU@z>

The patch adds functionality required for cache maintenance. The AArch64
architecture mandates non-aliasing VIPT or PIPT D-cache and VIPT (may
have aliases) or ASID-tagged VIVT I-cache. Cache maintenance operations
are automatically broadcast in hardware between CPUs.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cache.h      |   32 ++++
 arch/arm64/include/asm/cacheflush.h |  209 ++++++++++++++++++++++++++
 arch/arm64/include/asm/cachetype.h  |   48 ++++++
 arch/arm64/mm/cache.S               |  279 +++++++++++++++++++++++++++++++=
++++
 arch/arm64/mm/flush.c               |  132 +++++++++++++++++
 5 files changed, 700 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/cache.h
 create mode 100644 arch/arm64/include/asm/cacheflush.h
 create mode 100644 arch/arm64/include/asm/cachetype.h
 create mode 100644 arch/arm64/mm/cache.S
 create mode 100644 arch/arm64/mm/flush.c

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.=
h
new file mode 100644
index 0000000..390308a
--- /dev/null
+++ b/arch/arm64/include/asm/cache.h
@@ -0,0 +1,32 @@
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
+#ifndef __ASM_CACHE_H
+#define __ASM_CACHE_H
+
+#define L1_CACHE_SHIFT=09=096
+#define L1_CACHE_BYTES=09=09(1 << L1_CACHE_SHIFT)
+
+/*
+ * Memory returned by kmalloc() may be used for DMA, so we must make
+ * sure that all such allocations are cache aligned. Otherwise,
+ * unrelated code may cause parts of the buffer to be read into the
+ * cache before the transfer is done, causing old data to be seen by
+ * the CPU.
+ */
+#define ARCH_DMA_MINALIGN=09L1_CACHE_BYTES
+#define ARCH_SLAB_MINALIGN=098
+
+#endif
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/c=
acheflush.h
new file mode 100644
index 0000000..93b5590
--- /dev/null
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -0,0 +1,209 @@
+/*
+ * Based on arch/arm/include/asm/cacheflush.h
+ *
+ * Copyright (C) 1999-2002 Russell King.
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
+#ifndef __ASM_CACHEFLUSH_H
+#define __ASM_CACHEFLUSH_H
+
+#include <linux/mm.h>
+
+/*
+ * This flag is used to indicate that the page pointed to by a pte is clea=
n
+ * and does not require cleaning before returning it to the user.
+ */
+#define PG_dcache_clean PG_arch_1
+
+/*
+ *=09MM Cache Management
+ *=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *=09The arch/arm/mm/cache-*.S and arch/arm/mm/proc-*.S files
+ *=09implement these methods.
+ *
+ *=09Start addresses are inclusive and end addresses are exclusive;
+ *=09start addresses should be rounded down, end addresses up.
+ *
+ *=09See Documentation/cachetlb.txt for more information.
+ *=09Please note that the implementation of these, and the required
+ *=09effects are cache-type (VIVT/VIPT/PIPT) specific.
+ *
+ *=09flush_cache_kern_all()
+ *
+ *=09=09Unconditionally clean and invalidate the entire cache.
+ *
+ *=09flush_cache_user_mm(mm)
+ *
+ *=09=09Clean and invalidate all user space cache entries
+ *=09=09before a change of page tables.
+ *
+ *=09flush_cache_user_range(start, end, flags)
+ *
+ *=09=09Clean and invalidate a range of cache entries in the
+ *=09=09specified address space before a change of page tables.
+ *=09=09- start - user start address (inclusive, page aligned)
+ *=09=09- end   - user end address   (exclusive, page aligned)
+ *=09=09- flags - vma->vm_flags field
+ *
+ *=09coherent_kern_range(start, end)
+ *
+ *=09=09Ensure coherency between the Icache and the Dcache in the
+ *=09=09region described by start, end.  If you have non-snooping
+ *=09=09Harvard caches, you need to implement this function.
+ *=09=09- start  - virtual start address
+ *=09=09- end    - virtual end address
+ *
+ *=09coherent_user_range(start, end)
+ *
+ *=09=09Ensure coherency between the Icache and the Dcache in the
+ *=09=09region described by start, end.  If you have non-snooping
+ *=09=09Harvard caches, you need to implement this function.
+ *=09=09- start  - virtual start address
+ *=09=09- end    - virtual end address
+ *
+ *=09flush_kern_dcache_area(kaddr, size)
+ *
+ *=09=09Ensure that the data held in page is written back.
+ *=09=09- kaddr  - page address
+ *=09=09- size   - region size
+ *
+ *=09DMA Cache Coherency
+ *=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *=09dma_flush_range(start, end)
+ *
+ *=09=09Clean and invalidate the specified virtual address range.
+ *=09=09- start  - virtual start address
+ *=09=09- end    - virtual end address
+ */
+extern void __cpuc_flush_kern_all(void);
+extern void __cpuc_flush_user_all(void);
+extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned=
 int);
+extern void __cpuc_coherent_kern_range(unsigned long, unsigned long);
+extern void __cpuc_coherent_user_range(unsigned long, unsigned long);
+extern void __cpuc_flush_dcache_area(void *, size_t);
+
+/*
+ * These are private to the dma-mapping API.  Do not use directly.
+ * Their sole purpose is to ensure that data held in the cache
+ * is visible to DMA, or data written by DMA to system memory is
+ * visible to the CPU.
+ */
+extern void dmac_map_area(const void *, size_t, int);
+extern void dmac_unmap_area(const void *, size_t, int);
+extern void dmac_flush_range(const void *, const void *);
+
+/*
+ * Copy user data from/to a page which is mapped into a different
+ * processes address space.  Really, we want to allow our "user
+ * space" model to handle this.
+ */
+extern void copy_to_user_page(struct vm_area_struct *, struct page *,
+=09unsigned long, void *, const void *, unsigned long);
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+=09do {=09=09=09=09=09=09=09\
+=09=09memcpy(dst, src, len);=09=09=09=09\
+=09} while (0)
+
+/*
+ * Convert calls to our calling convention.
+ */
+#define flush_cache_all()=09=09__cpuc_flush_kern_all()
+extern void flush_cache_mm(struct mm_struct *mm);
+extern void flush_cache_range(struct vm_area_struct *vma, unsigned long st=
art, unsigned long end);
+extern void flush_cache_page(struct vm_area_struct *vma, unsigned long use=
r_addr, unsigned long pfn);
+
+#define flush_cache_dup_mm(mm) flush_cache_mm(mm)
+
+/*
+ * flush_cache_user_range is used when we want to ensure that the
+ * Harvard caches are synchronised for the user space address range.
+ * This is used for the ARM private sys_cacheflush system call.
+ */
+#define flush_cache_user_range(start, end) \
+=09__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
+
+/*
+ * Perform necessary cache operations to ensure that data previously
+ * stored within this range of addresses can be executed by the CPU.
+ */
+#define flush_icache_range(s,e)=09=09__cpuc_coherent_kern_range(s,e)
+
+/*
+ * flush_dcache_page is used when the kernel has written to the page
+ * cache page at virtual address page->virtual.
+ *
+ * If this page isn't mapped (ie, page_mapping =3D=3D NULL), or it might
+ * have userspace mappings, then we _must_ always clean + invalidate
+ * the dcache entries associated with the kernel mapping.
+ *
+ * Otherwise we can defer the operation, and clean the cache when we are
+ * about to change to user space.  This is the same method as used on SPAR=
C64.
+ * See update_mmu_cache for the user space part.
+ */
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
+extern void flush_dcache_page(struct page *);
+
+static inline void __flush_icache_all(void)
+{
+=09asm("ic=09ialluis");
+}
+
+#define ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma,
+=09=09=09 struct page *page, unsigned long vmaddr)
+{
+=09extern void __flush_anon_page(struct vm_area_struct *vma,
+=09=09=09=09struct page *, unsigned long);
+=09if (PageAnon(page))
+=09=09__flush_anon_page(vma, page, vmaddr);
+}
+
+#define flush_dcache_mmap_lock(mapping) \
+=09spin_lock_irq(&(mapping)->tree_lock)
+#define flush_dcache_mmap_unlock(mapping) \
+=09spin_unlock_irq(&(mapping)->tree_lock)
+
+#define flush_icache_user_range(vma,page,addr,len) \
+=09flush_dcache_page(page)
+
+/*
+ * We don't appear to need to do anything here.  In fact, if we did, we'd
+ * duplicate cache flushing elsewhere performed by flush_dcache_page().
+ */
+#define flush_icache_page(vma,page)=09do { } while (0)
+
+/*
+ * flush_cache_vmap() is used when creating mappings (eg, via vmap,
+ * vmalloc, ioremap etc) in kernel space for pages.  On non-VIPT
+ * caches, since the direct-mappings of these pages may contain cached
+ * data, we need to do a full cache flush to ensure that writebacks
+ * don't corrupt data placed into these pages via the new mappings.
+ */
+static inline void flush_cache_vmap(unsigned long start, unsigned long end=
)
+{
+=09/*
+=09 * set_pte_at() called from vmap_pte_range() does not
+=09 * have a DSB after cleaning the cache line.
+=09 */
+=09dsb();
+}
+
+static inline void flush_cache_vunmap(unsigned long start, unsigned long e=
nd)
+{
+}
+
+#endif
diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/ca=
chetype.h
new file mode 100644
index 0000000..85f5f51
--- /dev/null
+++ b/arch/arm64/include/asm/cachetype.h
@@ -0,0 +1,48 @@
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
+#ifndef __ASM_CACHETYPE_H
+#define __ASM_CACHETYPE_H
+
+#include <asm/cputype.h>
+
+#define CTR_L1IP_SHIFT=09=0914
+#define CTR_L1IP_MASK=09=093
+
+#define ICACHE_POLICY_RESERVED=090
+#define ICACHE_POLICY_AIVIVT=091
+#define ICACHE_POLICY_VIPT=092
+#define ICACHE_POLICY_PIPT=093
+
+static inline u32 icache_policy(void)
+{
+=09return (read_cpuid_cachetype() >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK;
+}
+
+/*
+ * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
+ * permitted in the I-cache.
+ */
+static inline int icache_is_aliasing(void)
+{
+=09return icache_policy() !=3D ICACHE_POLICY_PIPT;
+}
+
+static inline int icache_is_aivivt(void)
+{
+=09return icache_policy() =3D=3D ICACHE_POLICY_AIVIVT;
+}
+
+#endif=09/* __ASM_CACHETYPE_H */
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
new file mode 100644
index 0000000..f4efa04
--- /dev/null
+++ b/arch/arm64/mm/cache.S
@@ -0,0 +1,279 @@
+/*
+ * Cache maintenance
+ *
+ * Copyright (C) 2001 Deep Blue Solutions Ltd.
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
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+
+#include "proc-macros.S"
+
+/*
+ *=09__cpuc_flush_dcache_all()
+ *
+ *=09Flush the whole D-cache.
+ *
+ *=09Corrupted registers: x0-x7, x9-x11
+ */
+ENTRY(__cpuc_flush_dcache_all)
+=09dsb=09sy=09=09=09=09// ensure ordering with previous memory accesses
+=09mrs=09x0, clidr_el1=09=09=09// read clidr
+=09and=09x3, x0, #0x7000000=09=09// extract loc from clidr
+=09lsr=09x3, x3, #23=09=09=09// left align loc bit field
+=09cbz=09x3, finished=09=09=09// if loc is 0, then no need to clean
+=09mov=09x10, #0=09=09=09=09// start clean at cache level 0
+loop1:
+=09add=09x2, x10, x10, lsr #1=09=09// work out 3x current cache level
+=09lsr=09x1, x0, x2=09=09=09// extract cache type bits from clidr
+=09and=09x1, x1, #7=09=09=09// mask of the bits for current cache only
+=09cmp=09x1, #2=09=09=09=09// see what cache we have at this level
+=09b.lt=09skip=09=09=09=09// skip if no cache, or just i-cache
+=09save_and_disable_irqs x9=09=09// make CSSELR and CCSIDR access atomic
+=09msr=09csselr_el1, x10=09=09=09// select current cache level in csselr
+=09isb=09=09=09=09=09// isb to sych the new cssr&csidr
+=09mrs=09x1, ccsidr_el1=09=09=09// read the new ccsidr
+=09restore_irqs x9
+=09and=09x2, x1, #7=09=09=09// extract the length of the cache lines
+=09add=09x2, x2, #4=09=09=09// add 4 (line length offset)
+=09mov=09x4, #0x3ff
+=09and=09x4, x4, x1, lsr #3=09=09// find maximum number on the way size
+=09clz=09x5, x4=09=09=09=09// find bit position of way size increment
+=09mov=09x7, #0x7fff
+=09and=09x7, x7, x1, lsr #13=09=09// extract max number of the index size
+loop2:
+=09mov=09x9, x4=09=09=09=09// create working copy of max way size
+loop3:
+=09lsl=09x6, x9, x5
+=09orr=09x11, x10, x6=09=09=09// factor way and cache number into x11
+=09lsl=09x6, x7, x2
+=09orr=09x11, x11, x6=09=09=09// factor index number into x11
+=09dc=09cisw, x11=09=09=09// clean & invalidate by set/way
+=09subs=09x9, x9, #1=09=09=09// decrement the way
+=09b.ge=09loop3
+=09subs=09x7, x7, #1=09=09=09// decrement the index
+=09b.ge=09loop2
+skip:
+=09add=09x10, x10, #2=09=09=09// increment cache number
+=09cmp=09x3, x10
+=09b.gt=09loop1
+finished:
+=09mov=09x10, #0=09=09=09=09// swith back to cache level 0
+=09msr=09csselr_el1, x10=09=09=09// select current cache level in csselr
+=09dsb=09sy
+=09isb
+=09ret
+ENDPROC(__cpuc_flush_dcache_all)
+
+/*
+ *=09__cpuc_flush_cache_all()
+ *
+ *=09Flush the entire cache system.  The data cache flush is now achieved
+ *=09using atomic clean / invalidates working outwards from L1 cache. This
+ *=09is done using Set/Way based cache maintainance instructions.  The
+ *=09instruction cache can still be invalidated back to the point of
+ *=09unification in a single instruction.
+ */
+ENTRY(__cpuc_flush_kern_all)
+=09mov=09x12, lr
+=09bl=09__cpuc_flush_dcache_all
+=09mov=09x0, #0
+=09ic=09ialluis=09=09=09=09// I+BTB cache invalidate
+=09ret=09x12
+ENDPROC(__cpuc_flush_kern_all)
+
+/*
+ *=09__cpuc_flush_cache_all()
+ *
+ *=09Flush all TLB entries in a particular address space
+ */
+ENTRY(__cpuc_flush_user_all)
+=09/*FALLTHROUGH*/
+
+/*
+ *=09__cpuc_flush_cache_range(start, end, flags)
+ *
+ *=09Flush a range of TLB entries in the specified address space.
+ *
+ *=09- start - start address (may not be aligned)
+ *=09- end   - end address (exclusive, may not be aligned)
+ *=09- flags=09- vm_area_struct flags describing address space
+ */
+ENTRY(__cpuc_flush_user_range)
+=09ret
+ENDPROC(__cpuc_flush_user_all)
+ENDPROC(__cpuc_flush_user_range)
+
+/*
+ *=09__cpuc_coherent_kern_range(start,end)
+ *
+ *=09Ensure that the I and D caches are coherent within specified region.
+ *=09This is typically used when code has been written to a memory region,
+ *=09and will be executed.
+ *
+ *=09- start   - virtual start address of region
+ *=09- end     - virtual end address of region
+ */
+ENTRY(__cpuc_coherent_kern_range)
+=09/* FALLTHROUGH */
+
+/*
+ *=09__cpuc_coherent_user_range(start,end)
+ *
+ *=09Ensure that the I and D caches are coherent within specified region.
+ *=09This is typically used when code has been written to a memory region,
+ *=09and will be executed.
+ *
+ *=09- start   - virtual start address of region
+ *=09- end     - virtual end address of region
+ */
+ENTRY(__cpuc_coherent_user_range)
+=09dcache_line_size x2, x3
+=09sub=09x3, x2, #1
+=09bic=09x4, x0, x3
+1:
+USER(9f, dc=09cvau, x4=09)=09=09// clean D line to PoU
+=09add=09x4, x4, x2
+=09cmp=09x4, x1
+=09b.lo=091b
+=09dsb=09sy
+
+=09icache_line_size x2, x3
+=09sub=09x3, x2, #1
+=09bic=09x4, x0, x3
+1:
+USER(9f, ic=09ivau, x4=09)=09=09// invalidate I line PoU
+=09add=09x4, x4, x2
+=09cmp=09x4, x1
+=09b.lo=091b
+9:=09=09=09=09=09=09// ignore any faulting cache operation
+=09dsb=09sy
+=09isb
+=09ret
+ENDPROC(__cpuc_coherent_kern_range)
+ENDPROC(__cpuc_coherent_user_range)
+
+=09.section .fixup,"ax"
+=09.align=090
+9001:=09ret
+=09.previous
+
+
+/*
+ *=09__cpuc_flush_kern_dcache_page(kaddr)
+ *
+ *=09Ensure that the data held in the page kaddr is written back to the
+ *=09page in question.
+ *
+ *=09- kaddr   - kernel address
+ *=09- size    - size in question
+ */
+ENTRY(__cpuc_flush_dcache_area)
+=09dcache_line_size x2, x3
+=09add=09x1, x0, x1
+=09sub=09x3, x2, #1
+=09bic=09x0, x0, x3
+1:=09dc=09civac, x0=09=09=09// clean & invalidate D line / unified line
+=09add=09x0, x0, x2
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09ret
+ENDPROC(__cpuc_flush_dcache_area)
+
+/*
+ *=09dmac_inv_range(start,end)
+ *
+ *=09Invalidate the data cache within the specified region; we will be
+ *=09performing a DMA operation in this region and we want to purge old
+ *=09data in the cache.
+ *
+ *=09- start   - virtual start address of region
+ *=09- end     - virtual end address of region
+ */
+ENTRY(dmac_inv_range)
+=09dcache_line_size x2, x3
+=09sub=09x3, x2, #1
+=09bic=09x0, x0, x3
+=09bic=09x1, x1, x3
+1:=09dc=09ivac, x0=09=09=09// invalidate D / U line
+=09add=09x0, x0, x2
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09ret
+ENDPROC(dmac_inv_range)
+
+/*
+ *=09dmac_clean_range(start,end)
+ *=09- start   - virtual start address of region
+ *=09- end     - virtual end address of region
+ */
+ENTRY(dmac_clean_range)
+=09dcache_line_size x2, x3
+=09sub=09x3, x2, #1
+=09bic=09x0, x0, x3
+1:=09dc=09cvac, x0=09=09=09// clean D / U line
+=09add=09x0, x0, x2
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09ret
+ENDPROC(dmac_clean_range)
+
+/*
+ *=09dmac_flush_range(start,end)
+ *=09- start   - virtual start address of region
+ *=09- end     - virtual end address of region
+ */
+ENTRY(dmac_flush_range)
+=09dcache_line_size x2, x3
+=09sub=09x3, x2, #1
+=09bic=09x0, x0, x3
+1:=09dc=09civac, x0=09=09=09// clean & invalidate D / U line
+=09add=09x0, x0, x2
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09ret
+ENDPROC(dmac_flush_range)
+
+/*
+ *=09dmac_map_area(start, size, dir)
+ *=09- start=09- kernel virtual start address
+ *=09- size=09- size of region
+ *=09- dir=09- DMA direction
+ */
+ENTRY(dmac_map_area)
+=09add=09x1, x1, x0
+=09cmp=09x2, #DMA_FROM_DEVICE
+=09b.eq=09dmac_inv_range
+=09b=09dmac_clean_range
+ENDPROC(dmac_map_area)
+
+/*
+ *=09dmac_unmap_area(start, size, dir)
+ *=09- start=09- kernel virtual start address
+ *=09- size=09- size of region
+ *=09- dir=09- DMA direction
+ */
+ENTRY(dmac_unmap_area)
+=09add=09x1, x1, x0
+=09cmp=09x2, #DMA_TO_DEVICE
+=09b.ne=09dmac_inv_range
+=09ret
+ENDPROC(dmac_unmap_area)
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
new file mode 100644
index 0000000..44f9e5c
--- /dev/null
+++ b/arch/arm64/mm/flush.c
@@ -0,0 +1,132 @@
+/*
+ * Based on arch/arm/mm/flush.c
+ *
+ * Copyright (C) 1995-2002 Russell King
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
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cachetype.h>
+#include <asm/tlbflush.h>
+
+#include "mm.h"
+
+void flush_cache_mm(struct mm_struct *mm)
+{
+}
+
+void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
+=09=09       unsigned long end)
+{
+=09if (vma->vm_flags & VM_EXEC)
+=09=09__flush_icache_all();
+}
+
+void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr,
+=09=09      unsigned long pfn)
+{
+}
+
+static void flush_ptrace_access(struct vm_area_struct *vma, struct page *p=
age,
+=09=09=09=09unsigned long uaddr, void *kaddr,
+=09=09=09=09unsigned long len)
+{
+=09if (vma->vm_flags & VM_EXEC) {
+=09=09unsigned long addr =3D (unsigned long)kaddr;
+=09=09if (icache_is_aliasing()) {
+=09=09=09__cpuc_flush_dcache_area(kaddr, len);
+=09=09=09__flush_icache_all();
+=09=09} else {
+=09=09=09__cpuc_coherent_kern_range(addr, addr + len);
+=09=09}
+=09}
+}
+
+/*
+ * Copy user data from/to a page which is mapped into a different processe=
s
+ * address space.  Really, we want to allow our "user space" model to hand=
le
+ * this.
+ *
+ * Note that this code needs to run on the current CPU.
+ */
+void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
+=09=09       unsigned long uaddr, void *dst, const void *src,
+=09=09       unsigned long len)
+{
+#ifdef CONFIG_SMP
+=09preempt_disable();
+#endif
+=09memcpy(dst, src, len);
+=09flush_ptrace_access(vma, page, uaddr, dst, len);
+#ifdef CONFIG_SMP
+=09preempt_enable();
+#endif
+}
+
+void __flush_dcache_page(struct address_space *mapping, struct page *page)
+{
+=09__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+}
+
+void __sync_icache_dcache(pte_t pte)
+{
+=09unsigned long pfn;
+=09struct page *page;
+
+=09pfn =3D pte_pfn(pte);
+=09if (!pfn_valid(pfn))
+=09=09return;
+
+=09page =3D pfn_to_page(pfn);
+=09if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+=09=09__flush_dcache_page(NULL, page);
+=09__flush_icache_all();
+}
+
+/*
+ * Ensure cache coherency between kernel mapping and userspace mapping of =
this
+ * page.
+ */
+void flush_dcache_page(struct page *page)
+{
+=09struct address_space *mapping;
+
+=09/*
+=09 * The zero page is never written to, so never has any dirty cache
+=09 * lines, and therefore never needs to be flushed.
+=09 */
+=09if (page =3D=3D ZERO_PAGE(0))
+=09=09return;
+
+=09mapping =3D page_mapping(page);
+
+=09if (mapping && !mapping_mapped(mapping))
+=09=09clear_bit(PG_dcache_clean, &page->flags);
+=09else {
+=09=09__flush_dcache_page(mapping, page);
+=09=09if (mapping)
+=09=09=09__flush_icache_all();
+=09=09set_bit(PG_dcache_clean, &page->flags);
+=09}
+}
+EXPORT_SYMBOL(flush_dcache_page);
+
+void __flush_anon_page(struct vm_area_struct *vma, struct page *page, unsi=
gned long vmaddr)
+{
+}

