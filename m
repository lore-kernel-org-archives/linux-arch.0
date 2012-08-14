Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55099 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817Ab2HNRxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:08 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 10/31] arm64: TLB maintenance functionality
Date: Tue, 14 Aug 2012 18:52:11 +0100
Message-ID: <1344966752-16102-11-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175211.vnpvG2cz3gDKKbXQogp2xMzPruKUQiGy5C0zcx2kuoE@z>

This patch adds the TLB maintenance functions. There is no distinction
made between the I and D TLBs. TLB maintenance operations are
automatically broadcast between CPUs in hardware. The inner-shareable
operations are always present, even on UP systems.

NOTE: Large part of this patch to be dropped once Peter Z's generic
mmu_gather patches are merged.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/tlb.h      |  190 +++++++++++++++++++++++++++++++++=
++++
 arch/arm64/include/asm/tlbflush.h |  123 ++++++++++++++++++++++++
 arch/arm64/mm/tlb.S               |   71 ++++++++++++++
 3 files changed, 384 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/tlb.h
 create mode 100644 arch/arm64/include/asm/tlbflush.h
 create mode 100644 arch/arm64/mm/tlb.S

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
new file mode 100644
index 0000000..654f096
--- /dev/null
+++ b/arch/arm64/include/asm/tlb.h
@@ -0,0 +1,190 @@
+/*
+ * Based on arch/arm/include/asm/tlb.h
+ *
+ * Copyright (C) 2002 Russell King
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
+#ifndef __ASM_TLB_H
+#define __ASM_TLB_H
+
+#include <linux/pagemap.h>
+#include <linux/swap.h>
+
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+
+#define MMU_GATHER_BUNDLE=098
+
+/*
+ * TLB handling.  This allows us to remove pages from the page
+ * tables, and efficiently handle the TLB issues.
+ */
+struct mmu_gather {
+=09struct mm_struct=09*mm;
+=09unsigned int=09=09fullmm;
+=09struct vm_area_struct=09*vma;
+=09unsigned long=09=09range_start;
+=09unsigned long=09=09range_end;
+=09unsigned int=09=09nr;
+=09unsigned int=09=09max;
+=09struct page=09=09**pages;
+=09struct page=09=09*local[MMU_GATHER_BUNDLE];
+};
+
+/*
+ * This is unnecessarily complex.  There's three ways the TLB shootdown
+ * code is used:
+ *  1. Unmapping a range of vmas.  See zap_page_range(), unmap_region().
+ *     tlb->fullmm =3D 0, and tlb_start_vma/tlb_end_vma will be called.
+ *     tlb->vma will be non-NULL.
+ *  2. Unmapping all vmas.  See exit_mmap().
+ *     tlb->fullmm =3D 1, and tlb_start_vma/tlb_end_vma will be called.
+ *     tlb->vma will be non-NULL.  Additionally, page tables will be freed=
.
+ *  3. Unmapping argument pages.  See shift_arg_pages().
+ *     tlb->fullmm =3D 0, but tlb_start_vma/tlb_end_vma will not be called=
.
+ *     tlb->vma will be NULL.
+ */
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+=09if (tlb->fullmm || !tlb->vma)
+=09=09flush_tlb_mm(tlb->mm);
+=09else if (tlb->range_end > 0) {
+=09=09flush_tlb_range(tlb->vma, tlb->range_start, tlb->range_end);
+=09=09tlb->range_start =3D TASK_SIZE;
+=09=09tlb->range_end =3D 0;
+=09}
+}
+
+static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long add=
r)
+{
+=09if (!tlb->fullmm) {
+=09=09if (addr < tlb->range_start)
+=09=09=09tlb->range_start =3D addr;
+=09=09if (addr + PAGE_SIZE > tlb->range_end)
+=09=09=09tlb->range_end =3D addr + PAGE_SIZE;
+=09}
+}
+
+static inline void __tlb_alloc_page(struct mmu_gather *tlb)
+{
+=09unsigned long addr =3D __get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
+
+=09if (addr) {
+=09=09tlb->pages =3D (void *)addr;
+=09=09tlb->max =3D PAGE_SIZE / sizeof(struct page *);
+=09}
+}
+
+static inline void tlb_flush_mmu(struct mmu_gather *tlb)
+{
+=09tlb_flush(tlb);
+=09free_pages_and_swap_cache(tlb->pages, tlb->nr);
+=09tlb->nr =3D 0;
+=09if (tlb->pages =3D=3D tlb->local)
+=09=09__tlb_alloc_page(tlb);
+}
+
+static inline void
+tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm, unsigned int =
fullmm)
+{
+=09tlb->mm =3D mm;
+=09tlb->fullmm =3D fullmm;
+=09tlb->vma =3D NULL;
+=09tlb->max =3D ARRAY_SIZE(tlb->local);
+=09tlb->pages =3D tlb->local;
+=09tlb->nr =3D 0;
+=09__tlb_alloc_page(tlb);
+}
+
+static inline void
+tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long =
end)
+{
+=09tlb_flush_mmu(tlb);
+
+=09/* keep the page table cache within bounds */
+=09check_pgt_cache();
+
+=09if (tlb->pages !=3D tlb->local)
+=09=09free_pages((unsigned long)tlb->pages, 0);
+}
+
+/*
+ * Memorize the range for the TLB flush.
+ */
+static inline void
+tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long ad=
dr)
+{
+=09tlb_add_flush(tlb, addr);
+}
+
+/*
+ * In the case of tlb vma handling, we can optimise these away in the
+ * case where we're doing a full MM flush.  When we're doing a munmap,
+ * the vmas are adjusted to only cover the region to be torn down.
+ */
+static inline void
+tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+=09if (!tlb->fullmm) {
+=09=09tlb->vma =3D vma;
+=09=09tlb->range_start =3D TASK_SIZE;
+=09=09tlb->range_end =3D 0;
+=09}
+}
+
+static inline void
+tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+=09if (!tlb->fullmm)
+=09=09tlb_flush(tlb);
+}
+
+static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *p=
age)
+{
+=09tlb->pages[tlb->nr++] =3D page;
+=09VM_BUG_ON(tlb->nr > tlb->max);
+=09return tlb->max - tlb->nr;
+}
+
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *pa=
ge)
+{
+=09if (!__tlb_remove_page(tlb, page))
+=09=09tlb_flush_mmu(tlb);
+}
+
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
+=09unsigned long addr)
+{
+=09pgtable_page_dtor(pte);
+=09tlb_add_flush(tlb, addr);
+=09tlb_remove_page(tlb, pte);
+}
+
+#ifndef CONFIG_ARM64_64K_PAGES
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
+=09=09=09=09  unsigned long addr)
+{
+=09tlb_add_flush(tlb, addr);
+=09tlb_remove_page(tlb, virt_to_page(pmdp));
+}
+#endif
+
+#define pte_free_tlb(tlb, ptep, addr)=09__pte_free_tlb(tlb, ptep, addr)
+#define pmd_free_tlb(tlb, pmdp, addr)=09__pmd_free_tlb(tlb, pmdp, addr)
+#define pud_free_tlb(tlb, pudp, addr)=09pud_free((tlb)->mm, pudp)
+
+#define tlb_migrate_finish(mm)=09=09do { } while (0)
+
+#endif
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlb=
flush.h
new file mode 100644
index 0000000..615d131
--- /dev/null
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -0,0 +1,123 @@
+/*
+ * Based on arch/arm/include/asm/tlbflush.h
+ *
+ * Copyright (C) 1999-2003 Russell King
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
+#ifndef __ASM_TLBFLUSH_H
+#define __ASM_TLBFLUSH_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/sched.h>
+#include <asm/cputype.h>
+
+extern void __cpu_flush_user_tlb_range(unsigned long, unsigned long, struc=
t vm_area_struct *);
+extern void __cpu_flush_kern_tlb_range(unsigned long, unsigned long);
+
+extern struct cpu_tlb_fns cpu_tlb;
+
+/*
+ *=09TLB Management
+ *=09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ *=09The arch/arm/mm/tlb-*.S files implement these methods.
+ *
+ *=09The TLB specific code is expected to perform whatever tests it
+ *=09needs to determine if it should invalidate the TLB for each
+ *=09call.  Start addresses are inclusive and end addresses are
+ *=09exclusive; it is safe to round these addresses down.
+ *
+ *=09flush_tlb_all()
+ *
+ *=09=09Invalidate the entire TLB.
+ *
+ *=09flush_tlb_mm(mm)
+ *
+ *=09=09Invalidate all TLB entries in a particular address
+ *=09=09space.
+ *=09=09- mm=09- mm_struct describing address space
+ *
+ *=09flush_tlb_range(mm,start,end)
+ *
+ *=09=09Invalidate a range of TLB entries in the specified
+ *=09=09address space.
+ *=09=09- mm=09- mm_struct describing address space
+ *=09=09- start - start address (may not be aligned)
+ *=09=09- end=09- end address (exclusive, may not be aligned)
+ *
+ *=09flush_tlb_page(vaddr,vma)
+ *
+ *=09=09Invalidate the specified page in the specified address range.
+ *=09=09- vaddr - virtual address (may not be aligned)
+ *=09=09- vma=09- vma_struct describing address range
+ *
+ *=09flush_kern_tlb_page(kaddr)
+ *
+ *=09=09Invalidate the TLB entry for the specified page.  The address
+ *=09=09will be in the kernels virtual memory space.  Current uses
+ *=09=09only require the D-TLB to be invalidated.
+ *=09=09- kaddr - Kernel virtual memory address
+ */
+static inline void flush_tlb_all(void)
+{
+=09dsb();
+=09asm("tlbi=09vmalle1is");
+=09dsb();
+=09isb();
+}
+
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+=09unsigned long asid =3D (unsigned long)ASID(mm) << 48;
+
+=09dsb();
+=09asm("tlbi=09aside1is, %0" : : "r" (asid));
+=09dsb();
+}
+
+static inline void flush_tlb_page(struct vm_area_struct *vma,
+=09=09=09=09  unsigned long uaddr)
+{
+=09unsigned long addr =3D uaddr >> 12 |
+=09=09((unsigned long)ASID(vma->vm_mm) << 48);
+
+=09dsb();
+=09asm("tlbi=09vae1is, %0" : : "r" (addr));
+=09dsb();
+}
+
+/*
+ * Convert calls to our calling convention.
+ */
+#define flush_tlb_range(vma,start,end)=09__cpu_flush_user_tlb_range(start,=
end,vma)
+#define flush_tlb_kernel_range(s,e)=09__cpu_flush_kern_tlb_range(s,e)
+
+/*
+ * On AArch64, the cache coherency is handled via the set_pte_at() functio=
n.
+ */
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+=09=09=09=09    unsigned long addr, pte_t *ptep)
+{
+=09/*
+=09 * set_pte() does not have a DSB, so make sure that the page table
+=09 * write is visible.
+=09 */
+=09dsb();
+}
+
+#endif
+
+#endif
diff --git a/arch/arm64/mm/tlb.S b/arch/arm64/mm/tlb.S
new file mode 100644
index 0000000..8ae80a1
--- /dev/null
+++ b/arch/arm64/mm/tlb.S
@@ -0,0 +1,71 @@
+/*
+ * Based on arch/arm/mm/tlb.S
+ *
+ * Copyright (C) 1997-2002 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Written by Catalin Marinas <catalin.marinas@arm.com>
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
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
+#include "proc-macros.S"
+
+/*
+ *=09__cpu_flush_user_tlb_range(start, end, vma)
+ *
+ *=09Invalidate a range of TLB entries in the specified address space.
+ *
+ *=09- start - start address (may not be aligned)
+ *=09- end   - end address (exclusive, may not be aligned)
+ *=09- vma   - vma_struct describing address range
+ */
+ENTRY(__cpu_flush_user_tlb_range)
+=09vma_vm_mm x3, x2=09=09=09// get vma->vm_mm
+=09mmid=09x3, x3=09=09=09=09// get vm_mm->context.id
+=09dsb=09sy
+=09lsr=09x0, x0, #12=09=09=09// align address
+=09lsr=09x1, x1, #12
+=09bfi=09x0, x3, #48, #16=09=09// start VA and ASID
+=09bfi=09x1, x3, #48, #16=09=09// end VA and ASID
+1:=09tlbi=09vae1is, x0=09=09=09// TLB invalidate by address and ASID
+=09add=09x0, x0, #1
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09ret
+ENDPROC(__cpu_flush_user_tlb_range)
+
+/*
+ *=09__cpu_flush_kern_tlb_range(start,end)
+ *
+ *=09Invalidate a range of kernel TLB entries.
+ *
+ *=09- start - start address (may not be aligned)
+ *=09- end   - end address (exclusive, may not be aligned)
+ */
+ENTRY(__cpu_flush_kern_tlb_range)
+=09dsb=09sy
+=09lsr=09x0, x0, #12=09=09=09// align address
+=09lsr=09x1, x1, #12
+1:=09tlbi=09vaae1is, x0=09=09=09// TLB invalidate by address
+=09add=09x0, x0, #1
+=09cmp=09x0, x1
+=09b.lo=091b
+=09dsb=09sy
+=09isb
+=09ret
+ENDPROC(__cpu_flush_kern_tlb_range)

