Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linux-m32r.org ([211.14.7.36]:55259 "EHLO hikaru.fsij.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159AbXLHHfd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 8 Dec 2007 02:35:33 -0500
Received: from gniibe by hikaru.fsij.org with local (Exim 4.63)
	(envelope-from <gniibe@hikaru.fsij.org>)
	id 1J0uDk-0006U3-EW
	for linux-arch@vger.kernel.org; Sat, 08 Dec 2007 16:35:32 +0900
From: NIIBE Yutaka <gniibe@fsij.org>
Subject: change_protection should be called with old vma->vm_flags
In-Reply-To: <E1J0tqr-00067s-Lx@hikaru.fsij.org>
References: <E1J0tqr-00067s-Lx@hikaru.fsij.org>
Message-Id: <E1J0uDk-0006U3-EW@hikaru.fsij.org>
Date: Sat, 08 Dec 2007 16:35:32 +0900
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

For CPU with I/D separate cache, flush_cache_range/flush_tlb_range
checks vma->vm_flags if it is instruction related or not.

I think that change_protection should be called with old vma->vm_flags
so that it can flush instruction cache/TLB correctly.

Here is a patch.

Signed-off-by: NIIBE Yutaka <gniibe@fsij.org>

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4de5468..661c818 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -191,7 +191,6 @@ success:
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
 	 * held in write mode.
 	 */
-	vma->vm_flags = newflags;
 	vma->vm_page_prot = vm_get_page_prot(newflags);
 	if (vma_wants_writenotify(vma)) {
 		vma->vm_page_prot = vm_get_page_prot(newflags & ~VM_SHARED);
@@ -202,6 +201,7 @@ success:
 		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
 		change_protection(vma, start, end, vma->vm_page_prot, dirty_accountable);
+	vma->vm_flags = newflags;
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
 	return 0;

