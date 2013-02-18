Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:50682 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab3BRMmW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2013 07:42:22 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 18 Feb 2013 18:09:34 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 14/46] sched/rt: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Date: Mon, 18 Feb 2013 18:10:13 +0530
Message-ID: <20130218124012.26245.44243.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, walken@google.com, vincent.guittot@linaro.org
Message-ID: <20130218124013.uN4S8olYlpSpy3RQWwgIFFbZBeeM3Zu3jaVLH8BfOQw@z>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/rt.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4f02b28..e546c98 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -26,7 +27,9 @@ static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		get_online_cpus_atomic();
 		idle = do_sched_rt_period_timer(rt_b, overrun);
+		put_online_cpus_atomic();
 	}
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;

