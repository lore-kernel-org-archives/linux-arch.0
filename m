Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52031 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388194AbeGWO3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:34 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 14/17] driver/acpi: enable Hygon support to ACPI driver
Date: Mon, 23 Jul 2018 21:20:34 +0800
Message-ID: <1532352037-7151-15-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132034.yw9gtdzsrbDNsMjvMXZKtUoaQc4LXZiADONxWrJMga8@z>

For Dhyana processors have NONSTOP TSC feature, so enable the support
to ACPI driver.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/acpi/acpi_pad.c       | 1 +
 drivers/acpi/processor_idle.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f7..a47676a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -70,6 +70,7 @@ static void power_saving_mwait_init(void)
 
 #if defined(CONFIG_X86)
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 		/*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index abb559c..b2131c4 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -205,6 +205,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 static void tsc_check_state(int state)
 {
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
-- 
2.7.4
