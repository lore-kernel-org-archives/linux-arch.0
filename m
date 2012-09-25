From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] mm: Limit pgd range freeing to mm->task_size
Date: Tue, 25 Sep 2012 15:52:55 +0100
Message-ID: <1348584775-326-1-git-send-email-catalin.marinas@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40368 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753351Ab2IYOxp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Sep 2012 10:53:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Russell King <linux@arm.linux.org.uk>

ARM processors with LPAE enabled use 3 levels of page tables, with an
entry in the top level (pgd) covering 1GB of virtual space. Because of
the branch relocation limitations on ARM, the loadable modules are
mapped 16MB below PAGE_OFFSET, making the corresponding 1GB pgd shared
between kernel modules and user space.

Since free_pgtables() is called with ceiling == 0, free_pgd_range() (and
subsequently called functions) also frees the page table
shared between user space and kernel modules (which is normally handled
by the ARM-specific pgd_free() function).

This patch changes the ceiling argument to mm->task_size for the
free_pgtables() and free_pgd_range() function calls. We cannot use
TASK_SIZE since this macro may not be a run-time constant on 64-bit
systems supporting compat applications.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>
---

Posting on linux-arch as I would like to know whether there are any
implications with a non-zero ceiling argument on other architectures.

 fs/exec.c |    4 ++--
 mm/mmap.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 574cf4d..3d2fcc9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -623,7 +623,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : 0);
+			vma->vm_next ? vma->vm_next->vm_start : mm->task_size);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -632,7 +632,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : 0);
+			vma->vm_next ? vma->vm_next->vm_start : mm->task_size);
 	}
 	tlb_finish_mmu(&tlb, new_end, old_end);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index ae18a48..4e198b0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1912,7 +1912,7 @@ static void unmap_region(struct mm_struct *mm,
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, vma, start, end);
 	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : 0);
+				 next ? next->vm_start : mm->task_size);
 	tlb_finish_mmu(&tlb, start, end);
 }
 
@@ -2294,7 +2294,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, vma, 0, -1);
 
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
+	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, mm->task_size);
 	tlb_finish_mmu(&tlb, 0, -1);
 
 	/*
