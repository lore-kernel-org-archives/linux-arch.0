Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:58526 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbeIQS7K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 14:59:10 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 09/16] x86/bugs: Add mitigation to spectre and no meltdown for Hygon Dhyana
Date: Mon, 17 Sep 2018 21:31:33 +0800
Message-ID: <9e74e951a631616fcb33f47ac91960664e301e34.1537182523.git.puwen@hygon.cn>
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180917133133.hUSBx3zAqwPhCkYzQOZenBrNnMdfaBBLrfb-NCpLGak@z>

The Hygon Dhyana CPU has the same speculative execution as AMD family
17h, so share AMD spectre mitigation code for Hygon Dhyana.

Also Hygon Dhyana is not affected by meltdown vulnerability, so add
exception for it.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/bugs.c   | 4 +++-
 arch/x86/kernel/cpu/common.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 40bdaea..b810cc2 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -312,6 +312,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
 		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
 		return SPECTRE_V2_CMD_AUTO;
@@ -371,7 +372,8 @@ static void __init spectre_v2_select_mitigation(void)
 	return;
 
 retpoline_auto:
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 	retpoline_amd:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 44c4ef3..851cbe7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -963,6 +963,7 @@ static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 
 static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
+	{ X86_VENDOR_HYGON },
 	{}
 };
 
-- 
2.7.4
