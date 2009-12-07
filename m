Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51471 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154AbZLGDwe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Dec 2009 22:52:34 -0500
Date: Mon, 07 Dec 2009 03:52:40 +0000
Subject: [PATCH 5/19] fix the arch checks in MREMAP_FIXED case
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1NHUeO-0007vj-P8@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Message-ID: <20091207035240.Ckx_A45wXsHqVcsTPUPm5f0agwS7qSx7B8Wh9ev3nmk@z>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/mremap.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9d07539..84efffb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -325,6 +325,7 @@ static unsigned long mremap_to(unsigned long addr,
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
 	unsigned long charged = 0;
+	unsigned long map_flags;
 
 	if (new_addr & ~PAGE_MASK)
 		goto out;
@@ -362,9 +363,23 @@ static unsigned long mremap_to(unsigned long addr,
 		goto out;
 	}
 
-	ret = move_vma(vma, addr, old_len, new_len, new_addr);
+	map_flags = MAP_FIXED;
+	if (vma->vm_flags & VM_MAYSHARE)
+		map_flags |= MAP_SHARED;
+	ret = arch_mmap_check(new_addr, new_len, map_flags);
+	if (ret)
+		goto out1;
+	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
+				((addr - vma->vm_start) >> PAGE_SHIFT),
+				map_flags);
 	if (ret & ~PAGE_MASK)
-		vm_unacct_memory(charged);
+		goto out1;
+
+	ret = move_vma(vma, addr, old_len, new_len, new_addr);
+	if (!(ret & ~PAGE_MASK))
+		goto out;
+out1:
+	vm_unacct_memory(charged);
 
 out:
 	return ret;
-- 
1.5.6.5


