Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:37590 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfCLTa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Mar 2019 15:30:26 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k/mm: Implement set_pte_at() as an inline function
Date: Tue, 12 Mar 2019 20:30:23 +0100
Message-ID: <20190312193023.30731-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@lists.linux-m68k.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20190312193023.hv36Ofrl57ulZ2RqEZV03-9YTeqiXPJmsVdlwrf3lx4@z>

Since commit 0cbe3e26abe0cfe7 ("mm: update ptep_modify_prot_start/commit
to take vm_area_struct as arg"), using gcc 8.2.0:

    mm/mprotect.c: In function ‘change_pte_range’:
    mm/mprotect.c:42:20: warning: unused variable ‘mm’ [-Wunused-variable]
      struct mm_struct *mm = vma->vm_mm;
			^~

Fix this by converting set_pte_at() from a macro to a static inline
function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The following may want to apply a similar conversion:

    arch/alpha/include/asm/pgtable.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/c6x/include/asm/pgtable.h:#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
    arch/csky/include/asm/pgtable.h:#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
    arch/hexagon/include/asm/pgtable.h:#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
    arch/ia64/include/asm/pgtable.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/nds32/include/asm/pgtable.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/openrisc/include/asm/pgtable.h:#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
    arch/sh/include/asm/pgtable_32.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/sh/include/asm/pgtable_64.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/sparc/include/asm/pgtable_32.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/um/include/asm/pgtable.h:#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
    arch/unicore32/include/asm/pgtable.h:#define set_pte_at(mm, addr, ptep, pteval) \
    arch/unicore32/include/asm/pgtable.h-   do {                                    \
    arch/unicore32/include/asm/pgtable.h-           set_pte(ptep, pteval);          \
    arch/unicore32/include/asm/pgtable.h-   } while (0)
---
 arch/m68k/include/asm/pgtable_mm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index fe3ddd73a0ccb9e4..d931cfd291f667c9 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -26,7 +26,11 @@
 	do{							\
 		*(pteptr) = (pteval);				\
 	} while(0)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	set_pte(ptep, pteval);
+}
 
 
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
-- 
2.17.1
