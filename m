From: npiggin@suse.de
Subject: [patch 01/14] alpha: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:14 +1000
Message-ID: <20100422161222.762354051@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52085 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999Ab0DVQRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:41 -0400
Content-Disposition: inline; filename=alpha-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-alpha@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/alpha/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/alpha/mm/fault.c
+++ linux-2.6/arch/alpha/mm/fault.c
@@ -188,16 +188,10 @@ do_page_fault(unsigned long address, uns
 	/* We ran out of memory, or some other thing happened to us that
 	   made us unable to handle the page fault gracefully.  */
  out_of_memory:
-	if (is_global_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk(KERN_ALERT "VM: killing process %s(%d)\n",
-	       current->comm, task_pid_nr(current));
 	if (!user_mode(regs))
 		goto no_context;
-	do_group_exit(SIGKILL);
+	pagefault_out_of_memory();
+	return;
 
  do_sigbus:
 	/* Send a sigbus, regardless of whether we were in kernel
