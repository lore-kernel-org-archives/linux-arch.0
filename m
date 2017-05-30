From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/4] watchdog: Provide watchdog_reconfigure() for arch watchdogs
Date: Tue, 30 May 2017 11:26:59 +1000
Message-ID: <20170530012659.16791-5-npiggin@gmail.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36276 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdE3B1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 21:27:40 -0400
In-Reply-To: <20170530012659.16791-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

After reconfiguring watchdog sysctls etc., architecture specific
watchdogs may not get all their parameters updated.

watchdog_reconfigure() can be implemented to pull the new values
in and set the arch NMI watchdog.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/watchdog.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index deb010505646..5397c637db2d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -120,6 +120,11 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
 {
 }
 
+void __weak watchdog_nmi_reconfigure(void)
+{
+}
+
+
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
 
 /* Helper for online, unparked cpus. */
@@ -597,6 +602,12 @@ static void watchdog_disable_all_cpus(void)
 	}
 }
 
+static int watchdog_update_cpus(void)
+{
+	return smpboot_update_cpumask_percpu_thread(
+		    &watchdog_threads, &watchdog_cpumask);
+}
+
 #else /* SOFTLOCKUP */
 static int watchdog_park_threads(void)
 {
@@ -616,6 +627,11 @@ static void watchdog_disable_all_cpus(void)
 {
 }
 
+static int watchdog_update_cpus(void)
+{
+	return 0;
+}
+
 static void set_sample_period(void)
 {
 }
@@ -648,6 +664,8 @@ int lockup_detector_suspend(void)
 		watchdog_enabled = 0;
 	}
 
+	watchdog_nmi_reconfigure();
+
 	mutex_unlock(&watchdog_proc_mutex);
 
 	return ret;
@@ -668,6 +686,8 @@ void lockup_detector_resume(void)
 	if (watchdog_running && !watchdog_suspended)
 		watchdog_unpark_threads();
 
+	watchdog_nmi_reconfigure();
+
 	mutex_unlock(&watchdog_proc_mutex);
 	put_online_cpus();
 }
@@ -693,6 +713,8 @@ static int proc_watchdog_update(void)
 	else
 		watchdog_disable_all_cpus();
 
+	watchdog_nmi_reconfigure();
+
 	return err;
 
 }
@@ -878,12 +900,11 @@ int proc_watchdog_cpumask(struct ctl_table *table, int write,
 			 * a temporary cpumask, so we are likely not in a
 			 * position to do much else to make things better.
 			 */
-#ifdef CONFIG_SOFTLOCKUP_DETECTOR
-			if (smpboot_update_cpumask_percpu_thread(
-				    &watchdog_threads, &watchdog_cpumask) != 0)
+			if (watchdog_update_cpus() != 0)
 				pr_err("cpumask update failed\n");
-#endif
 		}
+
+		watchdog_nmi_reconfigure();
 	}
 out:
 	mutex_unlock(&watchdog_proc_mutex);
-- 
2.11.0
