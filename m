From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 10/32] x86/dumpstack: Honor supplied @regs arg
Date: Mon, 11 Jul 2016 13:53:43 -0700
Message-ID: <7207ea4229bf55bbfad565f693f33151d9e7c006.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-3907-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
In-Reply-To: <cover.1468270393.git.luto@kernel.org>
References: <cover.1468270393.git.luto@kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Denys Vlasenko <dvlasenk@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

[cherry-picked from ef16dd0c2a523d2e3975bb1bea9f5727e3e7146f to
 avoid tangling the trees too much.]

The comment suggests that show_stack(NULL, NULL) should backtrace the
current context, but the code doesn't match the comment. If regs are
given, start the "Stack:" hexdump at regs->sp.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1467671487-10344-2-git-send-email-bp@alien8.de
Link: http://lkml.kernel.org/r/efcd79bf4106d61f1cd258c2caa87f3a0618eeac.1466036668.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/dumpstack_32.c | 4 +++-
 arch/x86/kernel/dumpstack_64.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index fef917e79b9d..948d77da3881 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -96,7 +96,9 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
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
index d558a8a49016..a81e1ef73bf2 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -264,7 +264,9 @@ show_stack_log_lvl(struct task_struct *task, struct pt_regs *regs,
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
2.7.4
