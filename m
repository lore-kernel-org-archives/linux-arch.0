Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52105 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109Ab0DVQRw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:52 -0400
Message-ID: <20100422161224.322033236@suse.de>
Date: Fri, 23 Apr 2010 02:06:23 +1000
From: npiggin@suse.de
Subject: [patch 10/14] parisc: invoke oom-killer from page fault
References: <20100422160613.723698029@suse.de>
Content-Disposition: inline; filename=parisc-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-parisc@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>
Message-ID: <20100422160623.d8ZBEbhEzkjnaqJDN4GtaRQlp2qF9RMDmpFfEMmethc@z>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-parisc@vger.kernel.org
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/parisc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/parisc/mm/fault.c
+++ linux-2.6/arch/parisc/mm/fault.c
@@ -264,8 +264,7 @@ no_context:
 
   out_of_memory:
 	up_read(&mm->mmap_sem);
-	printk(KERN_CRIT "VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
 }


