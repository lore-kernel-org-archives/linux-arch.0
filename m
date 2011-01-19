From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Wed, 19 Jan 2011 22:10:44 +0100
Message-ID: <1295471444.2653.16.camel@edumazet-laptop>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
	 <1293131522.2170.798.camel@laptop>
	 <20110119120756.cd554fb1.akpm@linux-foundation.org>
	 <1295468119.2653.2.camel@edumazet-laptop>
	 <20110119201716.GH22288@tassilo.jf.intel.com>
	 <1295468515.2653.4.camel@edumazet-laptop>
	 <20110119124411.864d9d97.akpm@linux-foundation.org>
	 <1295470247.2653.9.camel@edumazet-laptop>
	 <20110119125938.f6c9537a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51478 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1ASVKv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2011 16:10:51 -0500
Received: by ywl5 with SMTP id 5so556052ywl.19
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2011 13:10:50 -0800 (PST)
In-Reply-To: <20110119125938.f6c9537a.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

Le mercredi 19 janvier 2011 =C3=A0 12:59 -0800, Andrew Morton a =C3=A9c=
rit :
> On Wed, 19 Jan 2011 21:50:47 +0100
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > I surrender :)
>=20
> Does that mean we have a name ;)
>=20
> > I'll send a patch, or do you prefer I respin the 4 patches ?
>=20
> I can trivially edit the patches locally if it's just a rename.=20
> kthread_create_for_cpu() would do the trick, I suggest.
>=20
> If we decide on kthread_create_node(node_t) then that's a significant
> rework.
>=20
> I'm all worn out too and would be OK with either approach.

Well, I was just changing to kthread_create_on_node(), since it appears
one call site doesnt want the kthread_bind(p, cpu);
(kernel/workqueue.c :=20

if (bind && !on_unbound_cpu)
	kthread_bind(worker->task, gcwq->cpu);

So my idea of doing the kthread_bind() inside kthread_create_on_cpu() i=
s
not possible

Something like following patch on top of previous ones :

[PATCH] kthread: rename kthread_create_on_cpu()

People told me kthread_create_on_cpu() was a wrong name and prefer
kthread_create_on_node()

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org
---
 include/linux/kthread.h |   10 +++++-----
 kernel/kthread.c        |   27 +++++++++++++--------------
 kernel/softirq.c        |    6 ++++--
 kernel/stop_machine.c   |    6 ++++--
 kernel/workqueue.c      |    6 ++++--
 net/core/pktgen.c       |    6 ++++--
 6 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index ec54c17..6ec201d 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -4,14 +4,14 @@
 #include <linux/err.h>
 #include <linux/sched.h>
=20
-struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
-					  void *data,
-					  int cpu,
-					  const char namefmt[], ...)
+struct task_struct *kthread_create_on_node(int (*threadfn)(void *data)=
,
+					   void *data,
+					   int node,
+					   const char namefmt[], ...)
 	__attribute__((format(printf, 4, 5)));
=20
 #define kthread_create(threadfn, data, namefmt, arg...) \
-	kthread_create_on_cpu(threadfn, data, -1, namefmt, ##arg)
+	kthread_create_on_node(threadfn, data, -1, namefmt, ##arg)
=20
=20
 /**
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1819927..684ab3f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -27,7 +27,7 @@ struct kthread_create_info
 	/* Information passed to kthread() from kthreadd. */
 	int (*threadfn)(void *data);
 	void *data;
-	int cpu;
+	int node;
=20
 	/* Result passed back to kthread_create() from kthreadd. */
 	struct task_struct *result;
@@ -114,8 +114,7 @@ static void create_kthread(struct kthread_create_in=
fo *create)
 	int pid;
=20
 #ifdef CONFIG_NUMA
-	current->pref_node_fork =3D (create->cpu !=3D -1) ?
-		cpu_to_node(create->cpu) : -1;
+	current->pref_node_fork =3D create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
 	pid =3D kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCH=
LD);
@@ -126,18 +125,18 @@ static void create_kthread(struct kthread_create_=
info *create)
 }
=20
 /**
- * kthread_create_on_cpu - create a kthread.
+ * kthread_create_on_node - create a kthread.
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
- * @cpu: cpu number.
+ * @node: memory node number.
  * @namefmt: printf-style name for the thread.
  *
  * Description: This helper function creates and names a kernel
  * thread.  The thread will be stopped: use wake_up_process() to start
  * it.  See also kthread_run().
  *
- * If thread is going to be bound on a particular cpu, give its number
- * in @cpu, to get NUMA affinity for kthread stack, or else give -1.
+ * If thread is going to be bound on a particular cpu, give its node
+ * in @node, to get NUMA affinity for kthread stack, or else give -1.
  * When woken, the thread will run @threadfn() with @data as its
  * argument. @threadfn() can either call do_exit() directly if it is a
  * standalone thread for which noone will call kthread_stop(), or
@@ -147,17 +146,17 @@ static void create_kthread(struct kthread_create_=
info *create)
  *
  * Returns a task_struct or ERR_PTR(-ENOMEM).
  */
-struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
-					  void *data,
-					  int cpu,
-					  const char namefmt[],
-					  ...)
+struct task_struct *kthread_create_on_node(int (*threadfn)(void *data)=
,
+					   void *data,
+					   int node,
+					   const char namefmt[],
+					   ...)
 {
 	struct kthread_create_info create;
=20
 	create.threadfn =3D threadfn;
 	create.data =3D data;
-	create.cpu =3D cpu;
+	create.node =3D node;
 	init_completion(&create.done);
=20
 	spin_lock(&kthread_create_lock);
@@ -184,7 +183,7 @@ struct task_struct *kthread_create_on_cpu(int (*thr=
eadfn)(void *data),
 	}
 	return create.result;
 }
-EXPORT_SYMBOL(kthread_create_on_cpu);
+EXPORT_SYMBOL(kthread_create_on_node);
=20
 /**
  * kthread_bind - bind a just-created kthread to a cpu.
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 118c666..fec6796 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -831,8 +831,10 @@ static int __cpuinit cpu_callback(struct notifier_=
block *nfb,
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		p =3D kthread_create_on_cpu(run_ksoftirqd, hcpu, hotcpu,
-					  "ksoftirqd/%d", hotcpu);
+		p =3D kthread_create_on_node(run_ksoftirqd,
+					   hcpu,
+					   cpu_to_node(hotcpu),
+					   "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return notifier_from_errno(PTR_ERR(p));
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 7c0f287..e3516b2 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -301,8 +301,10 @@ static int __cpuinit cpu_stop_cpu_callback(struct =
notifier_block *nfb,
 	case CPU_UP_PREPARE:
 		BUG_ON(stopper->thread || stopper->enabled ||
 		       !list_empty(&stopper->works));
-		p =3D kthread_create_on_cpu(cpu_stopper_thread, stopper, cpu,
-					  "migration/%d", cpu);
+		p =3D kthread_create_on_node(cpu_stopper_thread,
+					   stopper,
+					   cpu_to_node(cpu),
+					   "migration/%d", cpu);
 		if (IS_ERR(p))
 			return notifier_from_errno(PTR_ERR(p));
 		get_task_struct(p);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2aa2d32..3ff90e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1352,8 +1352,10 @@ static struct worker *create_worker(struct globa=
l_cwq *gcwq, bool bind)
 	worker->id =3D id;
=20
 	if (!on_unbound_cpu)
-		worker->task =3D kthread_create_on_cpu(worker_thread, worker, gcwq->=
cpu,
-						     "kworker/%u:%d", gcwq->cpu, id);
+		worker->task =3D kthread_create_on_node(worker_thread,
+						      worker,
+						      cpu_to_node(gcwq->cpu),
+						      "kworker/%u:%d", gcwq->cpu, id);
 	else
 		worker->task =3D kthread_create(worker_thread, worker,
 					      "kworker/u:%d", id);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index e522e90..1f9d2e0 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3812,8 +3812,10 @@ static int __init pktgen_create_thread(int cpu)
 	list_add_tail(&t->th_list, &pktgen_threads);
 	init_completion(&t->start_done);
=20
-	p =3D kthread_create_on_cpu(pktgen_thread_worker, t, cpu,
-				  "kpktgend_%d", cpu);
+	p =3D kthread_create_on_node(pktgen_thread_worker,
+				   t,
+				   cpu_to_node(cpu),
+				   "kpktgend_%d", cpu);
 	if (IS_ERR(p)) {
 		pr_err("kernel_thread() failed for cpu %d\n", t->cpu);
 		list_del(&t->th_list);
