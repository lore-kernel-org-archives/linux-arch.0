Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:52218 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbeIJSME (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Sep 2018 14:12:04 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v6 09/16] x86/bugs: Add mitigation to spectre and no meltdown for Hygon Dhyana
Date: Mon, 10 Sep 2018 21:17:40 +0800
Message-ID: <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
In-Reply-To: <cover.1536550549.git.puwen@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180910131740.Rnp43YywzTKA--CVMYryCSh7vOUVy9-BS17Hlt_MbGA@z>

The Hygon Dhyana CPU has the same speculative execution as AMD family
17h, so share AMD spectre mitigation code for Hygon Dhyana.

Also Hygon Dhyana is not affected by meltdown vulnerability as AMD,
so add the exception for Hygon Dhyana.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/bugs.c   | 6 ++++--
 arch/x86/kernel/cpu/common.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 40bdaea..726010d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -312,8 +312,9 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
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
