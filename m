Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:57716 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbeIQS6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 14:58:19 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 06/16] x86/alternative: Init ideal_nops for Hygon Dhyana
Date: Mon, 17 Sep 2018 21:30:42 +0800
Message-ID: <79e76c3173716984fe5fdd4a8e2c798bf4193205.1537182523.git.puwen@hygon.cn>
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180917133042.cJOXPCrzuviZ9Gy0XDbVttElEeqMESrEfeqwymp6K00@z>

The ideal_nops for Hygon Dhyana CPU should be p6_nops.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Borislav Petkov <bp@suse.de>
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
