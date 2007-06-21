Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:33062 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbXFUJVg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jun 2007 05:21:36 -0400
Date: Thu, 21 Jun 2007 05:11:04 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: [PARISC] Handle wrapping in expand_upwards()
Message-ID: <20070621091104.GA10043@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Helge Deller <deller@gmx.de>

Function expand_upwards() did not guarded against wrapping
around to address 0. This fixes the adjtimex02 testcase from
the Linux Test Project on a 32bit PARISC kernel.

[expand_upwards is only used on parisc and ia64; it looks like it does
 the right thing on both. --kyle]

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
---

Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c	2007-05-19 13:30:10.000000000 -0400
+++ linux-2.6/mm/mmap.c	2007-06-21 05:18:46.000000000 -0400
@@ -1536,9 +1536,14 @@
 	 * vma->vm_start/vm_end cannot change under us because the caller
 	 * is required to hold the mmap_sem in read mode.  We need the
 	 * anon_vma lock to serialize against concurrent expand_stacks.
+	 * Also guard against wrapping around to address 0.
 	 */
-	address += 4 + PAGE_SIZE - 1;
-	address &= PAGE_MASK;
+	if (address < PAGE_ALIGN(address+4))
+		address = PAGE_ALIGN(address+4);
+	else {
+		anon_vma_unlock(vma);
+		return -ENOMEM;
+	}
 	error = 0;
 
 	/* Somebody else might have raced and expanded it already */
