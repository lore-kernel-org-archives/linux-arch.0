Return-Path: <SRS0=xoZC=5W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgDFPxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:40 -0400
From: ltykernel@gmail.com
Subject: [PATCH V4 2/6] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date: Mon,  6 Apr 2020 08:53:27 -0700
Message-ID: <20200406155331.2105-3-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vkuznets@redhat.com
Message-ID: <20200406155327.DMQ4SQLsCkZwJ78dsc5Jmz9xQa4yhA5SSS8Ko0BZVNE@z>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

If kmsg_dump_register() fails, hv_panic_page will not be used
anywhere.  So free and reset it.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update commit log
	- Remove hv_free_hyperv_page() in the error path
Change since v3:
        - Add fix commit in the change log.	
---
 drivers/hv/vmbus_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6478240d11ab..00a511f15926 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
 			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret)
+				if (ret) {
 					pr_err("Hyper-V: kmsg dump register "
 						"error 0x%x\n", ret);
+					hv_free_hyperv_page(
+					    (unsigned long)hv_panic_page);
+					hv_panic_page = NULL;
+				}
 			} else
 				pr_err("Hyper-V: panic message page memory "
 					"allocation failed");
@@ -1416,7 +1420,6 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	hv_free_hyperv_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.14.5
