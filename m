Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59524 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258AbcFQUBL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jun 2016 16:01:11 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 11/13] x86/dumpstack/64: Handle faults when printing the "Stack:" part of an OOPS
Date: Fri, 17 Jun 2016 13:00:47 -0700
Message-ID: <bdb80a7119a4045a7c7d78218d14100b027ed1f6.1466192946.git.luto@kernel.org>
In-Reply-To: <cover.1466192946.git.luto@kernel.org>
References: <cover.1466192946.git.luto@kernel.org>
In-Reply-To: <cover.1466192946.git.luto@kernel.org>
References: <cover.1466192946.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160617200047.sCSb7MA-wh4iIMDMysJGJYrcSUdj2i_M1d6Zep-qUr0@z>

If we overflow the stack into a guard page, we'll recursively fault
when trying to dump the contents of the guard page.  Use
probe_kernel_address so we can recover if this happens.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack_64.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 603356a5597a..5e298638c790 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -276,6 +276,8 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
+		unsigned long word;
+
 		if (stack >= irq_stack && stack <= irq_stack_end) {
 			if (stack == irq_stack_end) {
 				stack = (unsigned long *) (irq_stack_end[-1]);
@@ -285,12 +287,18 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
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
2.5.5

