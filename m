From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] lockdep: warn on redundant or incorrect irq state changes
Date: Thu, 23 Jul 2020 20:56:15 +1000
Message-ID: <20200723105615.1268126-2-npiggin@gmail.com>
References: <20200723105615.1268126-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGWK4b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 06:56:31 -0400
In-Reply-To: <20200723105615.1268126-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

With the previous patch, lockdep hardirq state changes should not be
redundant. Softirq state changes already follow that pattern.

So warn on unexpected enable-when-enabled or disable-when-disabled
conditions, to catch possible errors or sloppy patterns that could
lead to similar bad behavior due to NMIs etc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/locking/lockdep.c           | 80 +++++++++++++-----------------
 kernel/locking/lockdep_internals.h |  4 --
 kernel/locking/lockdep_proc.c      | 10 +---
 3 files changed, 35 insertions(+), 59 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4c50b9..138458fb2234 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3649,15 +3649,8 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
-	if (unlikely(current->hardirqs_enabled)) {
-		/*
-		 * Neither irq nor preemption are disabled here
-		 * so this is racy by nature but losing one hit
-		 * in a stat is not a big deal.
-		 */
-		__debug_atomic_inc(redundant_hardirqs_on);
+	if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled))
 		return;
-	}
 
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
@@ -3695,15 +3688,8 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	if (unlikely(!debug_locks || curr->lockdep_recursion))
 		return;
 
-	if (curr->hardirqs_enabled) {
-		/*
-		 * Neither irq nor preemption are disabled here
-		 * so this is racy by nature but losing one hit
-		 * in a stat is not a big deal.
-		 */
-		__debug_atomic_inc(redundant_hardirqs_on);
+	if (DEBUG_LOCKS_WARN_ON(curr->hardirqs_enabled))
 		return;
-	}
 
 	/*
 	 * We're enabling irqs and according to our state above irqs weren't
@@ -3738,6 +3724,9 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (unlikely(!debug_locks || curr->lockdep_recursion))
 		return;
 
+	if (DEBUG_LOCKS_WARN_ON(!curr->hardirqs_enabled))
+		return;
+
 	/*
 	 * So we're supposed to get called after you mask local IRQs, but for
 	 * some reason the hardware doesn't quite think you did a proper job.
@@ -3745,17 +3734,13 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->hardirqs_enabled) {
-		/*
-		 * We have done an ON -> OFF transition:
-		 */
-		curr->hardirqs_enabled = 0;
-		curr->hardirq_disable_ip = ip;
-		curr->hardirq_disable_event = ++curr->irq_events;
-		debug_atomic_inc(hardirqs_off_events);
-	} else {
-		debug_atomic_inc(redundant_hardirqs_off);
-	}
+	/*
+	 * We have done an ON -> OFF transition:
+	 */
+	curr->hardirqs_enabled = 0;
+	curr->hardirq_disable_ip = ip;
+	curr->hardirq_disable_event = ++curr->irq_events;
+	debug_atomic_inc(hardirqs_off_events);
 }
 EXPORT_SYMBOL_GPL(lockdep_hardirqs_off);
 
@@ -3769,6 +3754,9 @@ void lockdep_softirqs_on(unsigned long ip)
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
+	if (DEBUG_LOCKS_WARN_ON(curr->softirqs_enabled))
+		return;
+
 	/*
 	 * We fancy IRQs being disabled here, see softirq.c, avoids
 	 * funny state and nesting things.
@@ -3776,11 +3764,6 @@ void lockdep_softirqs_on(unsigned long ip)
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->softirqs_enabled) {
-		debug_atomic_inc(redundant_softirqs_on);
-		return;
-	}
-
 	current->lockdep_recursion++;
 	/*
 	 * We'll do an OFF -> ON transition:
@@ -3809,26 +3792,26 @@ void lockdep_softirqs_off(unsigned long ip)
 	if (unlikely(!debug_locks || current->lockdep_recursion))
 		return;
 
+	if (DEBUG_LOCKS_WARN_ON(!curr->softirqs_enabled))
+		return;
+
 	/*
 	 * We fancy IRQs being disabled here, see softirq.c
 	 */
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return;
 
-	if (curr->softirqs_enabled) {
-		/*
-		 * We have done an ON -> OFF transition:
-		 */
-		curr->softirqs_enabled = 0;
-		curr->softirq_disable_ip = ip;
-		curr->softirq_disable_event = ++curr->irq_events;
-		debug_atomic_inc(softirqs_off_events);
-		/*
-		 * Whoops, we wanted softirqs off, so why aren't they?
-		 */
-		DEBUG_LOCKS_WARN_ON(!softirq_count());
-	} else
-		debug_atomic_inc(redundant_softirqs_off);
+	/*
+	 * We have done an ON -> OFF transition:
+	 */
+	curr->softirqs_enabled = 0;
+	curr->softirq_disable_ip = ip;
+	curr->softirq_disable_event = ++curr->irq_events;
+	debug_atomic_inc(softirqs_off_events);
+	/*
+	 * Whoops, we wanted softirqs off, so why aren't they?
+	 */
+	DEBUG_LOCKS_WARN_ON(!softirq_count());
 }
 
 static int
@@ -5684,6 +5667,11 @@ void __init lockdep_init(void)
 
 	printk(" per task-struct memory footprint: %zu bytes\n",
 	       sizeof(((struct task_struct *)NULL)->held_locks));
+
+	WARN_ON(irqs_disabled());
+
+	current->hardirqs_enabled = 1;
+	current->softirqs_enabled = 1;
 }
 
 static void
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index baca699b94e9..6dd8b1f06dc4 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -180,12 +180,8 @@ struct lockdep_stats {
 	unsigned int   chain_lookup_misses;
 	unsigned long  hardirqs_on_events;
 	unsigned long  hardirqs_off_events;
-	unsigned long  redundant_hardirqs_on;
-	unsigned long  redundant_hardirqs_off;
 	unsigned long  softirqs_on_events;
 	unsigned long  softirqs_off_events;
-	unsigned long  redundant_softirqs_on;
-	unsigned long  redundant_softirqs_off;
 	int            nr_unused_locks;
 	unsigned int   nr_redundant_checks;
 	unsigned int   nr_redundant;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 5525cd3ba0c8..98f204220ed9 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -172,12 +172,8 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	unsigned long long hi1 = debug_atomic_read(hardirqs_on_events),
 			   hi2 = debug_atomic_read(hardirqs_off_events),
-			   hr1 = debug_atomic_read(redundant_hardirqs_on),
-			   hr2 = debug_atomic_read(redundant_hardirqs_off),
 			   si1 = debug_atomic_read(softirqs_on_events),
-			   si2 = debug_atomic_read(softirqs_off_events),
-			   sr1 = debug_atomic_read(redundant_softirqs_on),
-			   sr2 = debug_atomic_read(redundant_softirqs_off);
+			   si2 = debug_atomic_read(softirqs_off_events);
 
 	seq_printf(m, " chain lookup misses:           %11llu\n",
 		debug_atomic_read(chain_lookup_misses));
@@ -196,12 +192,8 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 
 	seq_printf(m, " hardirq on events:             %11llu\n", hi1);
 	seq_printf(m, " hardirq off events:            %11llu\n", hi2);
-	seq_printf(m, " redundant hardirq ons:         %11llu\n", hr1);
-	seq_printf(m, " redundant hardirq offs:        %11llu\n", hr2);
 	seq_printf(m, " softirq on events:             %11llu\n", si1);
 	seq_printf(m, " softirq off events:            %11llu\n", si2);
-	seq_printf(m, " redundant softirq ons:         %11llu\n", sr1);
-	seq_printf(m, " redundant softirq offs:        %11llu\n", sr2);
 #endif
 }
 
-- 
2.23.0
