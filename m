From: npiggin@suse.de
Subject: [patch 08/14] microblaze: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:21 +1000
Message-ID: <20100422161223.984100935@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36316 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab0DVQRn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:43 -0400
Content-Disposition: inline; filename=microblaze-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: microblaze-uclinux@itee.uq.edu.au
Cc: Michal Simek <monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/microblaze/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/microblaze/mm/fault.c
+++ linux-2.6/arch/microblaze/mm/fault.c
@@ -273,16 +273,11 @@ bad_area_nosemaphore:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (current->pid == 1) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
 	up_read(&mm->mmap_sem);
-	printk(KERN_WARNING "VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_exit(SIGKILL);
-	bad_page_fault(regs, address, SIGKILL);
+	if (!user_mode(regs))
+		bad_page_fault(regs, address, SIGKILL);
+	else
+		pagefault_out_of_memory();
 	return;
 
 do_sigbus:
