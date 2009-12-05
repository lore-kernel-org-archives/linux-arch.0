From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC][PATCH 3/18] do_mremap() untangling, part 3
Date: Sat, 05 Dec 2009 19:08:50 +0000
Message-ID: <E1NGzzu-0008RN-Su@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932887AbZLEUTi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


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
