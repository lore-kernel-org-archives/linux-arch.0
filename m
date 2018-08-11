Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:36941 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeHKQBF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Aug 2018 12:01:05 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 03/17] x86/mtrr: get MTRR number and support TOP_MEM2
Date: Sat, 11 Aug 2018 21:26:29 +0800
Message-ID: <2df39b151f12498ae8b10bc904df59fae10e8e80.1533989492.git.puwen@hygon.cn>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180811132629.WV-wYEbZbeiBzSyTpCDVwxqLKbrVO96soRPn8TO053M@z>

Hygon CPU have a special magic MSR way to force WB for memory >4GB,
and also support TOP_MEM2. Therefore, it is necessary to add Hygon
support in amd_special_default_mtrr().

The MtrrFixDramModEn bit on Hygon platform should also be set to 1
during BIOS initialization of the fixed MTRRs, then cleared to 0 for
operation.

The number of variable MTRRs for Hygon is 2 as AMD's.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c | 5 +++--
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 765afd5..3668c5d 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -831,7 +831,8 @@ int __init amd_special_default_mtrr(void)
 {
 	u32 l, h;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return 0;
 	if (boot_cpu_data.x86 < 0xf)
 		return 0;
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e12ee86..77c3eaa 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -49,8 +49,9 @@ static inline void k8_check_syscfg_dram_mod_en(void)
 {
 	u32 lo, hi;
 
-	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
-	      (boot_cpu_data.x86 >= 0x0f)))
+	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	       boot_cpu_data.x86 >= 0x0f) ||
+	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
 		return;
 
 	rdmsr(MSR_K8_SYSCFG, lo, hi);
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9a19c80..507039c 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -127,7 +127,7 @@ static void __init set_num_var_ranges(void)
 
 	if (use_intel())
 		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD))
+	else if (is_cpu(AMD) || is_cpu(HYGON))
 		config = 2;
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
-- 
2.7.4
