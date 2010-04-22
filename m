From: npiggin@suse.de
Subject: [patch 03/14] cris: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:16 +1000
Message-ID: <20100422161223.139236262@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52065 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab0DVQRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:30 -0400
Content-Disposition: inline; filename=cris-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-cris-kernel@axis.com
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/cris/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/cris/mm/fault.c
+++ linux-2.6/arch/cris/mm/fault.c
@@ -245,10 +245,10 @@ do_page_fault(unsigned long address, str
 
  out_of_memory:
 	up_read(&mm->mmap_sem);
-	printk("VM: killing process %s\n", tsk->comm);
-	if (user_mode(regs))
-		do_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(regs))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
  do_sigbus:
 	up_read(&mm->mmap_sem);
