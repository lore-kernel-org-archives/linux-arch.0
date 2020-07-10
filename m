Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 5/7] lazy tlb: introduce lazy mm refcount helper functions
Date: Fri, 10 Jul 2020 11:56:44 +1000
Message-ID: <20200710015646.2020871-6-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710015644.tVij13Fpdyu_wRgJDfqqloHzET2V4x0hXqWgu_3DpwI@z>

Add explicit _lazy_tlb annotated functions for lazy mm refcounting.
This makes things a bit more explicit, and allows explicit refcounting
to be removed if it is not used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c            |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c |  4 ++--
 fs/exec.c                            |  2 +-
 include/linux/sched/mm.h             | 17 +++++++++++++++++
 kernel/cpu.c                         |  2 +-
 kernel/exit.c                        |  2 +-
 kernel/kthread.c                     | 11 +++++++----
 kernel/sched/core.c                  | 13 +++++++------
 8 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 73199470c265..ad95812d2a3f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1253,7 +1253,7 @@ void start_secondary(void *unused)
 	unsigned int cpu =3D smp_processor_id();
 	struct cpumask *(*sibling_mask)(int) =3D cpu_sibling_mask;
=20
-	mmgrab(&init_mm);
+	mmgrab(&init_mm); /* XXX: where is the mmput for this? */
 	current->active_mm =3D &init_mm;
=20
 	smp_store_cpu_info(cpu);
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3=
s64/radix_tlb.c
index b5cc9b23cf02..52730629b3eb 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -652,10 +652,10 @@ static void do_exit_flush_lazy_tlb(void *arg)
 		 * Must be a kernel thread because sender is single-threaded.
 		 */
 		BUG_ON(current->mm);
-		mmgrab(&init_mm);
+		mmgrab_lazy_tlb(&init_mm);
 		switch_mm(mm, &init_mm, current);
 		current->active_mm =3D &init_mm;
-		mmdrop(mm);
+		mmdrop_lazy_tlb(mm);
 	}
 	_tlbiel_pid(pid, RIC_FLUSH_ALL);
 }
diff --git a/fs/exec.c b/fs/exec.c
index e2ab71e88293..3a01b2751ea9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1119,7 +1119,7 @@ static int exec_mmap(struct mm_struct *mm)
 		mmput(old_mm);
 	} else {
 		exit_lazy_tlb(active_mm, tsk);
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
 	}
 	return 0;
 }
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 9b026264b445..110d4ad21de6 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -50,6 +50,23 @@ static inline void mmdrop(struct mm_struct *mm)
=20
 void mmdrop(struct mm_struct *mm);
=20
+/* Helpers for lazy TLB mm refcounting */
+static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
+{
+	mmgrab(mm);
+}
+
+static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
+static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
+{
+	/* This depends on mmdrop providing a full smp_mb() */
+	mmdrop(mm);
+}
+
 /*
  * This has to be called after a get_task_mm()/mmget_not_zero()
  * followed by taking the mmap_lock for writing before modifying the
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 134688d79589..ff9fcbc4e76b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -578,7 +578,7 @@ static int finish_cpu(unsigned int cpu)
 	 */
 	if (mm !=3D &init_mm)
 		idle->active_mm =3D &init_mm;
-	mmdrop(mm);
+	mmdrop_lazy_tlb(mm);
 	return 0;
 }
=20
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..d535da9fd2f8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -470,7 +470,7 @@ static void exit_mm(void)
 		__set_current_state(TASK_RUNNING);
 		mmap_read_lock(mm);
 	}
-	mmgrab(mm);
+	mmgrab_lazy_tlb(mm);
 	BUG_ON(mm !=3D current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 6f93c649aa97..a7133cc2ddaf 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1238,12 +1238,12 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
=20
+	mmgrab(mm);
+
 	task_lock(tsk);
 	active_mm =3D tsk->active_mm;
-	if (active_mm !=3D mm) {
-		mmgrab(mm);
+	if (active_mm !=3D mm)
 		tsk->active_mm =3D mm;
-	}
 	tsk->mm =3D mm;
 	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
@@ -1253,7 +1253,7 @@ void kthread_use_mm(struct mm_struct *mm)
=20
 	exit_lazy_tlb(active_mm, tsk);
 	if (active_mm !=3D mm)
-		mmdrop(active_mm);
+		mmdrop_lazy_tlb(active_mm);
=20
 	to_kthread(tsk)->oldfs =3D get_fs();
 	set_fs(USER_DS);
@@ -1276,9 +1276,12 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	task_lock(tsk);
 	sync_mm_rss(mm);
 	tsk->mm =3D NULL;
+	mmgrab_lazy_tlb(mm);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	task_unlock(tsk);
+
+	mmdrop(mm);
 }
 EXPORT_SYMBOL_GPL(kthread_unuse_mm);
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 31e22c79826c..d19f2f517f6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3302,10 +3302,11 @@ static struct rq *finish_task_switch(struct task_=
struct *prev)
 	 * schedule between user->kernel->user threads without passing though
 	 * switch_mm(). Membarrier requires a full barrier after storing to
 	 * rq->curr, before returning to userspace, for
-	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by mmdrop().
+	 * {PRIVATE,GLOBAL}_EXPEDITED. This is implicitly provided by
+	 * mmdrop_lazy_tlb_smp_mb().
 	 */
 	if (mm)
-		mmdrop(mm);
+		mmdrop_lazy_tlb_smp_mb(mm);
=20
 	if (unlikely(prev_state =3D=3D TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
@@ -3410,9 +3411,9 @@ context_switch(struct rq *rq, struct task_struct *p=
rev,
=20
 	/*
 	 * kernel -> kernel   lazy + transfer active
-	 *   user -> kernel   lazy + mmgrab() active
+	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
 	 *
-	 * kernel ->   user   switch + mmdrop() active
+	 * kernel ->   user   switch + mmdrop_lazy_tlb() active
 	 *   user ->   user   switch
 	 */
 	if (!next->mm) {                                // to kernel
@@ -3420,7 +3421,7 @@ context_switch(struct rq *rq, struct task_struct *p=
rev,
=20
 		next->active_mm =3D prev->active_mm;
 		if (prev->mm)                           // from user
-			mmgrab(prev->active_mm);
+			mmgrab_lazy_tlb(prev->active_mm);
 		else
 			prev->active_mm =3D NULL;
 	} else {                                        // to user
@@ -3438,7 +3439,7 @@ context_switch(struct rq *rq, struct task_struct *p=
rev,
 		if (!prev->mm) {                        // from kernel
 			exit_lazy_tlb(prev->active_mm, next);
=20
-			/* will mmdrop() in finish_task_switch(). */
+			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm =3D prev->active_mm;
 			prev->active_mm =3D NULL;
 		}
--=20
2.23.0
