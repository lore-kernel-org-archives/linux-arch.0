Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org ([203.10.76.45]:35992 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264000AbUDVMgn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:36:43 -0400
Date: Thu, 22 Apr 2004 22:33:18 +1000
From: Anton Blanchard <anton@samba.org>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422123318.GX22027@krispykreme>
References: <1082636511.1332.34.camel@halo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082636511.1332.34.camel@halo>
To: Jan Glauber <glauber@gmx.de>
Cc: linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

 
Hi,

> I've been looking into the SMP call function stuff on different
> archs and found many different functions...
> 
> In the common code part there are 2 functions:
> smp_call_function()  	// call a function on all CPUs but my own
> on_each_cpu()		// call a function on all CPUs
> 
> Many archs need an additional function to call a function on a 
> specific CPU:

We noticed this too. Rusty created on_one_cpu below and had a generic
(but costly) implementation so architectures could switch across when they
wanted.

Anton

--

Name: on_one_cpu function
Author: Rusty Russell
Status: Booted on 2.6.5

Similar to on_each_cpu, this implements on_one_cpu.  For archs which
don't do it natively, it's implemented in terms of smp_call_function().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21074-linux-2.6.5/include/linux/smp.h .21074-linux-2.6.5.updated/include/linux/smp.h
--- .21074-linux-2.6.5/include/linux/smp.h	2004-03-12 07:57:26.000000000 +1100
+++ .21074-linux-2.6.5.updated/include/linux/smp.h	2004-04-05 16:21:20.000000000 +1000
@@ -8,6 +8,10 @@
 
 #include <linux/config.h>
 
+#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
+#define put_cpu()		preempt_enable()
+#define put_cpu_no_resched()	preempt_enable_no_resched()
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -69,6 +73,24 @@ static inline int on_each_cpu(void (*fun
 	return ret;
 }
 
+#ifndef __HAVE_ARCH_ON_ONE_CPU
+extern int __on_one_cpu(unsigned cpu, void (*func)(void *info), void *info);
+static inline int on_one_cpu(unsigned cpu,
+			     void (*func)(void *info), void *info)
+{
+	int ret;
+
+	if (cpu == get_cpu()) {
+		func(info);
+		ret = 0;
+	} else
+		ret = __on_one_cpu(cpu, func, info);
+	put_cpu();
+	return ret;
+}
+#endif
+
+
 /*
  * True once the per process idle is forked
  */
@@ -107,8 +129,4 @@ static inline void smp_send_reschedule(i
 
 #endif /* !SMP */
 
-#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
-#define put_cpu()		preempt_enable()
-#define put_cpu_no_resched()	preempt_enable_no_resched()
-
 #endif /* __LINUX_SMP_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21074-linux-2.6.5/kernel/sched.c .21074-linux-2.6.5.updated/kernel/sched.c
--- .21074-linux-2.6.5/kernel/sched.c	2004-04-05 09:04:48.000000000 +1000
+++ .21074-linux-2.6.5.updated/kernel/sched.c	2004-04-05 16:21:45.000000000 +1000
@@ -631,7 +631,29 @@ void kick_process(task_t *p)
 
 EXPORT_SYMBOL_GPL(kick_process);
 
-#endif
+#ifndef __HAVE_ARCH_ON_ONE_CPU
+struct which_cpu
+{
+	unsigned int cpu;
+	void (*func)(void *info);
+	void *info;
+};
+
+static void maybe_on_cpu(void *_which)
+{
+	struct which_cpu *which = _which;
+
+	if (smp_processor_id() == which->cpu)
+		which->func(which->info);
+}
+
+int __on_one_cpu(unsigned cpu, void (*func)(void *info), void *info)
+{
+	struct which_cpu which = { cpu, info };
+	return smp_call_function(maybe_on_cpu, &which, 1, 1);
+}
+#endif /* __HAVE_ARCH_ON_ONE_CPU */
+#endif /* CONFIG_SMP */
 
 /***
  * try_to_wake_up - wake up a thread
