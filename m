From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 6/6] ARM: mm: Transparent huge page support for non-LPAE systems.
Date: Thu, 18 Oct 2012 17:15:42 +0100
Message-ID: <1350576942-25299-7-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57979 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756977Ab2JRQQR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:16:17 -0400
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Much of the required code for THP has been implemented in the earlier non-L=
PAE
HugeTLB patch.

One more domain bits is used (to store whether or not the THP is splitting)=
.

Some THP helper functions are defined; and we have to re-define pmd_page su=
ch
that it distinguishes between page tables and sections.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    2 +-
 arch/arm/include/asm/pgtable-2level.h |   68 +++++++++++++++++++++++++++++=
+++-
 arch/arm/include/asm/pgtable-3level.h |    2 +
 arch/arm/include/asm/pgtable.h        |    7 +++-
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9621d5f..d459673 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1773,7 +1773,7 @@ config SYS_SUPPORTS_HUGETLBFS
=20
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
        def_bool y
-       depends on ARM_LPAE
+       depends on SYS_SUPPORTS_HUGETLBFS
=20
 source "mm/Kconfig"
=20
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/p=
gtable-2level.h
index 34f4775..67eabb4 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -179,6 +179,13 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned l=
ong addr)
 =09=09clean_pmd_entry(pmdp);=09\
 =09} while (0)
=20
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define _PMD_HUGE(pmd) ((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SEC=
T)
+#else
+#define _PMD_HUGE(pmd) (0)
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /* we don't need complex calculations here as the pmd is folded into the p=
gd */
 #define pmd_addr_end(addr,end) (end)
=20
@@ -197,7 +204,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned lo=
ng addr)
=20
 #define HPAGE_SHIFT             PMD_SHIFT
 #define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
-#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
=20
 #define HUGE_LINUX_PTE_COUNT       (PAGE_OFFSET >> HPAGE_SHIFT)
@@ -209,6 +215,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned lo=
ng addr)
  */
 #define PMD_DSECT_DIRTY=09=09(_AT(pmdval_t, 1) << 5)
 #define PMD_DSECT_AF=09=09(_AT(pmdval_t, 1) << 6)
+#define PMD_DSECT_SPLITTING=09(_AT(pmdval_t, 1) << 7)
=20
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
@@ -261,8 +268,67 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t new=
prot)
 =09return __pmd(pmdval);
 }
=20
+#else
+#define=09HPAGE_SIZE=090
 #endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
=20
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_mkhuge(pmd)=09=09(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
+
+PMD_BIT_FUNC(mkold, &=3D ~PMD_DSECT_AF);
+PMD_BIT_FUNC(mksplitting, |=3D PMD_DSECT_SPLITTING);
+PMD_BIT_FUNC(mkdirty, |=3D PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkyoung, |=3D PMD_DSECT_AF);
+PMD_BIT_FUNC(mkwrite, |=3D PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(mknotpresent, &=3D ~PMD_TYPE_MASK);
+
+#define pmd_trans_splitting(pmd)=09(pmd_val(pmd) & PMD_DSECT_SPLITTING)
+#define pmd_young(pmd)=09=09=09(pmd_val(pmd) & PMD_DSECT_AF)
+#define pmd_write(pmd)=09=09=09(pmd_val(pmd) & PMD_SECT_AP_WRITE)
+#define pmd_trans_huge(pmd)=09=09((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PM=
D_TYPE_SECT)
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+=09/*
+=09 * for a section, we need to mask off more of the pmd
+=09 * before looking up the pfn
+=09 */
+=09if ((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SECT)
+=09=09return __phys_to_pfn(pmd_val(pmd) & HPAGE_MASK);
+=09else
+=09=09return __phys_to_pfn(pmd_val(pmd) & PHYS_MASK);
+}
+
+static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
+{
+=09pmd_t pmd =3D __pmd(__pfn_to_phys(pfn) | PMD_SECT_AP_READ | PMD_SECT_nG=
);
+
+=09return pmd_modify(pmd, prot);
+}
+
+#define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),prot);
+
+static inline int has_transparent_hugepage(void)
+{
+=09return 1;
+}
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+=09/*
+=09 * for a section, we need to mask off more of the pmd
+=09 * before looking up the page as it is a section descriptor.
+=09 */
+=09if (_PMD_HUGE(pmd))
+=09=09return phys_to_page(pmd_val(pmd) & HPAGE_MASK);
+
+=09return phys_to_page(pmd_val(pmd) & PHYS_MASK);
+}
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index 31c071f..8360814 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -197,6 +197,8 @@ PMD_BIT_FUNC(mknotpresent, &=3D ~PMD_TYPE_MASK);
 #define pfn_pmd(pfn,prot)=09(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pg=
prot_val(prot)))
 #define mk_pmd(page,prot)=09pfn_pmd(page_to_pfn(page),prot)
=20
+#define pmd_page(pmd)           pfn_to_page(__phys_to_pfn(pmd_val(pmd) & P=
HYS_MASK))
+
 static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 {
 =09const pmdval_t mask =3D PMD_SECT_USER | PMD_SECT_XN | PMD_SECT_RDONLY;
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.=
h
index 767aa7c..2d96381 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -169,11 +169,14 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
=20
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
+#ifdef SYS_SUPPORTS_HUGETLBFS
+=09if ((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SECT)
+=09=09return __va(pmd_val(pmd) & HPAGE_MASK);
+#endif
+
 =09return __va(pmd_val(pmd) & PHYS_MASK & (s32)PAGE_MASK);
 }
=20
-#define pmd_page(pmd)=09=09pfn_to_page(__phys_to_pfn(pmd_val(pmd) & PHYS_M=
ASK))
-
 #ifndef CONFIG_HIGHPTE
 #define __pte_map(pmd)=09=09pmd_page_vaddr(*(pmd))
 #define __pte_unmap(pte)=09do { } while (0)
--=20
1.7.9.5
