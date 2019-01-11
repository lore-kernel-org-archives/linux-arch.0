From: guoren@kernel.org
Subject: [PATCH] csky: fixup _PAGE_GLOBAL bit for 610 tlb entry
Date: Sat, 12 Jan 2019 00:09:04 +0800
Message-ID: <1547222944-5808-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, ren_guo@c-sky.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

C-SKY CPU 8xx's _PAGE_GLOBAL is BIT(0), but 610's _PAGE_GLOBAL is
BIT(6). Use _PAGE_GLOBAL macro instead of bad magic number.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index edfcbb2..af7a7fa 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -45,8 +45,8 @@
 	((pte_t *)page_address(pmd_page(*(dir))) + __pte_offset_t(address))
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
-			(((unsigned int)addr&0x80000000)?__pte(1):__pte(0)))
-#define pte_none(pte)	(!(pte_val(pte)&0xfffffffe))
+	(((unsigned int) addr & PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
+#define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_pfn(x)	((unsigned long)((x).pte_low >> PAGE_SHIFT))
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
-- 
2.7.4
