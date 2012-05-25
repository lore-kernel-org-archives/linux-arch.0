From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/20] c6x: Do not call do_signal() with irqs disabled
Date: Sat, 26 May 2012 00:04:18 +0200
Message-ID: <1337983476-22081-2-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/c6x/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/c6x/kernel/signal.c b/arch/c6x/kernel/signal.c
index cf37478..80e91bf 100644
--- a/arch/c6x/kernel/signal.c
+++ b/arch/c6x/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 
 #include <asm/ucontext.h>
 #include <asm/cacheflush.h>
@@ -356,6 +357,8 @@ static void do_signal(struct pt_regs *regs, int syscall)
 asmlinkage void do_notify_resume(struct pt_regs *regs, u32 thread_info_flags,
 				 int syscall)
 {
+	local_irq_enable();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & ((1 << TIF_SIGPENDING) |
 				 (1 << TIF_RESTORE_SIGMASK)))
-- 
1.7.7.3
