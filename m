From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 12/20] unicore32: Do not call do_signal() with irqs disabled
Date: Sat, 26 May 2012 00:04:28 +0200
Message-ID: <1337983476-22081-12-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/unicore32/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/unicore32/kernel/signal.c b/arch/unicore32/kernel/signal.c
index 7754df6..d25ddd8 100644
--- a/arch/unicore32/kernel/signal.c
+++ b/arch/unicore32/kernel/signal.c
@@ -17,6 +17,7 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 #include <linux/unistd.h>
+#include <linux/irqflags.h>
 
 #include <asm/cacheflush.h>
 #include <asm/ucontext.h>
@@ -458,6 +459,8 @@ static void do_signal(struct pt_regs *regs, int syscall)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 		unsigned int thread_flags, int syscall)
 {
+	local_irq_enable();
+
 	if (thread_flags & _TIF_SIGPENDING)
 		do_signal(regs, syscall);
 
-- 
1.7.7.3
