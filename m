From: Richard Kuo <rkuo@codeaurora.org>
Subject: [PATCH 6/6] Hexagon: fix psp/sp macro
Date: Wed,  3 Apr 2013 19:02:56 -0500
Message-ID: <1365033776-21804-7-git-send-email-rkuo@codeaurora.org>
References: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:22864 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481Ab3DDADV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2013 20:03:21 -0400
In-Reply-To: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk
Cc: Richard Kuo <rkuo@codeaurora.org>

Based on feedback from Al Viro; previous-stack-pointer and
user reg for same should always be kept consistent.

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/uapi/asm/registers.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/registers.h b/arch/hexagon/include/uapi/asm/registers.h
index 8050415..12005da 100644
--- a/arch/hexagon/include/uapi/asm/registers.h
+++ b/arch/hexagon/include/uapi/asm/registers.h
@@ -212,8 +212,7 @@ struct pt_regs {
 #define pt_badva(regs) ((regs)->hvmer.vmbadva)
 
 #define pt_set_rte_sp(regs, sp) do {\
-	pt_psp(regs) = (sp);\
-	(regs)->SP = (unsigned long) &((regs)->hvmer);\
+	pt_psp(regs) = (regs)->SP = (sp);\
 	} while (0)
 
 #define pt_set_kmode(regs) \
-- 
1.7.9.5

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
