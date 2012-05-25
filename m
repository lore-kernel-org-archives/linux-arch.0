From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 19/20] unicore32: Do not call try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:04:35 +0200
Message-ID: <1337983476-22081-19-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/unicore32/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index d25ddd8..1ee603e 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
-#include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
@@ -400,9 +399,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 	if (!user_mode(regs))
 		return;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		sigset_t *oldset;
@@ -425,7 +421,6 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		return;
 	}
 
- no_signal:
 	/*
 	 * No signal to deliver to the process - restart the syscall.
 	 */
-- 
1.7.7.3
