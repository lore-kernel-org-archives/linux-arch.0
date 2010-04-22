From: npiggin@suse.de
Subject: [patch 14/14] xtensa: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:27 +1000
Message-ID: <20100422161224.955039653@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36348 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197Ab0DVQRz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:55 -0400
Content-Disposition: inline; filename=xtensa-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: Chris Zankel <chris@zankel.net>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/xtensa/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/xtensa/mm/fault.c
+++ linux-2.6/arch/xtensa/mm/fault.c
@@ -146,15 +146,10 @@ bad_area:
 	 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	bad_page_fault(regs, address, SIGKILL);
+	if (!user_mode(regs))
+		bad_page_fault(regs, address, SIGKILL);
+	else
+		pagefault_out_of_memory();
 	return;
 
 do_sigbus:
