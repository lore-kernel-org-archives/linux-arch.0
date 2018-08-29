From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 13/16] driver/acpi: enable Hygon support to ACPI driver
Date: Wed, 29 Aug 2018 20:45:25 +0800
Message-ID: <b13718275dc136f9eda85fdfb65628bc055ec6aa.1535459013.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, lenb@kernel.org, rjw@rjwysocki.net, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

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
