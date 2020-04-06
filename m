From: ltykernel@gmail.com
Subject: [PATCH V4 3/6] x86/Hyper-V: Trigger crash enlightenment only once during 0;136;0c0;136;0c system crash.
Date: Mon,  6 Apr 2020 08:53:28 -0700
Message-ID: <20200406155331.2105-4-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37361 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgDFPxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:40 -0400
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vkuznets@redhat.com

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When a guest VM panics, Hyper-V should be notified only once via the
crash synthetic MSRs.  Current Linux code might write these crash MSRs
twice during a system panic:
1) hyperv_panic/die_event() calling hyperv_report_panic()
2) hv_kmsg_dump() calling hyperv_report_panic_msg()

Fix this by not calling hyperv_report_panic() if a kmsg dump has been
successfully registered.  The notification will happen later via
hyperv_report_panic_msg().

Fixes: 7ed4325a44ea ("Drivers: hv: vmbus: Make panic reporting to be more useful")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update commit log

Change since v2:
        - Update comment
Change since v3:
        - Add fix commit in the change log.	
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 00a511f15926..333dad39b1c1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -55,7 +55,13 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 
 	vmbus_initiate_unload(true);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
+	    && !hv_panic_page) {
 		regs = current_pt_regs();
 		hyperv_report_panic(regs, val);
 	}
@@ -68,7 +74,13 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	struct die_args *die = (struct die_args *)args;
 	struct pt_regs *regs = die->regs;
 
-	hyperv_report_panic(regs, val);
+	/*
+	 * Hyper-V should be notified only once about a panic.  If we will be
+	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
+	 * the notification here.
+	 */
+	if (!hv_panic_page)
+		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
 
-- 
2.14.5
