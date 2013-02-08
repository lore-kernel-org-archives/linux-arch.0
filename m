From: Steve Capper <steve.capper@arm.com>
Subject: [PATCH 6/6] ARM: mm: Transparent huge page support for non-LPAE systems.
Date: Fri,  8 Feb 2013 15:01:23 +0000
Message-ID: <1360335683-7755-7-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48052 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760065Ab3BHPCD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 10:02:03 -0500
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

Much of the required code for THP has been implemented in the
earlier non-LPAE HugeTLB patch.

One more domain bit is used (to store whether or not the THP is
splitting).

Some THP helper functions are defined; and we have to re-define
pmd_page such that it distinguishes between page tables and
sections.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    2 +-
 arch/arm/include/asm/pgtable-2level.h |   47 +++++++++++++++++++++++++++++=
++++
 arch/arm/include/asm/pgtable-3level.h |    2 ++
 arch/arm/include/asm/pgtable.h        |    7 +++--
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7bee9b9..32e6aba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1784,7 +1784,7 @@ config SYS_SUPPORTS_HUGETLBFS
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
index 7423ecf..e3b5ec2 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -207,6 +207,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned lo=
ng addr)
 #define PMD_DOMAIN_MASK=09=09(_AT(pmdval_t, 0xF) << 5)
 #define PMD_DSECT_DIRTY=09=09(_AT(pmdval_t, 1) << 5)
 #define PMD_DSECT_AF=09=09(_AT(pmdval_t, 1) << 6)
+#define PMD_DSECT_SPLITTING=09(_AT(pmdval_t, 1) << 7)
=20
 #define PMD_BIT_FUNC(fn,op) \
 static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
@@ -285,6 +286,52 @@ PMD_BIT_FUNC(mknexec,=09|=3D PMD_SECT_XN);
 #define HPAGE_SIZE 0
 #endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
=20
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pmd_mkhuge(pmd)=09=09(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_=
TYPE_SECT))
+
+PMD_BIT_FUNC(mksplitting, |=3D PMD_DSECT_SPLITTING);
+#define pmd_trans_splitting(pmd)=09(pmd_val(pmd) & PMD_DSECT_SPLITTING)
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
+#define pfn_pmd(pfn,prot) pmd_modify(__pmd(__pfn_to_phys(pfn)),prot);
+#define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),prot);
+
+static inline int has_transparent_hugepage(void)
+{
+=09return 1;
+}
+
+#define _PMD_HUGE(pmd) ((pmd_val(pmd) & PMD_TYPE_MASK) =3D=3D PMD_TYPE_SEC=
T)
+#define _PMD_HPAGE(pmd) (phys_to_page(pmd_val(pmd) & HPAGE_MASK))
+#else
+#define _PMD_HUGE(pmd) (0)
+#define _PMD_HPAGE(pmd) (0)
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static inline struct page *pmd_page(pmd_t pmd)
+{
+=09/*
+=09 * for a section, we need to mask off more of the pmd
+=09 * before looking up the page as it is a section descriptor.
+=09 */
+=09if (_PMD_HUGE(pmd))
+=09=09return _PMD_HPAGE(pmd);
+
+=09return phys_to_page(pmd_val(pmd) & PHYS_MASK);
+}
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index 1b0351d..cc16398 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -211,6 +211,8 @@ PMD_BIT_FUNC(mknotpresent, &=3D ~PMD_TYPE_MASK);
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
index bb27451..850270c5 100644
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
