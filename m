From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC][PATCH 14/18] fix a struct file leak in do_mmap_pgoff()
Date: Sat, 05 Dec 2009 19:08:51 +0000
Message-ID: <E1NGzzv-0008Rp-4T@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41320 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbZLEUQY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 15:16:24 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/mmap.c |   18 ------------------
 mm/util.c |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 73f5e4b..fd49f40 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -949,24 +949,6 @@ unsigned long do_mmap_pgoff(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-	if (flags & MAP_HUGETLB) {
-		struct user_struct *user = NULL;
-		if (file)
-			return -EINVAL;
-
-		/*
-		 * VM_NORESERVE is used because the reservations will be
-		 * taken when vm_ops->mmap() is called
-		 * A dummy user value is used because we are not locking
-		 * memory so no accounting is necessary
-		 */
-		len = ALIGN(len, huge_page_size(&default_hstate));
-		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len, VM_NORESERVE,
-						&user, HUGETLB_ANONHUGE_INODE);
-		if (IS_ERR(file))
-			return PTR_ERR(file);
-	}
-
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
diff --git a/mm/util.c b/mm/util.c
index 3bf81b2..b377ce4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -280,9 +280,24 @@ SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
 	unsigned long retval = -EBADF;
 
 	if (!(flags & MAP_ANONYMOUS)) {
+		if (unlikely(flags & MAP_HUGETLB))
+			return -EINVAL;
 		file = fget(fd);
 		if (!file)
 			goto out;
+	} else if (flags & MAP_HUGETLB) {
+		struct user_struct *user = NULL;
+		/*
+		 * VM_NORESERVE is used because the reservations will be
+		 * taken when vm_ops->mmap() is called
+		 * A dummy user value is used because we are not locking
+		 * memory so no accounting is necessary
+		 */
+		len = ALIGN(len, huge_page_size(&default_hstate));
+		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len, VM_NORESERVE,
+						&user, HUGETLB_ANONHUGE_INODE);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
 	}
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
-- 
1.5.6.5
