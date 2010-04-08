From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/13] powerpc: Add rcu_read_lock() to gup_fast() implementation
Date: Thu, 08 Apr 2010 21:17:38 +0200
Message-ID: <20100408192722.643778654@chello.nl>
References: <20100408191737.296180458@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=powerpc-gup_fast-rcu.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org

The powerpc page table freeing relies on the fact that IRQs hold off
an RCU grace period, this is currently true for all existing RCU
implementations but is not an assumption Paul wants to support.

Therefore, also take the RCU read lock along with disabling IRQs to
ensure the RCU grace period does at least cover these lookups.

Requested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Nick Piggin <npiggin@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/gup.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/arch/powerpc/mm/gup.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/gup.c
+++ linux-2.6/arch/powerpc/mm/gup.c
@@ -142,6 +142,7 @@ int get_user_pages_fast(unsigned long st
 	 * So long as we atomically load page table pointers versus teardown,
 	 * we can follow the address down to the the page and take a ref on it.
 	 */
+	rcu_read_lock();
 	local_irq_disable();
 
 	pgdp = pgd_offset(mm, addr);
@@ -162,6 +163,7 @@ int get_user_pages_fast(unsigned long st
 	} while (pgdp++, addr = next, addr != end);
 
 	local_irq_enable();
+	rcu_read_unlock();
 
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
@@ -171,6 +173,7 @@ int get_user_pages_fast(unsigned long st
 
 slow:
 		local_irq_enable();
+		rcu_read_unlock();
 slow_irqon:
 		pr_devel("  slow path ! nr = %d\n", nr);
 
