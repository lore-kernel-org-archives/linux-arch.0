From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 03/13] x86: Remove last traces of quicklist usage
Date: Thu, 08 Apr 2010 21:17:40 +0200
Message-ID: <20100408192722.729787846@chello.nl>
References: <20100408191737.296180458@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50021 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933450Ab0DHTbC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2010 15:31:02 -0400
Content-Disposition: inline; filename=x86-remove-quicklist-include.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>

We still have a stray quicklist header included even though we axed
quicklist usage quite a while back.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/x86/mm/pgtable_32.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/arch/x86/mm/pgtable_32.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/pgtable_32.c
+++ linux-2.6/arch/x86/mm/pgtable_32.c
@@ -9,7 +9,6 @@
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
-#include <linux/quicklist.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
