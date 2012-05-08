From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 6/6] get_unmapped_area remove extra check for TASK_SIZE
Date: Tue,  8 May 2012 18:40:22 +0400
Message-ID: <1336488022-3723-7-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50693 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755673Ab2EHOnm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:42 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so1119877lah.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:42 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

architecture specific and generic arch_get_unmapped_area() and
arch_get_unmapped_area_topdown() check for TASK_SIZE before
MAP_FIXED.

It is safe to remove check for TASK_SIZE in get_unmapped_area().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 mm/mmap.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index eae90af..6e6f934 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1544,10 +1544,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (error)
 		return error;
 
-	/* Careful about overflows.. */
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
 	get_area = current->mm->get_unmapped_area;
 	if (file && file->f_op && file->f_op->get_unmapped_area)
 		get_area = file->f_op->get_unmapped_area;
-- 
1.7.2.5
