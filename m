From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 05/20] hexagon: Do not call do_signal() with irqs disabled
Date: Sat, 26 May 2012 00:04:21 +0200
Message-ID: <1337983476-22081-5-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-hexagon-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/hexagon/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/kernel/signal.c b/arch/hexagon/kernel/signal.c
index 434866e..8403bfd 100644
--- a/arch/hexagon/kernel/signal.c
+++ b/arch/hexagon/kernel/signal.c
@@ -22,6 +22,7 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 #include <asm/registers.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
@@ -267,6 +268,8 @@ no_restart:
 
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 {
+	local_irq_enable();
+
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
 
-- 
1.7.7.3
