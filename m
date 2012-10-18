From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 4/6] ARM: mm: HugeTLB support for non-LPAE systems.
Date: Thu, 18 Oct 2012 17:15:40 +0100
Message-ID: <1350576942-25299-5-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53456 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757042Ab2JRQQL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:16:11 -0400
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Based on Bill Carson's HugeTLB patch, with the big difference being in the =
way
PTEs are passed back to the memory manager. Rather than store a "Linux Huge
PTE" separately; we make one up on the fly in huge_ptep_get. Also rather th=
an
consider 16M supersections, we focus solely on 2x1M sections.

To construct a huge PTE on the fly we need additional information (such as =
the
accessed flag and dirty bit) which we choose to store in the domain bits of=
 the
short section descriptor. In order to use these domain bits for storage, we=
 need
to make ourselves a client for all 16 domains and this is done in head.S.

Storing extra information in the domain bits also makes it a lot easier to
implement Transparent Huge Pages, and some of the code in pgtable-2level.h =
is
arranged to facilitate THP support in a later patch.

Non-LPAE HugeTLB pages are incompatible with the huge page migration code
(enabled when CONFIG_MEMORY_FAILURE is selected) as that code dereferences =
PTEs
directly, rather than calling huge_ptep_get and set_huge_pte_at.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    2 +-
 arch/arm/include/asm/hugetlb-2level.h |   71 ++++++++++++++++++++
 arch/arm/include/asm/hugetlb.h        |    4 ++
 arch/arm/include/asm/pgtable-2level.h |   79 +++++++++++++++++++++-
 arch/arm/include/asm/tlb.h            |   10 ++-
 arch/arm/kernel/head.S                |   10 ++-
 arch/arm/mm/Makefile                  |    4 ++
 arch/arm/mm/fault.c                   |    6 +-
 arch/arm/mm/hugetlbpage-2level.c      |  115 +++++++++++++++++++++++++++++=
++++
 9 files changed, 293 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h
 create mode 100644 arch/arm/mm/hugetlbpage-2level.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d863781..dd0a230 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1769,7 +1769,7 @@ config HW_PERF_EVENTS
=20
 config SYS_SUPPORTS_HUGETLBFS
        def_bool y
-       depends on ARM_LPAE
+       depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
=20
 source "mm/Kconfig"
=20
diff --git a/arch/arm/include/asm/hugetlb-2level.h b/arch/arm/include/asm/h=
ugetlb-2level.h
new file mode 100644
index 0000000..3532b54
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-2level.h
@@ -0,0 +1,71 @@
+/*
+ * arch/arm/include/asm/hugetlb-2level.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
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
+#ifndef _ASM_ARM_HUGETLB_2LEVEL_H
+#define _ASM_ARM_HUGETLB_2LEVEL_H
+
+
+pte_t huge_ptep_get(pte_t *ptep);
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+=09=09=09=09   pte_t *ptep, pte_t pte);
+
+static inline pte_t pte_mkhuge(pte_t pte) { return pte; }
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+=09=09=09=09=09 unsigned long addr, pte_t *ptep)
+{
+=09flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+=09=09=09=09=09   unsigned long addr, pte_t *ptep)
+{
+=09pmd_t *pmdp =3D (pmd_t *) ptep;
+=09set_pmd_at(mm, addr, pmdp, pmd_wrprotect(*pmdp));
+}
+
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+=09=09=09=09=09    unsigned long addr, pte_t *ptep)
+{
+=09pmd_t *pmdp =3D (pmd_t *)ptep;
+=09pte_t pte =3D huge_ptep_get(ptep);
+=09pmd_clear(pmdp);
+
+=09return pte;
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+=09=09=09=09=09     unsigned long addr, pte_t *ptep,
+=09=09=09=09=09     pte_t pte, int dirty)
+{
+=09int changed =3D !pte_same(huge_ptep_get(ptep), pte);
+
+=09if (changed) {
+=09=09set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+=09=09huge_ptep_clear_flush(vma, addr, &pte);
+=09}
+
+=09return changed;
+}
+
+#endif /* _ASM_ARM_HUGETLB_2LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.=
h
index 7af9cf6..1e92975 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -24,7 +24,11 @@
=20
 #include <asm/page.h>
=20
+#ifdef CONFIG_ARM_LPAE
 #include <asm/hugetlb-3level.h>
+#else
+#include <asm/hugetlb-2level.h>
+#endif
=20
 static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 =09=09=09=09=09  unsigned long addr, unsigned long end,
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/p=
gtable-2level.h
index 662a00e..fd1d9be 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -163,7 +163,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned lo=
ng addr)
 =09return (pmd_t *)pud;
 }
=20
-#define pmd_bad(pmd)=09=09(pmd_val(pmd) & 2)
+#define pmd_bad(pmd)=09=09((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_=
FAULT)
=20
 #define copy_pmd(pmdpd,pmdps)=09=09\
 =09do {=09=09=09=09\
@@ -184,6 +184,83 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned l=
ong addr)
=20
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
=20
+
+#ifdef CONFIG_SYS_SUPPORTS_HUGETLBFS
+
+/*
+ * now follows some of the definitions to allow huge page support, we can'=
t put
+ * these in the hugetlb source files as they are also required for transpa=
rent
+ * hugepage support.
+ */
+
+#define HPAGE_SHIFT             PMD_SHIFT
+#define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+
+#define HUGE_LINUX_PTE_COUNT       (PAGE_OFFSET >> HPAGE_SHIFT)
+#define HUGE_LINUX_PTE_SIZE        (HUGE_LINUX_PTE_COUNT * sizeof(pte_t *)=
)
+#define HUGE_LINUX_PTE_INDEX(addr) (addr >> HPAGE_SHIFT)
+
+/*
+ *  We re-purpose the following domain bits in the section descriptor
+ */
+#define PMD_DSECT_DIRTY=09=09(_AT(pmdval_t, 1) << 5)
+#define PMD_DSECT_AF=09=09(_AT(pmdval_t, 1) << 6)
+
+#define PMD_BIT_FUNC(fn,op) \
+static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
+
+PMD_BIT_FUNC(wrprotect,=09&=3D ~PMD_SECT_AP_WRITE);
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+=09=09=09=09pmd_t *pmdp, pmd_t pmd)
+{
+=09/*
+=09 * we can sometimes be passed a pmd pointing to a level 2 descriptor
+=09 * from collapse_huge_page.
+=09 */
+=09if ((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_TABLE) {
+=09=09pmdp[0] =3D __pmd(pmd_val(pmd));
+=09=09pmdp[1] =3D __pmd(pmd_val(pmd) + 256 * sizeof(pte_t));
+=09} else {
+=09=09pmdp[0] =3D __pmd(pmd_val(pmd));=09=09=09/* first 1M section  */
+=09=09pmdp[1] =3D __pmd(pmd_val(pmd) + SECTION_SIZE);=09/* second 1M secti=
on */
+=09}
+
+=09flush_pmd_entry(pmdp);
+}
+
+#define HPMD_XLATE(res, cmp, from, to) do { if (cmp & from) res |=3D to;=
=09\
+=09=09=09=09=09    else res &=3D ~to;=09=09\
+=09=09=09=09=09  } while (0)
+
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+=09pmdval_t pmdval =3D pmd_val(pmd);
+=09pteval_t newprotval =3D pgprot_val(newprot);
+
+=09HPMD_XLATE(pmdval, newprotval, L_PTE_XN, PMD_SECT_XN);
+=09HPMD_XLATE(pmdval, newprotval, L_PTE_SHARED, PMD_SECT_S);
+=09HPMD_XLATE(pmdval, newprotval, L_PTE_YOUNG, PMD_DSECT_AF);
+=09HPMD_XLATE(pmdval, newprotval, L_PTE_DIRTY, PMD_DSECT_DIRTY);
+
+=09/* preserve bits C & B */
+=09pmdval |=3D (newprotval & (3 << 2));
+
+=09/* Linux PTE bit 4 corresponds to PMD TEX bit 0 */
+=09HPMD_XLATE(pmdval, newprotval, 1 << 4, PMD_SECT_TEX(1));
+
+=09if (newprotval & L_PTE_RDONLY)
+=09=09pmdval &=3D ~PMD_SECT_AP_WRITE;
+=09else
+=09=09pmdval |=3D PMD_SECT_AP_WRITE;
+
+=09return __pmd(pmdval);
+}
+
+#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 99a1951..685e9e87 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -92,10 +92,16 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long add=
r)
 {
 =09if (!tlb->fullmm) {
+=09=09unsigned long size =3D PAGE_SIZE;
+
 =09=09if (addr < tlb->range_start)
 =09=09=09tlb->range_start =3D addr;
-=09=09if (addr + PAGE_SIZE > tlb->range_end)
-=09=09=09tlb->range_end =3D addr + PAGE_SIZE;
+
+=09=09if (tlb->vma && is_vm_hugetlb_page(tlb->vma))
+=09=09=09size =3D HPAGE_SIZE;
+
+=09=09if (addr + size > tlb->range_end)
+=09=09=09tlb->range_end =3D addr + size;
 =09}
 }
=20
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 4eee351..860f08e 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -410,13 +410,21 @@ __enable_mmu:
 =09mov=09r5, #0
 =09mcrr=09p15, 0, r4, r5, c2=09=09@ load TTBR0
 #else
+#ifndef=09CONFIG_SYS_SUPPORTS_HUGETLBFS
 =09mov=09r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
 =09=09      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 =09=09      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 =09=09      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+#else
+=09@ set ourselves as the client in all domains
+=09@ this allows us to then use the 4 domain bits in the
+=09@ section descriptors in our transparent huge pages
+=09ldr=09r5, =3D0x55555555
+#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
+
 =09mcr=09p15, 0, r5, c3, c0, 0=09=09@ load domain access register
 =09mcr=09p15, 0, r4, c2, c0, 0=09=09@ load page table pointer
-#endif
+#endif /* CONFIG_ARM_LPAE */
 =09b=09__turn_mmu_on
 ENDPROC(__enable_mmu)
=20
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 1560bbc..adf0b19 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -17,7 +17,11 @@ obj-$(CONFIG_MODULES)=09=09+=3D proc-syms.o
 obj-$(CONFIG_ALIGNMENT_TRAP)=09+=3D alignment.o
 obj-$(CONFIG_HIGHMEM)=09=09+=3D highmem.o
 obj-$(CONFIG_HUGETLB_PAGE)=09+=3D hugetlbpage.o
+ifeq ($(CONFIG_ARM_LPAE),y)
 obj-$(CONFIG_HUGETLB_PAGE)=09+=3D hugetlbpage-3level.o
+else
+obj-$(CONFIG_HUGETLB_PAGE)=09+=3D hugetlbpage-2level.o
+endif
=20
 obj-$(CONFIG_CPU_ABRT_NOMMU)=09+=3D abort-nommu.o
 obj-$(CONFIG_CPU_ABRT_EV4)=09+=3D abort-ev4.o
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5dbf13f..0884936 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -488,13 +488,13 @@ do_translation_fault(unsigned long addr, unsigned int=
 fsr,
 #endif=09=09=09=09=09/* CONFIG_MMU */
=20
 /*
- * Some section permission faults need to be handled gracefully.
- * They can happen due to a __{get,put}_user during an oops.
+ * A fault in a section will likely be due to a huge page, treat it
+ * as a page fault.
  */
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
-=09do_bad_area(addr, fsr, regs);
+=09do_page_fault(addr, fsr, regs);
 =09return 0;
 }
=20
diff --git a/arch/arm/mm/hugetlbpage-2level.c b/arch/arm/mm/hugetlbpage-2le=
vel.c
new file mode 100644
index 0000000..4b2b38c
--- /dev/null
+++ b/arch/arm/mm/hugetlbpage-2level.c
@@ -0,0 +1,115 @@
+/*
+ * arch/arm/mm/hugetlbpage-2level.c
+ *
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ * Copyright (C) 2012 ARM Ltd
+ * Copyright (C) 2012 Bill Carson.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
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
+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *pte=
p)
+{
+=09return 0;
+}
+
+pte_t *huge_pte_alloc(struct mm_struct *mm,
+=09=09=09unsigned long addr, unsigned long sz)
+{
+=09pgd_t *pgd;
+=09pud_t *pud;
+=09pmd_t *pmd;
+
+=09pgd =3D pgd_offset(mm, addr);
+=09pud =3D pud_offset(pgd, addr);
+=09pmd =3D pmd_offset(pud, addr);
+
+=09return (pte_t *)pmd; /* our huge pte is actually a pmd */
+}
+
+struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
+=09=09=09     pmd_t *pmd, int write)
+{
+=09struct page *page;
+=09unsigned long pfn;
+
+=09BUG_ON((pmd_val(*pmd) & PMD_TYPE_MASK) !=3D PMD_TYPE_SECT);
+=09pfn =3D ((pmd_val(*pmd) & HPAGE_MASK) >> PAGE_SHIFT);
+=09page =3D pfn_to_page(pfn);
+=09return page;
+}
+
+pte_t huge_ptep_get(pte_t *ptep)
+{
+=09pmd_t *pmdp =3D (pmd_t*)ptep;
+=09pmdval_t pmdval =3D pmd_val(*pmdp);
+=09pteval_t retval;
+
+=09if (!pmdval)
+=09=09return __pte(0);
+
+=09retval =3D (pteval_t) (pmdval & HPAGE_MASK);
+=09HPMD_XLATE(retval, pmdval, PMD_SECT_XN, L_PTE_XN);
+=09HPMD_XLATE(retval, pmdval, PMD_SECT_S, L_PTE_SHARED);
+=09HPMD_XLATE(retval, pmdval, PMD_DSECT_AF, L_PTE_YOUNG);
+=09HPMD_XLATE(retval, pmdval, PMD_DSECT_DIRTY, L_PTE_DIRTY);
+
+=09/* preserve bits C & B */
+=09retval |=3D (pmdval & (3 << 2));
+
+=09/* PMD TEX bit 0 corresponds to Linux PTE bit 4 */
+=09HPMD_XLATE(retval, pmdval, PMD_SECT_TEX(1), 1 << 4);
+
+=09if (pmdval & PMD_SECT_AP_WRITE)
+=09=09retval &=3D ~L_PTE_RDONLY;
+=09else
+=09=09retval |=3D L_PTE_RDONLY;
+
+=09if ((pmdval & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SECT)
+=09=09retval |=3D L_PTE_VALID;
+
+=09/* we assume all hugetlb pages are user */
+=09retval |=3D L_PTE_USER;
+
+=09return __pte(retval);
+}
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+=09=09=09=09   pte_t *ptep, pte_t pte)
+{
+=09pmdval_t pmdval =3D (pmdval_t) pte_val(pte);
+=09pmd_t *pmdp =3D (pmd_t*) ptep;
+
+=09pmdval &=3D HPAGE_MASK;
+=09pmdval |=3D PMD_SECT_AP_READ | PMD_SECT_nG | PMD_TYPE_SECT;
+=09pmdval =3D pmd_val(pmd_modify(__pmd(pmdval), __pgprot(pte_val(pte))));
+
+=09__sync_icache_dcache(pte);
+
+=09set_pmd_at(mm, addr, pmdp, __pmd(pmdval));
+}
--=20
1.7.9.5
