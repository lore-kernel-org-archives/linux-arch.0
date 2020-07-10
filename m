Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 3/7] mm: introduce exit_lazy_tlb
Date: Fri, 10 Jul 2020 11:56:42 +1000
Message-ID: <20200710015646.2020871-4-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710015642.Fzz8KE-mUUXNqY6H0i0KG6rVCDX_ln5MEmzGDn2Rucw@z>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 fs/exec.c                         |  5 +++--
 include/asm-generic/mmu_context.h | 20 ++++++++++++++++++++
 kernel/kthread.c                  |  1 +
 kernel/sched/core.c               |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..e2ab71e88293 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1117,9 +1117,10 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		exit_lazy_tlb(active_mm, tsk);
+		mmdrop(active_mm);
 	}
-	mmdrop(active_mm);
 	return 0;
 }
=20
diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_=
context.h
index 86cea80a50df..3fc4c3879b79 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -24,6 +24,26 @@ static inline void enter_lazy_tlb(struct mm_struct *mm=
,
 }
 #endif
=20
+/*
+ * exit_lazy_tlb - Called after switching away from a lazy TLB mode mm.
+ *
+ * mm:  the lazy mm context that was switched away from
+ * tsk: the task that was switched to non-lazy mm
+ *
+ * tsk->mm will not be NULL.
+ *
+ * Note this is not symmetrical to enter_lazy_tlb, this is not
+ * called when tasks switch into the lazy mm, it's called after the
+ * lazy mm becomes non-lazy (either switched to a different mm or the
+ * owner of the mm returns).
+ */
+#ifndef exit_lazy_tlb
+static inline void exit_lazy_tlb(struct mm_struct *mm,
+			struct task_struct *tsk)
+{
+}
+#endif
+
 /**
  * init_new_context - Initialize context of a new mm_struct.
  * @tsk: task struct for the mm
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 132f84a5fde3..e813d92f2eab 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1253,6 +1253,7 @@ void kthread_use_mm(struct mm_struct *mm)
=20
 	if (active_mm !=3D mm)
 		mmdrop(active_mm);
+	exit_lazy_tlb(active_mm, tsk);
=20
 	to_kthread(tsk)->oldfs =3D get_fs();
 	set_fs(USER_DS);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca5db40392d4..debc917bc69b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3439,6 +3439,8 @@ context_switch(struct rq *rq, struct task_struct *p=
rev,
 		switch_mm_irqs_off(prev->active_mm, next->mm, next);
=20
 		if (!prev->mm) {                        // from kernel
+			exit_lazy_tlb(prev->active_mm, next);
+
 			/* will mmdrop() in finish_task_switch(). */
 			rq->prev_mm =3D prev->active_mm;
 			prev->active_mm =3D NULL;
--=20
2.23.0
