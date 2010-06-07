From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/28] powerpc: Use call_rcu_sched() for pagetables
Date: Mon, 07 Jun 2010 13:06:55 +0200
Message-ID: <20100607111406.477271904@chello.nl>
References: <20100607110654.606530953@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=powerpc-pgtable-call_rcu_sched.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

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
@@ -93,7 +93,7 @@ static void pte_free_rcu_callback(struct
 static void pte_free_submit(struct pte_freelist_batch *batch)
 {
 	INIT_RCU_HEAD(&batch->rcu);
-	call_rcu(&batch->rcu, pte_free_rcu_callback);
+	call_rcu_sched(&batch->rcu, pte_free_rcu_callback);
 }
 
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, unsigned shift)
