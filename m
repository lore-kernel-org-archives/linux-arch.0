From: npiggin@suse.de
Subject: [patch 04/14] frv: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:17 +1000
Message-ID: <20100422161223.295571760@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36302 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab0DVQRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:30 -0400
Content-Disposition: inline; filename=frv-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/frv/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/frv/mm/fault.c
+++ linux-2.6/arch/frv/mm/fault.c
@@ -257,10 +257,10 @@ asmlinkage void do_page_fault(int datamm
  */
  out_of_memory:
 	up_read(&mm->mmap_sem);
-	printk("VM: killing process %s\n", current->comm);
-	if (user_mode(__frame))
-		do_group_exit(SIGKILL);
-	goto no_context;
+	if (!user_mode(__frame))
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
  do_sigbus:
 	up_read(&mm->mmap_sem);
