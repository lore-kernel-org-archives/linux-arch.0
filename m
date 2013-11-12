Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from georges.telenet-ops.be ([195.130.137.68]:38338 "EHLO
	georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab3KLTmn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2013 14:42:43 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 08/17] microblaze: Remove _fdt_start casts
Date: Tue, 12 Nov 2013 20:42:18 +0100
Message-ID: <1384285347-13506-9-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au
Message-ID: <20131112194218.m4coLHRdYatG8KgGN1Ns6lZWOLvGFbNikme0YhYb1JI@z>

_fdt_start is an array, i.e. a pointer.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux@itee.uq.edu.au
---
 arch/microblaze/kernel/setup.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index 8de8ebc309f1..603e22fec6d5 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -136,7 +136,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	lockdep_init();
 
 /* initialize device tree for usage in early_printk */
-	early_init_devtree((void *)_fdt_start);
+	early_init_devtree(_fdt_start);
 
 #ifdef CONFIG_EARLY_PRINTK
 	setup_early_printk(NULL);
@@ -152,8 +152,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	if (fdt)
 		pr_info("FDT at 0x%08x\n", fdt);
 	else
-		pr_info("Compiled-in FDT at 0x%08x\n",
-					(unsigned int)_fdt_start);
+		pr_info("Compiled-in FDT at %p\n", _fdt_start);
 
 #ifdef CONFIG_MTD_UCLINUX
 	pr_info("Found romfs @ 0x%08x (0x%08x)\n",
-- 
1.7.9.5

