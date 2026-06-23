Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF9384CFE;
	Tue, 23 Jun 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224830; cv=none; b=BX067pEKW02qYp+/jRyh+HjtzPK3Z6Gp4K/aBWeRoHzPlfHjUpJVs+4Wl9ugJ+jroE/7qKY1dX17tRmVA/YMlO8zsnlWsezPpGLd/b+lfooVPWOoU9vBKQFu0FATeG5/roN4U5hqsyQRCuGxjm5V7QaEWv4MUTc6tzhU7D+/pxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224830; c=relaxed/simple;
	bh=ql/65/4d7jaWyDOqEslRe5rtoHUDTjCEKip5wJd0v6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+dnE+Ps4w6Z4zWYRswo7vEWJw10pVAMUqg0W6CwixB7HknQVlyrMh10qIvXY4kdVjawIqzIKvJrzS43RA+oRcwAxKHP2nfJVuU+v6s9jNZxA9ntStqXmRdhjGtxldtdyNrZs3yDeTl7x577t6YezXHuTrGuQOwfxEdFsEpn8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BXugmghw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvXt6eZv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXugmghw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvXt6eZv"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782224825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GXo+dc1CyqMq0CS0Yc7v3w+f2E0Y1U3B3jDX166OA4=;
	b=BXugmghwYg9ZZ2W5JC5jXk6gEN/ulGY3W50j9/dB7eWAr4lvodbBuHwdwoiySw7lDAgRMq
	KHhbAGmLplx5R8eokzSCZp/bd/NaBhz/qebHRhI4W1Jqu73+D1WEeLpTJsNGUD5/4Ohts9
	yuiDaPJSHqiusl/9ASwzWtxd91l+PPbrcErPAaqN5bkvj9majVSH8VWSdYS97bB9MshPXk
	dzx4c6IfcttArifMPp7NlXhrwIt4yoaYz5DOZG/5APpRd+oIwDdjUg9WxMgFEECLSnD9XB
	nKLCBIwjfRG9IExkU/rNofp0Wo1cMbM7ro3jQwC4pM+xANPJCbI9zIGbgrMSkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782224825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GXo+dc1CyqMq0CS0Yc7v3w+f2E0Y1U3B3jDX166OA4=;
	b=zvXt6eZv8vUsedtw5WrJuuyh2XM9Goc2L1FKDGf3GBA8tF6D4a9z/JPerRyMleAhu/1AsI
	qhnjCwdEGYfIcpCw==
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] sched: Use WARN_ON.*_DEFERRED()
Date: Tue, 23 Jun 2026 16:26:50 +0200
Message-ID: <20260623142650.265721-3-bigeasy@linutronix.de>
In-Reply-To: <20260623142650.265721-1-bigeasy@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Vlad managed to trigger a warning in __enqueue_entity() while the rq
lock was held. He was using the netconsole in an older kernel which was
a legacy console (not nbcon). This resulted in an immediate flush which
led to sending packets and this in turn led to waking ksoftirqd. This
wake up ended up in deadlock because the scheduler tried to acquire the
already acquired rq.

This problem is not limited to the netconsole but all legacy consoles:
Should the console wake any task while holding its internal lock then
lockdep will observe and report a possible AB-BA deadlock. Also since
the warning does not happen regulary, lockdep may observe a lockchain
while acquiring the locks, leading to a recursion report while holding
locks.
More importantly after the during the console printing and once it is
finished the console semaphore is released which will lead to wakeup if
there is a waiter pending.

Replace WARNs within the scheduler with the DEFERRED variant. This will
queue an irq_work and the print will occur once the locks are dropped.

Reported-by: Vlad Poenaru <vlad.wing@gmail.com>
Closes: https://lore.kernel.org/all/20260610183621.3915271-1-vlad.wing@gmai=
l.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c        |  78 +++++++++++++-------------
 kernel/sched/core_sched.c  |   6 +-
 kernel/sched/cpudeadline.c |   6 +-
 kernel/sched/deadline.c    |  62 ++++++++++-----------
 kernel/sched/ext.c         | 110 ++++++++++++++++++-------------------
 kernel/sched/fair.c        |  88 ++++++++++++++---------------
 kernel/sched/rt.c          |  36 ++++++------
 kernel/sched/sched.h       |  18 +++---
 8 files changed, 202 insertions(+), 202 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c69..0e282457abb91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -853,7 +853,7 @@ void update_rq_clock(struct rq *rq)
 		return;
=20
 	if (sched_feat(WARN_DOUBLE_CLOCK))
-		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
+		WARN_ON_ONCE_DEFERRED(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |=3D RQCF_UPDATED;
=20
 	clock =3D sched_clock_cpu(cpu_of(rq));
@@ -1807,7 +1807,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, st=
ruct task_struct *p,
=20
 	bucket =3D &uc_rq->bucket[uc_se->bucket_id];
=20
-	WARN_ON_ONCE(!bucket->tasks);
+	WARN_ON_ONCE_DEFERRED(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
=20
@@ -1827,7 +1827,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, st=
ruct task_struct *p,
 	 * Defensive programming: this should never happen. If it happens,
 	 * e.g. due to future modification, warn and fix up the expected value.
 	 */
-	WARN_ON_ONCE(bucket->value > rq_clamp);
+	WARN_ON_ONCE_DEFERRED(bucket->value > rq_clamp);
 	if (bucket->value >=3D rq_clamp) {
 		bkt_clamp =3D uclamp_rq_max_value(rq, clamp_id, uc_se->value);
 		uclamp_rq_set(rq, clamp_id, bkt_clamp);
@@ -2210,7 +2210,7 @@ void activate_task(struct rq *rq, struct task_struct =
*p, int flags)
=20
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	WARN_ON_ONCE(flags & DEQUEUE_SLEEP);
+	WARN_ON_ONCE_DEFERRED(flags & DEQUEUE_SLEEP);
=20
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
@@ -2516,7 +2516,7 @@ static struct rq *move_queued_task(struct rq *rq, str=
uct rq_flags *rf,
 	rq =3D cpu_rq(new_cpu);
=20
 	rq_lock(rq, rf);
-	WARN_ON_ONCE(task_cpu(p) !=3D new_cpu);
+	WARN_ON_ONCE_DEFERRED(task_cpu(p) !=3D new_cpu);
 	activate_task(rq, p, 0);
 	wakeup_preempt(rq, p, 0);
=20
@@ -2602,7 +2602,7 @@ static int migration_cpu_stop(void *data)
 	 * If we were passed a pending, then ->stop_pending was set, thus
 	 * p->migration_pending must have remained stable.
 	 */
-	WARN_ON_ONCE(pending && pending !=3D p->migration_pending);
+	WARN_ON_ONCE_DEFERRED(pending && pending !=3D p->migration_pending);
=20
 	/*
 	 * If task_rq(p) !=3D rq, it cannot be migrated here, because we're
@@ -2661,7 +2661,7 @@ static int migration_cpu_stop(void *data)
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
-		WARN_ON_ONCE(!pending->stop_pending);
+		WARN_ON_ONCE_DEFERRED(!pending->stop_pending);
 		preempt_disable();
 		rq_unlock(rq, &rf);
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
@@ -3004,7 +3004,7 @@ static int affine_move_task(struct rq *rq, struct tas=
k_struct *p, struct rq_flag
 	 *
 	 * Either way, we really should have a @pending here.
 	 */
-	if (WARN_ON_ONCE(!pending)) {
+	if (WARN_ON_ONCE_DEFERRED(!pending)) {
 		task_rq_unlock(rq, p, rf);
 		return -EINVAL;
 	}
@@ -3116,9 +3116,9 @@ static int __set_cpus_allowed_ptr_locked(struct task_=
struct *p,
 			goto out;
 		}
=20
-		if (WARN_ON_ONCE(p =3D=3D current &&
-				 is_migration_disabled(p) &&
-				 !cpumask_test_cpu(task_cpu(p), ctx->new_mask))) {
+		if (WARN_ON_ONCE_DEFERRED(p =3D=3D current &&
+					  is_migration_disabled(p) &&
+					  !cpumask_test_cpu(task_cpu(p), ctx->new_mask))) {
 			ret =3D -EBUSY;
 			goto out;
 		}
@@ -3267,7 +3267,7 @@ void force_compatible_cpus_allowed_ptr(struct task_st=
ruct *p)
 				cpumask_pr_args(override_mask));
 	}
=20
-	WARN_ON(set_cpus_allowed_ptr(p, override_mask));
+	WARN_ON_DEFERRED(set_cpus_allowed_ptr(p, override_mask));
 out_free_mask:
 	cpus_read_unlock();
 	free_cpumask_var(new_mask);
@@ -3293,7 +3293,7 @@ void relax_compatible_cpus_allowed_ptr(struct task_st=
ruct *p)
 	 * Cpuset masking will be done there too.
 	 */
 	ret =3D __sched_setaffinity(p, &ac);
-	WARN_ON_ONCE(ret);
+	WARN_ON_ONCE_DEFERRED(ret);
 }
=20
 #ifdef CONFIG_SMP
@@ -3306,16 +3306,16 @@ void set_task_cpu(struct task_struct *p, unsigned i=
nt new_cpu)
 	 * We should never call set_task_cpu() on a blocked task,
 	 * ttwu() will sort out the placement.
 	 */
-	WARN_ON_ONCE(state !=3D TASK_RUNNING && state !=3D TASK_WAKING && !p->on_=
rq);
+	WARN_ON_ONCE_DEFERRED(state !=3D TASK_RUNNING && state !=3D TASK_WAKING &=
& !p->on_rq);
=20
 	/*
 	 * Migrating fair class task must have p->on_rq =3D TASK_ON_RQ_MIGRATING,
 	 * because schedstat_wait_{start,end} rebase migrating task's wait_start
 	 * time relying on p->on_rq.
 	 */
-	WARN_ON_ONCE(state =3D=3D TASK_RUNNING &&
-		     p->sched_class =3D=3D &fair_sched_class &&
-		     (p->on_rq && !task_on_rq_migrating(p)));
+	WARN_ON_ONCE_DEFERRED(state =3D=3D TASK_RUNNING &&
+			      p->sched_class =3D=3D &fair_sched_class &&
+			      (p->on_rq && !task_on_rq_migrating(p)));
=20
 #ifdef CONFIG_LOCKDEP
 	/*
@@ -3328,15 +3328,15 @@ void set_task_cpu(struct task_struct *p, unsigned i=
nt new_cpu)
 	 * Furthermore, all task_rq users should acquire both locks, see
 	 * task_rq_lock().
 	 */
-	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
-				      lockdep_is_held(__rq_lockp(task_rq(p)))));
+	WARN_ON_ONCE_DEFERRED(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
+					       lockdep_is_held(__rq_lockp(task_rq(p)))));
 #endif
 	/*
 	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
 	 */
-	WARN_ON_ONCE(!cpu_online(new_cpu));
+	WARN_ON_ONCE_DEFERRED(!cpu_online(new_cpu));
=20
-	WARN_ON_ONCE(is_migration_disabled(p));
+	WARN_ON_ONCE_DEFERRED(is_migration_disabled(p));
=20
 	trace_sched_migrate_task(p, new_cpu);
=20
@@ -3803,10 +3803,10 @@ void sched_ttwu_pending(void *arg)
 	update_rq_clock(rq);
=20
 	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
-		if (WARN_ON_ONCE(p->on_cpu))
+		if (WARN_ON_ONCE_DEFERRED(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
=20
-		if (WARN_ON_ONCE(task_cpu(p) !=3D cpu_of(rq)))
+		if (WARN_ON_ONCE_DEFERRED(task_cpu(p) !=3D cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
=20
 		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
@@ -4003,8 +4003,8 @@ bool ttwu_state_match(struct task_struct *p, unsigned=
 int state, int *success)
 	int match;
=20
 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
-		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
-			     state !=3D TASK_RTLOCK_WAIT);
+		WARN_ON_ONCE_DEFERRED((state & TASK_RTLOCK_WAIT) &&
+				      state !=3D TASK_RTLOCK_WAIT);
 	}
=20
 	*success =3D !!(match =3D __task_state_match(p, state));
@@ -5745,7 +5745,7 @@ static void sched_tick_remote(struct work_struct *wor=
k)
 			 * we are always sure that there is no proxy (only a
 			 * single task is running).
 			 */
-			WARN_ON_ONCE(rq->curr !=3D rq->donor);
+			WARN_ON_ONCE_DEFERRED(rq->curr !=3D rq->donor);
 			update_rq_clock(rq);
=20
 			if (!is_idle_task(curr)) {
@@ -5754,7 +5754,7 @@ static void sched_tick_remote(struct work_struct *wor=
k)
 				 * reasonable amount of time.
 				 */
 				u64 delta =3D rq_clock_task(rq) - curr->se.exec_start;
-				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
+				WARN_ON_ONCE_DEFERRED(delta > (u64)NSEC_PER_SEC * 30);
 			}
 			curr->sched_class->task_tick(rq, curr, 0);
=20
@@ -5769,7 +5769,7 @@ static void sched_tick_remote(struct work_struct *wor=
k)
 	 * first update state to reflect hotplug activity if required.
 	 */
 	os =3D atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNI=
NG);
-	WARN_ON_ONCE(os =3D=3D TICK_SCHED_REMOTE_OFFLINE);
+	WARN_ON_ONCE_DEFERRED(os =3D=3D TICK_SCHED_REMOTE_OFFLINE);
 	if (os =3D=3D TICK_SCHED_REMOTE_RUNNING)
 		queue_delayed_work(system_dfl_wq, dwork, HZ);
 }
@@ -6196,7 +6196,7 @@ pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 			 * For robustness, update the min_vruntime_fi for
 			 * unconstrained picks as well.
 			 */
-			WARN_ON_ONCE(fi_before);
+			WARN_ON_ONCE_DEFERRED(fi_before);
 			task_vruntime_update(rq, next, false);
 			goto out_set_next;
 		}
@@ -6274,7 +6274,7 @@ pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 	rq->core_sched_seq =3D rq->core->core_pick_seq;
=20
 	/* Something should have been selected for current CPU */
-	WARN_ON_ONCE(!next);
+	WARN_ON_ONCE_DEFERRED(!next);
=20
 	/*
 	 * Reschedule siblings
@@ -6317,7 +6317,7 @@ pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
 		}
=20
 		/* Did we break L1TF mitigation requirements? */
-		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
+		WARN_ON_ONCE_DEFERRED(!cookie_match(next, rq_i->core_pick));
=20
 		if (rq_i->curr =3D=3D rq_i->core_pick) {
 			rq_i->core_pick =3D NULL;
@@ -6717,7 +6717,7 @@ static void proxy_migrate_task(struct rq *rq, struct =
rq_flags *rf,
 	struct rq *target_rq =3D cpu_rq(target_cpu);
=20
 	lockdep_assert_rq_held(rq);
-	WARN_ON(p =3D=3D rq->curr);
+	WARN_ON_DEFERRED(p =3D=3D rq->curr);
 	/*
 	 * Since we are migrating a blocked donor, it could be rq->donor,
 	 * and we want to make sure there aren't any references from this
@@ -6749,7 +6749,7 @@ static void proxy_force_return(struct rq *rq, struct =
rq_flags *rf,
 	int cpu, wake_flag =3D WF_TTWU;
=20
 	lockdep_assert_rq_held(rq);
-	WARN_ON(p =3D=3D rq->curr);
+	WARN_ON_DEFERRED(p =3D=3D rq->curr);
=20
 	if (p =3D=3D rq->donor)
 		proxy_resched_idle(rq);
@@ -6951,7 +6951,7 @@ find_proxy_task(struct rq *rq, struct task_struct *do=
nor, struct rq_flags *rf)
 		 * guarantee its existence, as per ttwu_remote().
 		 */
 	}
-	WARN_ON_ONCE(owner && !owner->on_rq);
+	WARN_ON_ONCE_DEFERRED(owner && !owner->on_rq);
 	return owner;
=20
 deactivate:
@@ -7631,8 +7631,8 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
 	 * real need to boost.
 	 */
 	if (unlikely(p =3D=3D rq->idle)) {
-		WARN_ON(p !=3D rq->curr);
-		WARN_ON(p->pi_blocked_on);
+		WARN_ON_DEFERRED(p !=3D rq->curr);
+		WARN_ON_DEFERRED(p->pi_blocked_on);
 		goto out_unlock;
 	}
=20
@@ -8463,7 +8463,7 @@ static void balance_push_set(int cpu, bool on)
=20
 	rq_lock_irqsave(rq, &rf);
 	if (on) {
-		WARN_ON_ONCE(rq->balance_callback);
+		WARN_ON_ONCE_DEFERRED(rq->balance_callback);
 		rq->balance_callback =3D &balance_push_callback;
 	} else if (rq->balance_callback =3D=3D &balance_push_callback) {
 		rq->balance_callback =3D NULL;
@@ -11150,7 +11150,7 @@ struct sched_change_ctx *sched_change_begin(struct =
task_struct *p, unsigned int
 	 * Must exclusively use matched flags since this is both dequeue and
 	 * enqueue.
 	 */
-	WARN_ON_ONCE(flags & 0xFFFF0000);
+	WARN_ON_ONCE_DEFERRED(flags & 0xFFFF0000);
=20
 	lockdep_assert_rq_held(rq);
=20
@@ -11198,7 +11198,7 @@ void sched_change_end(struct sched_change_ctx *ctx)
 	/*
 	 * Changing class without *QUEUE_CLASS is bad.
 	 */
-	WARN_ON_ONCE(p->sched_class !=3D ctx->class && !(ctx->flags & ENQUEUE_CLA=
SS));
+	WARN_ON_ONCE_DEFERRED(p->sched_class !=3D ctx->class && !(ctx->flags & EN=
QUEUE_CLASS));
=20
 	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
 		p->sched_class->switching_to(rq, p);
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 73b6b24269119..ec88ed7d8ee87 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -67,7 +67,7 @@ static unsigned long sched_core_update_cookie(struct task=
_struct *p,
 	 * a cookie until after we've removed it, we must have core scheduling
 	 * enabled here.
 	 */
-	WARN_ON_ONCE((p->core_cookie || cookie) && !sched_core_enabled(rq));
+	WARN_ON_ONCE_DEFERRED((p->core_cookie || cookie) && !sched_core_enabled(r=
q));
=20
 	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
@@ -249,7 +249,7 @@ void __sched_core_account_forceidle(struct rq *rq)
=20
 	lockdep_assert_rq_held(rq);
=20
-	WARN_ON_ONCE(!rq->core->core_forceidle_count);
+	WARN_ON_ONCE_DEFERRED(!rq->core->core_forceidle_count);
=20
 	if (rq->core->core_forceidle_start =3D=3D 0)
 		return;
@@ -260,7 +260,7 @@ void __sched_core_account_forceidle(struct rq *rq)
=20
 	rq->core->core_forceidle_start =3D now;
=20
-	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
+	if (WARN_ON_ONCE_DEFERRED(!rq->core->core_forceidle_occupation)) {
 		/* can't be forced idle without a running task */
 	} else if (rq->core->core_forceidle_count > 1 ||
 		   rq->core->core_forceidle_occupation > 1) {
diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 0a2b7e30fd10c..e305a8e993e27 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -149,7 +149,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	} else {
 		int best_cpu =3D cpudl_maximum(cp);
=20
-		WARN_ON(best_cpu !=3D -1 && !cpu_present(best_cpu));
+		WARN_ON_DEFERRED(best_cpu !=3D -1 && !cpu_present(best_cpu));
=20
 		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
@@ -177,7 +177,7 @@ void cpudl_clear(struct cpudl *cp, int cpu, bool online)
 	int old_idx, new_cpu;
 	unsigned long flags;
=20
-	WARN_ON(!cpu_present(cpu));
+	WARN_ON_DEFERRED(!cpu_present(cpu));
=20
 	raw_spin_lock_irqsave(&cp->lock, flags);
=20
@@ -220,7 +220,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 	int old_idx;
 	unsigned long flags;
=20
-	WARN_ON(!cpu_present(cpu));
+	WARN_ON_DEFERRED(!cpu_present(cpu));
=20
 	raw_spin_lock_irqsave(&cp->lock, flags);
=20
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7db4c87df83b0..863ac7509192f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -217,8 +217,8 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw +=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->running_bw < old); /* overflow */
-	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE_DEFERRED(dl_rq->running_bw < old); /* overflow */
+	WARN_ON_ONCE_DEFERRED(dl_rq->running_bw > dl_rq->this_bw);
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -230,7 +230,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->running_bw > old); /* underflow */
+	WARN_ON_ONCE_DEFERRED(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw =3D 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
@@ -244,7 +244,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw +=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->this_bw < old); /* overflow */
+	WARN_ON_ONCE_DEFERRED(dl_rq->this_bw < old); /* overflow */
 }
=20
 static inline
@@ -254,10 +254,10 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
=20
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -=3D dl_bw;
-	WARN_ON_ONCE(dl_rq->this_bw > old); /* underflow */
+	WARN_ON_ONCE_DEFERRED(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
 		dl_rq->this_bw =3D 0;
-	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE_DEFERRED(dl_rq->running_bw > dl_rq->this_bw);
 }
=20
 static inline
@@ -335,7 +335,7 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_s=
e)
=20
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
-	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
+	WARN_ON_ONCE_DEFERRED(p->dl.flags & SCHED_FLAG_SUGOV);
=20
 	if (task_on_rq_queued(p))
 		return;
@@ -416,7 +416,7 @@ static void task_non_contending(struct sched_dl_entity =
*dl_se, bool dl_task)
 	if (dl_entity_is_special(dl_se))
 		return;
=20
-	WARN_ON(dl_se->dl_non_contending);
+	WARN_ON_DEFERRED(dl_se->dl_non_contending);
=20
 	zerolag_time =3D dl_se->deadline -
 		 div64_long((dl_se->runtime * dl_se->dl_period),
@@ -582,7 +582,7 @@ static void enqueue_pushable_dl_task(struct rq *rq, str=
uct task_struct *p)
 {
 	struct rb_node *leftmost;
=20
-	WARN_ON_ONCE(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
+	WARN_ON_ONCE_DEFERRED(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
=20
 	leftmost =3D rb_add_cached(&p->pushable_dl_tasks,
 				 &rq->dl.pushable_dl_tasks_root,
@@ -664,7 +664,7 @@ static struct rq *dl_task_offline_migration(struct rq *=
rq, struct task_struct *p
 			 * Failed to find any suitable CPU.
 			 * The task will never come back!
 			 */
-			WARN_ON_ONCE(dl_bandwidth_enabled());
+			WARN_ON_ONCE_DEFERRED(dl_bandwidth_enabled());
=20
 			/*
 			 * If admission control is disabled we
@@ -756,8 +756,8 @@ static inline void setup_new_dl_entity(struct sched_dl_=
entity *dl_se)
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
-	WARN_ON(is_dl_boosted(dl_se));
-	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
+	WARN_ON_DEFERRED(is_dl_boosted(dl_se));
+	WARN_ON_DEFERRED(dl_time_before(rq_clock(rq), dl_se->deadline));
=20
 	/*
 	 * We are racing with the deadline timer. So, do nothing because
@@ -801,7 +801,7 @@ static void replenish_dl_entity(struct sched_dl_entity =
*dl_se)
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
-	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <=3D 0);
+	WARN_ON_ONCE_DEFERRED(pi_of(dl_se)->dl_runtime <=3D 0);
=20
 	/*
 	 * This could be the case for a !-dl task that is boosted.
@@ -975,7 +975,7 @@ update_dl_revised_wakeup(struct sched_dl_entity *dl_se,=
 struct rq *rq)
 	 *
 	 * See update_dl_entity() comments for further details.
 	 */
-	WARN_ON(dl_time_before(dl_se->deadline, rq_clock(rq)));
+	WARN_ON_DEFERRED(dl_time_before(dl_se->deadline, rq_clock(rq)));
=20
 	dl_se->runtime =3D (dl_se->dl_density * laxity) >> BW_SHIFT;
 }
@@ -1080,7 +1080,7 @@ static int start_dl_timer(struct sched_dl_entity *dl_=
se)
 	 * (current u > U).
 	 */
 	if (dl_se->dl_defer_armed) {
-		WARN_ON_ONCE(!dl_se->dl_throttled);
+		WARN_ON_ONCE_DEFERRED(!dl_se->dl_throttled);
 		act =3D ns_to_ktime(dl_se->deadline - dl_se->runtime);
 	} else {
 		/* act =3D deadline - rel-deadline + period */
@@ -1451,7 +1451,7 @@ static void update_curr_dl_se(struct rq *rq, struct s=
ched_dl_entity *dl_se, s64
 		/*
 		 * Non-servers would never get time accounted while throttled.
 		 */
-		WARN_ON_ONCE(!dl_server(dl_se));
+		WARN_ON_ONCE_DEFERRED(!dl_server(dl_se));
=20
 		/*
 		 * While the server is marked idle, do not push out the
@@ -1492,7 +1492,7 @@ static void update_curr_dl_se(struct rq *rq, struct s=
ched_dl_entity *dl_se, s64
 		 * and queue right away. Otherwise nothing might queue it. That's similar
 		 * to what enqueue_dl_entity() does on start_dl_timer=3D=3D0. For now, j=
ust warn.
 		 */
-		WARN_ON_ONCE(!start_dl_timer(dl_se));
+		WARN_ON_ONCE_DEFERRED(!start_dl_timer(dl_se));
=20
 		return;
 	}
@@ -1801,7 +1801,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	 */
 	rq->donor->sched_class->update_curr(rq);
=20
-	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
+	if (WARN_ON_ONCE_DEFERRED(!cpu_online(cpu_of(rq))))
 		return;
=20
 	trace_sched_dl_server_start_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
@@ -2073,7 +2073,7 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, stru=
ct dl_rq *dl_rq)
 static inline
 void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	WARN_ON(!dl_rq->dl_nr_running);
+	WARN_ON_DEFERRED(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
=20
 	if (!dl_server(dl_se))
@@ -2165,7 +2165,7 @@ static void __enqueue_dl_entity(struct sched_dl_entit=
y *dl_se)
 {
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
=20
-	WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node));
+	WARN_ON_ONCE_DEFERRED(!RB_EMPTY_NODE(&dl_se->rb_node));
=20
 	rb_add_cached(&dl_se->rb_node, &dl_rq->root, __dl_less);
=20
@@ -2189,7 +2189,7 @@ static void __dequeue_dl_entity(struct sched_dl_entit=
y *dl_se)
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
-	WARN_ON_ONCE(on_dl_rq(dl_se));
+	WARN_ON_ONCE_DEFERRED(on_dl_rq(dl_se));
=20
 	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
=20
@@ -2611,7 +2611,7 @@ static struct task_struct *__pick_task_dl(struct rq *=
rq, struct rq_flags *rf)
 		return NULL;
=20
 	dl_se =3D pick_next_dl_entity(dl_rq);
-	WARN_ON_ONCE(!dl_se);
+	WARN_ON_ONCE_DEFERRED(!dl_se);
=20
 	if (dl_server(dl_se)) {
 		p =3D dl_se->server_pick_task(dl_se, rf);
@@ -2823,12 +2823,12 @@ static struct task_struct *pick_next_pushable_dl_ta=
sk(struct rq *rq)
 	if (!p)
 		return NULL;
=20
-	WARN_ON_ONCE(rq->cpu !=3D task_cpu(p));
-	WARN_ON_ONCE(task_current(rq, p));
-	WARN_ON_ONCE(p->nr_cpus_allowed <=3D 1);
+	WARN_ON_ONCE_DEFERRED(rq->cpu !=3D task_cpu(p));
+	WARN_ON_ONCE_DEFERRED(task_current(rq, p));
+	WARN_ON_ONCE_DEFERRED(p->nr_cpus_allowed <=3D 1);
=20
-	WARN_ON_ONCE(!task_on_rq_queued(p));
-	WARN_ON_ONCE(!dl_task(p));
+	WARN_ON_ONCE_DEFERRED(!task_on_rq_queued(p));
+	WARN_ON_ONCE_DEFERRED(!dl_task(p));
=20
 	return p;
 }
@@ -2944,7 +2944,7 @@ static int push_dl_task(struct rq *rq)
 	if (is_migration_disabled(next_task))
 		return 0;
=20
-	if (WARN_ON(next_task =3D=3D rq->curr))
+	if (WARN_ON_DEFERRED(next_task =3D=3D rq->curr))
 		return 0;
=20
 	/* We might release rq lock */
@@ -3050,8 +3050,8 @@ static void pull_dl_task(struct rq *this_rq)
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
 		    dl_task_is_earliest_deadline(p, this_rq)) {
-			WARN_ON(p =3D=3D src_rq->curr);
-			WARN_ON(!task_on_rq_queued(p));
+			WARN_ON_DEFERRED(p =3D=3D src_rq->curr);
+			WARN_ON_DEFERRED(!task_on_rq_queued(p));
=20
 			/*
 			 * Then we pull iff p has actually an earlier
@@ -3109,7 +3109,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 {
 	struct rq *rq;
=20
-	WARN_ON_ONCE(!dl_task(p));
+	WARN_ON_ONCE_DEFERRED(!dl_task(p));
=20
 	rq =3D task_rq(p);
 	/*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d2d19473a82e..47d3a4c16455a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -512,12 +512,12 @@ do {										\
  * So if kf_tasks[] is set, @p's scheduler-protected fields are stable.
  *
  * kf_tasks[] can not stack, so task-based SCX ops must not nest. The
- * WARN_ON_ONCE() in each macro catches a re-entry of any of the three var=
iants
- * while a previous one is still in progress.
+ * WARN_ON_ONCE_DEFERRED() in each macro catches a re-entry of any of the =
three
+ * variants while a previous one is still in progress.
  */
 #define SCX_CALL_OP_TASK(sch, op, locked_rq, task, args...)			\
 do {										\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	WARN_ON_ONCE_DEFERRED(current->scx.kf_tasks[0]);			\
 	current->scx.kf_tasks[0] =3D task;					\
 	SCX_CALL_OP((sch), op, locked_rq, task, ##args);			\
 	current->scx.kf_tasks[0] =3D NULL;					\
@@ -526,7 +526,7 @@ do {										\
 #define SCX_CALL_OP_TASK_RET(sch, op, locked_rq, task, args...)			\
 ({										\
 	__typeof__((sch)->ops.op(task, ##args)) __ret;				\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	WARN_ON_ONCE_DEFERRED(current->scx.kf_tasks[0]);			\
 	current->scx.kf_tasks[0] =3D task;					\
 	__ret =3D SCX_CALL_OP_RET((sch), op, locked_rq, task, ##args);		\
 	current->scx.kf_tasks[0] =3D NULL;					\
@@ -536,7 +536,7 @@ do {										\
 #define SCX_CALL_OP_2TASKS_RET(sch, op, locked_rq, task0, task1, args...)	\
 ({										\
 	__typeof__((sch)->ops.op(task0, task1, ##args)) __ret;			\
-	WARN_ON_ONCE(current->scx.kf_tasks[0]);					\
+	WARN_ON_ONCE_DEFERRED(current->scx.kf_tasks[0]);			\
 	current->scx.kf_tasks[0] =3D task0;					\
 	current->scx.kf_tasks[1] =3D task1;					\
 	__ret =3D SCX_CALL_OP_RET((sch), op, locked_rq, task0, task1, ##args);	\
@@ -687,7 +687,7 @@ static bool nldsq_cursor_lost_task(struct scx_dsq_list_=
node *cursor,
 		return true;
=20
 	/* if @p has stayed on @dsq, its rq couldn't have changed */
-	if (WARN_ON_ONCE(rq !=3D task_rq(p)))
+	if (WARN_ON_ONCE_DEFERRED(rq !=3D task_rq(p)))
 		return true;
=20
 	return false;
@@ -1282,7 +1282,7 @@ static void schedule_reenq_local(struct rq *rq, u64 r=
eenq_flags)
 {
 	struct scx_sched *root =3D rcu_dereference_sched(scx_root);
=20
-	if (WARN_ON_ONCE(!root))
+	if (WARN_ON_ONCE_DEFERRED(!root))
 		return;
=20
 	schedule_dsq_reenq(root, &rq->scx.local_dsq, reenq_flags, rq);
@@ -1379,7 +1379,7 @@ static void dsq_inc_nr(struct scx_dispatch_q *dsq, st=
ruct task_struct *p, u64 en
 	 */
 	if (enq_flags & SCX_ENQ_IMMED) {
 		if (unlikely(dsq->id !=3D SCX_DSQ_LOCAL)) {
-			WARN_ON_ONCE(!(enq_flags & SCX_ENQ_GDSQ_FALLBACK));
+			WARN_ON_ONCE_DEFERRED(!(enq_flags & SCX_ENQ_GDSQ_FALLBACK));
 			return;
 		}
 		p->scx.flags |=3D SCX_TASK_IMMED;
@@ -1388,7 +1388,7 @@ static void dsq_inc_nr(struct scx_dispatch_q *dsq, st=
ruct task_struct *p, u64 en
 	if (p->scx.flags & SCX_TASK_IMMED) {
 		struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
=20
-		if (WARN_ON_ONCE(dsq->id !=3D SCX_DSQ_LOCAL))
+		if (WARN_ON_ONCE_DEFERRED(dsq->id !=3D SCX_DSQ_LOCAL))
 			return;
=20
 		rq->scx.nr_immed++;
@@ -1410,8 +1410,8 @@ static void dsq_dec_nr(struct scx_dispatch_q *dsq, st=
ruct task_struct *p)
 	if (p->scx.flags & SCX_TASK_IMMED) {
 		struct rq *rq =3D container_of(dsq, struct rq, scx.local_dsq);
=20
-		if (WARN_ON_ONCE(dsq->id !=3D SCX_DSQ_LOCAL) ||
-		    WARN_ON_ONCE(rq->scx.nr_immed <=3D 0))
+		if (WARN_ON_ONCE_DEFERRED(dsq->id !=3D SCX_DSQ_LOCAL) ||
+		    WARN_ON_ONCE_DEFERRED(rq->scx.nr_immed <=3D 0))
 			return;
=20
 		rq->scx.nr_immed--;
@@ -1521,9 +1521,9 @@ static void dispatch_enqueue(struct scx_sched *sch, s=
truct rq *rq,
 {
 	bool is_local =3D dsq->id =3D=3D SCX_DSQ_LOCAL;
=20
-	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
-	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
-		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
+	WARN_ON_ONCE_DEFERRED(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
+	WARN_ON_ONCE_DEFERRED((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
+			      !RB_EMPTY_NODE(&p->scx.dsq_priq));
=20
 	if (!is_local) {
 		raw_spin_lock_nested(&dsq->lock,
@@ -1646,7 +1646,7 @@ static void dispatch_enqueue(struct scx_sched *sch, s=
truct rq *rq,
 static void task_unlink_from_dsq(struct task_struct *p,
 				 struct scx_dispatch_q *dsq)
 {
-	WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
+	WARN_ON_ONCE_DEFERRED(list_empty(&p->scx.dsq_list.node));
=20
 	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
 		rb_erase(&p->scx.dsq_priq, &dsq->priq);
@@ -1709,7 +1709,7 @@ static void dispatch_dequeue(struct rq *rq, struct ta=
sk_struct *p)
 		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
 		 * the race.
 		 */
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
+		WARN_ON_ONCE_DEFERRED(!list_empty(&p->scx.dsq_list.node));
 		p->scx.holding_cpu =3D -1;
 	}
 	p->scx.dsq =3D NULL;
@@ -1787,8 +1787,8 @@ static void mark_direct_dispatch(struct scx_sched *sc=
h,
 		return;
 	}
=20
-	WARN_ON_ONCE(p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID);
-	WARN_ON_ONCE(p->scx.ddsp_enq_flags);
+	WARN_ON_ONCE_DEFERRED(p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID);
+	WARN_ON_ONCE_DEFERRED(p->scx.ddsp_enq_flags);
=20
 	p->scx.ddsp_dsq_id =3D dsq_id;
 	p->scx.ddsp_enq_flags =3D enq_flags;
@@ -1855,7 +1855,7 @@ static void direct_dispatch(struct scx_sched *sch, st=
ruct task_struct *p,
 			break;
 		}
=20
-		WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
+		WARN_ON_ONCE_DEFERRED(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 		list_add_tail(&p->scx.dsq_list.node,
 			      &rq->scx.ddsp_deferred_locals);
 		schedule_deferred_locked(rq);
@@ -1888,7 +1888,7 @@ static void do_enqueue_task(struct rq *rq, struct tas=
k_struct *p, u64 enq_flags,
 	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
=20
-	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
+	WARN_ON_ONCE_DEFERRED(!(p->scx.flags & SCX_TASK_QUEUED));
=20
 	/* internal movements - rq migration / RESTORE */
 	if (sticky_cpu =3D=3D cpu_of(rq))
@@ -1938,11 +1938,11 @@ static void do_enqueue_task(struct rq *rq, struct t=
ask_struct *p, u64 enq_flags,
 	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
 	qseq =3D rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
=20
-	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) !=3D SCX_OPSS_NONE);
+	WARN_ON_ONCE_DEFERRED(atomic_long_read(&p->scx.ops_state) !=3D SCX_OPSS_N=
ONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
=20
 	ddsp_taskp =3D this_cpu_ptr(&direct_dispatch_task);
-	WARN_ON_ONCE(*ddsp_taskp);
+	WARN_ON_ONCE_DEFERRED(*ddsp_taskp);
 	*ddsp_taskp =3D p;
=20
 	SCX_CALL_OP_TASK(sch, enqueue, rq, p, enq_flags);
@@ -2039,7 +2039,7 @@ static void enqueue_task_scx(struct rq *rq, struct ta=
sk_struct *p, int core_enq_
 		sticky_cpu =3D cpu_of(rq);
=20
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		WARN_ON_ONCE(!task_runnable(p));
+		WARN_ON_ONCE_DEFERRED(!task_runnable(p));
 		goto out;
 	}
=20
@@ -2159,7 +2159,7 @@ static bool dequeue_task_scx(struct rq *rq, struct ta=
sk_struct *p, int core_deq_
 		deq_flags |=3D SCX_DEQ_SCHED_CHANGE;
=20
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
-		WARN_ON_ONCE(task_runnable(p));
+		WARN_ON_ONCE_DEFERRED(task_runnable(p));
 		return true;
 	}
=20
@@ -2256,7 +2256,7 @@ static void move_local_task_to_local_dsq(struct scx_s=
ched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(dst_rq);
=20
-	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
+	WARN_ON_ONCE_DEFERRED(p->scx.holding_cpu >=3D 0);
=20
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -2299,8 +2299,8 @@ static void move_remote_task_to_local_dsq(struct task=
_struct *p, u64 enq_flags,
 	 * truncate the upper 32 bit. As we own @rq, we can pass them through
 	 * @rq->scx.extra_enq_flags instead.
 	 */
-	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
-	WARN_ON_ONCE(dst_rq->scx.extra_enq_flags);
+	WARN_ON_ONCE_DEFERRED(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));
+	WARN_ON_ONCE_DEFERRED(dst_rq->scx.extra_enq_flags);
 	dst_rq->scx.extra_enq_flags =3D enq_flags;
 	activate_task(dst_rq, p, 0);
 	dst_rq->scx.extra_enq_flags =3D 0;
@@ -2331,7 +2331,7 @@ static bool task_can_run_on_remote_rq(struct scx_sche=
d *sch,
 {
 	s32 cpu =3D cpu_of(rq);
=20
-	WARN_ON_ONCE(task_cpu(p) =3D=3D cpu);
+	WARN_ON_ONCE_DEFERRED(task_cpu(p) =3D=3D cpu);
=20
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
@@ -2411,7 +2411,7 @@ static bool unlink_dsq_and_lock_src_rq(struct task_st=
ruct *p,
=20
 	lockdep_assert_held(&dsq->lock);
=20
-	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
+	WARN_ON_ONCE_DEFERRED(p->scx.holding_cpu >=3D 0);
 	task_unlink_from_dsq(p, dsq);
 	p->scx.holding_cpu =3D cpu;
=20
@@ -2420,7 +2420,7 @@ static bool unlink_dsq_and_lock_src_rq(struct task_st=
ruct *p,
=20
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	return likely(p->scx.holding_cpu =3D=3D cpu) &&
-		!WARN_ON_ONCE(src_rq !=3D task_rq(p));
+		!WARN_ON_ONCE_DEFERRED(src_rq !=3D task_rq(p));
 }
=20
 static bool consume_remote_task(struct rq *this_rq,
@@ -2630,7 +2630,7 @@ static void dispatch_to_local_dsq(struct scx_sched *s=
ch, struct rq *rq,
=20
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	if (likely(p->scx.holding_cpu =3D=3D raw_smp_processor_id()) &&
-	    !WARN_ON_ONCE(src_rq !=3D task_rq(p))) {
+	    !WARN_ON_ONCE_DEFERRED(src_rq !=3D task_rq(p))) {
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -3099,7 +3099,7 @@ static void put_prev_task_scx(struct rq *rq, struct t=
ask_struct *p,
 		 * which should trigger an explicit follow-up scheduling event.
 		 */
 		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
-			WARN_ON_ONCE(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
+			WARN_ON_ONCE_DEFERRED(!(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
@@ -3201,7 +3201,7 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, =
bool force_scx)
 	keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
 	if (unlikely(keep_prev &&
 		     prev->sched_class !=3D &ext_sched_class)) {
-		WARN_ON_ONCE(scx_enable_state() =3D=3D SCX_ENABLED);
+		WARN_ON_ONCE_DEFERRED(scx_enable_state() =3D=3D SCX_ENABLED);
 		keep_prev =3D false;
 	}
=20
@@ -3332,7 +3332,7 @@ static int select_task_rq_scx(struct task_struct *p, =
int prev_cpu, int wake_flag
 		struct task_struct **ddsp_taskp;
=20
 		ddsp_taskp =3D this_cpu_ptr(&direct_dispatch_task);
-		WARN_ON_ONCE(*ddsp_taskp);
+		WARN_ON_ONCE_DEFERRED(*ddsp_taskp);
 		*ddsp_taskp =3D p;
=20
 		this_rq()->scx.in_select_cpu =3D true;
@@ -3620,7 +3620,7 @@ static void __scx_enable_task(struct scx_sched *sch, =
struct task_struct *p)
 	 * transitions are consistent, the flag should always be clear
 	 * here.
 	 */
-	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
+	WARN_ON_ONCE_DEFERRED(p->scx.flags & SCX_TASK_IN_CUSTODY);
=20
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
@@ -3651,7 +3651,7 @@ static void scx_disable_task(struct scx_sched *sch, s=
truct task_struct *p)
 	struct rq *rq =3D task_rq(p);
=20
 	lockdep_assert_rq_held(rq);
-	WARN_ON_ONCE(scx_get_task_state(p) !=3D SCX_TASK_ENABLED);
+	WARN_ON_ONCE_DEFERRED(scx_get_task_state(p) !=3D SCX_TASK_ENABLED);
=20
 	clear_direct_dispatch(p);
=20
@@ -3664,7 +3664,7 @@ static void scx_disable_task(struct scx_sched *sch, s=
truct task_struct *p)
 	 * transitions are consistent, the flag should always be clear
 	 * here.
 	 */
-	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
+	WARN_ON_ONCE_DEFERRED(p->scx.flags & SCX_TASK_IN_CUSTODY);
 }
=20
 static void __scx_disable_and_exit_task(struct scx_sched *sch,
@@ -3689,7 +3689,7 @@ static void __scx_disable_and_exit_task(struct scx_sc=
hed *sch,
 		scx_disable_task(sch, p);
 		break;
 	default:
-		WARN_ON_ONCE(true);
+		WARN_ON_ONCE_DEFERRED(true);
 		return;
 	}
=20
@@ -3726,7 +3726,7 @@ static void scx_disable_and_exit_task(struct scx_sche=
d *sch,
 	 * path, so it's always clear when @p arrives here in %SCX_TASK_NONE.
 	 */
 	if (p->scx.flags & SCX_TASK_SUB_INIT) {
-		if (!WARN_ON_ONCE(!scx_enabling_sub_sched))
+		if (!WARN_ON_ONCE_DEFERRED(!scx_enabling_sub_sched))
 			scx_sub_init_cancel_task(scx_enabling_sub_sched, p);
 		p->scx.flags &=3D ~SCX_TASK_SUB_INIT;
 	}
@@ -3818,7 +3818,7 @@ void scx_cancel_fork(struct task_struct *p)
 		struct rq_flags rf;
=20
 		rq =3D task_rq_lock(p, &rf);
-		WARN_ON_ONCE(scx_get_task_state(p) >=3D SCX_TASK_READY);
+		WARN_ON_ONCE_DEFERRED(scx_get_task_state(p) >=3D SCX_TASK_READY);
 		scx_disable_and_exit_task(scx_task_sched(p), p);
 		task_rq_unlock(rq, p, &rf);
 	}
@@ -3986,7 +3986,7 @@ static void process_ddsp_deferred_locals(struct rq *r=
q)
 		clear_direct_dispatch(p);
=20
 		dsq =3D find_dsq_for_dispatch(sch, rq, dsq_id, task_cpu(p));
-		if (!WARN_ON_ONCE(dsq->id !=3D SCX_DSQ_LOCAL))
+		if (!WARN_ON_ONCE_DEFERRED(dsq->id !=3D SCX_DSQ_LOCAL))
 			dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
 	}
 }
@@ -4041,7 +4041,7 @@ static u32 reenq_local(struct scx_sched *sch, struct =
rq *rq, u64 reenq_flags)
=20
 	lockdep_assert_rq_held(rq);
=20
-	if (WARN_ON_ONCE(reenq_flags & __SCX_REENQ_TSR_MASK))
+	if (WARN_ON_ONCE_DEFERRED(reenq_flags & __SCX_REENQ_TSR_MASK))
 		reenq_flags &=3D ~__SCX_REENQ_TSR_MASK;
 	if (rq_is_open(rq, 0))
 		reenq_flags |=3D SCX_REENQ_TSR_RQ_OPEN;
@@ -4078,7 +4078,7 @@ static u32 reenq_local(struct scx_sched *sch, struct =
rq *rq, u64 reenq_flags)
=20
 		dispatch_dequeue(rq, p);
=20
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+		if (WARN_ON_ONCE_DEFERRED(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
 			p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
 		p->scx.flags |=3D reason;
=20
@@ -4199,7 +4199,7 @@ static void reenq_user(struct rq *rq, struct scx_disp=
atch_q *dsq, u64 reenq_flag
 		dispatch_dequeue_locked(p, dsq);
 		raw_spin_unlock(&dsq->lock);
=20
-		if (WARN_ON_ONCE(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
+		if (WARN_ON_ONCE_DEFERRED(p->scx.flags & SCX_TASK_REENQ_REASON_MASK))
 			p->scx.flags &=3D ~SCX_TASK_REENQ_REASON_MASK;
 		p->scx.flags |=3D reason;
=20
@@ -4360,7 +4360,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 		struct cgroup *from =3D tg_cgrp(task_group(p));
 		struct cgroup *to =3D tg_cgrp(css_tg(css));
=20
-		WARN_ON_ONCE(p->scx.cgrp_moving_from);
+		WARN_ON_ONCE_DEFERRED(p->scx.cgrp_moving_from);
=20
 		/*
 		 * sched_move_task() omits identity migrations. Let's match the
@@ -4617,7 +4617,7 @@ static void exit_dsq(struct scx_dispatch_q *dsq)
 		 * There must have been a RCU grace period since the last
 		 * insertion and @dsq should be off the deferred list by now.
 		 */
-		if (WARN_ON_ONCE(!list_empty(&dru->node))) {
+		if (WARN_ON_ONCE_DEFERRED(!list_empty(&dru->node))) {
 			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
 			list_del_init(&dru->node);
 		}
@@ -4745,7 +4745,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 		tg->scx.flags |=3D SCX_TG_INITED;
 	}
=20
-	WARN_ON_ONCE(scx_cgroup_enabled);
+	WARN_ON_ONCE_DEFERRED(scx_cgroup_enabled);
 	scx_cgroup_enabled =3D true;
=20
 	return 0;
@@ -4848,7 +4848,7 @@ static void scx_sched_free_rcu_work(struct work_struc=
t *work)
 		 * period. As that blocks new deferrals, all
 		 * deferred_reenq_local_node's must be off-list by now.
 		 */
-		WARN_ON_ONCE(!list_empty(&pcpu->deferred_reenq_local.node));
+		WARN_ON_ONCE_DEFERRED(!list_empty(&pcpu->deferred_reenq_local.node));
=20
 		exit_dsq(bypass_dsq(sch, cpu));
 	}
@@ -5324,7 +5324,7 @@ static bool inc_bypass_depth(struct scx_sched *sch)
 {
 	lockdep_assert_held(&scx_bypass_lock);
=20
-	WARN_ON_ONCE(sch->bypass_depth < 0);
+	WARN_ON_ONCE_DEFERRED(sch->bypass_depth < 0);
 	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth + 1);
 	if (sch->bypass_depth !=3D 1)
 		return false;
@@ -5339,7 +5339,7 @@ static bool dec_bypass_depth(struct scx_sched *sch)
 {
 	lockdep_assert_held(&scx_bypass_lock);
=20
-	WARN_ON_ONCE(sch->bypass_depth < 1);
+	WARN_ON_ONCE_DEFERRED(sch->bypass_depth < 1);
 	WRITE_ONCE(sch->bypass_depth, sch->bypass_depth - 1);
 	if (sch->bypass_depth !=3D 0)
 		return false;
@@ -5360,7 +5360,7 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 	 * @sch->bypass_depth transitioning from 0 to 1 triggers enabling.
 	 * Shouldn't stagger.
 	 */
-	if (WARN_ON_ONCE(test_and_set_bit(0, &sch->bypass_dsp_claim)))
+	if (WARN_ON_ONCE_DEFERRED(test_and_set_bit(0, &sch->bypass_dsp_claim)))
 		return;
=20
 	/*
@@ -5380,11 +5380,11 @@ static void enable_bypass_dsp(struct scx_sched *sch)
 	 * Bump enable depth on both @sch and bypass dispatch host.
 	 */
 	ret =3D atomic_inc_return(&sch->bypass_dsp_enable_depth);
-	WARN_ON_ONCE(ret <=3D 0);
+	WARN_ON_ONCE_DEFERRED(ret <=3D 0);
=20
 	if (host !=3D sch) {
 		ret =3D atomic_inc_return(&host->bypass_dsp_enable_depth);
-		WARN_ON_ONCE(ret <=3D 0);
+		WARN_ON_ONCE_DEFERRED(ret <=3D 0);
 	}
=20
 	/*
@@ -5405,11 +5405,11 @@ static void disable_bypass_dsp(struct scx_sched *sc=
h)
 		return;
=20
 	ret =3D atomic_dec_return(&sch->bypass_dsp_enable_depth);
-	WARN_ON_ONCE(ret < 0);
+	WARN_ON_ONCE_DEFERRED(ret < 0);
=20
 	if (scx_parent(sch)) {
 		ret =3D atomic_dec_return(&scx_parent(sch)->bypass_dsp_enable_depth);
-		WARN_ON_ONCE(ret < 0);
+		WARN_ON_ONCE_DEFERRED(ret < 0);
 	}
 }
=20
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ebec186f9823..1213e77665fe9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -404,7 +404,7 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *=
cfs_rq)
=20
 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
-	WARN_ON_ONCE(rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list);
+	WARN_ON_ONCE_DEFERRED(rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list);
 }
=20
 /* Iterate through all leaf cfs_rq's on a runqueue */
@@ -689,7 +689,7 @@ __sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sche=
d_entity *se)
 	s64 w_vruntime, key =3D entity_key(cfs_rq, se);
=20
 	w_vruntime =3D key * weight;
-	WARN_ON_ONCE((w_vruntime >> 63) !=3D (w_vruntime >> 62));
+	WARN_ON_ONCE_DEFERRED((w_vruntime >> 63) !=3D (w_vruntime >> 62));
=20
 	cfs_rq->sum_w_vruntime +=3D w_vruntime;
 	cfs_rq->sum_weight +=3D weight;
@@ -861,7 +861,7 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
 	u64 avruntime =3D avg_vruntime(cfs_rq);
 	s64 vlag =3D entity_lag(cfs_rq, se, avruntime);
=20
-	WARN_ON_ONCE(!se->on_rq);
+	WARN_ON_ONCE_DEFERRED(!se->on_rq);
=20
 	if (se->sched_delayed) {
 		/* previous vlag < 0 otherwise se would not be delayed */
@@ -1153,7 +1153,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq =
*cfs_rq, bool protect)
 	if (sched_feat(PICK_BUDDY) && protect &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
-		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
+		WARN_ON_ONCE_DEFERRED(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
=20
@@ -4302,9 +4302,9 @@ static inline bool load_avg_is_decayed(struct sched_a=
vg *sa)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	WARN_ON_ONCE(sa->load_avg ||
-		      sa->util_avg ||
-		      sa->runnable_avg);
+	WARN_ON_ONCE_DEFERRED(sa->load_avg ||
+			      sa->util_avg ||
+			      sa->runnable_avg);
=20
 	return true;
 }
@@ -5460,7 +5460,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
=20
 		weight =3D avg_vruntime_weight(cfs_rq, se->load.weight);
 		lag *=3D load + weight;
-		if (WARN_ON_ONCE(!load))
+		if (WARN_ON_ONCE_DEFERRED(!load))
 			load =3D 1;
 		lag =3D div64_long(lag, load);
=20
@@ -5653,7 +5653,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int flags)
 	clear_buddies(cfs_rq, se);
=20
 	if (flags & DEQUEUE_DELAYED) {
-		WARN_ON_ONCE(!se->sched_delayed);
+		WARN_ON_ONCE_DEFERRED(!se->sched_delayed);
 	} else {
 		bool delay =3D sleep;
 		/*
@@ -5663,7 +5663,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int flags)
 		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay =3D false;
=20
-		WARN_ON_ONCE(delay && se->sched_delayed);
+		WARN_ON_ONCE_DEFERRED(delay && se->sched_delayed);
=20
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
@@ -5747,7 +5747,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_e=
ntity *se, bool first)
 	}
=20
 	update_stats_curr_start(cfs_rq, se);
-	WARN_ON_ONCE(cfs_rq->curr);
+	WARN_ON_ONCE_DEFERRED(cfs_rq->curr);
 	cfs_rq->curr =3D se;
=20
 	/*
@@ -5814,7 +5814,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, st=
ruct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	WARN_ON_ONCE(cfs_rq->curr !=3D prev);
+	WARN_ON_ONCE_DEFERRED(cfs_rq->curr !=3D prev);
 	cfs_rq->curr =3D NULL;
 }
=20
@@ -6015,7 +6015,7 @@ static void throttle_cfs_rq_work(struct callback_head=
 *work)
 	struct cfs_rq *cfs_rq;
 	struct rq *rq;
=20
-	WARN_ON_ONCE(p !=3D current);
+	WARN_ON_ONCE_DEFERRED(p !=3D current);
 	p->sched_throttle_work.next =3D &p->sched_throttle_work;
=20
 	/*
@@ -6041,7 +6041,7 @@ static void throttle_cfs_rq_work(struct callback_head=
 *work)
 			return;
 		rq =3D scope.rq;
 		update_rq_clock(rq);
-		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
+		WARN_ON_ONCE_DEFERRED(p->throttled || !list_empty(&p->throttle_node));
 		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		/*
@@ -6072,7 +6072,7 @@ void init_cfs_throttle_work(struct task_struct *p)
 static void detach_task_cfs_rq(struct task_struct *p);
 static void dequeue_throttled_task(struct task_struct *p, int flags)
 {
-	WARN_ON_ONCE(p->se.on_rq);
+	WARN_ON_ONCE_DEFERRED(p->se.on_rq);
 	list_del_init(&p->throttle_node);
=20
 	/* task blocked after throttled */
@@ -6094,7 +6094,7 @@ static bool enqueue_throttled_task(struct task_struct=
 *p)
 	struct cfs_rq *cfs_rq =3D cfs_rq_of(&p->se);
=20
 	/* @p should have gone through dequeue_throttled_task() first */
-	WARN_ON_ONCE(!list_empty(&p->throttle_node));
+	WARN_ON_ONCE_DEFERRED(!list_empty(&p->throttle_node));
=20
 	/*
 	 * If the throttled task @p is enqueued to a throttled cfs_rq,
@@ -6162,7 +6162,7 @@ static int tg_unthrottle_up(struct task_group *tg, vo=
id *data)
=20
 		cfs_rq->throttled_clock_self =3D 0;
=20
-		if (WARN_ON_ONCE((s64)delta < 0))
+		if (WARN_ON_ONCE_DEFERRED((s64)delta < 0))
 			delta =3D 0;
=20
 		cfs_rq->throttled_clock_self_time +=3D delta;
@@ -6231,8 +6231,8 @@ static int tg_throttle_down(struct task_group *tg, vo=
id *data)
 		cfs_rq->pelt_clock_throttled =3D 1;
 	}
=20
-	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
-	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
+	WARN_ON_ONCE_DEFERRED(cfs_rq->throttled_clock_self);
+	WARN_ON_ONCE_DEFERRED(!list_empty(&cfs_rq->throttled_limbo_list));
 	return 0;
 }
=20
@@ -6273,7 +6273,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled =3D 1;
-	WARN_ON_ONCE(cfs_rq->throttled_clock);
+	WARN_ON_ONCE_DEFERRED(cfs_rq->throttled_clock);
 	return true;
 }
=20
@@ -6380,7 +6380,7 @@ static inline void __unthrottle_cfs_rq_async(struct c=
fs_rq *cfs_rq)
 	}
=20
 	/* Already enqueued */
-	if (WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_csd_list)))
+	if (WARN_ON_ONCE_DEFERRED(!list_empty(&cfs_rq->throttled_csd_list)))
 		return;
=20
 	first =3D list_empty(&rq->cfsb_csd_list);
@@ -6393,7 +6393,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cf=
s_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
=20
-	if (WARN_ON_ONCE(!cfs_rq_throttled(cfs_rq) ||
+	if (WARN_ON_ONCE_DEFERRED(!cfs_rq_throttled(cfs_rq) ||
 	    cfs_rq->runtime_remaining <=3D 0))
 		return;
=20
@@ -6429,7 +6429,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwid=
th *cfs_b)
 			goto next;
=20
 		/* By the above checks, this should never be true */
-		WARN_ON_ONCE(cfs_rq->runtime_remaining > 0);
+		WARN_ON_ONCE_DEFERRED(cfs_rq->runtime_remaining > 0);
=20
 		raw_spin_lock(&cfs_b->lock);
 		runtime =3D -cfs_rq->runtime_remaining + 1;
@@ -6450,7 +6450,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwid=
th *cfs_b)
 				 * We currently only expect to be unthrottling
 				 * a single cfs_rq locally.
 				 */
-				WARN_ON_ONCE(!list_empty(&local_unthrottle));
+				WARN_ON_ONCE_DEFERRED(!list_empty(&local_unthrottle));
 				list_add_tail(&cfs_rq->throttled_csd_list,
 					      &local_unthrottle);
 			}
@@ -6475,7 +6475,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwid=
th *cfs_b)
=20
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	WARN_ON_ONCE(!list_empty(&local_unthrottle));
+	WARN_ON_ONCE_DEFERRED(!list_empty(&local_unthrottle));
=20
 	rcu_read_unlock();
=20
@@ -7048,7 +7048,7 @@ static void hrtick_start_fair(struct rq *rq, struct t=
ask_struct *p)
 	u64 vdelta;
 	u64 delta;
=20
-	WARN_ON_ONCE(task_rq(p) !=3D rq);
+	WARN_ON_ONCE_DEFERRED(task_rq(p) !=3D rq);
=20
 	if (rq->cfs.h_nr_queued <=3D 1)
 		return;
@@ -7171,8 +7171,8 @@ requeue_delayed_entity(struct sched_entity *se)
 	 * Because a delayed entity is one that is still on
 	 * the runqueue competing until elegibility.
 	 */
-	WARN_ON_ONCE(!se->sched_delayed);
-	WARN_ON_ONCE(!se->on_rq);
+	WARN_ON_ONCE_DEFERRED(!se->sched_delayed);
+	WARN_ON_ONCE_DEFERRED(!se->on_rq);
=20
 	if (update_entity_lag(cfs_rq, se)) {
 		cfs_rq->nr_queued--;
@@ -7409,8 +7409,8 @@ static int dequeue_entities(struct rq *rq, struct sch=
ed_entity *se, int flags)
 		rq->next_balance =3D jiffies;
=20
 	if (p && task_delayed) {
-		WARN_ON_ONCE(!task_sleep);
-		WARN_ON_ONCE(p->on_rq !=3D 1);
+		WARN_ON_ONCE_DEFERRED(!task_sleep);
+		WARN_ON_ONCE_DEFERRED(p->on_rq !=3D 1);
=20
 		/*
 		 * Fix-up what block_task() skipped.
@@ -8976,7 +8976,7 @@ static void set_cpus_allowed_fair(struct task_struct =
*p, struct affinity_context
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
-		if (WARN_ON_ONCE(!se->on_rq))
+		if (WARN_ON_ONCE_DEFERRED(!se->on_rq))
 			return;
 		if (se_is_idle(se))
 			return;
@@ -9023,7 +9023,7 @@ preempt_sync(struct rq *rq, int wake_flags,
 	 * WF_SYNC without WF_TTWU is not expected so warn if it happens even
 	 * though it is likely harmless.
 	 */
-	WARN_ON_ONCE(!(wake_flags & WF_TTWU));
+	WARN_ON_ONCE_DEFERRED(!(wake_flags & WF_TTWU));
=20
 	threshold =3D sysctl_sched_migration_cost;
 	delta =3D rq_clock_task(rq) - se->exec_start;
@@ -9095,7 +9095,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct=
 task_struct *p, int wake_f
 		return;
=20
 	find_matching_se(&se, &pse);
-	WARN_ON_ONCE(!pse);
+	WARN_ON_ONCE_DEFERRED(!pse);
=20
 	cse_is_idle =3D se_is_idle(se);
 	pse_is_idle =3D se_is_idle(pse);
@@ -9857,8 +9857,8 @@ static void detach_task(struct task_struct *p, struct=
 lb_env *env)
 		schedstat_inc(p->stats.nr_forced_migrations);
 	}
=20
-	WARN_ON(task_current(env->src_rq, p));
-	WARN_ON(task_current_donor(env->src_rq, p));
+	WARN_ON_DEFERRED(task_current(env->src_rq, p));
+	WARN_ON_DEFERRED(task_current_donor(env->src_rq, p));
=20
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
@@ -12151,7 +12151,7 @@ static int sched_balance_rq(int this_cpu, struct rq=
 *this_rq,
 		goto out_balanced;
 	}
=20
-	WARN_ON_ONCE(busiest =3D=3D env.dst_rq);
+	WARN_ON_ONCE_DEFERRED(busiest =3D=3D env.dst_rq);
=20
 	update_lb_imbalance_stat(&env, sd, idle);
=20
@@ -12461,7 +12461,7 @@ static int active_load_balance_cpu_stop(void *data)
 	 * we need to fix it. Originally reported by
 	 * Bjorn Helgaas on a 128-CPU setup.
 	 */
-	WARN_ON_ONCE(busiest_rq =3D=3D target_rq);
+	WARN_ON_ONCE_DEFERRED(busiest_rq =3D=3D target_rq);
=20
 	/* Search for an sd spanning us and the target CPU. */
 	rcu_read_lock();
@@ -12883,7 +12883,7 @@ static void set_cpu_sd_state_busy(int cpu)
=20
 void nohz_balance_exit_idle(struct rq *rq)
 {
-	WARN_ON_ONCE(rq !=3D this_rq());
+	WARN_ON_ONCE_DEFERRED(rq !=3D this_rq());
=20
 	if (likely(!rq->nohz_tick_stopped))
 		return;
@@ -12918,7 +12918,7 @@ void nohz_balance_enter_idle(int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
=20
-	WARN_ON_ONCE(cpu !=3D smp_processor_id());
+	WARN_ON_ONCE_DEFERRED(cpu !=3D smp_processor_id());
=20
 	/* If this CPU is going down, then nothing needs to be done: */
 	if (!cpu_active(cpu))
@@ -13000,7 +13000,7 @@ static void _nohz_idle_balance(struct rq *this_rq, =
unsigned int flags)
 	int balance_cpu;
 	struct rq *rq;
=20
-	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) =3D=3D NOHZ_BALANCE_KICK);
+	WARN_ON_ONCE_DEFERRED((flags & NOHZ_KICK_MASK) =3D=3D NOHZ_BALANCE_KICK);
=20
 	/*
 	 * We assume there will be no idle load after this update and clear
@@ -13623,7 +13623,7 @@ bool cfs_prio_less(const struct task_struct *a, con=
st struct task_struct *b,
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
=20
-	WARN_ON_ONCE(task_rq(b)->core !=3D rq->core);
+	WARN_ON_ONCE_DEFERRED(task_rq(b)->core !=3D rq->core);
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
@@ -13839,7 +13839,7 @@ static void switched_from_fair(struct rq *rq, struc=
t task_struct *p)
=20
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
-	WARN_ON_ONCE(p->se.sched_delayed);
+	WARN_ON_ONCE_DEFERRED(p->se.sched_delayed);
=20
 	attach_task_cfs_rq(p);
=20
@@ -13872,7 +13872,7 @@ static void __set_next_task_fair(struct rq *rq, str=
uct task_struct *p, bool firs
 	if (!first)
 		return;
=20
-	WARN_ON_ONCE(se->sched_delayed);
+	WARN_ON_ONCE_DEFERRED(se->sched_delayed);
=20
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
@@ -14148,7 +14148,7 @@ int sched_group_set_idle(struct task_group *tg, lon=
g idle)
 		rq_lock_irqsave(rq, &rf);
=20
 		grp_cfs_rq->idle =3D idle;
-		if (WARN_ON_ONCE(was_idle =3D=3D cfs_rq_is_idle(grp_cfs_rq)))
+		if (WARN_ON_ONCE_DEFERRED(was_idle =3D=3D cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
=20
 		idle_task_delta =3D grp_cfs_rq->h_nr_queued -
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4ee8faf01441a..506d0f1afa58f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -170,7 +170,7 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *r=
t_b)
=20
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
+	WARN_ON_ONCE_DEFERRED(!rt_entity_is_task(rt_se));
=20
 	return container_of(rt_se, struct task_struct, rt);
 }
@@ -178,13 +178,13 @@ static inline struct task_struct *rt_task_of(struct s=
ched_rt_entity *rt_se)
 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
 	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
+	WARN_ON_DEFERRED(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_g=
roup);
 	return rt_rq->rq;
 }
=20
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
-	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg !=3D &root_task_gro=
up);
+	WARN_ON_DEFERRED(!rt_group_sched_enabled() && rt_se->rt_rq->tg !=3D &root=
_task_group);
 	return rt_se->rt_rq;
 }
=20
@@ -192,7 +192,7 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_en=
tity *rt_se)
 {
 	struct rt_rq *rt_rq =3D rt_se->rt_rq;
=20
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
+	WARN_ON_DEFERRED(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_g=
roup);
 	return rt_rq->rq;
 }
=20
@@ -493,7 +493,7 @@ typedef struct task_group *rt_rq_iter_t;
 static inline struct task_group *next_task_group(struct task_group *tg)
 {
 	if (!rt_group_sched_enabled()) {
-		WARN_ON(tg !=3D &root_task_group);
+		WARN_ON_DEFERRED(tg !=3D &root_task_group);
 		return NULL;
 	}
=20
@@ -723,7 +723,7 @@ static void __disable_runtime(struct rq *rq)
 		 * We cannot be left wanting - that would mean some runtime
 		 * leaked out of the system.
 		 */
-		WARN_ON_ONCE(want);
+		WARN_ON_ONCE_DEFERRED(want);
 balanced:
 		/*
 		 * Disable all the borrow logic by pretending we have inf
@@ -1094,7 +1094,7 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
=20
 	if (rt_rq->rt_nr_running) {
=20
-		WARN_ON(prio < prev_prio);
+		WARN_ON_DEFERRED(prio < prev_prio);
=20
 		/*
 		 * This may have been our highest task, and therefore
@@ -1131,7 +1131,7 @@ dec_rt_group(struct sched_rt_entity *rt_se, struct rt=
_rq *rt_rq)
 	if (rt_se_boosted(rt_se))
 		rt_rq->rt_nr_boosted--;
=20
-	WARN_ON(!rt_rq->rt_nr_running && rt_rq->rt_nr_boosted);
+	WARN_ON_DEFERRED(!rt_rq->rt_nr_running && rt_rq->rt_nr_boosted);
 }
=20
 #else /* !CONFIG_RT_GROUP_SCHED: */
@@ -1176,7 +1176,7 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, stru=
ct rt_rq *rt_rq)
 {
 	int prio =3D rt_se_prio(rt_se);
=20
-	WARN_ON(!rt_prio(prio));
+	WARN_ON_DEFERRED(!rt_prio(prio));
 	rt_rq->rt_nr_running +=3D rt_se_nr_running(rt_se);
 	rt_rq->rr_nr_running +=3D rt_se_rr_nr_running(rt_se);
=20
@@ -1187,8 +1187,8 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, stru=
ct rt_rq *rt_rq)
 static inline
 void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
-	WARN_ON(!rt_prio(rt_se_prio(rt_se)));
-	WARN_ON(!rt_rq->rt_nr_running);
+	WARN_ON_DEFERRED(!rt_prio(rt_se_prio(rt_se)));
+	WARN_ON_DEFERRED(!rt_rq->rt_nr_running);
 	rt_rq->rt_nr_running -=3D rt_se_nr_running(rt_se);
 	rt_rq->rr_nr_running -=3D rt_se_rr_nr_running(rt_se);
=20
@@ -1348,7 +1348,7 @@ static void __enqueue_rt_entity(struct sched_rt_entit=
y *rt_se, unsigned int flag
 	}
=20
 	if (move_entity(flags)) {
-		WARN_ON_ONCE(rt_se->on_list);
+		WARN_ON_ONCE_DEFERRED(rt_se->on_list);
 		if (flags & ENQUEUE_HEAD)
 			list_add(&rt_se->run_list, queue);
 		else
@@ -1368,7 +1368,7 @@ static void __dequeue_rt_entity(struct sched_rt_entit=
y *rt_se, unsigned int flag
 	struct rt_prio_array *array =3D &rt_rq->active;
=20
 	if (move_entity(flags)) {
-		WARN_ON_ONCE(!rt_se->on_list);
+		WARN_ON_ONCE_DEFERRED(!rt_se->on_list);
 		__delist_rt_entity(rt_se, array);
 	}
 	rt_se->on_rq =3D 0;
@@ -1684,7 +1684,7 @@ static struct sched_rt_entity *pick_next_rt_entity(st=
ruct rt_rq *rt_rq)
 	BUG_ON(idx >=3D MAX_RT_PRIO);
=20
 	queue =3D array->queue + idx;
-	if (WARN_ON_ONCE(list_empty(queue)))
+	if (WARN_ON_ONCE_DEFERRED(list_empty(queue)))
 		return NULL;
 	next =3D list_entry(queue->next, struct sched_rt_entity, run_list);
=20
@@ -2016,7 +2016,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		return 0;
 	}
=20
-	if (WARN_ON(next_task =3D=3D rq->curr))
+	if (WARN_ON_DEFERRED(next_task =3D=3D rq->curr))
 		return 0;
=20
 	/* We might release rq lock */
@@ -2316,8 +2316,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * the to-be-scheduled task?
 		 */
 		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
-			WARN_ON(p =3D=3D src_rq->curr);
-			WARN_ON(!task_on_rq_queued(p));
+			WARN_ON_DEFERRED(p =3D=3D src_rq->curr);
+			WARN_ON_DEFERRED(!task_on_rq_queued(p));
=20
 			/*
 			 * There's a chance that p is higher in priority
@@ -2583,7 +2583,7 @@ static int task_is_throttled_rt(struct task_struct *p=
, int cpu)
=20
 #ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched=
_rt_period_rt_rq
 	rt_rq =3D task_group(p)->rt_rq[cpu];
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_group);
+	WARN_ON_DEFERRED(!rt_group_sched_enabled() && rt_rq->tg !=3D &root_task_g=
roup);
 #else
 	rt_rq =3D &cpu_rq(cpu)->rt;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d1..f74f9cd44e098 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1684,7 +1684,7 @@ static inline void update_idle_core(struct rq *rq) { }
=20
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
-	WARN_ON_ONCE(!entity_is_task(se));
+	WARN_ON_ONCE_DEFERRED(!entity_is_task(se));
 	return container_of(se, struct task_struct, se);
 }
=20
@@ -1766,7 +1766,7 @@ static inline void assert_clock_updated(struct rq *rq)
 	 * The only reason for not seeing a clock update since the
 	 * last rq_pin_lock() is if we're currently skipping updates.
 	 */
-	WARN_ON_ONCE(rq->clock_update_flags < RQCF_ACT_SKIP);
+	WARN_ON_ONCE_DEFERRED(rq->clock_update_flags < RQCF_ACT_SKIP);
 }
=20
 static inline u64 rq_clock(struct rq *rq)
@@ -1813,7 +1813,7 @@ static inline void rq_clock_cancel_skipupdate(struct =
rq *rq)
 static inline void rq_clock_start_loop_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
-	WARN_ON_ONCE(rq->clock_update_flags & RQCF_ACT_SKIP);
+	WARN_ON_ONCE_DEFERRED(rq->clock_update_flags & RQCF_ACT_SKIP);
 	rq->clock_update_flags |=3D RQCF_ACT_SKIP;
 }
=20
@@ -1870,9 +1870,9 @@ static inline void scx_rq_clock_invalidate(struct rq =
*rq) {}
=20
 static inline void assert_balance_callbacks_empty(struct rq *rq)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_LOCKING) &&
-		     rq->balance_callback &&
-		     rq->balance_callback !=3D &balance_push_callback);
+	WARN_ON_ONCE_DEFERRED(IS_ENABLED(CONFIG_PROVE_LOCKING) &&
+			      rq->balance_callback &&
+			      rq->balance_callback !=3D &balance_push_callback);
 }
=20
 /*
@@ -2681,7 +2681,7 @@ struct sched_class {
=20
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->donor !=3D prev);
+	WARN_ON_ONCE_DEFERRED(rq->donor !=3D prev);
 	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
=20
@@ -2704,7 +2704,7 @@ static inline void put_prev_set_next_task(struct rq *=
rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->donor !=3D prev);
+	WARN_ON_ONCE_DEFERRED(rq->donor !=3D prev);
=20
 	__put_prev_set_next_dl_server(rq, prev, next);
=20
@@ -3030,7 +3030,7 @@ static inline void attach_task(struct rq *rq, struct =
task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
=20
-	WARN_ON_ONCE(task_rq(p) !=3D rq);
+	WARN_ON_ONCE_DEFERRED(task_rq(p) !=3D rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	wakeup_preempt(rq, p, 0);
 }
--=20
2.53.0

