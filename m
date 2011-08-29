From: Eric B Munson <emunson@mgebm.net>
Subject: [PATCH 4/4] Add check for suspended vm in softlockup detector
Date: Mon, 29 Aug 2011 17:27:15 -0600
Message-ID: <1314660435-23293-5-git-send-email-emunson@mgebm.net>
References: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314660435-23293-1-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: avi@redhat.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, mtosatti@redhat.com, riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm-ppc@vger.kernel.org, aliguori@us.ibm.com, raharper@us.ibm.com, kvm-ia64@vger.kernel.org, Eric B Munson <emunson@mgebm.net>
List-Id: linux-arch.vger.kernel.org

A suspended VM can cause spurious soft lockup warnings.  To avoid these, the
watchdog now checks if the kernel knows it was stopped by the host and skips
the warning if so.

Signed-off-by: Eric B Munson <emunson@mgebm.net>
---
 kernel/watchdog.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 36491cd..4cbb69f 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -25,6 +25,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/irq_regs.h>
+#include <asm/pvclock.h>
 #include <linux/perf_event.h>
 
 int watchdog_enabled = 1;
@@ -292,6 +293,17 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 	 */
 	duration = is_softlockup(touch_ts);
 	if (unlikely(duration)) {
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like a soft lockup, check to see if the host
+		 * stopped the vm before we issue the warning
+		 */
+		if (kvm_check_and_clear_host_stopped(get_cpu())) {
+			put_cpu();
+			return HRTIMER_RESTART;
+		}
+		put_cpu();
+
 		/* only warn once */
 		if (__this_cpu_read(soft_watchdog_warn) == true)
 			return HRTIMER_RESTART;
-- 
1.7.4.1
