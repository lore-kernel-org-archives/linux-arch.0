From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 4/6] get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sparc64
Date: Tue,  8 May 2012 18:40:20 +0400
Message-ID: <1336488022-3723-5-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50693 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755077Ab2EHOnY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:24 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so1119877lah.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:23 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

Move check for TASK_SIZE before MAP_FIXED in sparc64's
arch_get_unmapped_area() and arch_get_unmapped_area_topdown().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/sparc/kernel/sys_sparc_64.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 232df99..df1a121 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -120,6 +120,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	unsigned long start_addr;
 	int do_color_align;
 
+	if (test_thread_flag(TIF_32BIT))
+		task_size = STACK_TOP32;
+	if (unlikely(len > task_size || len >= VA_EXCLUDE_START))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -130,11 +135,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 		return addr;
 	}
 
-	if (test_thread_flag(TIF_32BIT))
-		task_size = STACK_TOP32;
-	if (unlikely(len > task_size || len >= VA_EXCLUDE_START))
-		return -ENOMEM;
-
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
@@ -211,6 +211,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
 
+	if (unlikely(len > task_size))
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -221,9 +224,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		return addr;
 	}
 
-	if (unlikely(len > task_size))
-		return -ENOMEM;
-
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
-- 
1.7.2.5
