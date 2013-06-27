Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:58767 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab3F0T54 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 15:57:56 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 28 Jun 2013 01:20:52 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 12/45] migration: Use raw_spin_lock/unlock since interrupts
 are already disabled
Date: Fri, 28 Jun 2013 01:24:32 +0530
Message-ID: <20130627195432.29830.52228.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com, vincent.guittot@linaro.org, laijs@cn.fujitsu.com, David.Laight@aculab.com
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20130627195432.uZaILY0H-_ldq9RGn5dF78ALwk8tEKQQBk5FE_aRNyU@z>

We need not use the raw_spin_lock_irqsave/restore primitives because
all CPU_DYING notifiers run with interrupts disabled. So just use
raw_spin_lock/unlock.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9d870bf..ad8a554 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4675,14 +4675,14 @@ migration_call(struct notifier_block *nfb, unsigned long action, void *hcpu)
 	case CPU_DYING:
 		sched_ttwu_pending();
 		/* Update our root-domain */
-		raw_spin_lock_irqsave(&rq->lock, flags);
+		raw_spin_lock(&rq->lock); /* IRQs already disabled */
 		if (rq->rd) {
 			BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 			set_rq_offline(rq);
 		}
 		migrate_tasks(cpu);
 		BUG_ON(rq->nr_running != 1); /* the migration thread */
-		raw_spin_unlock_irqrestore(&rq->lock, flags);
+		raw_spin_unlock(&rq->lock);
 		break;
 
 	case CPU_DEAD:

