From: guoren@kernel.org
Subject: [PATCH] csky: Fixup wrong update_mmu_cache implementation
Date: Wed, 10 Apr 2019 14:18:19 +0800
Message-ID: <1554877099-30927-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

In our stress test, we found some crash problem caused by:

if (!(vma->vm_flags & VM_EXEC))
	return;

in update_mmu_cache().

Seems current update_mmu_cache implementation is wrong and we retread
to the conservative implementation.

Also the usage of kmap_atomic in update_mmu_cache is risky, page-virtual
may be scheduled out and changed, so we must use preempt_disable &
pagefault_disable which is called by kmap_atomic().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv2/cacheflush.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index d22c95f..5bb887b 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -34,10 +34,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long addr, pfn;
 	struct page *page;
-	void *va;
-
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
 
 	pfn = pte_pfn(*pte);
 	if (unlikely(!pfn_valid(pfn)))
@@ -47,14 +43,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	if (page == ZERO_PAGE(0))
 		return;
 
-	va = page_address(page);
-	addr = (unsigned long) va;
-
-	if (va == NULL && PageHighMem(page))
-		addr = (unsigned long) kmap_atomic(page);
+	addr = (unsigned long) kmap_atomic(page);
 
 	cache_wbinv_range(addr, addr + PAGE_SIZE);
 
-	if (va == NULL && PageHighMem(page))
-		kunmap_atomic((void *) addr);
+	kunmap_atomic((void *) addr);
 }
-- 
2.7.4
