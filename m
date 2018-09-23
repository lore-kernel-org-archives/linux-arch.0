Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:47166 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeIWPbW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Sep 2018 11:31:22 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v8 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR number
Date: Sun, 23 Sep 2018 17:34:16 +0800
Message-ID: <8246f81648d014601de3812ade40e85d9c50d9b3.1537533369.git.puwen@hygon.cn>
In-Reply-To: <cover.1537533368.git.puwen@hygon.cn>
References: <cover.1537533368.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180923093416.LISSHGI7_44Uq8n6yB05lVQw8k8sy2CaIrWBiprygZk@z>

The Hygon Dhyana CPU has a special magic MSR way to force WB for
memory >4GB, and support TOP_MEM2. Therefore, it is necessary to
add Hygon Dhyana support in amd_special_default_mtrr().

The number of variable MTRRs for Hygon is 2 as AMD's.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
