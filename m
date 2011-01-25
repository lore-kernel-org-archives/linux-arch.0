From: akpm@linux-foundation.org
Subject: [patch 23/23] kthread: use kthread_create_on_node()
Date: Tue, 25 Jan 2011 15:07:40 -0800
Message-ID: <201101252307.p0PN7exP013507@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40775 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679Ab1AYXIu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 25 Jan 2011 18:08:50 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, eric.dumazet@gmail.com, ak@linux.intel.com, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

From: Eric Dumazet <eric.dumazet@gmail.com>

ksoftirqd, kworker, migration, and pktgend kthreads can be created with
kthread_create_on_node(), to get proper NUMA affinities for their stack and
task_struct.

Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/softirq.c      |    5 ++++-
 kernel/stop_machine.c |    6 ++++--
 kernel/workqueue.c    |    6 ++++--
 net/core/pktgen.c     |    5 ++++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff -puN kernel/softirq.c~kthread-use-kthread_create_on_cpu kernel/softirq.c
--- a/kernel/softirq.c~kthread-use-kthread_create_on_cpu
+++ a/kernel/softirq.c
@@ -831,7 +831,10 @@ static int __cpuinit cpu_callback(struct
 	switch (action) {
 	case CPU_UP_PREPARE:
 	case CPU_UP_PREPARE_FROZEN:
-		p = kthread_create(run_ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create_on_node(run_ksoftirqd,
+					   hcpu,
+					   cpu_to_node(hotcpu),
+					   "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return notifier_from_errno(PTR_ERR(p));
diff -puN kernel/stop_machine.c~kthread-use-kthread_create_on_cpu kernel/stop_machine.c
--- a/kernel/stop_machine.c~kthread-use-kthread_create_on_cpu
+++ a/kernel/stop_machine.c
@@ -301,8 +301,10 @@ static int __cpuinit cpu_stop_cpu_callba
 	case CPU_UP_PREPARE:
 		BUG_ON(stopper->thread || stopper->enabled ||
 		       !list_empty(&stopper->works));
-		p = kthread_create(cpu_stopper_thread, stopper, "migration/%d",
-				   cpu);
+		p = kthread_create_on_node(cpu_stopper_thread,
+					   stopper,
+					   cpu_to_node(cpu),
+					   "migration/%d", cpu);
 		if (IS_ERR(p))
 			return notifier_from_errno(PTR_ERR(p));
 		get_task_struct(p);
diff -puN kernel/workqueue.c~kthread-use-kthread_create_on_cpu kernel/workqueue.c
--- a/kernel/workqueue.c~kthread-use-kthread_create_on_cpu
+++ a/kernel/workqueue.c
@@ -1356,8 +1356,10 @@ static struct worker *create_worker(stru
 	worker->id = id;
 
 	if (!on_unbound_cpu)
-		worker->task = kthread_create(worker_thread, worker,
-					      "kworker/%u:%d", gcwq->cpu, id);
+		worker->task = kthread_create_on_node(worker_thread,
+						      worker,
+						      cpu_to_node(gcwq->cpu),
+						      "kworker/%u:%d", gcwq->cpu, id);
 	else
 		worker->task = kthread_create(worker_thread, worker,
 					      "kworker/u:%d", id);
diff -puN net/core/pktgen.c~kthread-use-kthread_create_on_cpu net/core/pktgen.c
--- a/net/core/pktgen.c~kthread-use-kthread_create_on_cpu
+++ a/net/core/pktgen.c
@@ -3812,7 +3812,10 @@ static int __init pktgen_create_thread(i
 	list_add_tail(&t->th_list, &pktgen_threads);
 	init_completion(&t->start_done);
 
-	p = kthread_create(pktgen_thread_worker, t, "kpktgend_%d", cpu);
+	p = kthread_create_on_node(pktgen_thread_worker,
+				   t,
+				   cpu_to_node(cpu),
+				   "kpktgend_%d", cpu);
 	if (IS_ERR(p)) {
 		pr_err("kernel_thread() failed for cpu %d\n", t->cpu);
 		list_del(&t->th_list);
_
