Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:47837 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619Ab2EYWFA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 May 2012 18:05:00 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 09/20] score: Do not call do_signal() with irqs disabled
Date: Sat, 26 May 2012 00:04:25 +0200
Message-ID: <1337983476-22081-9-git-send-email-richard@nod.at>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
Message-ID: <20120525220425.G5UYa3zIynMksSNQ3ufLjx0_s74bObwebLt-G7CJGdE@z>

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Chen Liqin <liqin.chen@sunplusct.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/score/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/score/kernel/signal.c b/arch/score/kernel/signal.c
index d4a4901..452c1fa 100644
--- a/arch/score/kernel/signal.c
+++ b/arch/score/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/unistd.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 
 #include <asm/cacheflush.h>
 #include <asm/syscalls.h>
@@ -350,6 +351,8 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 				__u32 thread_info_flags)
 {
+	local_irq_enable();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
-- 
1.7.7.3

