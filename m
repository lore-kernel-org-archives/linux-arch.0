From: guoren@kernel.org
Subject: [PATCH 4/5] csky: fixup compile error with pte_alloc
Date: Wed,  9 Jan 2019 00:26:37 +0800
Message-ID: <1546964798-30067-4-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@kernel.org, torvalds@linux-foundation.org, linux@roeck-us.net, Guo Ren <ren_guo@c-sky.com>, Joel Fernandes <joel@joelfernandes.org>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Commit: 4cf58924951e remove the address argument of pte_alloc without
modify csky related code. linux-5.0-rc1 compile failed with csky.

Remove the unnecessary address testing in pte_alloc().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/csky/include/asm/pgalloc.h | 43 +++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf4f4a0..d213bb4 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -24,41 +24,34 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern void pgd_init(unsigned long *p);
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-					unsigned long address)
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *pte;
-	unsigned long *kaddr, i;
+	unsigned long i;
 
-	pte = (pte_t *) __get_free_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL,
-					 PTE_ORDER);
-	kaddr = (unsigned long *)pte;
-	if (address & 0x80000000)
-		for (i = 0; i < (PAGE_SIZE/4); i++)
-			*(kaddr + i) = 0x1;
-	else
-		clear_page(kaddr);
+	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	if (!pte)
+		return NULL;
+
+	for (i = 0; i < PAGE_SIZE/sizeof(pte_t); i++)
+		(pte + i)->pte_low = _PAGE_GLOBAL;
 
 	return pte;
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm,
-						unsigned long address)
+static inline struct page *pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
-	unsigned long *kaddr, i;
-
-	pte = alloc_pages(GFP_KERNEL | __GFP_RETRY_MAYFAIL, PTE_ORDER);
-	if (pte) {
-		kaddr = kmap_atomic(pte);
-		if (address & 0x80000000) {
-			for (i = 0; i < (PAGE_SIZE/4); i++)
-				*(kaddr + i) = 0x1;
-		} else
-			clear_page(kaddr);
-		kunmap_atomic(kaddr);
-		pgtable_page_ctor(pte);
+
+	pte = alloc_pages(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!pte)
+		return NULL;
+
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
 	}
+
 	return pte;
 }
 
-- 
2.7.4
