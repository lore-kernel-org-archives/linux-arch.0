Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59684 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401Ab1ANWVw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Jan 2011 17:21:52 -0500
Subject: [PATCH] parisc: fix compile breakage caused by inlining
 maybe_mkwrite
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Jan 2011 16:21:47 -0600
Message-ID: <1295043707.18445.70.camel@mulgrave.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Parisc List <linux-parisc@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20110114222147.1flgOT-dWgJ7MhRs8dJ7HjcJFV90BTNn0-f9sSmc1MY@z>

on Parisc, we have an include of linux/mm.h inside our asm/pgtable.h, so
this patch 

commit 14fd403f2146f740942d78af4e0ee59396ad8eab
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Thu Jan 13 15:46:37 2011 -0800

    thp: export maybe_mkwrite

Causes us an unsatisfiable use of pte_mkwrite in linux/mm.h

The fix is obviously not to include linux/mm.h in our pgtable.h, which
unbreaks the build.

James

---

diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index f3c0973..5d7b8ce 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -10,11 +10,13 @@
  * we simulate an x86-style page table for the linux mm code
  */
 
-#include <linux/mm.h>		/* for vm_area_struct */
 #include <linux/bitops.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/cache.h>
 
+struct vm_area_struct;
+
 /*
  * kern_addr_valid(ADDR) tests if ADDR is pointing to valid kernel
  * memory.  For the return value to be meaningful, ADDR must be >=


