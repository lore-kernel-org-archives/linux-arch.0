From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 6/7] lazy tlb: allow lazy tlb mm switching to be configurable
Date: Fri, 10 Jul 2020 11:56:45 +1000
Message-ID: <20200710015646.2020871-7-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGJB5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:36 -0400
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>

NOMMU systems could easily go without this and save a bit of code
and the mm refcounting, because their mm switch is a no-op. I haven't
flipped them over because haven't audited all arch code to convert
over to using the _lazy_tlb refcounting.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             |  7 +++++
 include/linux/sched/mm.h | 12 ++++++---
 kernel/sched/core.c      | 55 +++++++++++++++++++++++++++-------------
 kernel/sched/sched.h     |  4 ++-
 4 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..2daf8fe6146a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -411,6 +411,13 @@ config MMU_GATHER_NO_GATHER
 	bool
 	depends on MMU_GATHER_TABLE_FREE
 
+# Would like to make this depend on MMU, because there is little use for lazy mm switching
+# with NOMMU, but have to audit NOMMU architecture code first.
+config MMU_LAZY_TLB
+	def_bool y
+	help
+	  Enable "lazy TLB" mmu context switching for kernel threads.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 110d4ad21de6..2c2b20e2ccc7 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -53,18 +53,22 @@ void mmdrop(struct mm_struct *mm);
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	mmgrab(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmdrop(mm);
 }
 
 static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
 {
-	/* This depends on mmdrop providing a full smp_mb() */
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		mmdrop(mm); /* This depends on mmdrop providing a full smp_mb() */
+	else
+		smp_mb();
 }
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d19f2f517f6c..14b4fae6f6e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3253,7 +3253,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
-	struct mm_struct *mm = rq->prev_mm;
+	struct mm_struct *mm = NULL;
 	long prev_state;
 
 	/*
@@ -3272,7 +3272,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		      current->comm, current->pid, preempt_count()))
 		preempt_count_set(FORK_PREEMPT_COUNT);
 
-	rq->prev_mm = NULL;
+#ifdef CONFIG_MMU_LAZY_TLB
+	mm = rq->prev_lazy_mm;
+	rq->prev_lazy_mm = NULL;
+#endif
 
 	/*
 	 * A task struct has one reference for the use as "current".
@@ -3393,22 +3396,11 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
-/*
- * context_switch - switch to the new MM and the new thread's register state.
- */
-static __always_inline struct rq *
-context_switch(struct rq *rq, struct task_struct *prev,
-	       struct task_struct *next, struct rq_flags *rf)
+static __always_inline void
+context_switch_mm(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next)
 {
-	prepare_task_switch(rq, prev, next);
-
-	/*
-	 * For paravirt, this is coupled with an exit in switch_to to
-	 * combine the page table reload and the switch backend into
-	 * one hypercall.
-	 */
-	arch_start_context_switch(prev);
-
+#ifdef CONFIG_MMU_LAZY_TLB
 	/*
 	 * kernel -> kernel   lazy + transfer active
 	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
@@ -3440,10 +3432,37 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			exit_lazy_tlb(prev->active_mm, next);
 
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
-			rq->prev_mm = prev->active_mm;
+			rq->prev_lazy_mm = prev->active_mm;
 			prev->active_mm = NULL;
 		}
 	}
+#else
+	if (!next->mm)
+		next->active_mm = &init_mm;
+	membarrier_switch_mm(rq, prev->active_mm, next->active_mm);
+	switch_mm_irqs_off(prev->active_mm, next->active_mm, next);
+	if (!prev->mm)
+		prev->active_mm = NULL;
+#endif
+}
+
+/*
+ * context_switch - switch to the new MM and the new thread's register state.
+ */
+static __always_inline struct rq *
+context_switch(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next, struct rq_flags *rf)
+{
+	prepare_task_switch(rq, prev, next);
+
+	/*
+	 * For paravirt, this is coupled with an exit in switch_to to
+	 * combine the page table reload and the switch backend into
+	 * one hypercall.
+	 */
+	arch_start_context_switch(prev);
+
+	context_switch_mm(rq, prev, next);
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877fb08eb1b0..b196dd885d33 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -929,7 +929,9 @@ struct rq {
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
-	struct mm_struct	*prev_mm;
+#ifdef CONFIG_MMU_LAZY_TLB
+	struct mm_struct	*prev_lazy_mm;
+#endif
 
 	unsigned int		clock_update_flags;
 	u64			clock;
-- 
2.23.0
