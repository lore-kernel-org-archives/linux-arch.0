From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 2/6] get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sh
Date: Tue,  8 May 2012 18:40:18 +0400
Message-ID: <1336488022-3723-3-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49672 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2EHOnH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so4261600lbb.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:06 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

Move check for TASK_SIZE before MAP_FIXED in sh's
arch_get_unmapped_area() and arch_get_unmapped_area_topdown().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/sh/mm/mmap.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index afeb710..2c61159 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -50,6 +50,9 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long start_addr;
 	int do_colour_align;
 
+	if (unlikely(len > TASK_SIZE))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -60,9 +63,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return addr;
 	}
 
-	if (unlikely(len > TASK_SIZE))
-		return -ENOMEM;
-
 	do_colour_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_colour_align = 1;
@@ -132,6 +132,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_colour_align;
 
+	if (unlikely(len > TASK_SIZE))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -142,9 +145,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		return addr;
 	}
 
-	if (unlikely(len > TASK_SIZE))
-		return -ENOMEM;
-
 	do_colour_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_colour_align = 1;
-- 
1.7.2.5
