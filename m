From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 13/19] s390: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 13:08:06 +0200
Message-ID: <1460372892-8157-14-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

arch_dup_task_struct uses __GFP_REPEAT for fpu_regs_size which is either
sizeof(__vector128) * __NUM_VXRS = 4069B resp.
sizeof(freg_t) * __NUM_FPRS = 1024B AFAICS. page_table_alloc then uses
the flag for a single page allocation. This means that this flag has
never been actually useful here because it has always been used only for
PAGE_ALLOC_COSTLY requests.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/s390/kernel/process.c | 2 +-
 arch/s390/mm/pgalloc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index f8e79824e284..1837a1901d4b 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -102,7 +102,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 */
 	fpu_regs_size = MACHINE_HAS_VX ? sizeof(__vector128) * __NUM_VXRS
 				       : sizeof(freg_t) * __NUM_FPRS;
-	dst->thread.fpu.regs = kzalloc(fpu_regs_size, GFP_KERNEL|__GFP_REPEAT);
+	dst->thread.fpu.regs = kzalloc(fpu_regs_size, GFP_KERNEL);
 	if (!dst->thread.fpu.regs)
 		return -ENOMEM;
 
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index f6c3de26cda8..3f716741797a 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -198,7 +198,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 			return table;
 	}
 	/* Allocate a fresh page */
-	page = alloc_page(GFP_KERNEL|__GFP_REPEAT);
+	page = alloc_page(GFP_KERNEL);
 	if (!page)
 		return NULL;
 	if (!pgtable_page_ctor(page)) {
-- 
2.8.0.rc3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
