From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 34/40] um: Don't restore current->blocked on error
Date: Tue, 14 Feb 2012 11:41:07 +0000
Message-ID: <1329219673-28711-35-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

If we fail to setup the signal stack frame then we don't need to
restore current->blocked because it is not modified by
setup_signal_stack_*.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/um/kernel/signal.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index e8b889d..8382e0b 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -65,13 +65,9 @@ static int handle_signal(struct pt_regs *regs, unsigned long signr,
 #endif
 		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
 
-	if (err) {
-		spin_lock_irq(&current->sighand->siglock);
-		current->blocked = *oldset;
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
+	if (err)
 		force_sigsegv(signr, current);
-	} else {
+	else {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked,
 			  &ka->sa.sa_mask);
-- 
1.7.4.4
