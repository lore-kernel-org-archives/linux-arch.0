Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43956 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 23:35:17 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for suspend / kexec freeze
Date: Thu, 11 Apr 2019 13:34:46 +1000
Message-ID: <20190411033448.20842-4-npiggin@gmail.com>
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190411033446.YYc7Q_Nm6EvTncXAEWOE3zhYW0-HUVZri0NoPQfevPs@z>

This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
opt-in to allowing suspend to occur on one of the housekeeping CPUs
rather than hardcoded CPU0.

This will allow CPU0 to be a nohz_full CPU with a later change.

It may be possible for platforms with hardware/firmware restrictions
on suspend/wake effectively support this by handing off the final
stage to CPU0 when kernel housekeeping is no longer required. Another
option is to make housekeeping / nohz_full mask dynamic at runtime,
but the complexity could not be justified at this time.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig |  4 ++++
 include/linux/cpu.h  |  7 ++++++-
 kernel/cpu.c         | 10 +++++++++-
 kernel/power/Kconfig |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..bc98b0e37a10 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -318,6 +318,10 @@ config ARCH_SUSPEND_POSSIBLE
 		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
+config ARCH_SUSPEND_NONZERO_CPU
+	def_bool y
+	depends on PPC_POWERNV || PPC_PSERIES
+
 config PPC_DCR_NATIVE
 	bool
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 563e697e7779..dd3813959d62 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -140,7 +140,12 @@ extern void enable_nonboot_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
-	return freeze_secondary_cpus(0);
+	int cpu = 0;
+
+	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU))
+		cpu = -1;
+
+	return freeze_secondary_cpus(cpu);
 }
 static inline void suspend_enable_secondary_cpus(void)
 {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6754f3ecfd94..d1bf6e2b4752 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -9,6 +9,7 @@
 #include <linux/notifier.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/hotplug.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/task.h>
 #include <linux/sched/smt.h>
 #include <linux/unistd.h>
@@ -1199,8 +1200,15 @@ int freeze_secondary_cpus(int primary)
 	int cpu, error = 0;
 
 	cpu_maps_update_begin();
-	if (!cpu_online(primary))
+	if (primary == -1) {
 		primary = cpumask_first(cpu_online_mask);
+		if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
+			primary = housekeeping_any_cpu(HK_FLAG_TIMER);
+	} else {
+		if (!cpu_online(primary))
+			primary = cpumask_first(cpu_online_mask);
+	}
+
 	/*
 	 * We take down all of the non-boot CPUs in one shot to avoid races
 	 * with the userspace trying to use the CPU hotplug at the same time
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index f8fe57d1022e..9bbaaab14b36 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -114,6 +114,15 @@ config PM_SLEEP_SMP
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 
+config PM_SLEEP_SMP_NONZERO_CPU
+	def_bool y
+	depends on PM_SLEEP_SMP
+	depends on ARCH_SUSPEND_NONZERO_CPU
+	---help---
+	If an arch can suspend (for suspend, hibernate, kexec, etc) on a
+	non-zero numbered CPU, it may define ARCH_SUSPEND_NONZERO_CPU. This
+	will allow nohz_full mask to include CPU0.
+
 config PM_AUTOSLEEP
 	bool "Opportunistic sleep"
 	depends on PM_SLEEP
-- 
2.20.1
