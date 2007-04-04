Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49664 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992592AbXDDECb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Apr 2007 00:02:31 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Apr 2007 14:02:20 +1000
Subject: [PATCH 10/14] get_unmapped_area handles MAP_FIXED in hugetlbfs
In-Reply-To: <1175659331.690672.592289266160.qpush@grosgo>
Message-Id: <20070404040231.1F9B5DDEB6@ozlabs.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 fs/hugetlbfs/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-cell/fs/hugetlbfs/inode.c
===================================================================
--- linux-cell.orig/fs/hugetlbfs/inode.c	2007-03-22 16:12:56.000000000 +1100
+++ linux-cell/fs/hugetlbfs/inode.c	2007-03-22 16:16:02.000000000 +1100
@@ -115,6 +115,12 @@ hugetlb_get_unmapped_area(struct file *f
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
+	if (flags & MAP_FIXED) {
+		if (prepare_hugepage_range(addr, len, pgoff))
+			return -EINVAL;
+		return addr;
+	}
+
 	if (addr) {
 		addr = ALIGN(addr, HPAGE_SIZE);
 		vma = find_vma(mm, addr);
