Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52028 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388087AbeGWO3f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 09/17] x86/bugs: add lfence mitigation to spectre v2 and no meltdown for Hygon
Date: Mon, 23 Jul 2018 21:20:29 +0800
Message-ID: <1532352037-7151-10-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132029.S4tGfb2ZXmHVcHsoSACw3oaTwjucXZ2FFz4W8DgO5KE@z>

To share codes between AMD and Hygon to mitigate Spectre V2 Retpoline
vulnerability, rename macros SPECTRE_V2_RETPOLINE_MINIMAL_AMD to
SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE, and SPECTRE_V2_CMD_RETPOLINE_AMD
to SPECTRE_V2_CMD_RETPOLINE_LFENCE.

As Hygon processors is not affected by meltdown vulnerability as AMD's,
so add exception in array cpu_no_meltdown[] for it.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 arch/x86/kernel/cpu/bugs.c           | 28 +++++++++++++++-------------
 arch/x86/kernel/cpu/common.c         |  1 +
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f6f6c63..aad6b9c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -211,9 +211,9 @@
 enum spectre_v2_mitigation {
 	SPECTRE_V2_NONE,
 	SPECTRE_V2_RETPOLINE_MINIMAL,
-	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
+	SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE,
 	SPECTRE_V2_RETPOLINE_GENERIC,
-	SPECTRE_V2_RETPOLINE_AMD,
+	SPECTRE_V2_RETPOLINE_LFENCE,
 	SPECTRE_V2_IBRS,
 };
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5c0ea39..5d0ba61 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -121,15 +121,15 @@ enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_FORCE,
 	SPECTRE_V2_CMD_RETPOLINE,
 	SPECTRE_V2_CMD_RETPOLINE_GENERIC,
-	SPECTRE_V2_CMD_RETPOLINE_AMD,
+	SPECTRE_V2_CMD_RETPOLINE_LFENCE,
 };
 
 static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
-	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
+	[SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE]	= "Vulnerable: Minimal LFENCE ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
-	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_RETPOLINE_LFENCE]		= "Mitigation: Full LFENCE retpoline",
 };
 
 #undef pr_fmt
@@ -260,7 +260,7 @@ static const struct {
 	{ "off",               SPECTRE_V2_CMD_NONE,              false },
 	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
 	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
-	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
 	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
 	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
 };
@@ -292,16 +292,17 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
 	    !IS_ENABLED(CONFIG_RETPOLINE)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n", mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	if (cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
@@ -352,9 +353,9 @@ static void __init spectre_v2_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
-	case SPECTRE_V2_CMD_RETPOLINE_AMD:
+	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
-			goto retpoline_amd;
+			goto retpoline_lfence;
 		break;
 	case SPECTRE_V2_CMD_RETPOLINE_GENERIC:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
@@ -369,14 +370,15 @@ static void __init spectre_v2_select_mitigation(void)
 	return;
 
 retpoline_auto:
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-	retpoline_amd:
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+	retpoline_lfence:
 		if (!boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
 			pr_err("Spectre mitigation: LFENCE not serializing, switching to generic retpoline\n");
 			goto retpoline_generic;
 		}
-		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_AMD :
-					 SPECTRE_V2_RETPOLINE_MINIMAL_AMD;
+		mode = retp_compiler() ? SPECTRE_V2_RETPOLINE_LFENCE :
+					 SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE;
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_AMD);
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	} else {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3e..06b3168 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -968,6 +968,7 @@ static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
 
 static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
 	{ X86_VENDOR_AMD },
+	{ X86_VENDOR_HYGON },
 	{}
 };
 
-- 
2.7.4
