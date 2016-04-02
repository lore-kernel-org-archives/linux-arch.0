Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34414 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbcDBTS1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Apr 2016 15:18:27 -0400
From: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Subject: [PATCH 2/3] mm/mremap.c: don't unmap the overlapping VMA(s)
Date: Sat,  2 Apr 2016 21:17:33 +0200
Message-ID: <1459624654-7955-3-git-send-email-kwapulinski.piotr@gmail.com>
In-Reply-To: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
References: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com, mtk.manpages@gmail.com, cmetcalf@mellanox.com, arnd@arndb.de, viro@zeniv.linux.org.uk, mszeredi@suse.cz, dave@stgolabs.net, kirill.shutemov@linux.intel.com, vbabka@suse.cz, mingo@kernel.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, koct9i@gmail.com, hannes@cmpxchg.org, jack@suse.cz, xiexiuqi@huawei.com, iamjoonsoo.kim@lge.com, oleg@redhat.com, gang.chen.5i5j@gmail.com, aarcange@redhat.com, aryabinin@virtuozzo.com, rientjes@google.com, denc716@gmail.com, toshi.kani@hpe.com, ldufour@linux.vnet.ibm.com, kuleshovmail@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Message-ID: <20160402191733.gIeV7zb9FZ-tmV-rtTzXs6aFLIksHRhPiwHPwQPsuWk@z>

Currently the
mremap(new_size, MREMAP_MAYMOVE | MREMAP_FIXED, new_address)
discards the part of existing VMA(s) if it overlaps the memory region
specified by new_address and new_size.
Introduce the new MREMAP_DONTUNMAP flag which forces the mremap to
fail with ENOMEM whenever the overlapping occurs. No existing
mapping(s) is discarded.
The implementation tests the MAP_DONTUNMAP flag and scans the AS for
the overlapping VMA(s) right before unmapping the area.

I did the isolated tests and also tested it with Gentoo full
installation.

Signed-off-by: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
---
 include/uapi/linux/mman.h |  5 +++--
 mm/mremap.c               | 23 +++++++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index ade4acd..bc6478e 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -3,8 +3,9 @@
 
 #include <asm/mman.h>
 
-#define MREMAP_MAYMOVE	1
-#define MREMAP_FIXED	2
+#define MREMAP_MAYMOVE		1
+#define MREMAP_FIXED		2
+#define MREMAP_DONTUNMAP	4
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/mremap.c b/mm/mremap.c
index 3fa0a467..f57d396 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -397,7 +397,8 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 }
 
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
-		unsigned long new_addr, unsigned long new_len, bool *locked)
+		unsigned long new_addr, unsigned long new_len,
+		unsigned long flags, bool *locked)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -415,9 +416,16 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		goto out;
 
-	ret = do_munmap(mm, new_addr, new_len);
-	if (ret)
-		goto out;
+	if (flags & MREMAP_DONTUNMAP) {
+		if (find_vma_intersection(mm, new_addr, new_len)) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		ret = do_munmap(mm, new_addr, new_len);
+		if (ret)
+			goto out;
+	}
 
 	if (old_len >= new_len) {
 		ret = do_munmap(mm, addr+new_len, old_len - new_len);
@@ -482,12 +490,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	unsigned long charged = 0;
 	bool locked = false;
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return ret;
 
 	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
 		return ret;
 
+	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_FIXED))
+		return ret;
+
 	if (offset_in_page(addr))
 		return ret;
 
@@ -505,7 +516,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	down_write(&current->mm->mmap_sem);
 
 	if (flags & MREMAP_FIXED) {
-		ret = mremap_to(addr, old_len, new_addr, new_len,
+		ret = mremap_to(addr, old_len, new_addr, new_len, flags,
 				&locked);
 		goto out;
 	}
-- 
2.7.4

