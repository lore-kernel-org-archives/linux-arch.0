Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34464 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbcGKUy2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jul 2016 16:54:28 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 11/32] x86/dumpstack: Try harder to get a call trace on stack overflow
Date: Mon, 11 Jul 2016 13:53:44 -0700
Message-ID: <f3337dd324e86d7a56bce884ef3fde572e7fa281.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160711205344.JjRmEwB2RBCYjRHJvyD3Ude4dradloSt4jMZHs2JNBA@z>

If we overflow the stack, print_context_stack will abort.  Detect
this case and rewind back into the valid part of the stack so that
we can trace it.

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 4eefee06f6fd..de8242d8bb61 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -87,7 +87,7 @@ static inline int valid_stack_ptr(struct task_struct *task,
 		else
 			return 0;
 	}
-	return p > t && p < t + THREAD_SIZE - size;
+	return p >= t && p < t + THREAD_SIZE - size;
 }
 
 unsigned long
@@ -98,6 +98,14 @@ print_context_stack(struct task_struct *task,
 {
 	struct stack_frame *frame = (struct stack_frame *)bp;
 
+	/*
+	 * If we overflowed the stack into a guard page, jump back to the
+	 * bottom of the usable stack.
+	 */
+	if ((unsigned long)task_stack_page(task) - (unsigned long)stack <
+	    PAGE_SIZE)
+		stack = (unsigned long *)task_stack_page(task);
+
 	while (valid_stack_ptr(task, stack, sizeof(*stack), end)) {
 		unsigned long addr;
 
-- 
2.7.4

