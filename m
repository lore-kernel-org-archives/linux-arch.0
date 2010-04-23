From: Mikael Starvik <mikael.starvik@axis.com>
Subject: RE: [patch 03/14] cris: invoke oom-killer from page fault
Date: Fri, 23 Apr 2010 06:33:36 +0200
Message-ID: <4BEA3FF3CAA35E408EA55C7BE2E61D0549641EBEBB@xmail3.se.axis.com>
References: <20100422160613.723698029@suse.de>
 <20100422161223.139236262@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from krynn.se.axis.com ([193.13.178.10]:49317 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab0DWEeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2010 00:34:00 -0400
In-Reply-To: <20100422161223.139236262@suse.de>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "npiggin@suse.de" <npiggin@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-cris-kernel <linux-cris-kernel@axis.com>

Signed-off-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: npiggin@suse.de [mailto:npiggin@suse.de] 
Sent: den 22 april 2010 18:06
To: linux-arch@vger.kernel.org
Cc: David Rientjes; Andrew Morton; linux-cris-kernel; Mikael Starvik
Subject: [patch 03/14] cris: invoke oom-killer from page fault

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
