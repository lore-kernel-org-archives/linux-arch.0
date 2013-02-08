From: Steve Capper <steve.capper@arm.com>
Subject: [PATCH 1/6] ARM: mm: correct pte_same behaviour for LPAE.
Date: Fri,  8 Feb 2013 15:01:18 +0000
Message-ID: <1360335683-7755-2-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41782 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758440Ab3BHPBs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 10:01:48 -0500
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: c.dall@virtualopensystems.com, akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

For 3 levels of paging the PTE_EXT_NG bit will be set for user
address ptes that are written to a page table but not for ptes
created with mk_pte.

This can cause some comparison tests made by pte_same to fail
spuriously and lead to other problems.

To correct this behaviour, we mask off PTE_EXT_NG for any pte that
is present before running the comparison.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index a3f3792..2b73b0f 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -148,6 +148,23 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned l=
ong addr)
 =09=09clean_pmd_entry(pmdp);=09\
 =09} while (0)
=20
+/*
+ * For 3 levels of paging the PTE_EXT_NG bit will be set for user address =
ptes
+ * that are written to a page table but not for ptes created with mk_pte.
+ *
+ * In hugetlb_no_page, a new huge pte (new_pte) is generated and passed to
+ * hugetlb_cow, where it is compared with an entry in a page table.
+ * This comparison test fails erroneously leading ultimately to a memory l=
eak.
+ *
+ * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
+ * present before running the comparison.
+ */
+#define __HAVE_ARCH_PTE_SAME
+#define pte_same(pte_a,pte_b)=09((pte_present(pte_a) ? pte_val(pte_a) & ~P=
TE_EXT_NG=09\
+=09=09=09=09=09: pte_val(pte_a))=09=09=09=09\
+=09=09=09=09=3D=3D (pte_present(pte_b) ? pte_val(pte_b) & ~PTE_EXT_NG=09\
+=09=09=09=09=09: pte_val(pte_b)))
+
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,__pte(pte_val(pte)|=
(ext)))
=20
 #endif /* __ASSEMBLY__ */
--=20
1.7.9.5
