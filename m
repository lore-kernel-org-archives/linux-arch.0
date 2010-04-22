From: npiggin@suse.de
Subject: [patch 05/14] ia64: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:18 +1000
Message-ID: <20100422161223.462054441@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52079 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab0DVQRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:38 -0400
Content-Disposition: inline; filename=ia64-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-ia64@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/ia64/mm/fault.c
+++ linux-2.6/arch/ia64/mm/fault.c
@@ -276,13 +276,7 @@ ia64_do_page_fault (unsigned long addres
 
   out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk(KERN_CRIT "VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
 }
