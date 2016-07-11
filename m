Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34428 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbcGKUy3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jul 2016 16:54:29 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 12/32] x86/dumpstack/64: Handle faults when printing the "Stack:" part of an OOPS
Date: Mon, 11 Jul 2016 13:53:45 -0700
Message-ID: <8230a6f98a1646041c783350e099994bf2ccfcc4.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160711205345.vGeCYkMwQR1LU02G2Up4L1M_B9wRZwJfoVfuXkRCH58@z>

If we overflow the stack into a guard page, we'll recursively fault
when trying to dump the contents of the guard page.  Use
probe_kernel_address so we can recover if this happens.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack_64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index a81e1ef73bf2..6dede08dd98b 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -274,6 +274,8 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
+		unsigned long word;
+
 		if (stack >= irq_stack && stack <= irq_stack_end) {
 			if (stack == irq_stack_end) {
 				stack = (unsigned long *) (irq_stack_end[-1]);
@@ -283,12 +285,18 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 		if (kstack_end(stack))
 			break;
 		}
+
+		if (probe_kernel_address(stack, word))
+			break;
+
 		if ((i % STACKSLOTS_PER_LINE) == 0) {
 			if (i != 0)
 				pr_cont("\n");
-			printk("%s %016lx", log_lvl, *stack++);
+			printk("%s %016lx", log_lvl, word);
 		} else
-			pr_cont(" %016lx", *stack++);
+			pr_cont(" %016lx", word);
+
+		stack++;
 		touch_nmi_watchdog();
 	}
 	preempt_enable();
-- 
2.7.4

