Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:57273 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbeIQS5h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 14:57:37 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 03/16] x86/cpu/mtrr: Support TOP_MEM2 and get MTRR number
Date: Mon, 17 Sep 2018 21:29:53 +0800
Message-ID: <8246f81648d014601de3812ade40e85d9c50d9b3.1537182523.git.puwen@hygon.cn>
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180917132953.vPjJIp-zgVaFBciE3XrvRo9bywZmBsNgv96H7lFEq34@z>

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
