From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 3/6] ARM: mm: HugeTLB support for LPAE systems.
Date: Thu, 18 Oct 2012 17:15:39 +0100
Message-ID: <1350576942-25299-4-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52979 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042Ab2JRQQG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:16:06 -0400
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds support for hugetlbfs based on the x86 implementation.
It allows mapping of 2MB sections (see Documentation/vm/hugetlbpage.txt
for usage). The 64K pages configuration is not supported (section size
is 512MB in this case).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[steve.capper@arm.com: symbolic constants replace numbers in places.
Split up into multiple files, to simplify future non-LPAE support].
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    4 +
 arch/arm/include/asm/hugetlb-3level.h |   61 +++++++++++
 arch/arm/include/asm/hugetlb.h        |   83 ++++++++++++++
 arch/arm/include/asm/pgtable-3level.h |   13 +++
 arch/arm/mm/Makefile                  |    2 +
 arch/arm/mm/dma-mapping.c             |    2 +-
 arch/arm/mm/hugetlbpage-3level.c      |  190 +++++++++++++++++++++++++++++=
++++
 arch/arm/mm/hugetlbpage.c             |   65 +++++++++++
 8 files changed, 419 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/hugetlb-3level.h
 create mode 100644 arch/arm/include/asm/hugetlb.h
 create mode 100644 arch/arm/mm/hugetlbpage-3level.c
 create mode 100644 arch/arm/mm/hugetlbpage.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 73067ef..d863781 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1767,6 +1767,10 @@ config HW_PERF_EVENTS
 =09  Enable hardware performance counter support for perf events. If
 =09  disabled, perf events will use software events only.
=20
+config SYS_SUPPORTS_HUGETLBFS
+       def_bool y
+       depends on ARM_LPAE
+
 source "mm/Kconfig"
=20
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/h=
ugetlb-3level.h
new file mode 100644
index 0000000..4868064
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/include/asm/hugetlb-3level.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h.
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_ARM_HUGETLB_3LEVEL_H
+#define _ASM_ARM_HUGETLB_3LEVEL_H
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+=09return *ptep;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long add=
r,
+=09=09=09=09   pte_t *ptep, pte_t pte)
+{
+=09set_pte_at(mm, addr, ptep, pte);
+}
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+=09=09=09=09=09 unsigned long addr, pte_t *ptep)
+{
+=09ptep_clear_flush(vma, addr, ptep);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+=09=09=09=09=09   unsigned long addr, pte_t *ptep)
+{
+=09ptep_set_wrprotect(mm, addr, ptep);
+}
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+=09=09=09=09=09    unsigned long addr, pte_t *ptep)
+{
+=09return ptep_get_and_clear(mm, addr, ptep);
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+=09=09=09=09=09     unsigned long addr, pte_t *ptep,
+=09=09=09=09=09     pte_t pte, int dirty)
+{
+=09return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+}
+
+#endif /* _ASM_ARM_HUGETLB_3LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.=
h
new file mode 100644
index 0000000..7af9cf6
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb.h
@@ -0,0 +1,83 @@
+/*
+ * arch/arm/include/asm/hugetlb.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_ARM_HUGETLB_H
+#define _ASM_ARM_HUGETLB_H
+
+#include <asm/page.h>
+
+#include <asm/hugetlb-3level.h>
+
+static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
+=09=09=09=09=09  unsigned long addr, unsigned long end,
+=09=09=09=09=09  unsigned long floor,
+=09=09=09=09=09  unsigned long ceiling)
+{
+=09free_pgd_range(tlb, addr, end, floor, ceiling);
+}
+
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+=09=09=09=09=09 unsigned long addr, unsigned long len)
+{
+=09return 0;
+}
+
+static inline int prepare_hugepage_range(struct file *file,
+=09=09=09=09=09 unsigned long addr, unsigned long len)
+{
+=09struct hstate *h =3D hstate_file(file);
+=09if (len & ~huge_page_mask(h))
+=09=09return -EINVAL;
+=09if (addr & ~huge_page_mask(h))
+=09=09return -EINVAL;
+=09return 0;
+}
+
+static inline void hugetlb_prefault_arch_hook(struct mm_struct *mm)
+{
+}
+
+static inline int huge_pte_none(pte_t pte)
+{
+=09return pte_none(pte);
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+=09return pte_wrprotect(pte);
+}
+
+static inline int arch_prepare_hugepage(struct page *page)
+{
+=09return 0;
+}
+
+static inline void arch_release_hugepage(struct page *page)
+{
+}
+
+static inline void arch_clear_hugepage_flags(struct page *page)
+{
+=09clear_bit(PG_dcache_clean, &page->flags);
+}
+
+#endif /* _ASM_ARM_HUGETLB_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index 0eaeb55..d086f61 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -62,6 +62,14 @@
 #define USER_PTRS_PER_PGD=09(PAGE_OFFSET / PGDIR_SIZE)
=20
 /*
+ * Hugetlb definitions.
+ */
+#define HPAGE_SHIFT=09=09PMD_SHIFT
+#define HPAGE_SIZE=09=09(_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK=09=09(~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER=09(HPAGE_SHIFT - PAGE_SHIFT)
+
+/*
  * "Linux" PTE definitions for LPAE.
  *
  * These bits overlap with the hardware bits but the naming is preserved f=
or
@@ -153,6 +161,11 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned l=
ong addr)
=20
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|=
(ext)))
=20
+#define pte_huge(pte)=09=09((pte_val(pte) & PMD_TYPE_MASK) =3D=3D PMD_TYPE=
_SECT)
+
+#define pte_mkhuge(pte)=09=09(__pte((pte_val(pte) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
+
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_3LEVEL_H */
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 8a9c4cb..1560bbc 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_MODULES)=09=09+=3D proc-syms.o
=20
 obj-$(CONFIG_ALIGNMENT_TRAP)=09+=3D alignment.o
 obj-$(CONFIG_HIGHMEM)=09=09+=3D highmem.o
+obj-$(CONFIG_HUGETLB_PAGE)=09+=3D hugetlbpage.o
+obj-$(CONFIG_HUGETLB_PAGE)=09+=3D hugetlbpage-3level.o
=20
 obj-$(CONFIG_CPU_ABRT_NOMMU)=09+=3D abort-nommu.o
 obj-$(CONFIG_CPU_ABRT_EV4)=09+=3D abort-ev4.o
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 477a2d2..3ced228 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -241,7 +241,7 @@ static void __dma_free_buffer(struct page *page, size_t=
 size)
=20
 #ifdef CONFIG_MMU
 #ifdef CONFIG_HUGETLB_PAGE
-#error ARM Coherent DMA allocator does not (yet) support huge TLB
+#warning ARM Coherent DMA allocator does not (yet) support huge TLB
 #endif
=20
 static void *__alloc_from_contiguous(struct device *dev, size_t size,
diff --git a/arch/arm/mm/hugetlbpage-3level.c b/arch/arm/mm/hugetlbpage-3le=
vel.c
new file mode 100644
index 0000000..86474f0
--- /dev/null
+++ b/arch/arm/mm/hugetlbpage-3level.c
@@ -0,0 +1,190 @@
+/*
+ * arch/arm/mm/hugetlbpage-3level.c
+ *
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/mm/hugetlbpage.c
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/err.h>
+#include <linux/sysctl.h>
+#include <asm/mman.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
+
+static unsigned long page_table_shareable(struct vm_area_struct *svma,
+=09=09=09=09struct vm_area_struct *vma,
+=09=09=09=09unsigned long addr, pgoff_t idx)
+{
+=09unsigned long saddr =3D ((idx - svma->vm_pgoff) << PAGE_SHIFT) +
+=09=09=09=09svma->vm_start;
+=09unsigned long sbase =3D saddr & PUD_MASK;
+=09unsigned long s_end =3D sbase + PUD_SIZE;
+
+=09/* Allow segments to share if only one is marked locked */
+=09unsigned long vm_flags =3D vma->vm_flags & ~VM_LOCKED;
+=09unsigned long svm_flags =3D svma->vm_flags & ~VM_LOCKED;
+
+=09/*
+=09 * match the virtual addresses, permission and the alignment of the
+=09 * page table page.
+=09 */
+=09if (pmd_index(addr) !=3D pmd_index(saddr) ||
+=09    vm_flags !=3D svm_flags ||
+=09    sbase < svma->vm_start || svma->vm_end < s_end)
+=09=09return 0;
+
+=09return saddr;
+}
+
+static int vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+=09unsigned long base =3D addr & PUD_MASK;
+=09unsigned long end =3D base + PUD_SIZE;
+
+=09/*
+=09 * check on proper vm_flags and page table alignment
+=09 */
+=09if (vma->vm_flags & VM_MAYSHARE &&
+=09    vma->vm_start <=3D base && end <=3D vma->vm_end)
+=09=09return 1;
+=09return 0;
+}
+
+/*
+ * search for a shareable pmd page for hugetlb.
+ */
+static pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr,
+=09=09=09     pud_t *pud)
+{
+=09struct vm_area_struct *vma =3D find_vma(mm, addr);
+=09struct address_space *mapping =3D vma->vm_file->f_mapping;
+=09pgoff_t idx =3D ((addr - vma->vm_start) >> PAGE_SHIFT) +
+=09=09=09vma->vm_pgoff;
+=09struct vm_area_struct *svma;
+=09unsigned long saddr;
+=09pte_t *spte =3D NULL;
+=09pte_t *pte;
+
+=09if (!vma_shareable(vma, addr))
+=09=09return (pte_t *)pmd_alloc(mm, pud, addr);
+
+=09mutex_lock(&mapping->i_mmap_mutex);
+=09vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
+=09=09if (svma =3D=3D vma)
+=09=09=09continue;
+
+=09=09saddr =3D page_table_shareable(svma, vma, addr, idx);
+=09=09if (saddr) {
+=09=09=09spte =3D huge_pte_offset(svma->vm_mm, saddr);
+=09=09=09if (spte) {
+=09=09=09=09get_page(virt_to_page(spte));
+=09=09=09=09break;
+=09=09=09}
+=09=09}
+=09}
+
+=09if (!spte)
+=09=09goto out;
+
+=09spin_lock(&mm->page_table_lock);
+=09if (pud_none(*pud))
+=09=09pud_populate(mm, pud, (pmd_t *)((unsigned long)spte & PAGE_MASK));
+=09else
+=09=09put_page(virt_to_page(spte));
+=09spin_unlock(&mm->page_table_lock);
+out:
+=09pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
+=09mutex_unlock(&mapping->i_mmap_mutex);
+=09return pte;
+}
+
+/*
+ * unmap huge page backed by shared pte.
+ *
+ * Hugetlb pte page is ref counted at the time of mapping.  If pte is shar=
ed
+ * indicated by page_count > 1, unmap is achieved by clearing pud and
+ * decrementing the ref count. If count =3D=3D 1, the pte page is not shar=
ed.
+ *
+ * called with vma->vm_mm->page_table_lock held.
+ *
+ * returns: 1 successfully unmapped a shared pte page
+ *=09    0 the underlying pte page is not shared, or it is the last user
+ */
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *pte=
p)
+{
+=09pgd_t *pgd =3D pgd_offset(mm, *addr);
+=09pud_t *pud =3D pud_offset(pgd, *addr);
+
+=09BUG_ON(page_count(virt_to_page(ptep)) =3D=3D 0);
+=09if (page_count(virt_to_page(ptep)) =3D=3D 1)
+=09=09return 0;
+
+=09pud_clear(pud);
+=09put_page(virt_to_page(ptep));
+=09*addr =3D ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
+=09return 1;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm,
+=09=09=09unsigned long addr, unsigned long sz)
+{
+=09pgd_t *pgd;
+=09pud_t *pud;
+=09pte_t *pte =3D NULL;
+
+=09pgd =3D pgd_offset(mm, addr);
+=09pud =3D pud_alloc(mm, pgd, addr);
+=09if (pud) {
+=09=09BUG_ON(sz !=3D PMD_SIZE);
+=09=09if (pud_none(*pud))
+=09=09=09pte =3D huge_pmd_share(mm, addr, pud);
+=09=09else
+=09=09=09pte =3D (pte_t *)pmd_alloc(mm, pud, addr);
+=09}
+=09BUG_ON(pte && !pte_none(*pte) && !pte_huge(*pte));
+
+=09return pte;
+}
+
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+=09=09=09     pmd_t *pmd, int write)
+{
+=09struct page *page;
+
+=09page =3D pte_page(*(pte_t *)pmd);
+=09if (page)
+=09=09page +=3D ((address & ~PMD_MASK) >> PAGE_SHIFT);
+=09return page;
+}
+
+struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
+=09=09=09     pud_t *pud, int write)
+{
+=09struct page *page;
+
+=09page =3D pte_page(*(pte_t *)pud);
+=09if (page)
+=09=09page +=3D ((address & ~PUD_MASK) >> PAGE_SHIFT);
+=09return page;
+}
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
new file mode 100644
index 0000000..32fe7fd
--- /dev/null
+++ b/arch/arm/mm/hugetlbpage.c
@@ -0,0 +1,65 @@
+/*
+ * arch/arm/mm/hugetlbpage.c
+ *
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/mm/hugetlbpage.c
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/pagemap.h>
+#include <linux/err.h>
+#include <linux/sysctl.h>
+#include <asm/mman.h>
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
+
+pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+=09pgd_t *pgd;
+=09pud_t *pud;
+=09pmd_t *pmd =3D NULL;
+
+=09pgd =3D pgd_offset(mm, addr);
+=09if (pgd_present(*pgd)) {
+=09=09pud =3D pud_offset(pgd, addr);
+=09=09if (pud_present(*pud))
+=09=09=09pmd =3D pmd_offset(pud, addr);
+=09}
+
+=09return (pte_t *)pmd;
+}
+
+struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
+=09=09=09      int write)
+{
+=09return ERR_PTR(-EINVAL);
+}
+
+int pmd_huge(pmd_t pmd)
+{
+=09return (pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SECT;
+}
+
+int pud_huge(pud_t pud)
+{
+=09return 0;
+}
--=20
1.7.9.5
