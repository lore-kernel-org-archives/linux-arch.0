Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:48133 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab3FYUa5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 16:30:57 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 26 Jun 2013 06:21:28 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 13/45] timer: Use get/put_online_cpus_atomic() to prevent
 CPU offline
Date: Wed, 26 Jun 2013 01:57:31 +0530
Message-ID: <20130625202730.16593.35113.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com, vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20130625202731.FludiXrqPNGQOMp_zQ8nGyW4ikPb9AQim6910oOxcuQ@z>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/timer.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/timer.c b/kernel/timer.c
index 15ffdb3..5db594c 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -729,6 +729,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
 
+	get_online_cpus_atomic();
 	base = lock_timer_base(timer, &flags);
 
 	ret = detach_if_pending(timer, base, false);
@@ -768,6 +769,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 
 out_unlock:
 	spin_unlock_irqrestore(&base->lock, flags);
+	put_online_cpus_atomic();
 
 	return ret;
 }
@@ -926,6 +928,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(timer_pending(timer) || !timer->function);
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&base->lock, flags);
 	timer_set_base(timer, base);
 	debug_activate(timer, timer->expires);
@@ -940,6 +943,7 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	 */
 	wake_up_nohz_cpu(cpu);
 	spin_unlock_irqrestore(&base->lock, flags);
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL_GPL(add_timer_on);
 

