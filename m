Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:57767 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760450Ab2BNLnR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 06:43:17 -0500
From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 22/40] OpenRISC: No need to reset handler if SA_ONESHOT
Date: Tue, 14 Feb 2012 11:40:55 +0000
Message-ID: <1329219673-28711-23-git-send-email-matt@console-pimps.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Jonas Bonn <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>, linux@lists.openrisc.net
Message-ID: <20120214114055.9TMHUyw2UuLU_94nhAKEZu1R5fCDEEdsoVZmcKH8Uk8@z>

From: Matt Fleming <matt.fleming@intel.com>

get_signal_to_deliver() already resets the signal handler if
SA_ONESHOT is set in ka->sa.sa_flags, there's no need to do it again
in handle_signal(). Furthermore, because we were modifying
ka->sa.sa_handler (which is a copy of sighand->action[]) instead of
sighand->action[] the original code actually had no effect on signal
delivery.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux@lists.openrisc.net
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/openrisc/kernel/signal.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 53741ba..92d2218 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -260,9 +260,6 @@ handle_signal(unsigned long sig,
 {
 	setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	spin_lock_irq(&current->sighand->siglock);
 	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
 	if (!(ka->sa.sa_flags & SA_NODEFER))
-- 
1.7.4.4

