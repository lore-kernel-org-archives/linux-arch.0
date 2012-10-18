From: Steve Capper <steve.capper@arm.com>
Subject: [RFC PATCH 1/6] ARM: mm: correct pte_same behaviour for LPAE.
Date: Thu, 18 Oct 2012 17:15:37 +0100
Message-ID: <1350576942-25299-2-git-send-email-steve.capper@arm.com>
References: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52657 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab2JRQQC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2012 12:16:02 -0400
In-Reply-To: <1350576942-25299-1-git-send-email-steve.capper@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org, mhocko@suse.cz, kirill@shutemov.name, aarcange@redhat.com, cmetcalf@tilera.com, hoffman@marvell.com, notasas@gmail.com, bill4carson@gmail.com, will.deacon@arm.com, catalin.marinas@arm.com, maen@marvell.com, shadi@marvell.com, tawfik@marvell.com, Steve Capper <steve.capper@arm.com>

For 3 levels of paging the PTE_EXT_NG bit will be set for user address ptes
that are written to a page table but not for ptes created with mk_pte.

This can cause some comparison tests made by pte_same to fail spuriously an=
d
lead to other problems.

To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
present before running the comparison.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/include/asm/pgtable-2level.h |    5 +++++
 arch/arm/include/asm/pgtable-3level.h |    5 +++++
 arch/arm/include/asm/pgtable.h        |   23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/p=
gtable-2level.h
index 2317a71..662a00e 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -125,6 +125,11 @@
 #define L_PTE_SHARED=09=09(_AT(pteval_t, 1) << 10)=09/* shared(v6), cohere=
nt(xsc3) */
=20
 /*
+ * for 2 levels of paging we don't mask off any bits when comparing presen=
t ptes
+ */
+#define L_PTE_CMP_MASKOFF=090
+
+/*
  * These are the memory types, defined to be compatible with
  * pre-ARMv6 CPUs cacheable and bufferable bits:   XXCB
  */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/p=
gtable-3level.h
index b249035..0eaeb55 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -84,6 +84,11 @@
 #define L_PTE_DIRTY_HIGH=09(1 << (55 - 32))
=20
 /*
+ * we need to mask off PTE_EXT_NG when comparing present ptes.
+ */
+#define L_PTE_CMP_MASKOFF      PTE_EXT_NG
+
+/*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registe=
rs).
  */
 #define L_PTE_MT_UNCACHED=09(_AT(pteval_t, 0) << 2)=09/* strongly ordered =
*/
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.=
h
index 08c1231..c35bf46 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -248,6 +248,29 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t new=
prot)
 }
=20
 /*
+ * For 3 levels of paging the PTE_EXT_NG bit will be set for user address =
ptes
+ * that are written to a page table but not for ptes created with mk_pte.
+ *
+ * This can cause some comparison tests made by pte_same to fail spuriousl=
y and
+ * lead to other problems.
+ *
+ * To correct this behaviour, we mask off PTE_EXT_NG for any pte that is
+ * present before running the comparison.
+ */
+#define __HAVE_ARCH_PTE_SAME
+static inline int pte_same(pte_t pte_a, pte_t pte_b)
+{
+       pteval_t vala =3D pte_val(pte_a), valb =3D pte_val(pte_b);
+       if (pte_present(pte_a))
+               vala &=3D ~L_PTE_CMP_MASKOFF;
+
+       if (pte_present(pte_b))
+               valb &=3D ~L_PTE_CMP_MASKOFF;
+
+       return vala =3D=3D valb;
+}
+
+/*
  * Encode and decode a swap entry.  Swap entries are stored in the Linux
  * page tables as follows:
  *
--=20
1.7.9.5
