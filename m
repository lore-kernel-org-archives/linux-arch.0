From: npiggin@suse.de
Subject: [patch 09/14] mn10300: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:22 +1000
Message-ID: <20100422161224.174904436@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52072 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933Ab0DVQRc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:32 -0400
Content-Disposition: inline; filename=mn10300-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-am33-list@redhat.com, David Howells <dhowells@redhat.com>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-am33-list@redhat.com
Cc: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/mn10300/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/mn10300/mm/fault.c
+++ linux-2.6/arch/mn10300/mm/fault.c
@@ -338,11 +338,10 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	monitor_signal(regs);
-	printk(KERN_ALERT "VM: killing process %s\n", tsk->comm);
-	if ((fault_code & MMUFCR_xFC_ACCESS) == MMUFCR_xFC_ACCESS_USR)
-		do_exit(SIGKILL);
-	goto no_context;
+	if ((fault_code & MMUFCR_xFC_ACCESS) != MMUFCR_xFC_ACCESS_USR)
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
