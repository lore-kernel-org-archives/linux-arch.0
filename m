From: Richard Kuo <rkuo@codeaurora.org>
Subject: [PATCH 4/6] Hexagon: check to if we will overflow the signal stack
Date: Wed,  3 Apr 2013 19:02:54 -0500
Message-ID: <1365033776-21804-5-git-send-email-rkuo@codeaurora.org>
References: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk
Cc: Richard Kuo <rkuo@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/kernel/signal.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
index 8a20e8e..097623c 100644
--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -41,6 +41,10 @@ static void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
 {
 	unsigned long sp = regs->r29;
 
+	/* check if we would overflow the alt stack */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
+		return (void __user __force *)-1UL;
+
 	/* Switch to signal stack if appropriate */
 	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
-- 
1.7.9.5

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
