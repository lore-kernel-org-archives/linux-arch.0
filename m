From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 5/6] ARM: mm: Transparent huge page support for LPAE systems.
Date: Thu, 18 Oct 2012 17:15:41 +0100
Message-ID: <1350576942-25299-6-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54959 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977Ab2JRQQO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:16:14 -0400
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

From: Catalin Marinas <catalin.marinas@arm.com>

The patch adds support for THP (transparent huge pages) to LPAE systems. Wh=
en
this feature is enabled, the kernel tries to map anonymous pages as 2MB
sections where possible.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[steve.capper@arm.com: symbolic constants used, value of PMD_SECT_SPLITTING
adjusted, tlbflush.h included in pgtable.h]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                            |    4 ++
 arch/arm/include/asm/pgtable-2level.h       |    2 +
 arch/arm/include/asm/pgtable-3level-hwdef.h |    2 +
 arch/arm/include/asm/pgtable-3level.h       |   57 +++++++++++++++++++++++=
++++
 arch/arm/include/asm/pgtable.h              |    4 +-
 arch/arm/include/asm/tlb.h                  |    6 +++
 arch/arm/include/asm/tlbflush.h             |    2 +
 arch/arm/mm/fsr-3level.c                    |    2 +-
 8 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dd0a230..9621d5f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1771,6 +1771,10 @@ config SYS_SUPPORTS_HUGETLBFS
        def_bool y
        depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
=20
+config HAVE_ARCH_TRANSPARENT_HUGEPAGE
+       def_bool y
+       depends on ARM_LPAE
+
 source "mm/Kconfig"
=20
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/p=
gtable-2level.h
index fd1d9be..34f4775 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -182,6 +182,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned lo=
ng addr)
 /* we don't need complex calculations here as the pmd is folded into the p=
gd */
 #define pmd_addr_end(addr,end) (end)
=20
+#define pmd_present(pmd)        ((pmd_val(pmd) & PMD_TYPE_MASK) !=3D PMD_T=
YPE_FAULT)
+
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
=20
=20
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include=
/asm/pgtable-3level-hwdef.h
index d795282..53c7f67 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -38,6 +38,8 @@
  */
 #define PMD_SECT_BUFFERABLE=09(_AT(pmdval_t, 1) << 2)
 #define PMD_SECT_CACHEABLE=09(_AT(pmdval_t, 1) << 3)
+#define PMD_SECT_USER=09=09(_AT(pmdval_t, 1) << 6)=09=09/* AP[1] */
+#define PMD_SECT_RDONLY=09=09(_AT(pmdval_t, 1) << 7)=09=09/* AP[2] */
 #define PMD_SECT_S=09=09(_AT(pmdval_t, 3) << 8)
 #define PMD_SECT_AF=09=09(_AT(pmdval_t, 1) << 10)
 #define PMD_SECT_nG=09=09(_AT(pmdval_t, 1) << 11)
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index d086f61..31c071f 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -85,6 +85,9 @@
 #define L_PTE_DIRTY=09=09(_AT(pteval_t, 1) << 55)=09/* unused */
 #define L_PTE_SPECIAL=09=09(_AT(pteval_t, 1) << 56)=09/* unused */
=20
+#define PMD_SECT_DIRTY=09=09(_AT(pmdval_t, 1) << 55)
+#define PMD_SECT_SPLITTING=09(_AT(pmdval_t, 1) << 57)
+
 /*
  * To be used in assembly code with the upper page attributes.
  */
@@ -166,6 +169,60 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned l=
ong addr)
 #define pte_mkhuge(pte)=09=09(__pte((pte_val(pte) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
=20
=20
+#define pmd_present(pmd)=09((pmd_val(pmd) & PMD_TYPE_MASK) !=3D PMD_TYPE_F=
AULT)
+#define pmd_young(pmd)=09=09(pmd_val(pmd) & PMD_SECT_AF)
+
+#define __HAVE_ARCH_PMD_WRITE
+#define pmd_write(pmd)=09=09(!(pmd_val(pmd) & PMD_SECT_RDONLY))
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_trans_huge(pmd)=09((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_T=
YPE_SECT)
+#define pmd_trans_splitting(pmd) (pmd_val(pmd) & PMD_SECT_SPLITTING)
+#endif
+
+#define PMD_BIT_FUNC(fn,op) \
+static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
+
+PMD_BIT_FUNC(wrprotect,=09|=3D PMD_SECT_RDONLY);
+PMD_BIT_FUNC(mkold,=09&=3D ~PMD_SECT_AF);
+PMD_BIT_FUNC(mksplitting, |=3D PMD_SECT_SPLITTING);
+PMD_BIT_FUNC(mkwrite,   &=3D ~PMD_SECT_RDONLY);
+PMD_BIT_FUNC(mkdirty,   |=3D PMD_SECT_DIRTY);
+PMD_BIT_FUNC(mkyoung,   |=3D PMD_SECT_AF);
+PMD_BIT_FUNC(mknotpresent, &=3D ~PMD_TYPE_MASK);
+
+#define pmd_mkhuge(pmd)=09=09(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
+
+#define pmd_pfn(pmd)=09=09((pmd_val(pmd) & PHYS_MASK) >> PAGE_SHIFT)
+#define pfn_pmd(pfn,prot)=09(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pg=
prot_val(prot)))
+#define mk_pmd(page,prot)=09pfn_pmd(page_to_pfn(page),prot)
+
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+=09const pmdval_t mask =3D PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY;
+=09pmd_val(pmd) =3D (pmd_val(pmd) & ~mask) | (pgprot_val(newprot) & mask);
+=09return pmd;
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+=09*pmdp =3D pmd;
+}
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+=09=09=09      pmd_t *pmdp, pmd_t pmd)
+{
+=09BUG_ON(addr >=3D TASK_SIZE);
+=09pmd =3D __pmd(pmd_val(pmd) | PMD_SECT_nG);
+=09set_pmd(pmdp, pmd);
+=09flush_pmd_entry(pmdp);
+}
+
+static inline int has_transparent_hugepage(void)
+{
+=09return 1;
+}
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_3LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.=
h
index c35bf46..767aa7c 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -24,6 +24,9 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
=20
+
+#include <asm/tlbflush.h>
+
 #ifdef CONFIG_ARM_LPAE
 #include <asm/pgtable-3level.h>
 #else
@@ -163,7 +166,6 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 #define pgd_offset_k(addr)=09pgd_offset(&init_mm, addr)
=20
 #define pmd_none(pmd)=09=09(!pmd_val(pmd))
-#define pmd_present(pmd)=09(pmd_val(pmd))
=20
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 685e9e87..0fc2d9d 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -229,6 +229,12 @@ static inline void __pmd_free_tlb(struct mmu_gather *t=
lb, pmd_t *pmdp,
 #endif
 }
=20
+static inline void
+tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned lon=
g addr)
+{
+=09tlb_add_flush(tlb, addr);
+}
+
 #define pte_free_tlb(tlb, ptep, addr)=09__pte_free_tlb(tlb, ptep, addr)
 #define pmd_free_tlb(tlb, pmdp, addr)=09__pmd_free_tlb(tlb, pmdp, addr)
 #define pud_free_tlb(tlb, pudp, addr)=09pud_free((tlb)->mm, pudp)
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflus=
h.h
index 6e924d3..907cede 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -505,6 +505,8 @@ static inline void update_mmu_cache(struct vm_area_stru=
ct *vma,
 }
 #endif
=20
+#define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
+
 #endif
=20
 #endif /* CONFIG_MMU */
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index 05a4e94..47f4c6f 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -9,7 +9,7 @@ static struct fsr_info fsr_info[] =3D {
 =09{ do_page_fault,=09SIGSEGV, SEGV_MAPERR,=09"level 3 translation fault"=
=09},
 =09{ do_bad,=09=09SIGBUS,  0,=09=09"reserved access flag fault"=09},
 =09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 1 access flag fault"=09},
-=09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 2 access flag fault"=09},
+=09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"level 2 access flag fault"=
=09},
 =09{ do_page_fault,=09SIGSEGV, SEGV_ACCERR,=09"level 3 access flag fault"=
=09},
 =09{ do_bad,=09=09SIGBUS,  0,=09=09"reserved permission fault"=09},
 =09{ do_bad,=09=09SIGSEGV, SEGV_ACCERR,=09"level 1 permission fault"=09},
--=20
1.7.9.5
