Return-Path: <SRS0=xoZC=5W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgDFPxi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:38 -0400
From: ltykernel@gmail.com
Subject: [PATCH V4 1/6] x86/Hyper-V: Unload vmbus channel in hv panic callback
Date: Mon,  6 Apr 2020 08:53:26 -0700
Message-ID: <20200406155331.2105-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vkuznets@redhat.com
Message-ID: <20200406155326.an6lrED7LttSc-b6o0F6Nw0KPV0hxIPvvqdvNYAVpHw@z>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When kdump is not configured, a Hyper-V VM might still respond to
network traffic after a kernel panic when kernel parameter panic=0.
The panic CPU goes into an infinite loop with interrupts enabled,
and the VMbus driver interrupt handler still works because the
VMbus connection is unloaded only in the kdump path.  The network
responses make the other end of the connection think the VM is
still functional even though it has panic'ed, which could affect any
failover actions that should be taken.

Fix this by unloading the VMbus connection during the panic process.
vmbus_initiate_unload() could then be called twice (e.g., by
hyperv_panic_event() and hv_crash_handler(), so reset the connection
state in vmbus_initiate_unload() to ensure the unload is done only
once.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update change log
	- Use xchg() to change vmbus connection status
Change since v2:
	- Update comment of registering panic callback.
Change since v3:
        - Add fix commit in the change log.
---
 drivers/hv/channel_mgmt.c |  3 +++
 drivers/hv/vmbus_drv.c    | 21 +++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0370364169c4..501c43c5851d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
 {
 	struct vmbus_channel_message_header hdr;
 
+	if (xchg(&vmbus_connection.conn_state, DISCONNECTED) == DISCONNECTED)
+		return;
+
 	/* Pre-Win2012R2 hosts don't support reconnect */
 	if (vmbus_proto_version < VERSION_WIN8_1)
 		return;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..6478240d11ab 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -53,9 +53,12 @@ static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
 {
 	struct pt_regs *regs;
 
-	regs = current_pt_regs();
+	vmbus_initiate_unload(true);
 
-	hyperv_report_panic(regs, val);
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		regs = current_pt_regs();
+		hyperv_report_panic(regs, val);
+	}
 	return NOTIFY_DONE;
 }
 
@@ -1391,10 +1394,16 @@ static int vmbus_bus_init(void)
 		}
 
 		register_die_notifier(&hyperv_die_block);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &hyperv_panic_block);
 	}
 
+	/*
+	 * Always register the panic notifier because we need to unload
+	 * the VMbus channel connection to prevent any VMbus
+	 * activity after the VM panics.
+	 */
+	atomic_notifier_chain_register(&panic_notifier_list,
+			       &hyperv_panic_block);
+
 	vmbus_request_offers();
 
 	return 0;
@@ -2204,8 +2213,6 @@ static int vmbus_bus_suspend(struct device *dev)
 
 	vmbus_initiate_unload(false);
 
-	vmbus_connection.conn_state = DISCONNECTED;
-
 	/* Reset the event for the next resume. */
 	reinit_completion(&vmbus_connection.ready_for_resume_event);
 
@@ -2289,7 +2296,6 @@ static void hv_kexec_handler(void)
 {
 	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
-	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
 	mb();
 	cpuhp_remove_state(hyperv_cpuhp_online);
@@ -2306,7 +2312,6 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * doing the cleanup for current CPU only. This should be sufficient
 	 * for kdump.
 	 */
-	vmbus_connection.conn_state = DISCONNECTED;
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
 	hv_synic_disable_regs(cpu);
-- 
2.14.5
