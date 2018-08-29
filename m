Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:48368 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727590AbeH2QlK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 12:41:10 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 06/16] x86/nops: init ideal_nops for Hygon
Date: Wed, 29 Aug 2018 20:44:07 +0800
Message-ID: <afb6dd7821d014932dbc5c7d80aa6bffe6aef2c8.1535459013.git.puwen@hygon.cn>
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180829124407.l6Oew2j7RRPCnC3LJMhh6snqZFUQphcBDv25Qd0hJEs@z>

The ideal_nops for Dhyana processors should be p6_nops.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 014f214..3f51d1c 100644
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
