From: npiggin@suse.de
Subject: [patch 11/14] powerpc: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 02:06:24 +1000
Message-ID: <20100422161224.465958039@suse.de>
References: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52094 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033Ab0DVQRr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:47 -0400
Content-Disposition: inline; filename=powerpc-pagefault-use-oom.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

As explained in commit 1c0fe6e3bd, we want to call the architecture independent
oom killer when getting an unexplained OOM from handle_mm_fault, rather than
simply killing current.

Cc: linuxppc-dev@ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Nick Piggin <npiggin@suse.de>
---
Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c
+++ linux-2.6/arch/powerpc/mm/fault.c
@@ -359,15 +359,10 @@ bad_area_nosemaphore:
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
-	return SIGKILL;
+	if (!user_mode(regs))
+		return SIGKILL;
+	pagefault_out_of_memory();
+	return 0;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
