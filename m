From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 12/20] sparc: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:58 +0200
Message-ID: <1461849846-27209-13-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

{pud,pmd}_alloc_one is using __GFP_REPEAT but it always allocates from
pgtable_cache which is initialzed to PAGE_SIZE objects. This means that
this flag has never been actually useful here because it has always been
used only for PAGE_ALLOC_COSTLY requests.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/sparc/include/asm/pgalloc_64.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
index 5e3187185b4a..3529f1378cd8 100644
--- a/arch/sparc/include/asm/pgalloc_64.h
+++ b/arch/sparc/include/asm/pgalloc_64.h
@@ -41,8 +41,7 @@ static inline void __pud_populate(pud_t *pud, pmd_t *pmd)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(pgtable_cache,
-				GFP_KERNEL|__GFP_REPEAT);
+	return kmem_cache_alloc(pgtable_cache, GFP_KERNEL);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
@@ -52,8 +51,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(pgtable_cache,
-				GFP_KERNEL|__GFP_REPEAT);
+	return kmem_cache_alloc(pgtable_cache, GFP_KERNEL);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
-- 
2.8.0.rc3
