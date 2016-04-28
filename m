From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 04/20] arm: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:50 +0200
Message-ID: <1461849846-27209-5-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

PGALLOC_GFP uses __GFP_REPEAT but none of the allocation which uses
this flag is for more than order-2. This means that this flag has never
been actually useful here because it has always been used only for
PAGE_ALLOC_COSTLY requests.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/arm/include/asm/pgalloc.h | 2 +-
 arch/arm/mm/pgd.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 20febb368844..b2902a5cd780 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -57,7 +57,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
+#define PGALLOC_GFP	(GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
 
 static inline void clean_pte_table(pte_t *pte)
 {
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index b8d477321730..c1c1a5c67da1 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -23,7 +23,7 @@
 #define __pgd_alloc()	kmalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL)
 #define __pgd_free(pgd)	kfree(pgd)
 #else
-#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_REPEAT, 2)
+#define __pgd_alloc()	(pgd_t *)__get_free_pages(GFP_KERNEL, 2)
 #define __pgd_free(pgd)	free_pages((unsigned long)pgd, 2)
 #endif
 
-- 
2.8.0.rc3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
