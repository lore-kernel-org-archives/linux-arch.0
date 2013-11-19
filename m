From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 8/9] openrisc: Remove duplicate DT selection logic
Date: Tue, 19 Nov 2013 12:12:33 +0100
Message-ID: <1384859554-27268-8-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
 <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:34824 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3KSLMp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 06:12:45 -0500
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net

early_init_dt_scan() now takes care of falling back to the built-in DTB,
and printing what it did.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux@lists.openrisc.net
---
 arch/openrisc/kernel/setup.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 3ca640cd42be..4ec6b07f02b3 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -212,12 +212,6 @@ void __init setup_cpuinfo(void)
 
 void __init or32_early_setup(void *fdt)
 {
-	if (fdt)
-		pr_info("FDT at %p\n", fdt);
-	else {
-		fdt = &__dtb_start;
-		pr_info("Compiled-in FDT at %p\n", fdt);
-	}
 	early_init_devtree(fdt);
 }
 
-- 
1.7.9.5
