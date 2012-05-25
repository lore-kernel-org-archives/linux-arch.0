From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 18/20] m32r: Do not call try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:04:34 +0200
Message-ID: <1337983476-22081-18-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/m32r/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/m32r/kernel/signal.c b/arch/m32r/kernel/signal.c
index 0521e19..00494f0 100644
--- a/arch/m32r/kernel/signal.c
+++ b/arch/m32r/kernel/signal.c
@@ -20,7 +20,6 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/personality.h>
-#include <linux/freezer.h>
 #include <linux/tracehook.h>
 #include <linux/irqflags.h>
 #include <asm/cacheflush.h>
@@ -323,9 +322,6 @@ static void do_signal(struct pt_regs *regs)
 	if (!user_mode(regs))
 		return;
 
-	if (try_to_freeze()) 
-		goto no_signal;
-
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else
@@ -346,7 +342,6 @@ static void do_signal(struct pt_regs *regs)
 		return;
 	}
 
- no_signal:
 	/* Did we come from a system call? */
 	if (regs->syscall_nr >= 0) {
 		/* Restart the system call - no handlers present */
-- 
1.7.7.3
