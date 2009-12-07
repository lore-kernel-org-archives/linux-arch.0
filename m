From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/19] do_mremap() untangling, part 2
Date: Mon, 07 Dec 2009 03:52:10 +0000
Message-ID: <E1NHUdu-0007uy-OT@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933422AbZLGDwJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Take the MREMAP_FIXED into a separate helper, simplify the living
hell out of conditions in both cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/mremap.c |  120 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 6776136..5f34617 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -313,6 +313,59 @@ Eagain:
 	return ERR_PTR(-EAGAIN);
 }
 
+static unsigned long mremap_to(unsigned long addr,
+	unsigned long old_len, unsigned long new_addr,
+	unsigned long new_len)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long ret = -EINVAL;
+	unsigned long charged = 0;
+
+	if (new_addr & ~PAGE_MASK)
+		goto out;
+
+	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+		goto out;
+
+	/* Check if the location we're moving into overlaps the
+	 * old location at all, and fail if it does.
+	 */
+	if ((new_addr <= addr) && (new_addr+new_len) > addr)
+		goto out;
+
+	if ((addr <= new_addr) && (addr+old_len) > new_addr)
+		goto out;
+
+	ret = security_file_mmap(NULL, 0, 0, 0, new_addr, 1);
+	if (ret)
+		goto out;
+
+	ret = do_munmap(mm, new_addr, new_len);
+	if (ret)
+		goto out;
+
+	if (old_len >= new_len) {
+		ret = do_munmap(mm, addr+new_len, old_len - new_len);
+		if (ret && old_len != new_len)
+			goto out;
+		old_len = new_len;
+	}
+
+	vma = vma_to_resize(addr, old_len, new_len, &charged);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
+
+	ret = move_vma(vma, addr, old_len, new_len, new_addr);
+	if (ret & ~PAGE_MASK)
+		vm_unacct_memory(charged);
+
+out:
+	return ret;
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -346,32 +399,10 @@ unsigned long do_mremap(unsigned long addr,
 	if (!new_len)
 		goto out;
 
-	/* new_addr is only valid if MREMAP_FIXED is specified */
 	if (flags & MREMAP_FIXED) {
-		if (new_addr & ~PAGE_MASK)
-			goto out;
-		if (!(flags & MREMAP_MAYMOVE))
-			goto out;
-
-		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
-			goto out;
-
-		/* Check if the location we're moving into overlaps the
-		 * old location at all, and fail if it does.
-		 */
-		if ((new_addr <= addr) && (new_addr+new_len) > addr)
-			goto out;
-
-		if ((addr <= new_addr) && (addr+old_len) > new_addr)
-			goto out;
-
-		ret = security_file_mmap(NULL, 0, 0, 0, new_addr, 1);
-		if (ret)
-			goto out;
-
-		ret = do_munmap(mm, new_addr, new_len);
-		if (ret)
-			goto out;
+		if (flags & MREMAP_MAYMOVE)
+			ret = mremap_to(addr, old_len, new_addr, new_len);
+		goto out;
 	}
 
 	/*
@@ -384,13 +415,11 @@ unsigned long do_mremap(unsigned long addr,
 		if (ret && old_len != new_len)
 			goto out;
 		ret = addr;
-		if (!(flags & MREMAP_FIXED) || (new_addr == addr))
-			goto out;
-		old_len = new_len;
+		goto out;
 	}
 
 	/*
-	 * Ok, we need to grow..  or relocate.
+	 * Ok, we need to grow..
 	 */
 	vma = vma_to_resize(addr, old_len, new_len, &charged);
 	if (IS_ERR(vma)) {
@@ -399,11 +428,8 @@ unsigned long do_mremap(unsigned long addr,
 	}
 
 	/* old_len exactly to the end of the area..
-	 * And we're not relocating the area.
 	 */
-	if (old_len == vma->vm_end - addr &&
-	    !((flags & MREMAP_FIXED) && (addr != new_addr)) &&
-	    (old_len != new_len || !(flags & MREMAP_MAYMOVE))) {
+	if (old_len == vma->vm_end - addr) {
 		unsigned long max_addr = TASK_SIZE;
 		if (vma->vm_next)
 			max_addr = vma->vm_next->vm_start;
@@ -432,22 +458,20 @@ unsigned long do_mremap(unsigned long addr,
 	 */
 	ret = -ENOMEM;
 	if (flags & MREMAP_MAYMOVE) {
-		if (!(flags & MREMAP_FIXED)) {
-			unsigned long map_flags = 0;
-			if (vma->vm_flags & VM_MAYSHARE)
-				map_flags |= MAP_SHARED;
-
-			new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-						vma->vm_pgoff, map_flags);
-			if (new_addr & ~PAGE_MASK) {
-				ret = new_addr;
-				goto out;
-			}
-
-			ret = security_file_mmap(NULL, 0, 0, 0, new_addr, 1);
-			if (ret)
-				goto out;
+		unsigned long map_flags = 0;
+		if (vma->vm_flags & VM_MAYSHARE)
+			map_flags |= MAP_SHARED;
+
+		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
+					vma->vm_pgoff, map_flags);
+		if (new_addr & ~PAGE_MASK) {
+			ret = new_addr;
+			goto out;
 		}
+
+		ret = security_file_mmap(NULL, 0, 0, 0, new_addr, 1);
+		if (ret)
+			goto out;
 		ret = move_vma(vma, addr, old_len, new_len, new_addr);
 	}
 out:
-- 
1.5.6.5
