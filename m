From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/9] c6x: Remove duplicate DT selection logic
Date: Tue, 19 Nov 2013 12:12:28 +0100
Message-ID: <1384859554-27268-3-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
 <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from georges.telenet-ops.be ([195.130.137.68]:34604 "EHLO
	georges.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab3KSLMp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 06:12:45 -0500
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org

early_init_dt_scan() now takes care of falling back to the built-in DTB.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: linux-c6x-dev@linux-c6x.org
---
 arch/c6x/kernel/setup.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
index 414353027ba9..ad7c5d73bb3c 100644
--- a/arch/c6x/kernel/setup.c
+++ b/arch/c6x/kernel/setup.c
@@ -266,7 +266,6 @@ int __init c6x_add_memory(phys_addr_t start, unsigned long size)
 notrace void __init machine_init(unsigned long dt_ptr)
 {
 	struct boot_param_header *dtb = __va(dt_ptr);
-	struct boot_param_header *fdt = &__dtb_start;
 
 	/* interrupts must be masked */
 	set_creg(IER, 2);
@@ -279,15 +278,8 @@ notrace void __init machine_init(unsigned long dt_ptr)
 
 	lockdep_init();
 
-	/*
-	 * dtb is passed in from bootloader.
-	 * fdt is linked in blob.
-	 */
-	if (dtb && dtb != fdt)
-		fdt = dtb;
-
 	/* Do some early initialization based on the flat device tree */
-	early_init_dt_scan(fdt);
+	early_init_dt_scan(dtb);
 
 	parse_early_param();
 }
-- 
1.7.9.5
