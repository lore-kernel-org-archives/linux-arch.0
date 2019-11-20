Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:20640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfKTHQm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:42 -0500
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 2/2] hv_balloon: Add the support of hibernation
Date: Tue, 19 Nov 2019 23:16:05 -0800
Message-ID: <1574234165-49066-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, david@redhat.com, arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Message-ID: <20191120071605.y1NniDRLRRnMtC06K-QK8T3J9--AocbvZ3o8H_bguck@z>

When hibernation is enabled, we must ignore the balloon up/down and
hot-add requests from the host, if any.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Acked-by: David Hildenbrand <david@redhat.com>
---

v2 is actually the same as v1. This is just a resend.

I suggest this patch should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
together with 
[PATCH v2 1/2] x86/hyperv: Implement hv_is_hibernation_supported()

 drivers/hv/hv_balloon.c | 87 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 935904830d42..7f4cf4fc805e 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -25,6 +25,8 @@
 #include <linux/hyperv.h>
 #include <asm/hyperv-tlfs.h>
 
+#include <asm/mshyperv.h>
+
 #define CREATE_TRACE_POINTS
 #include "hv_trace_balloon.h"
 
@@ -456,6 +458,7 @@ struct hot_add_wrk {
 	struct work_struct wrk;
 };
 
+static bool allow_hibernation;
 static bool hot_add = true;
 static bool do_hot_add;
 /*
@@ -1052,8 +1055,12 @@ static void hot_add_req(struct work_struct *dummy)
 	else
 		resp.result = 0;
 
-	if (!do_hot_add || (resp.page_count == 0))
-		pr_err("Memory hot add failed\n");
+	if (!do_hot_add || resp.page_count == 0) {
+		if (!allow_hibernation)
+			pr_err("Memory hot add failed\n");
+		else
+			pr_info("Ignore hot-add request!\n");
+	}
 
 	dm->state = DM_INITIALIZED;
 	resp.hdr.trans_id = atomic_inc_return(&trans_id);
@@ -1508,6 +1515,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		case DM_BALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-up request!\n");
+				break;
+			}
+
 			if (dm->state == DM_BALLOON_UP)
 				pr_warn("Currently ballooning\n");
 			bal_msg = (struct dm_balloon *)recv_buffer;
@@ -1517,6 +1529,11 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		case DM_UNBALLOON_REQUEST:
+			if (allow_hibernation) {
+				pr_info("Ignore balloon-down request!\n");
+				break;
+			}
+
 			dm->state = DM_BALLOON_DOWN;
 			balloon_down(dm,
 				 (struct dm_unballoon_request *)recv_buffer);
@@ -1622,6 +1639,11 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	cap_msg.hdr.size = sizeof(struct dm_capabilities);
 	cap_msg.hdr.trans_id = atomic_inc_return(&trans_id);
 
+	/*
+	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
+	 * currently still requires the bits to be set, so we have to add code
+	 * to fail the host's hot-add and balloon up/down requests, if any.
+	 */
 	cap_msg.caps.cap_bits.balloon = 1;
 	cap_msg.caps.cap_bits.hot_add = 1;
 
@@ -1671,6 +1693,10 @@ static int balloon_probe(struct hv_device *dev,
 {
 	int ret;
 
+	allow_hibernation = hv_is_hibernation_supported();
+	if (allow_hibernation)
+		hot_add = false;
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 	do_hot_add = hot_add;
 #else
@@ -1710,6 +1736,8 @@ static int balloon_probe(struct hv_device *dev,
 	return 0;
 
 probe_error:
+	dm_device.state = DM_INIT_ERROR;
+	dm_device.thread  = NULL;
 	vmbus_close(dev->channel);
 #ifdef CONFIG_MEMORY_HOTPLUG
 	unregister_memory_notifier(&hv_memory_nb);
@@ -1751,6 +1779,59 @@ static int balloon_remove(struct hv_device *dev)
 	return 0;
 }
 
+static int balloon_suspend(struct hv_device *hv_dev)
+{
+	struct hv_dynmem_device *dm = hv_get_drvdata(hv_dev);
+
+	tasklet_disable(&hv_dev->channel->callback_event);
+
+	cancel_work_sync(&dm->balloon_wrk.wrk);
+	cancel_work_sync(&dm->ha_wrk.wrk);
+
+	if (dm->thread) {
+		kthread_stop(dm->thread);
+		dm->thread = NULL;
+		vmbus_close(hv_dev->channel);
+	}
+
+	tasklet_enable(&hv_dev->channel->callback_event);
+
+	return 0;
+
+}
+
+static int balloon_resume(struct hv_device *dev)
+{
+	int ret;
+
+	dm_device.state = DM_INITIALIZING;
+
+	ret = balloon_connect_vsp(dev);
+
+	if (ret != 0)
+		goto out;
+
+	dm_device.thread =
+		 kthread_run(dm_thread_func, &dm_device, "hv_balloon");
+	if (IS_ERR(dm_device.thread)) {
+		ret = PTR_ERR(dm_device.thread);
+		dm_device.thread = NULL;
+		goto close_channel;
+	}
+
+	dm_device.state = DM_INITIALIZED;
+	return 0;
+close_channel:
+	vmbus_close(dev->channel);
+out:
+	dm_device.state = DM_INIT_ERROR;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	unregister_memory_notifier(&hv_memory_nb);
+	restore_online_page_callback(&hv_online_page);
+#endif
+	return ret;
+}
+
 static const struct hv_vmbus_device_id id_table[] = {
 	/* Dynamic Memory Class ID */
 	/* 525074DC-8985-46e2-8057-A307DC18A502 */
@@ -1765,6 +1846,8 @@ static  struct hv_driver balloon_drv = {
 	.id_table = id_table,
 	.probe =  balloon_probe,
 	.remove =  balloon_remove,
+	.suspend = balloon_suspend,
+	.resume = balloon_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.19.1
