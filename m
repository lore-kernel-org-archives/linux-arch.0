Return-Path: <SRS0=xoZC=5W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgDFPxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:41 -0400
From: ltykernel@gmail.com
Subject: [PATCH V4 4/6] x86/Hyper-V: Report crash register data or kmsg before running crash kernel
Date: Mon,  6 Apr 2020 08:53:29 -0700
Message-ID: <20200406155331.2105-5-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, michael.h.kelley@microsoft.com
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vkuznets@redhat.com
Message-ID: <20200406155329.PJMZoe2zKkBgzkq4Iu7Z1liCY60FMmnorPb_PpJtbl4@z>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

We want to notify Hyper-V when a Linux guest VM crash occurs, so
there is a record of the crash even when kdump is enabled.   But
crash_kexec_post_notifiers defaults to "false", so the kdump kernel
runs before the notifiers and Hyper-V never gets notified.  Fix this by
always setting crash_kexec_post_notifiers to be true for Hyper-V VMs.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Update commit log
Change since v3:
        - Add fix commit in the change log.
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index caa032ce3fe3..5e296a7e6036 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -263,6 +263,16 @@ static void __init ms_hyperv_init_platform(void)
 			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
 	}
 
+	/*
+	 * Hyper-V expects to get crash register data or kmsg when
+	 * crash enlightment is available and system crashes. Set
+	 * crash_kexec_post_notifiers to be true to make sure that
+	 * calling crash enlightment interface before running kdump
+	 * kernel.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-- 
2.14.5
