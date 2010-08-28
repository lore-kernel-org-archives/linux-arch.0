From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/20] powerpc: Use call_rcu_sched() for pagetables
Date: Sat, 28 Aug 2010 16:16:38 +0200
Message-ID: <20100828142455.464074954@chello.nl>
References: <20100828141637.421594670@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:47745 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0H1O1n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 10:27:43 -0400
Content-Disposition: inline; filename=powerpc-pgtable-call_rcu_sched.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

PowerPC relies on IRQ-disable to guard against RCU quiecent states,
use the appropriate RCU call version.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <npiggin@suse.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/powerpc/mm/pgtable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/powerpc/mm/pgtable.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/pgtable.c
+++ linux-2.6/arch/powerpc/mm/pgtable.c
@@ -92,7 +92,7 @@ static void pte_free_rcu_callback(struct
 
 static void pte_free_submit(struct pte_freelist_batch *batch)
 {
-	call_rcu(&batch->rcu, pte_free_rcu_callback);
+	call_rcu_sched(&batch->rcu, pte_free_rcu_callback);
 }
 
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, unsigned shift)
