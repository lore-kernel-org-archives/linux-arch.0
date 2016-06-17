Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59370 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933220AbcFQUBG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jun 2016 16:01:06 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 09/13] x86/dumpstack: When dumping stack bytes due to OOPS, start with regs->sp
Date: Fri, 17 Jun 2016 13:00:45 -0700
Message-ID: <ac1423ff89885723ceb5c9cb1615b258b2f11544.1466192946.git.luto@kernel.org>
In-Reply-To: <cover.1466192946.git.luto@kernel.org>
References: <cover.1466192946.git.luto@kernel.org>
In-Reply-To: <cover.1466192946.git.luto@kernel.org>
References: <cover.1466192946.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160617200045.3z0N2RZ62-3LApCguHid9A1VV-r1Xz2SLNU9eYI5Hbk@z>

The comment suggests that show_stack(NULL, NULL) should backtrace
the current context, but the code doesn't match the comment.  If
regs are given, start the "Stack:" hexdump at regs->sp.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack_32.c | 4 +++-
 arch/x86/kernel/dumpstack_64.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 464ffd69b92e..91069ebe3c87 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -98,7 +98,9 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	int i;
 
 	if (sp == NULL) {
-		if (task)
+		if (regs)
+			sp = (unsigned long *)regs->sp;
+		else if (task)
 			sp = (unsigned long *)task->thread.sp;
 		else
 			sp = (unsigned long *)&sp;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 5f1c6266eb30..603356a5597a 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -266,7 +266,9 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	 * back trace for this cpu:
 	 */
 	if (sp == NULL) {
-		if (task)
+		if (regs)
+			sp = (unsigned long *)regs->sp;
+		else if (task)
 			sp = (unsigned long *)task->thread.sp;
 		else
 			sp = (unsigned long *)&sp;
-- 
2.5.5

