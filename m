From: Matt Fleming <matt@console-pimps.org>
Subject: [PATCH 03/40] avr32: Don't mask signals in the error path
Date: Tue, 14 Feb 2012 11:40:36 +0000
Message-ID: <1329219673-28711-4-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-arch.vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

The current handle_signal() implementation is broken - it will mask
signals if we fail to setup the signal stack frame, which isn't the
desired behaviour, we should only be masking signals if we succeed in
setting up the stack frame. It looks like this code was copied from
the old (broken) arm implementation but wasn't updated when the arm
code was fixed in commit a6c61e9dfdd0 ("[ARM] 3168/1: Update ARM
signal delivery and masking").

Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Acked-by: Havard Skinnemoen <hskinnemoen@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/avr32/kernel/signal.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 64f886f..9c075e1 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -238,22 +238,21 @@ handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
 	 */
 	ret |= !valid_user_regs(regs);
 
+	if (ret != 0) {
+		force_sigsegv(sig, current);
+		return;
+	}
+
 	/*
-	 * Block the signal if we were unsuccessful.
+	 * Block the signal if we were successful.
 	 */
-	if (ret != 0 || !(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked, &current->blocked,
-			  &ka->sa.sa_mask);
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked,
+		  &ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
 		sigaddset(&current->blocked, sig);
-		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
-	}
-
-	if (ret == 0)
-		return;
-
-	force_sigsegv(sig, current);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
 }
 
 /*
-- 
1.7.4.4
