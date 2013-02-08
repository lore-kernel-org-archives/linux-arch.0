From: Steve Capper <steve.capper@arm.com>
Subject: [PATCH 4/6] ARM: mm: HugeTLB support for non-LPAE systems.
Date: Fri,  8 Feb 2013 15:01:21 +0000
Message-ID: <1360335683-7755-5-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46451 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758440Ab3BHPB6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 10:01:58 -0500
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Based on Bill Carson's HugeTLB patch, with the big difference being
in the way PTEs are passed back to the memory manager. Rather than
store a "Linux Huge PTE" separately; we make one up on the fly in
huge_ptep_get. Also rather than consider 16M supersections, we focus
solely on 2x1M sections.

To construct a huge PTE on the fly we need additional information
(such as the accessed flag and dirty bit) which we choose to store
in the domain bits of the short section descriptor. In order to use
these domain bits for storage, we need to make ourselves a client
for all 16 domains and this is done in head.S.

Storing extra information in the domain bits also makes it a lot
easier to implement Transparent Huge Pages, and some of the code in
pgtable-2level.h is arranged to facilitate THP support in a later
patch.

Non-LPAE HugeTLB pages are incompatible with the huge page migration
code (enabled when CONFIG_MEMORY_FAILURE is selected) as that code
dereferences PTEs directly, rather than calling huge_ptep_get and
set_huge_pte_at.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    2 +-
 arch/arm/include/asm/hugetlb-2level.h |  121 +++++++++++++++++++++++++++++=
++++
 arch/arm/include/asm/hugetlb.h        |    4 ++
 arch/arm/include/asm/pgtable-2level.h |  102 +++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h        |    2 +
 arch/arm/include/asm/tlb.h            |   10 ++-
 arch/arm/kernel/head.S                |   10 ++-
 arch/arm/mm/fault.c                   |   11 ---
 arch/arm/mm/fsr-2level.c              |    4 +-
 arch/arm/mm/mmu.c                     |   27 ++++++++
 10 files changed, 276 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9a80544..077f5b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1780,7 +1780,7 @@ config HW_PERF_EVENTS
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
index 0000000..eb0e8b6
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-2level.h
@@ -0,0 +1,121 @@
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
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+=09pmd_t pmd =3D  *((pmd_t *)ptep);
+=09pte_t retval;
+
+=09if (!pmd_val(pmd))
+=09=09return __pte(0);
+
+=09retval =3D __pte((pteval_t) (pmd_val(pmd) & HPAGE_MASK)
+=09=09=09| arm_hugepteprotval);
+
+=09if (pmd_exec(pmd))
+=09=09retval =3D pte_mkexec(retval);
+=09else
+=09=09retval =3D pte_mknexec(retval);
+
+=09if (pmd_young(pmd))
+=09=09retval =3D pte_mkyoung(retval);
+=09else
+=09=09retval =3D pte_mkold(retval);
+
+=09if (pmd_dirty(pmd))
+=09=09retval =3D pte_mkdirty(retval);
+=09else
+=09=09retval =3D pte_mkclean(retval);
+
+=09if (pmd_write(pmd))
+=09=09retval =3D pte_mkwrite(retval);
+=09else
+=09=09retval =3D pte_wrprotect(retval);
+
+=09return retval;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long add=
r,
+=09=09=09=09   pte_t *ptep, pte_t pte)
+{
+=09pmdval_t pmdval =3D (pmdval_t) pte_val(pte);
+=09pmd_t *pmdp =3D (pmd_t *) ptep;
+
+=09/* take the target address bits from the pte only */
+=09pmdval &=3D HPAGE_MASK;
+
+=09/*
+=09 * now use pmd_modify to translate the permission bits from the pte
+=09 * and set the memory type information.
+=09 */
+=09pmdval =3D pmd_val(pmd_modify(__pmd(pmdval), __pgprot(pte_val(pte))));
+
+=09__sync_icache_dcache(pte);
+
+=09set_pmd_at(mm, addr, pmdp, __pmd(pmdval));
+}
+
+static inline pte_t pte_mkhuge(pte_t pte) { return pte; }
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+=09=09=09=09=09 unsigned long addr, pte_t *ptep)
+{
+=09pmd_t *pmdp =3D (pmd_t *)ptep;
+=09pmd_clear(pmdp);
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
+=09if (changed) {
+=09=09set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+=09=09flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
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
index f97ee02..d859613 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -181,6 +181,108 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned =
long addr)
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
+#define PMD_DOMAIN_MASK=09=09(_AT(pmdval_t, 0xF) << 5)
+#define PMD_DSECT_DIRTY=09=09(_AT(pmdval_t, 1) << 5)
+#define PMD_DSECT_AF=09=09(_AT(pmdval_t, 1) << 6)
+
+#define PMD_BIT_FUNC(fn,op) \
+static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
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
+extern pmdval_t arm_hugepmdprotval;
+extern pteval_t arm_hugepteprotval;
+
+#define pmd_mkhuge(pmd)=09=09(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
+
+PMD_BIT_FUNC(mkold, &=3D ~PMD_DSECT_AF);
+PMD_BIT_FUNC(mkdirty, |=3D PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkclean, &=3D ~PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkyoung, |=3D PMD_DSECT_AF);
+PMD_BIT_FUNC(mkwrite, |=3D PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(wrprotect,=09&=3D ~PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(mknotpresent, &=3D ~PMD_TYPE_MASK);
+PMD_BIT_FUNC(mkexec,=09&=3D ~PMD_SECT_XN);
+PMD_BIT_FUNC(mknexec,=09|=3D PMD_SECT_XN);
+
+#define pmd_young(pmd)=09=09=09(pmd_val(pmd) & PMD_DSECT_AF)
+#define pmd_write(pmd)=09=09=09(pmd_val(pmd) & PMD_SECT_AP_WRITE)
+#define pmd_exec(pmd)=09=09=09(!(pmd_val(pmd) & PMD_SECT_XN))
+#define pmd_dirty(pmd)=09=09=09(pmd_val(pmd) & PMD_DSECT_DIRTY)
+
+#define __HAVE_ARCH_PMD_WRITE
+
+#define pmd_modify(pmd, prot)=09=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09=09\
+=09pmd_t pmdret =3D __pmd((pmd_val(pmd) & (PMD_MASK | PMD_DOMAIN_MASK)) =
=09\
+=09=09| arm_hugepmdprotval);=09=09=09=09=09=09\
+=09pgprot_t inprot =3D prot;=09=09=09=09=09=09=09\
+=09pte_t newprot =3D __pte(pgprot_val(inprot));=09=09=09=09\
+=09=09=09=09=09=09=09=09=09=09\
+=09if (pte_dirty(newprot))=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkdirty(pmdret);=09=09=09=09=09\
+=09else=09=09=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkclean(pmdret);=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09=09\
+=09if (pte_exec(newprot))=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkexec(pmdret);=09=09=09=09=09\
+=09else=09=09=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mknexec(pmdret);=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09=09\
+=09if (pte_write(newprot))=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkwrite(pmdret);=09=09=09=09=09\
+=09else=09=09=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_wrprotect(pmdret);=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09=09\
+=09if (pte_young(newprot))=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkyoung(pmdret);=09=09=09=09=09\
+=09else=09=09=09=09=09=09=09=09=09\
+=09=09pmdret =3D pmd_mkold(pmdret);=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09=09\
+=09pmdret;=09=09=09=09=09=09=09=09=09\
+})
+
+#else
+#define HPAGE_SIZE 0
+#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.=
h
index 9c82f98..4e7efc6 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -235,6 +235,8 @@ PTE_BIT_FUNC(mkclean,   &=3D ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |=3D L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &=3D ~L_PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |=3D L_PTE_YOUNG);
+PTE_BIT_FUNC(mkexec,=09&=3D ~L_PTE_XN);
+PTE_BIT_FUNC(mknexec,=09|=3D L_PTE_XN);
=20
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
=20
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
index 486a15a..1378221 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -413,13 +413,21 @@ __enable_mmu:
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
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5dbf13f..95d53f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -488,17 +488,6 @@ do_translation_fault(unsigned long addr, unsigned int =
fsr,
 #endif=09=09=09=09=09/* CONFIG_MMU */
=20
 /*
- * Some section permission faults need to be handled gracefully.
- * They can happen due to a __{get,put}_user during an oops.
- */
-static int
-do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-{
-=09do_bad_area(addr, fsr, regs);
-=09return 0;
-}
-
-/*
  * This abort handler always returns "fault".
  */
 static int
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c..c1a2afc 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -16,7 +16,7 @@ static struct fsr_info fsr_info[] =3D {
 =09{ do_bad,=09=09SIGBUS,=09 0,=09=09"external abort on non-linefetch"  },
 =09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"page domain fault"=09=09   },
 =09{ do_bad,=09=09SIGBUS,=09 0,=09=09"external abort on translation"=09   =
},
-=09{ do_sect_fault,=09SIGSEGV, SEGV_ACCERR,=09"section permission fault"=
=09   },
+=09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"section permission fault"=
=09   },
 =09{ do_bad,=09=09SIGBUS,=09 0,=09=09"external abort on translation"=09   =
},
 =09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"page permission fault"=09=
=09   },
 =09/*
@@ -56,7 +56,7 @@ static struct fsr_info ifsr_info[] =3D {
 =09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 10"=09=09=09   },
 =09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"page domain fault"=09=09   },
 =09{ do_bad,=09=09SIGBUS,=09 0,=09=09"external abort on translation"=09   =
},
-=09{ do_sect_fault,=09SIGSEGV, SEGV_ACCERR,=09"section permission fault"=
=09   },
+=09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"section permission fault"=
=09   },
 =09{ do_bad,=09=09SIGBUS,=09 0,=09=09"external abort on translation"=09   =
},
 =09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"page permission fault"=09=
=09   },
 =09{ do_bad,=09=09SIGBUS,  0,=09=09"unknown 16"=09=09=09   },
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce328c7..74f1917 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -303,6 +303,21 @@ const struct mem_type *get_mem_type(unsigned int type)
 EXPORT_SYMBOL(get_mem_type);
=20
 /*
+ * If the system supports huge pages and we are running with short descrip=
tors,
+ * then compute the pmd and linux pte prot values for a huge page.
+ *
+ * These values are used by both the HugeTLB and THP code.
+ */
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+pmdval_t arm_hugepmdprotval;
+EXPORT_SYMBOL(arm_hugepmdprotval);
+
+pteval_t arm_hugepteprotval;
+EXPORT_SYMBOL(arm_hugepteprotval);
+#endif
+
+
+/*
  * Adjust the PMD section entries according to the CPU in use.
  */
 static void __init build_mem_type_table(void)
@@ -526,6 +541,18 @@ static void __init build_mem_type_table(void)
 =09=09if (t->prot_sect)
 =09=09=09t->prot_sect |=3D PMD_DOMAIN(t->domain);
 =09}
+
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+=09/*
+=09 * we assume all huge pages are user pages and that hardware access
+=09 * flag updates are disabled (i.e. SCTLR.AFE =3D=3D 0b).
+=09 */
+=09arm_hugepteprotval =3D mem_types[MT_MEMORY].prot_pte | L_PTE_USER | L_P=
TE_VALID;
+
+=09arm_hugepmdprotval =3D mem_types[MT_MEMORY].prot_sect | PMD_SECT_AP_REA=
D
+=09=09=09=09| PMD_SECT_nG;
+#endif
+
 }
=20
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
--=20
1.7.9.5
