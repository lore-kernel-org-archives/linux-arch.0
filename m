From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 5/6] get_unmapped_area checks for TASK_SIZE before MAP_FIXED on x86_64
Date: Tue,  8 May 2012 18:40:21 +0400
Message-ID: <1336488022-3723-6-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50693 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755591Ab2EHOnc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:32 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so1119877lah.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:31 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

Move check for TASK_SIZE before MAP_FIXED in x86_64's arch_get_unmapped_area().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/x86/kernel/sys_x86_64.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 0514890..1988a9f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -129,14 +129,14 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long start_addr;
 	unsigned long begin, end;
 
-	if (flags & MAP_FIXED)
-		return addr;
-
 	find_start_end(flags, &begin, &end);
 
 	if (len > end)
 		return -ENOMEM;
 
+	if (flags & MAP_FIXED)
+		return addr;
+
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-- 
1.7.2.5
