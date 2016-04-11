From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 09/19] parisc: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 13:08:02 +0200
Message-ID: <1460372892-8157-10-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

pmd_alloc_one allocate PMD_ORDER which is 1. This means that this flag
has never been actually useful here because it has always been used only
for PAGE_ALLOC_COSTLY requests.

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/parisc/include/asm/pgalloc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 52c3defb40c9..f08dda3f0995 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -63,8 +63,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
-	pmd_t *pmd = (pmd_t *)__get_free_pages(GFP_KERNEL|__GFP_REPEAT,
-					       PMD_ORDER);
+	pmd_t *pmd = (pmd_t *)__get_free_pages(GFP_KERNEL, PMD_ORDER);
 	if (pmd)
 		memset(pmd, 0, PAGE_SIZE<<PMD_ORDER);
 	return pmd;
-- 
2.8.0.rc3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
