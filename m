Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40270 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab0I1C5n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 22:57:43 -0400
Date: Tue, 28 Sep 2010 03:57:42 +0100
Subject: [PATCH 3/6] avr32: fix handling of blocked signals
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1P0QNz-0008ST-00@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100928025742.gDzekQqDt-SXDUGSg3YbBrSoXg0VQqpQYDXkhb8YYas@z>


We do _not_ want to block anything on failure to set sigframe up
and we do not want to ignore sa_mask even when SA_NODOFER is set.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/avr32/kernel/signal.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 8c481fb..52affae 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -231,28 +231,24 @@ handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
 	/*
 	 * Set up the stack frame
 	 */
-	ret = setup_rt_frame(sig, ka, info, oldset, regs);
+	if (setup_rt_frame(sig, ka, info, oldset, regs) != 0)
+		goto fail;
 
 	/*
 	 * Check that the resulting registers are sane
 	 */
-	ret |= !valid_user_regs(regs);
+	if (!valid_user_regs(regs))
+		goto fail;
 
-	/*
-	 * Block the signal if we were unsuccessful.
-	 */
-	if (ret != 0 || !(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked,
-			  &ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
-
-	if (ret == 0)
-		return;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	return;
 
+fail:
 	force_sigsegv(sig, current);
 }
 
-- 
1.5.6.5


