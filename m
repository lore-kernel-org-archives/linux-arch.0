From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/20] cpu/hotplug: Restructure cpu_up code
Date: Fri, 26 Feb 2016 18:43:24 -0000
Message-ID: <20160226182340.429389195@linutronix.de>
References: <20160226164321.657646833@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33386 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422889AbcBZSo5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 13:44:57 -0500
Content-Disposition: inline; filename=cpu-Restructure-cpu_down-code.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

Split out into separate functions, so we can convert it to a state machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/cpu.c |   69 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 22 deletions(-)

Index: b/kernel/cpu.c
===================================================================
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -228,6 +228,43 @@ static int cpu_notify(unsigned long val,
 	return __cpu_notify(val, cpu, -1, NULL);
 }
 
+/* Notifier wrappers for transitioning to state machine */
+static int notify_prepare(unsigned int cpu)
+{
+	int nr_calls = 0;
+	int ret;
+
+	ret = __cpu_notify(CPU_UP_PREPARE, cpu, -1, &nr_calls);
+	if (ret) {
+		nr_calls--;
+		printk(KERN_WARNING "%s: attempt to bring up CPU %u failed\n",
+				__func__, cpu);
+		__cpu_notify(CPU_UP_CANCELED, cpu, nr_calls, NULL);
+	}
+	return ret;
+}
+
+static int notify_online(unsigned int cpu)
+{
+	cpu_notify(CPU_ONLINE, cpu);
+	return 0;
+}
+
+static int bringup_cpu(unsigned int cpu)
+{
+	struct task_struct *idle = idle_thread_get(cpu);
+	int ret;
+
+	/* Arch-specific enabling code. */
+	ret = __cpu_up(cpu, idle);
+	if (ret) {
+		cpu_notify(CPU_UP_CANCELED, cpu);
+		return ret;
+	}
+	BUG_ON(!cpu_online(cpu));
+	return 0;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 static void cpu_notify_nofail(unsigned long val, unsigned int cpu)
@@ -481,7 +518,7 @@ void smpboot_thread_init(void)
 static int _cpu_up(unsigned int cpu, int tasks_frozen)
 {
 	struct task_struct *idle;
-	int ret, nr_calls = 0;
+	int ret;
 
 	cpu_hotplug_begin();
 
@@ -496,33 +533,21 @@ static int _cpu_up(unsigned int cpu, int
 		goto out;
 	}
 
+	cpuhp_tasks_frozen = tasks_frozen;
+
 	ret = smpboot_create_threads(cpu);
 	if (ret)
 		goto out;
 
-	cpuhp_tasks_frozen = tasks_frozen;
-
-	ret = __cpu_notify(CPU_UP_PREPARE, cpu, -1, &nr_calls);
-	if (ret) {
-		nr_calls--;
-		pr_warn("%s: attempt to bring up CPU %u failed\n",
-			__func__, cpu);
-		goto out_notify;
-	}
-
-	/* Arch-specific enabling code. */
-	ret = __cpu_up(cpu, idle);
-
-	if (ret != 0)
-		goto out_notify;
-	BUG_ON(!cpu_online(cpu));
+	ret = notify_prepare(cpu);
+	if (ret)
+		goto out;
 
-	/* Now call notifier in preparation. */
-	cpu_notify(CPU_ONLINE, cpu);
+	ret = bringup_cpu(cpu);
+	if (ret)
+		goto out;
 
-out_notify:
-	if (ret != 0)
-		__cpu_notify(CPU_UP_CANCELED, cpu, nr_calls, NULL);
+	notify_online(cpu);
 out:
 	cpu_hotplug_done();
 
