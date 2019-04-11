Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36435 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 23:35:13 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/5] PM / suspend: add function to disable secondaries for suspend
Date: Thu, 11 Apr 2019 13:34:45 +1000
Message-ID: <20190411033448.20842-3-npiggin@gmail.com>
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190411033445.fNi0RgN6jQrm2g0kLn0g7fv2JwJcRmb-GNpxNkuWXqY@z>

This adds a function to disable secondary CPUs for suspend that are
not necessarily non-zero / non-boot CPUs. Platforms will be able to
use this to suspend using non-zero CPUs.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/linux/cpu.h      | 10 ++++++++++
 kernel/kexec_core.c      |  4 ++--
 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/suspend.c   |  4 ++--
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..563e697e7779 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -137,6 +137,16 @@ static inline int disable_nonboot_cpus(void)
 	return freeze_secondary_cpus(0);
 }
 extern void enable_nonboot_cpus(void);
+
+static inline int suspend_disable_secondary_cpus(void)
+{
+	return freeze_secondary_cpus(0);
+}
+static inline void suspend_enable_secondary_cpus(void)
+{
+	return enable_nonboot_cpus();
+}
+
 #else /* !CONFIG_PM_SLEEP_SMP */
 static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..fd5c95ff9251 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1150,7 +1150,7 @@ int kernel_kexec(void)
 		error = dpm_suspend_end(PMSG_FREEZE);
 		if (error)
 			goto Resume_devices;
-		error = disable_nonboot_cpus();
+		error = suspend_disable_secondary_cpus();
 		if (error)
 			goto Enable_cpus;
 		local_irq_disable();
@@ -1183,7 +1183,7 @@ int kernel_kexec(void)
  Enable_irqs:
 		local_irq_enable();
  Enable_cpus:
-		enable_nonboot_cpus();
+		suspend_enable_secondary_cpus();
 		dpm_resume_start(PMSG_RESTORE);
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index abef759de7c8..cfc7a57049e4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -281,7 +281,7 @@ static int create_image(int platform_mode)
 	if (error || hibernation_test(TEST_PLATFORM))
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || hibernation_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -323,7 +323,7 @@ static int create_image(int platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	platform_finish(platform_mode);
@@ -417,7 +417,7 @@ int hibernation_snapshot(int platform_mode)
 
 int __weak hibernate_resume_nonboot_cpu_disable(void)
 {
-	return disable_nonboot_cpus();
+	return suspend_disable_secondary_cpus();
 }
 
 /**
@@ -486,7 +486,7 @@ static int resume_target_kernel(bool platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Cleanup:
 	platform_restore_cleanup(platform_mode);
@@ -564,7 +564,7 @@ int hibernation_platform_enter(void)
 	if (error)
 		goto Platform_finish;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error)
 		goto Enable_cpus;
 
@@ -586,7 +586,7 @@ int hibernation_platform_enter(void)
 	local_irq_enable();
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_finish:
 	hibernation_ops->finish();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 0bd595a0b610..59b6def23046 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -428,7 +428,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = suspend_disable_secondary_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -458,7 +458,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	suspend_enable_secondary_cpus();
 
  Platform_wake:
 	platform_resume_noirq(state);
-- 
2.20.1
