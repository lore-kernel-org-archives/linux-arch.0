From: npiggin@suse.de
Subject: [patch 02/14] avr32: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:15 +1000
Message-ID: <20100422161222.953856396@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36323 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab0DVQRo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:44 -0400
Content-Disposition: inline; filename=avr32-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/avr32/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/avr32/mm/fault.c
+++ linux-2.6/arch/avr32/mm/fault.c
@@ -211,15 +211,10 @@ no_context:
 	 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: Killing process %s\n", tsk->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	pagefault_out_of_memory();
+	if (!user_mode(regs))
+		goto no_context;
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
