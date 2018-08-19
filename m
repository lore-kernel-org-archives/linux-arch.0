Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:56482 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbeHST0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Aug 2018 15:26:55 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 13/16] driver/acpi: enable Hygon support to ACPI driver
Date: Mon, 20 Aug 2018 00:14:17 +0800
Message-ID: <3264be92a112b331094f60ef9b5e8c3e4a8e5034.1534599097.git.puwen@hygon.cn>
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180819161417.lWHsM9jE-Tku0l5r4zOcb4FagVXV7RFiRCBAD5BnM28@z>

For Dhyana processors have NONSTOP TSC feature, so enable the support
to ACPI driver.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
