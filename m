From: npiggin@suse.de
Subject: [patch 06/14] m32r: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:19 +1000
Message-ID: <20100422161223.608103837@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36334 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021Ab0DVQRr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:47 -0400
Content-Disposition: inline; filename=m32r-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-m32r@ml.linux-m32r.org, Hirokazu Takata <takata@linux-m32r.org>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linux-m32r@ml.linux-m32r.org
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/m32r/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/m32r/mm/fault.c
+++ linux-2.6/arch/m32r/mm/fault.c
@@ -271,15 +271,10 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_global_init(tsk)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & ACE_USERMODE)
-		do_group_exit(SIGKILL);
-	goto no_context;
+		goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
