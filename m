From: Chen Yucong <slaoub@gmail.com>
Subject: [PATCH] cpu/hotplug: print warning message in proper places for online or offline cpu
Date: Wed,  4 May 2016 21:51:48 +0800
Message-ID: <1462369908-17395-1-git-send-email-slaoub@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35429 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbcEDNyp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 09:54:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: peterz@infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yucong <slaoub@gmail.com>

When we online or offline a CPU, unexpected errors may occur for
a number of reasons. So if a function called within _cpu_down() or
_cpu_up() returns a error code indicating a failed operation, the
warning message should be printed rather than fallow the failed
__cpu_notify().

Signed-off-by: Chen Yucong <slaoub@gmail.com>
---
 kernel/cpu.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3e3f6e4..b8a2d2a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -317,8 +317,8 @@ static int notify_prepare(unsigned int cpu)
 	ret = __cpu_notify(CPU_UP_PREPARE, cpu, -1, &nr_calls);
 	if (ret) {
 		nr_calls--;
-		printk(KERN_WARNING "%s: attempt to bring up CPU %u failed\n",
-				__func__, cpu);
+		pr_warn("%s: attempt to bring up CPU %u failed\n",
+			__func__, cpu);
 		__cpu_notify(CPU_UP_CANCELED, cpu, nr_calls, NULL);
 	}
 	return ret;
@@ -353,6 +353,8 @@ static int bringup_cpu(unsigned int cpu)
 	ret = __cpu_up(cpu, idle);
 	if (ret) {
 		cpu_notify(CPU_UP_CANCELED, cpu);
+		pr_warn("%s: attempt to bring up CPU %u failed\n",
+			__func__, cpu);
 		return ret;
 	}
 	ret = bringup_wait_for_ap(cpu);
@@ -662,7 +664,7 @@ static int notify_down_prepare(unsigned int cpu)
 		nr_calls--;
 		__cpu_notify(CPU_DOWN_FAILED, cpu, nr_calls, NULL);
 		pr_warn("%s: attempt to take down CPU %u failed\n",
-				__func__, cpu);
+			__func__, cpu);
 	}
 	return err;
 }
@@ -737,6 +739,8 @@ static int takedown_cpu(unsigned int cpu)
 		irq_unlock_sparse();
 		/* Unpark the hotplug thread so we can rollback there */
 		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		pr_warn("%s: attempt to take down CPU %u failed\n",
+			__func__, cpu);
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));
-- 
1.7.10.4
