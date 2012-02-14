Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57880 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754748Ab2BNLoD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 06:44:03 -0500
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 38/40] xtensa: No need to reset handler if SA_ONESHOT
Date: Tue, 14 Feb 2012 11:41:11 +0000
Message-ID: <1329219673-28711-39-git-send-email-matt@console-pimps.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Chris Zankel <chris@zankel.net>
Message-ID: <20120214114111.ft-NrULz4xRRYs5d02C1HxOvlklWSym3yAJ_764DmLw@z>

From: Matt Fleming <matt.fleming@intel.com>

get_signal_to_deliver() already resets the signal handler if
SA_ONESHOT is set in ka->sa.sa_flags, there's no need to do it again
in handle_signal(). Furthermore, because we were modifying
ka->sa.sa_handler (which is a copy of sighand->action[]) instead of
sighand->action[] the original code actually had no effect on signal
delivery.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Zankel <chris@zankel.net>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/xtensa/kernel/signal.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 4f53770..24655e3 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -536,9 +536,6 @@ int do_signal(struct pt_regs *regs, sigset_t *oldset)
 		/* Set up the stack frame */
 		setup_frame(signr, &ka, &info, oldset, regs);
 
-		if (ka.sa.sa_flags & SA_ONESHOT)
-			ka.sa.sa_handler = SIG_DFL;
-
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, &ka.sa.sa_mask);
 		if (!(ka.sa.sa_flags & SA_NODEFER))
-- 
1.7.4.4

