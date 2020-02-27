From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v3 07/14] powerpc/32: drop get_pteptr()
Date: Thu, 27 Feb 2020 10:46:01 +0200
Message-ID: <20200227084608.18223-8-rppt@kernel.org>
References: <20200227084608.18223-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgB0ItZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 03:49:25 -0500
In-Reply-To: <20200227084608.18223-1-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>Stefan Kristiansson <s>

From: Christophe Leroy <christophe.leroy@c-s.fr>

Commit 8d30c14cab30 ("powerpc/mm: Rework I$/D$ coherency (v3)") and
commit 90ac19a8b21b ("[POWERPC] Abolish iopa(), mm_ptov(),
io_block_mapping() from arch/powerpc") removed the use of get_pteptr()
outside of mm/pgtable_32.c

In mm/pgtable_32.c, the only user of get_pteptr() is __change_page_attr()
which operates on kernel context and on lowmem pages only.

Move page table traversal to __change_page_attr() and drop get_pteptr().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/powerpc/mm/pgtable_32.c | 43 ++++++------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5fb90edd865e..4894555622d7 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -121,53 +121,24 @@ void __init mapin_ram(void)
 	}
 }
 
-/* Scan the real Linux page tables and return a PTE pointer for
- * a virtual address in a context.
- * Returns true (1) if PTE was found, zero otherwise.  The pointer to
- * the PTE pointer is unmodified if PTE is not found.
- */
-static int
-get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
-{
-        pgd_t	*pgd;
-	pud_t	*pud;
-        pmd_t	*pmd;
-        pte_t	*pte;
-        int     retval = 0;
-
-        pgd = pgd_offset(mm, addr & PAGE_MASK);
-        if (pgd) {
-		pud = pud_offset(pgd, addr & PAGE_MASK);
-		if (pud && pud_present(*pud)) {
-			pmd = pmd_offset(pud, addr & PAGE_MASK);
-			if (pmd_present(*pmd)) {
-				pte = pte_offset_map(pmd, addr & PAGE_MASK);
-				if (pte) {
-					retval = 1;
-					*ptep = pte;
-					if (pmdp)
-						*pmdp = pmd;
-					/* XXX caller needs to do pte_unmap, yuck */
-				}
-			}
-		}
-        }
-        return(retval);
-}
-
 static int __change_page_attr_noflush(struct page *page, pgprot_t prot)
 {
 	pte_t *kpte;
 	pmd_t *kpmd;
-	unsigned long address;
+	unsigned long address, va;
 
 	BUG_ON(PageHighMem(page));
 	address = (unsigned long)page_address(page);
+	va = address & PAGE_MASK;
 
 	if (v_block_mapped(address))
 		return 0;
-	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
+
+	kpmd = pmd_offset(pud_offset(pgd_offset_k(va), va), va);
+	if (!pmd_present(*kpmd))
 		return -EINVAL;
+
+	kpte = pte_offset_map(kpmd, va);
 	__set_pte_at(&init_mm, address, kpte, mk_pte(page, prot), 0);
 	pte_unmap(kpte);
 
-- 
2.24.0
