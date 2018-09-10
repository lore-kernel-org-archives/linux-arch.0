Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:51997 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbeIJSLT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Sep 2018 14:11:19 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v6 06/16] x86/alternative: Init ideal_nops for Hygon Dhyana
Date: Mon, 10 Sep 2018 21:16:58 +0800
Message-ID: <f2c05506408c8730ae75c4cb39760ae75525364a.1536550550.git.puwen@hygon.cn>
In-Reply-To: <cover.1536550549.git.puwen@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180910131658.R_Toa9UpMi9PSD8JIrja7u2-crttfFEwj6d1vniaAUg@z>

The ideal_nops for Hygon Dhyana CPU should be p6_nops.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b9d5e7c..184e9a0 100644
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
