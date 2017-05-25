From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/4] watchdog: split out config options
Date: Thu, 25 May 2017 18:28:55 +1000
Message-ID: <20170525082856.21685-4-npiggin@gmail.com>
References: <20170525082856.21685-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33374 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbdEYI3Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2017 04:29:16 -0400
In-Reply-To: <20170525082856.21685-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Split SOFTLOCKUP_DETECTOR from LOCKUP_DETECTOR, and split
HARDLOCKUP_DETECTOR_PERF from HARDLOCKUP_DETECTOR.

LOCKUP_DETECTOR provides the boot, sysctl, and programming interfaces
for lockup detectors. An architecture that defines HAVE_NMI_WATCHDOG
need not use this this if it has a very basic watchdog or uses its own
options and interfaces (e.g., sparc). touch_nmi_watchdog() will
continue to call their arch_touch_nmi_watchdog().

HARDLOCKUP_DETECTOR_PERF is the perf-based lockup detector.

HARDLOCKUP_DETECTOR is the framework for arch NMI_WATCHDOG hard lockup
detectors that conform to the LOCKUP_DETECTOR interfaces.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c |   2 +-
 arch/x86/kernel/apic/hw_nmi.c  |   2 +-
 include/linux/nmi.h            |  35 ++++--
 kernel/Makefile                |   2 +-
 kernel/sysctl.c                |  18 ++--
 kernel/watchdog.c              | 238 ++++++++++++++++++++++++++---------------
 kernel/watchdog_hld.c          |  32 ------
 lib/Kconfig.debug              |  27 +++--
 8 files changed, 212 insertions(+), 144 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f35ff9dea4fb..ab650905f75a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -727,7 +727,7 @@ struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh)
 {
 	return ppc_proc_freq * watchdog_thresh;
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index c73c9fb281e1..d6f387780849 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh)
 {
 	return (u64)(cpu_khz) * 1000 * watchdog_thresh;
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 6ea465a842a1..c11dc695fb0b 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -11,13 +11,21 @@
 #endif
 
 #ifdef CONFIG_LOCKUP_DETECTOR
+void lockup_detector_init(void);
+#else
+static inline void lockup_detector_init(void)
+{
+}
+#endif
+
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
 extern void touch_softlockup_watchdog_sched(void);
 extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
-extern unsigned int  hardlockup_panic;
-void lockup_detector_init(void);
+extern int soft_watchdog_enabled;
+extern atomic_t watchdog_park_in_progress;
 #else
 static inline void touch_softlockup_watchdog_sched(void)
 {
@@ -31,9 +39,6 @@ static inline void touch_softlockup_watchdog_sync(void)
 static inline void touch_all_softlockup_watchdogs(void)
 {
 }
-static inline void lockup_detector_init(void)
-{
-}
 #endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK
@@ -61,14 +66,19 @@ static inline void reset_hung_task_detector(void)
 #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
 #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR)
-extern void hld_touch_nmi_watchdog(void);
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 extern void hardlockup_detector_disable(void);
+extern unsigned int hardlockup_panic;
 #else
-static inline void hld_touch_nmi_watchdog(void) {}
 static inline void hardlockup_detector_disable(void) {}
 #endif
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+extern void hld_touch_nmi_watchdog(void);
+#else
+static inline void hld_touch_nmi_watchdog(void) {}
+#endif
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  * 
@@ -140,15 +150,18 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 }
 #endif
 
-#ifdef CONFIG_LOCKUP_DETECTOR
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
+#endif
+
+#ifdef CONFIG_LOCKUP_DETECTOR
 extern int nmi_watchdog_enabled;
-extern int soft_watchdog_enabled;
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
 extern unsigned long watchdog_enabled;
+extern struct cpumask watchdog_cpumask;
 extern unsigned long *watchdog_cpumask_bits;
-extern atomic_t watchdog_park_in_progress;
+extern int __read_mostly watchdog_suspended;
 #ifdef CONFIG_SMP
 extern int sysctl_softlockup_all_cpu_backtrace;
 extern int sysctl_hardlockup_all_cpu_backtrace;
diff --git a/kernel/Makefile b/kernel/Makefile
index 72aa080f91f0..4cb8e8b23c6e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR) += watchdog_hld.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 4dfba1a76cc3..fa37faa89143 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -873,13 +873,21 @@ static struct ctl_table kern_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_nmi_watchdog,
 		.extra1		= &zero,
-#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 		.extra2		= &one,
 #else
 		.extra2		= &zero,
 #endif
 	},
 	{
+		.procname	= "watchdog_cpumask",
+		.data		= &watchdog_cpumask_bits,
+		.maxlen		= NR_CPUS,
+		.mode		= 0644,
+		.proc_handler	= proc_watchdog_cpumask,
+	},
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	{
 		.procname       = "soft_watchdog",
 		.data           = &soft_watchdog_enabled,
 		.maxlen         = sizeof (int),
@@ -889,13 +897,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one,
 	},
 	{
-		.procname	= "watchdog_cpumask",
-		.data		= &watchdog_cpumask_bits,
-		.maxlen		= NR_CPUS,
-		.mode		= 0644,
-		.proc_handler	= proc_watchdog_cpumask,
-	},
-	{
 		.procname	= "softlockup_panic",
 		.data		= &softlockup_panic,
 		.maxlen		= sizeof(int),
@@ -904,6 +905,7 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
+#endif
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 	{
 		.procname	= "hardlockup_panic",
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 03e0b69bb5bf..deb010505646 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -29,15 +29,55 @@
 #include <linux/kvm_para.h>
 #include <linux/kthread.h>
 
+/* Watchdog configuration */
 static DEFINE_MUTEX(watchdog_proc_mutex);
 
-#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
+int __read_mostly nmi_watchdog_enabled;
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
+
+/* boot commands */
+/*
+ * Should we panic when a soft-lockup or hard-lockup occurs:
+ */
+unsigned int __read_mostly hardlockup_panic =
+			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
+/*
+ * We may not want to enable hard lockup detection by default in all cases,
+ * for example when running the kernel as a guest on a hypervisor. In these
+ * cases this function can be called to disable hard lockup detection. This
+ * function should only be executed once by the boot processor before the
+ * kernel command line parameters are parsed, because otherwise it is not
+ * possible to override this in hardlockup_panic_setup().
+ */
+void hardlockup_detector_disable(void)
+{
+	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
+}
+
+static int __init hardlockup_panic_setup(char *str)
+{
+	if (!strncmp(str, "panic", 5))
+		hardlockup_panic = 1;
+	else if (!strncmp(str, "nopanic", 7))
+		hardlockup_panic = 0;
+	else if (!strncmp(str, "0", 1))
+		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
+	else if (!strncmp(str, "1", 1))
+		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
+	return 1;
+}
+__setup("nmi_watchdog=", hardlockup_panic_setup);
+
 #else
 unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
 #endif
-int __read_mostly nmi_watchdog_enabled;
+
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
 int __read_mostly soft_watchdog_enabled;
+#endif
+
 int __read_mostly watchdog_user_enabled;
 int __read_mostly watchdog_thresh = 10;
 
@@ -45,15 +85,9 @@ int __read_mostly watchdog_thresh = 10;
 int __read_mostly sysctl_softlockup_all_cpu_backtrace;
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
 #endif
-static struct cpumask watchdog_cpumask __read_mostly;
+struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
-/* Helper for online, unparked cpus. */
-#define for_each_watchdog_cpu(cpu) \
-	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
-
-atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
-
 /*
  * The 'watchdog_running' variable is set to 1 when the watchdog threads
  * are registered/started and is set to 0 when the watchdog threads are
@@ -72,7 +106,27 @@ static int __read_mostly watchdog_running;
  * of 'watchdog_running' cannot change while the watchdog is deactivated
  * temporarily (see related code in 'proc' handlers).
  */
-static int __read_mostly watchdog_suspended;
+int __read_mostly watchdog_suspended;
+
+/*
+ * These functions can be overridden if an architecture implements its
+ * own hardlockup detector.
+ */
+int __weak watchdog_nmi_enable(unsigned int cpu)
+{
+	return 0;
+}
+void __weak watchdog_nmi_disable(unsigned int cpu)
+{
+}
+
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+
+/* Helper for online, unparked cpus. */
+#define for_each_watchdog_cpu(cpu) \
+	for_each_cpu_and((cpu), cpu_online_mask, &watchdog_cpumask)
+
+atomic_t watchdog_park_in_progress = ATOMIC_INIT(0);
 
 static u64 __read_mostly sample_period;
 
@@ -120,6 +174,7 @@ static int __init softlockup_all_cpu_backtrace_setup(char *str)
 	return 1;
 }
 __setup("softlockup_all_cpu_backtrace=", softlockup_all_cpu_backtrace_setup);
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
 static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 {
 	sysctl_hardlockup_all_cpu_backtrace =
@@ -128,6 +183,7 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
 }
 __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
 #endif
+#endif
 
 /*
  * Hard-lockup warnings should be triggered after just a few seconds. Soft-
@@ -213,18 +269,6 @@ void touch_softlockup_watchdog_sync(void)
 	__this_cpu_write(watchdog_touch_ts, 0);
 }
 
-/* watchdog detector functions */
-bool is_hardlockup(void)
-{
-	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
-
-	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
-		return true;
-
-	__this_cpu_write(hrtimer_interrupts_saved, hrint);
-	return false;
-}
-
 static int is_softlockup(unsigned long touch_ts)
 {
 	unsigned long now = get_timestamp();
@@ -237,21 +281,21 @@ static int is_softlockup(unsigned long touch_ts)
 	return 0;
 }
 
-static void watchdog_interrupt_count(void)
+/* watchdog detector functions */
+bool is_hardlockup(void)
 {
-	__this_cpu_inc(hrtimer_interrupts);
-}
+	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
 
-/*
- * These two functions are mostly architecture specific
- * defining them as weak here.
- */
-int __weak watchdog_nmi_enable(unsigned int cpu)
-{
-	return 0;
+	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
+		return true;
+
+	__this_cpu_write(hrtimer_interrupts_saved, hrint);
+	return false;
 }
-void __weak watchdog_nmi_disable(unsigned int cpu)
+
+static void watchdog_interrupt_count(void)
 {
+	__this_cpu_inc(hrtimer_interrupts);
 }
 
 static int watchdog_enable_all_cpus(void);
@@ -502,57 +546,6 @@ static void watchdog_unpark_threads(void)
 		kthread_unpark(per_cpu(softlockup_watchdog, cpu));
 }
 
-/*
- * Suspend the hard and soft lockup detector by parking the watchdog threads.
- */
-int lockup_detector_suspend(void)
-{
-	int ret = 0;
-
-	get_online_cpus();
-	mutex_lock(&watchdog_proc_mutex);
-	/*
-	 * Multiple suspend requests can be active in parallel (counted by
-	 * the 'watchdog_suspended' variable). If the watchdog threads are
-	 * running, the first caller takes care that they will be parked.
-	 * The state of 'watchdog_running' cannot change while a suspend
-	 * request is active (see related code in 'proc' handlers).
-	 */
-	if (watchdog_running && !watchdog_suspended)
-		ret = watchdog_park_threads();
-
-	if (ret == 0)
-		watchdog_suspended++;
-	else {
-		watchdog_disable_all_cpus();
-		pr_err("Failed to suspend lockup detectors, disabled\n");
-		watchdog_enabled = 0;
-	}
-
-	mutex_unlock(&watchdog_proc_mutex);
-
-	return ret;
-}
-
-/*
- * Resume the hard and soft lockup detector by unparking the watchdog threads.
- */
-void lockup_detector_resume(void)
-{
-	mutex_lock(&watchdog_proc_mutex);
-
-	watchdog_suspended--;
-	/*
-	 * The watchdog threads are unparked if they were previously running
-	 * and if there is no more active suspend request.
-	 */
-	if (watchdog_running && !watchdog_suspended)
-		watchdog_unpark_threads();
-
-	mutex_unlock(&watchdog_proc_mutex);
-	put_online_cpus();
-}
-
 static int update_watchdog_all_cpus(void)
 {
 	int ret;
@@ -604,6 +597,81 @@ static void watchdog_disable_all_cpus(void)
 	}
 }
 
+#else /* SOFTLOCKUP */
+static int watchdog_park_threads(void)
+{
+	return 0;
+}
+
+static void watchdog_unpark_threads(void)
+{
+}
+
+static int watchdog_enable_all_cpus(void)
+{
+	return 0;
+}
+
+static void watchdog_disable_all_cpus(void)
+{
+}
+
+static void set_sample_period(void)
+{
+}
+#endif /* SOFTLOCKUP */
+
+/*
+ * Suspend the hard and soft lockup detector by parking the watchdog threads.
+ */
+int lockup_detector_suspend(void)
+{
+	int ret = 0;
+
+	get_online_cpus();
+	mutex_lock(&watchdog_proc_mutex);
+	/*
+	 * Multiple suspend requests can be active in parallel (counted by
+	 * the 'watchdog_suspended' variable). If the watchdog threads are
+	 * running, the first caller takes care that they will be parked.
+	 * The state of 'watchdog_running' cannot change while a suspend
+	 * request is active (see related code in 'proc' handlers).
+	 */
+	if (watchdog_running && !watchdog_suspended)
+		ret = watchdog_park_threads();
+
+	if (ret == 0)
+		watchdog_suspended++;
+	else {
+		watchdog_disable_all_cpus();
+		pr_err("Failed to suspend lockup detectors, disabled\n");
+		watchdog_enabled = 0;
+	}
+
+	mutex_unlock(&watchdog_proc_mutex);
+
+	return ret;
+}
+
+/*
+ * Resume the hard and soft lockup detector by unparking the watchdog threads.
+ */
+void lockup_detector_resume(void)
+{
+	mutex_lock(&watchdog_proc_mutex);
+
+	watchdog_suspended--;
+	/*
+	 * The watchdog threads are unparked if they were previously running
+	 * and if there is no more active suspend request.
+	 */
+	if (watchdog_running && !watchdog_suspended)
+		watchdog_unpark_threads();
+
+	mutex_unlock(&watchdog_proc_mutex);
+	put_online_cpus();
+}
+
 #ifdef CONFIG_SYSCTL
 
 /*
@@ -810,9 +878,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 			 * a temporary cpumask, so we are likely not in a
 			 * position to do much else to make things better.
 			 */
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
 			if (smpboot_update_cpumask_percpu_thread(
 				    &watchdog_threads, &watchdog_cpumask) != 0)
 				pr_err("cpumask update failed\n");
+#endif
 		}
 	}
 out:
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index e0d7a7c43fb5..ffd4fa59fbde 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -22,39 +22,7 @@ static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
 static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
 
-/* boot commands */
-/*
- * Should we panic when a soft-lockup or hard-lockup occurs:
- */
-unsigned int __read_mostly hardlockup_panic =
-			CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE;
 static unsigned long hardlockup_allcpu_dumped;
-/*
- * We may not want to enable hard lockup detection by default in all cases,
- * for example when running the kernel as a guest on a hypervisor. In these
- * cases this function can be called to disable hard lockup detection. This
- * function should only be executed once by the boot processor before the
- * kernel command line parameters are parsed, because otherwise it is not
- * possible to override this in hardlockup_panic_setup().
- */
-void hardlockup_detector_disable(void)
-{
-	watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
-}
-
-static int __init hardlockup_panic_setup(char *str)
-{
-	if (!strncmp(str, "panic", 5))
-		hardlockup_panic = 1;
-	else if (!strncmp(str, "nopanic", 7))
-		hardlockup_panic = 0;
-	else if (!strncmp(str, "0", 1))
-		watchdog_enabled &= ~NMI_WATCHDOG_ENABLED;
-	else if (!strncmp(str, "1", 1))
-		watchdog_enabled |= NMI_WATCHDOG_ENABLED;
-	return 1;
-}
-__setup("nmi_watchdog=", hardlockup_panic_setup);
 
 void hld_touch_nmi_watchdog(void)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e4587ebe52c7..74d5ad667426 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -801,10 +801,25 @@ config LOCKUP_DETECTOR
 	  The frequency of hrtimer and NMI events and the soft and hard lockup
 	  thresholds can be controlled through the sysctl watchdog_thresh.
 
+config SOFTLOCKUP_DETECTOR
+	bool "Detect Soft Lockups"
+	depends on LOCKUP_DETECTOR
+
+config HARDLOCKUP_DETECTOR_PERF
+	bool
+	select SOFTLOCKUP_DETECTOR
+
+#
+# arch/ can define HAVE_NMI_WATCHDOG to provide their own NMI watchdog
+# rather than the perf based detector.
+#
+# The arch may do its own thing, or select HARDLOCKUP_DETECTOR, which
+#
 config HARDLOCKUP_DETECTOR
-	def_bool y
-	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
-	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	bool "Detect Hard Lockups"
+	depends on LOCKUP_DETECTOR
+	depends on !HAVE_NMI_WATCHDOG || (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)
+	select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG
 
 config BOOTPARAM_HARDLOCKUP_PANIC
 	bool "Panic (Reboot) On Hard Lockups"
@@ -826,7 +841,7 @@ config BOOTPARAM_HARDLOCKUP_PANIC_VALUE
 
 config BOOTPARAM_SOFTLOCKUP_PANIC
 	bool "Panic (Reboot) On Soft Lockups"
-	depends on LOCKUP_DETECTOR
+	depends on SOFTLOCKUP_DETECTOR
 	help
 	  Say Y here to enable the kernel to panic on "soft lockups",
 	  which are bugs that cause the kernel to loop in kernel
@@ -843,7 +858,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
 
 config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
 	int
-	depends on LOCKUP_DETECTOR
+	depends on SOFTLOCKUP_DETECTOR
 	range 0 1
 	default 0 if !BOOTPARAM_SOFTLOCKUP_PANIC
 	default 1 if BOOTPARAM_SOFTLOCKUP_PANIC
@@ -851,7 +866,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC_VALUE
 config DETECT_HUNG_TASK
 	bool "Detect Hung Tasks"
 	depends on DEBUG_KERNEL
-	default LOCKUP_DETECTOR
+	default SOFTLOCKUP_DETECTOR
 	help
 	  Say Y here to enable the kernel to detect "hung tasks",
 	  which are bugs that cause the task to be stuck in
-- 
2.11.0
