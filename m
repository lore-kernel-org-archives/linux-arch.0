Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41329 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365AbZLEUQo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 15:16:44 -0500
Date: Sat, 05 Dec 2009 19:08:50 +0000
Subject: [RFC][PATCH 3/18] do_mremap() untangling, part 3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1NGzzu-0008RN-Su@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Message-ID: <20091205190850.ADJGron2LOZk9mdgs9qYdnb6SfRbh9UU7v-B4QX-TSE@z>


Take the check for being able to expand vma in place into a separate
helper.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/mremap.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5f34617..90e422c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -366,6 +366,17 @@ out:
 	return ret;
 }
 
+static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
+{
+	unsigned long max_addr = TASK_SIZE;
+	if (vma->vm_next)
+		max_addr = vma->vm_next->vm_start;
+	if (max_addr - vma->vm_end < delta)
+		return 0;
+	/* we need to do arch-specific checks here */
+	return 1;
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -430,11 +441,8 @@ unsigned long do_mremap(unsigned long addr,
 	/* old_len exactly to the end of the area..
 	 */
 	if (old_len == vma->vm_end - addr) {
-		unsigned long max_addr = TASK_SIZE;
-		if (vma->vm_next)
-			max_addr = vma->vm_next->vm_start;
 		/* can we just expand the current mapping? */
-		if (max_addr - addr >= new_len) {
+		if (vma_expandable(vma, new_len - old_len)) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
 
 			vma_adjust(vma, vma->vm_start,
-- 
1.5.6.5


