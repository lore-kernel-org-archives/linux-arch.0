From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/19] fix pgoff in "have to relocate" case of mremap()
Date: Mon, 07 Dec 2009 03:52:50 +0000
Message-ID: <E1NHUeY-0007vy-PN@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934470AbZLGDwv@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/mremap.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 84efffb..bbbbbf5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -495,7 +495,9 @@ unsigned long do_mremap(unsigned long addr,
 			map_flags |= MAP_SHARED;
 
 		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff, map_flags);
+					vma->vm_pgoff +
+					((addr - vma->vm_start) >> PAGE_SHIFT),
+					map_flags);
 		if (new_addr & ~PAGE_MASK) {
 			ret = new_addr;
 			goto out;
-- 
1.5.6.5
