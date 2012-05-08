From: Vladimir Murzin <murzin.v@gmail.com>
Subject: [PATCH 1/6] get_unmapped_area checks for TASK_SIZE before MAP_FIXED on arm
Date: Tue,  8 May 2012 18:40:17 +0400
Message-ID: <1336488022-3723-2-git-send-email-murzin.v@gmail.com>
References: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50693 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755077Ab2EHOnB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2012 10:43:01 -0400
Received: by lahd3 with SMTP id d3so1119877lah.19
        for <linux-arch@vger.kernel.org>; Tue, 08 May 2012 07:43:00 -0700 (PDT)
In-Reply-To: <1336488022-3723-1-git-send-email-murzin.v@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, davem@davemloft.net, lethal@linux-sh.org, linux@arm.linux.org.uk, Vladimir Murzin <murzin.v@gmail.com>

Move check for TASK_SIZE before MAP_FIXED in arm's arch_get_unmapped_area().

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/arm/mm/mmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index ce8cb19..288cc5f 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -80,6 +80,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (aliasing)
 		do_align = filp || (flags & MAP_SHARED);
 
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
 	/*
 	 * We enforce the MAP_FIXED case.
 	 */
@@ -90,9 +93,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return addr;
 	}
 
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
 	if (addr) {
 		if (do_align)
 			addr = COLOUR_ALIGN(addr, pgoff);
-- 
1.7.2.5
