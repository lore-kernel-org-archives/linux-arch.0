Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 09:59:04 +1100
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] ?mb() -> smp_?mb() conversion
Message-ID: <20050321225904.GF23908@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hi,

On a UP machine loads and stores should appear in program order so we
dont need most memory barriers. Convert a number of ?mb() etc to smp_?mb()
so we only take a hit on SMP builds.

What do people think of this patch?

Thinking some more about this, perhaps we should remove the ?mb() barriers
and instead have only io_?mb() and smp_?mb(). This has the advantage of
making it clear what barriers should be used in drivers to order
cacheable and non cacheable memory (a problem on ppc/ppc64 at least).

diff -puN fs/buffer.c~barrier_rework_2 fs/buffer.c
--- foobar2/fs/buffer.c~barrier_rework_2	2005-03-21 12:01:06.773011661 +1100
+++ foobar2-anton/fs/buffer.c	2005-03-21 12:01:06.848005928 +1100
@@ -218,7 +218,7 @@ struct super_block *freeze_bdev(struct b
 	sb = get_super(bdev);
 	if (sb && !(sb->s_flags & MS_RDONLY)) {
 		sb->s_frozen = SB_FREEZE_WRITE;
-		wmb();
+		smp_wmb();
 
 		sync_inodes_sb(sb, 0);
 		DQUOT_SYNC(sb);
@@ -235,7 +235,7 @@ struct super_block *freeze_bdev(struct b
 		sync_inodes_sb(sb, 1);
 
 		sb->s_frozen = SB_FREEZE_TRANS;
-		wmb();
+		smp_wmb();
 
 		sync_blockdev(sb->s_bdev);
 
@@ -263,7 +263,7 @@ void thaw_bdev(struct block_device *bdev
 		if (sb->s_op->unlockfs)
 			sb->s_op->unlockfs(sb);
 		sb->s_frozen = SB_UNFROZEN;
-		wmb();
+		smp_wmb();
 		wake_up(&sb->s_wait_unfrozen);
 		drop_super(sb);
 	}
diff -puN ipc/mqueue.c~barrier_rework_2 ipc/mqueue.c
--- foobar2/ipc/mqueue.c~barrier_rework_2	2005-03-21 12:01:06.779011202 +1100
+++ foobar2-anton/ipc/mqueue.c	2005-03-21 12:01:06.851005699 +1100
@@ -767,7 +767,7 @@ static inline void pipelined_send(struct
 	list_del(&receiver->list);
 	receiver->state = STATE_PENDING;
 	wake_up_process(receiver->task);
-	wmb();
+	smp_wmb();
 	receiver->state = STATE_READY;
 }
 
@@ -786,7 +786,7 @@ static inline void pipelined_receive(str
 	list_del(&sender->list);
 	sender->state = STATE_PENDING;
 	wake_up_process(sender->task);
-	wmb();
+	smp_wmb();
 	sender->state = STATE_READY;
 }
 
diff -puN kernel/kthread.c~barrier_rework_2 kernel/kthread.c
--- foobar2/kernel/kthread.c~barrier_rework_2	2005-03-21 12:01:06.784010820 +1100
+++ foobar2-anton/kernel/kthread.c	2005-03-21 12:01:06.853005546 +1100
@@ -174,7 +174,7 @@ int kthread_stop(struct task_struct *k)
 
 	/* Must init completion *before* thread sees kthread_stop_info.k */
 	init_completion(&kthread_stop_info.done);
-	wmb();
+	smp_wmb();
 
 	/* Now set kthread_should_stop() to true, and wake it up. */
 	kthread_stop_info.k = k;
diff -puN kernel/profile.c~barrier_rework_2 kernel/profile.c
--- foobar2/kernel/profile.c~barrier_rework_2	2005-03-21 12:01:06.790010361 +1100
+++ foobar2-anton/kernel/profile.c	2005-03-21 12:01:06.855005393 +1100
@@ -528,7 +528,7 @@ static int __init create_hash_tables(voi
 	return 0;
 out_cleanup:
 	prof_on = 0;
-	mb();
+	smp_mb();
 	on_each_cpu(profile_nop, NULL, 0, 1);
 	for_each_online_cpu(cpu) {
 		struct page *page;
diff -puN kernel/ptrace.c~barrier_rework_2 kernel/ptrace.c
--- foobar2/kernel/ptrace.c~barrier_rework_2	2005-03-21 12:01:06.795009979 +1100
+++ foobar2-anton/kernel/ptrace.c	2005-03-21 12:01:06.856005316 +1100
@@ -135,7 +135,7 @@ int ptrace_attach(struct task_struct *ta
  	    (current->gid != task->sgid) ||
  	    (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto bad;
-	rmb();
+	smp_rmb();
 	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	/* the same process cannot be attached many times */
diff -puN kernel/stop_machine.c~barrier_rework_2 kernel/stop_machine.c
--- foobar2/kernel/stop_machine.c~barrier_rework_2	2005-03-21 12:01:06.800009597 +1100
+++ foobar2-anton/kernel/stop_machine.c	2005-03-21 12:01:06.858005164 +1100
@@ -32,7 +32,7 @@ static int stopmachine(void *cpu)
 	set_cpus_allowed(current, cpumask_of_cpu((int)(long)cpu));
 
 	/* Ack: we are alive */
-	mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
+	smp_mb(); /* Theoretically the ack = 0 might not be on this CPU yet. */
 	atomic_inc(&stopmachine_thread_ack);
 
 	/* Simple state machine */
@@ -42,14 +42,14 @@ static int stopmachine(void *cpu)
 			local_irq_disable();
 			irqs_disabled = 1;
 			/* Ack: irqs disabled. */
-			mb(); /* Must read state first. */
+			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		} else if (stopmachine_state == STOPMACHINE_PREPARE
 			   && !prepared) {
 			/* Everyone is in place, hold CPU. */
 			preempt_disable();
 			prepared = 1;
-			mb(); /* Must read state first. */
+			smp_mb(); /* Must read state first. */
 			atomic_inc(&stopmachine_thread_ack);
 		}
 		/* Yield in first stage: migration threads need to
@@ -61,7 +61,7 @@ static int stopmachine(void *cpu)
 	}
 
 	/* Ack: we are exiting. */
-	mb(); /* Must read state first. */
+	smp_mb(); /* Must read state first. */
 	atomic_inc(&stopmachine_thread_ack);
 
 	if (irqs_disabled)
@@ -76,7 +76,7 @@ static int stopmachine(void *cpu)
 static void stopmachine_set_state(enum stopmachine_state state)
 {
 	atomic_set(&stopmachine_thread_ack, 0);
-	wmb();
+	smp_wmb();
 	stopmachine_state = state;
 	while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads)
 		cpu_relax();
diff -puN kernel/sys.c~barrier_rework_2 kernel/sys.c
--- foobar2/kernel/sys.c~barrier_rework_2	2005-03-21 12:01:06.804009291 +1100
+++ foobar2-anton/kernel/sys.c	2005-03-21 12:01:06.862004858 +1100
@@ -525,7 +525,7 @@ asmlinkage long sys_setregid(gid_t rgid,
 	if (new_egid != old_egid)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	if (rgid != (gid_t) -1 ||
 	    (egid != (gid_t) -1 && egid != old_rgid))
@@ -556,7 +556,7 @@ asmlinkage long sys_setgid(gid_t gid)
 		if(old_egid != gid)
 		{
 			current->mm->dumpable=0;
-			wmb();
+			smp_wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
 	}
@@ -565,7 +565,7 @@ asmlinkage long sys_setgid(gid_t gid)
 		if(old_egid != gid)
 		{
 			current->mm->dumpable=0;
-			wmb();
+			smp_wmb();
 		}
 		current->egid = current->fsgid = gid;
 	}
@@ -596,7 +596,7 @@ static int set_user(uid_t new_ruid, int 
 	if(dumpclear)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	current->uid = new_ruid;
 	return 0;
@@ -653,7 +653,7 @@ asmlinkage long sys_setreuid(uid_t ruid,
 	if (new_euid != old_euid)
 	{
 		current->mm->dumpable=0;
-		wmb();
+		smp_wmb();
 	}
 	current->fsuid = current->euid = new_euid;
 	if (ruid != (uid_t) -1 ||
@@ -703,7 +703,7 @@ asmlinkage long sys_setuid(uid_t uid)
 	if (old_euid != uid)
 	{
 		current->mm->dumpable = 0;
-		wmb();
+		smp_wmb();
 	}
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
@@ -748,7 +748,7 @@ asmlinkage long sys_setresuid(uid_t ruid
 		if (euid != current->euid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->euid = euid;
 	}
@@ -798,7 +798,7 @@ asmlinkage long sys_setresgid(gid_t rgid
 		if (egid != current->egid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->egid = egid;
 	}
@@ -845,7 +845,7 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		if (uid != old_fsuid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->fsuid = uid;
 	}
@@ -875,7 +875,7 @@ asmlinkage long sys_setfsgid(gid_t gid)
 		if (gid != old_fsgid)
 		{
 			current->mm->dumpable = 0;
-			wmb();
+			smp_wmb();
 		}
 		current->fsgid = gid;
 		key_fsgid_changed(current);
diff -puN kernel/timer.c~barrier_rework_2 kernel/timer.c
--- foobar2/kernel/timer.c~barrier_rework_2	2005-03-21 12:01:06.809008909 +1100
+++ foobar2-anton/kernel/timer.c	2005-03-21 12:01:06.866004552 +1100
@@ -1007,7 +1007,7 @@ asmlinkage long sys_getppid(void)
 		 * Make sure we read the pid before re-reading the
 		 * parent pointer:
 		 */
-		rmb();
+		smp_rmb();
 		parent = me->group_leader->real_parent;
 		if (old != parent)
 			continue;
diff -puN lib/rwsem-spinlock.c~barrier_rework_2 lib/rwsem-spinlock.c
--- foobar2/lib/rwsem-spinlock.c~barrier_rework_2	2005-03-21 12:01:06.814008527 +1100
+++ foobar2-anton/lib/rwsem-spinlock.c	2005-03-21 12:01:06.867004476 +1100
@@ -76,7 +76,7 @@ __rwsem_do_wake(struct rw_semaphore *sem
 		list_del(&waiter->list);
 		tsk = waiter->task;
 		/* Don't touch waiter after ->task has been NULLed */
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
@@ -91,7 +91,7 @@ __rwsem_do_wake(struct rw_semaphore *sem
 
 		list_del(&waiter->list);
 		tsk = waiter->task;
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
@@ -123,7 +123,7 @@ __rwsem_wake_one_writer(struct rw_semaph
 	list_del(&waiter->list);
 
 	tsk = waiter->task;
-	mb();
+	smp_mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
 	put_task_struct(tsk);
diff -puN lib/rwsem.c~barrier_rework_2 lib/rwsem.c
--- foobar2/lib/rwsem.c~barrier_rework_2	2005-03-21 12:01:06.819008145 +1100
+++ foobar2-anton/lib/rwsem.c	2005-03-21 12:01:06.869004323 +1100
@@ -74,7 +74,7 @@ __rwsem_do_wake(struct rw_semaphore *sem
 	 */
 	list_del(&waiter->list);
 	tsk = waiter->task;
-	mb();
+	smp_mb();
 	waiter->task = NULL;
 	wake_up_process(tsk);
 	put_task_struct(tsk);
@@ -117,7 +117,7 @@ __rwsem_do_wake(struct rw_semaphore *sem
 		waiter = list_entry(next, struct rwsem_waiter, list);
 		next = waiter->list.next;
 		tsk = waiter->task;
-		mb();
+		smp_mb();
 		waiter->task = NULL;
 		wake_up_process(tsk);
 		put_task_struct(tsk);
diff -puN mm/mempool.c~barrier_rework_2 mm/mempool.c
--- foobar2/mm/mempool.c~barrier_rework_2	2005-03-21 12:01:06.824007762 +1100
+++ foobar2-anton/mm/mempool.c	2005-03-21 12:01:06.870004246 +1100
@@ -210,7 +210,7 @@ repeat_alloc:
 	 * If the pool is less than 50% full and we can perform effective
 	 * page reclaim then try harder to allocate an element.
 	 */
-	mb();
+	smp_mb();
 	if ((gfp_mask & __GFP_FS) && (gfp_mask != gfp_nowait) &&
 				(pool->curr_nr <= pool->min_nr/2)) {
 		element = pool->alloc(gfp_mask, pool->pool_data);
@@ -236,7 +236,7 @@ repeat_alloc:
 		return NULL;
 
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
-	mb();
+	smp_mb();
 	if (!pool->curr_nr)
 		io_schedule();
 	finish_wait(&pool->wait, &wait);
@@ -257,7 +257,7 @@ void mempool_free(void *element, mempool
 {
 	unsigned long flags;
 
-	mb();
+	smp_mb();
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (pool->curr_nr < pool->min_nr) {
_
