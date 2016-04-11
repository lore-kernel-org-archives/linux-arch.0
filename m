From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 14/19] sh: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 13:08:07 +0200
Message-ID: <1460372892-8157-15-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

PGALLOC_GFP uses __GFP_REPEAT but {pgd,pmd}_alloc allocate from
{pgd,pmd}_cache but both caches are allocating up to PAGE_SIZE
objects. This means that this flag has never been actually useful here
because it has always been used only for PAGE_ALLOC_COSTLY requests.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/sh/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/pgtable.c b/arch/sh/mm/pgtable.c
index 26e03a1f7ca4..a62bd8696779 100644
--- a/arch/sh/mm/pgtable.c
+++ b/arch/sh/mm/pgtable.c
@@ -1,7 +1,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
-#define PGALLOC_GFP GFP_KERNEL | __GFP_REPEAT | __GFP_ZERO
+#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
 
 static struct kmem_cache *pgd_cachep;
 #if PAGETABLE_LEVELS > 2
-- 
2.8.0.rc3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
