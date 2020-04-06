From: ltykernel@gmail.com
Subject: [PATCH V4 5/6] x86/Hyper-V: Report crash register data when sysctl_record_panic_msg is not set
Date: Mon,  6 Apr 2020 08:53:30 -0700
Message-ID: <20200406155331.2105-6-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vkuznets@redhat.com
List-Id: linux-arch.vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When sysctl_record_panic_msg is not set, the panic will
not be reported to Hyper-V via hyperv_report_panic_msg().
So the crash should be reported via hyperv_report_panic().

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
        - Add fix commit in the change log
---
 drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 333dad39b1c1..172ceae69abb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -48,6 +48,18 @@ static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
 
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+static int hyperv_report_reg(void)
+{
+	return !sysctl_record_panic_msg || !hv_panic_page;
+}
+
 static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
@@ -61,7 +73,7 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 	 * the notification here.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && !hv_panic_page) {
+	    && hyperv_report_reg()) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -79,7 +91,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
 	 * the notification here.
 	 */
-	if (!hv_panic_page)
+	if (hyperv_report_reg())
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
@@ -1267,13 +1279,6 @@ static void vmbus_isr(void)
 	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
 }
 
-/*
- * Boolean to control whether to report panic messages over Hyper-V.
- *
- * It can be set via /proc/sys/kernel/hyperv/record_panic_msg
- */
-static int sysctl_record_panic_msg = 1;
-
 /*
  * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
  * buffer and call into Hyper-V to transfer the data.
-- 
2.14.5
