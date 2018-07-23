Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52033 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388213AbeGWO3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:34 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 06/17] x86/nops: init ideal_nops for Hygon
Date: Mon, 23 Jul 2018 21:20:26 +0800
Message-ID: <1532352037-7151-7-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132026.m4Z_tGNO5rMp683KNayZ20c4SkwOAoPwHjrljQcKijs@z>

The ideal_nops for Dhyana processors should be p6_nops.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763..8f4925b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -222,6 +222,10 @@ void __init arch_init_ideal_nops(void)
 		}
 		break;
 
+	case X86_VENDOR_HYGON:
+		ideal_nops = p6_nops;
+		return;
+
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 > 0xf) {
 			ideal_nops = p6_nops;
-- 
2.7.4
