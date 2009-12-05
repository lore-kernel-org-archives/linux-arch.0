From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC][PATCH 18/18] Get rid of open-coding in ia64_brk()
Date: Sat, 05 Dec 2009 19:08:51 +0000
Message-ID: <E1NGzzv-0008Rz-6P@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41324 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbZLEUQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 15:16:36 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org


The comment in there used to be true, but these days do_brk() does
the arch-specific check that covers what we open-coded here.  So we
can use sys_brk() just fine, only need to do force_successful_syscall_return()
after it.

See commit 3a459756810912d2c2bf188cef566af255936b4d - that's when the
checks in do_brk() had been originally added.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/kernel/sys_ia64.c |   46 +------------------------------------------
 1 files changed, 1 insertions(+), 45 deletions(-)

diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index ae384a2..609d500 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -100,51 +100,7 @@ sys_getpagesize (void)
 asmlinkage unsigned long
 ia64_brk (unsigned long brk)
 {
-	unsigned long rlim, retval, newbrk, oldbrk;
-	struct mm_struct *mm = current->mm;
-
-	/*
-	 * Most of this replicates the code in sys_brk() except for an additional safety
-	 * check and the clearing of r8.  However, we can't call sys_brk() because we need
-	 * to acquire the mmap_sem before we can do the test...
-	 */
-	down_write(&mm->mmap_sem);
-
-	if (brk < mm->end_code)
-		goto out;
-	newbrk = PAGE_ALIGN(brk);
-	oldbrk = PAGE_ALIGN(mm->brk);
-	if (oldbrk == newbrk)
-		goto set_brk;
-
-	/* Always allow shrinking brk. */
-	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
-			goto set_brk;
-		goto out;
-	}
-
-	/* Check against unimplemented/unmapped addresses: */
-	if ((newbrk - oldbrk) > RGN_MAP_LIMIT || REGION_OFFSET(newbrk) > RGN_MAP_LIMIT)
-		goto out;
-
-	/* Check against rlimit.. */
-	rlim = current->signal->rlim[RLIMIT_DATA].rlim_cur;
-	if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
-		goto out;
-
-	/* Check against existing mmap mappings. */
-	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
-		goto out;
-
-	/* Ok, looks good - let it rip. */
-	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
-		goto out;
-set_brk:
-	mm->brk = brk;
-out:
-	retval = mm->brk;
-	up_write(&mm->mmap_sem);
+	unsigned long retval = sys_brk(brk);
 	force_successful_syscall_return();
 	return retval;
 }
-- 
1.5.6.5
