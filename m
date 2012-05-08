From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 3/6] get_unmapped_area checks for TASK_SIZE before MAP_FIXED on sparc32
Date: Tue,  8 May 2012 18:40:19 +0400
Message-ID: <1336488022-3723-4-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50693 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755077Ab2EHOnQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:16 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so1119877lah.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:15 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

Move check for TASK_SIZE before MAP_FIXED in sparc32's arch_get_unmapped_area().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/sparc/kernel/sys_sparc_32.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 42b282f..7bf30de 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -40,6 +40,11 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 {
 	struct vm_area_struct * vmm;
 
+	if (len > TASK_SIZE - PAGE_SIZE)
+		return -ENOMEM;
+	if (ARCH_SUN4C && len > 0x20000000)
+		return -ENOMEM;
+
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
@@ -51,10 +56,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	}
 
 	/* See asm-sparc/uaccess.h */
-	if (len > TASK_SIZE - PAGE_SIZE)
-		return -ENOMEM;
-	if (ARCH_SUN4C && len > 0x20000000)
-		return -ENOMEM;
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
-- 
1.7.2.5
