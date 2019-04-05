Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfDEOSj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 10:18:39 -0400
Date: Fri, 5 Apr 2019 10:18:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] tracing/syscalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190405101832.1273bfac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190405141832.x7u3k5T-8_B1TAe3FT8ntHhrfaV1wkyOda9t8etJw5k@z>


Linus,

Andy Lutomirski approached me to tell me that the syscall_get_arguments()
implementation in x86 was horrible and gcc certainly gets it wrong. He
said that since the tracepoints only pass in 0 and 6 for i and n repectively,
it should be optimized for that case. Inspecting the kernel, I discovered
that all users pass in 0 for i and only one file passing in something other
than 6 for the number of arguments. That code happens to be my own code used
for the special syscall tracing. That can easily be converted to just
using 0 and 6 as well, and only copying what is needed. Which is probably
the faster path anyway for that case.

Along the way, a couple of real fixes came from this as the
syscall_get_arguments() function was incorrect for csky and riscv.

x86 has been optimized too for the new interface that removes the
variable number of arguments, but the other architectures could still
use some loving and take more advantage of the simpler interface.


Please pull the latest trace-5.1-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-5.1-rc3

Tag SHA1: bdded9c1646e635228e68af36bb145a357c0b769
Head SHA1: 32d92586629a8b3637a3c9361709818e25f327ad


Dmitry V. Levin (2):
      riscv: Fix syscall_get_arguments() and syscall_set_arguments()
      csky: Fix syscall_get_arguments() and syscall_set_arguments()

Steven Rostedt (Red Hat) (3):
      ptrace: Remove maxargs from task_current_syscall()
      tracing/syscalls: Pass in hardcoded 6 into syscall_get_arguments()
      syscalls: Remove start and number from syscall_get_arguments() args

Steven Rostedt (VMware) (1):
      syscalls: Remove start and number from syscall_set_arguments() args

----
 arch/arc/include/asm/syscall.h        |   7 +-
 arch/arm/include/asm/syscall.h        |  47 ++---------
 arch/arm64/include/asm/syscall.h      |  46 ++---------
 arch/c6x/include/asm/syscall.h        |  79 ++++---------------
 arch/csky/include/asm/syscall.h       |  26 ++-----
 arch/h8300/include/asm/syscall.h      |  34 ++------
 arch/hexagon/include/asm/syscall.h    |   4 +-
 arch/ia64/include/asm/syscall.h       |  13 +---
 arch/ia64/kernel/ptrace.c             |   7 +-
 arch/microblaze/include/asm/syscall.h |   8 +-
 arch/mips/include/asm/syscall.h       |   3 +-
 arch/mips/kernel/ptrace.c             |   2 +-
 arch/nds32/include/asm/syscall.h      |  62 +++------------
 arch/nios2/include/asm/syscall.h      |  84 ++++----------------
 arch/openrisc/include/asm/syscall.h   |  12 +--
 arch/parisc/include/asm/syscall.h     |  30 ++-----
 arch/powerpc/include/asm/syscall.h    |  15 ++--
 arch/riscv/include/asm/syscall.h      |  24 ++----
 arch/s390/include/asm/syscall.h       |  28 +++----
 arch/sh/include/asm/syscall_32.h      |  47 +++--------
 arch/sh/include/asm/syscall_64.h      |   8 +-
 arch/sparc/include/asm/syscall.h      |  11 ++-
 arch/um/include/asm/syscall-generic.h |  78 +++----------------
 arch/x86/include/asm/syscall.h        | 142 ++++++++--------------------------
 arch/xtensa/include/asm/syscall.h     |  33 ++------
 fs/proc/base.c                        |  17 ++--
 include/asm-generic/syscall.h         |  21 ++---
 include/linux/ptrace.h                |  11 ++-
 include/trace/events/syscalls.h       |   2 +-
 kernel/seccomp.c                      |   2 +-
 kernel/trace/trace_syscalls.c         |   9 ++-
 lib/syscall.c                         |  57 ++++++--------
 32 files changed, 247 insertions(+), 722 deletions(-)
---------------------------
diff --git a/arch/arc/include/asm/syscall.h b/arch/arc/include/asm/syscall.h
index 29de09804306..c7a4201ed62b 100644
--- a/arch/arc/include/asm/syscall.h
+++ b/arch/arc/include/asm/syscall.h
@@ -55,12 +55,11 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  */
 static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args)
+		      unsigned long *args)
 {
 	unsigned long *inside_ptregs = &(regs->r0);
-	inside_ptregs -= i;
-
-	BUG_ON((i + n) > 6);
+	unsigned int n = 6;
+	unsigned int i = 0;
 
 	while (n--) {
 		args[i++] = (*inside_ptregs);
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 06dea6bce293..080ce70cab12 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -55,53 +55,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	if (n == 0)
-		return;
-
-	if (i + n > SYSCALL_MAX_ARGS) {
-		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
-		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
-		pr_warn("%s called with max args %d, handling only %d\n",
-			__func__, i + n, SYSCALL_MAX_ARGS);
-		memset(args_bad, 0, n_bad * sizeof(args[0]));
-		n = SYSCALL_MAX_ARGS - i;
-	}
-
-	if (i == 0) {
-		args[0] = regs->ARM_ORIG_r0;
-		args++;
-		i++;
-		n--;
-	}
-
-	memcpy(args, &regs->ARM_r0 + i, n * sizeof(args[0]));
+	args[0] = regs->ARM_ORIG_r0;
+	args++;
+
+	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	if (n == 0)
-		return;
-
-	if (i + n > SYSCALL_MAX_ARGS) {
-		pr_warn("%s called with max args %d, handling only %d\n",
-			__func__, i + n, SYSCALL_MAX_ARGS);
-		n = SYSCALL_MAX_ARGS - i;
-	}
-
-	if (i == 0) {
-		regs->ARM_ORIG_r0 = args[0];
-		args++;
-		i++;
-		n--;
-	}
-
-	memcpy(&regs->ARM_r0 + i, args, n * sizeof(args[0]));
+	regs->ARM_ORIG_r0 = args[0];
+	args++;
+
+	memcpy(&regs->ARM_r0 + 1, args, 5 * sizeof(args[0]));
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index ad8be16a39c9..a179df3674a1 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -65,52 +65,22 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	if (n == 0)
-		return;
-
-	if (i + n > SYSCALL_MAX_ARGS) {
-		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
-		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
-		pr_warning("%s called with max args %d, handling only %d\n",
-			   __func__, i + n, SYSCALL_MAX_ARGS);
-		memset(args_bad, 0, n_bad * sizeof(args[0]));
-	}
-
-	if (i == 0) {
-		args[0] = regs->orig_x0;
-		args++;
-		i++;
-		n--;
-	}
-
-	memcpy(args, &regs->regs[i], n * sizeof(args[0]));
+	args[0] = regs->orig_x0;
+	args++;
+
+	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	if (n == 0)
-		return;
-
-	if (i + n > SYSCALL_MAX_ARGS) {
-		pr_warning("%s called with max args %d, handling only %d\n",
-			   __func__, i + n, SYSCALL_MAX_ARGS);
-		n = SYSCALL_MAX_ARGS - i;
-	}
-
-	if (i == 0) {
-		regs->orig_x0 = args[0];
-		args++;
-		i++;
-		n--;
-	}
-
-	memcpy(&regs->regs[i], args, n * sizeof(args[0]));
+	regs->orig_x0 = args[0];
+	args++;
+
+	memcpy(&regs->regs[1], args, 5 * sizeof(args[0]));
 }
 
 /*
diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
index ae2be315ee9c..15ba8599858e 100644
--- a/arch/c6x/include/asm/syscall.h
+++ b/arch/c6x/include/asm/syscall.h
@@ -46,78 +46,27 @@ static inline void syscall_set_return_value(struct task_struct *task,
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
-					 struct pt_regs *regs, unsigned int i,
-					 unsigned int n, unsigned long *args)
+					 struct pt_regs *regs,
+					 unsigned long *args)
 {
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		*args++ = regs->a4;
-	case 1:
-		if (!n--)
-			break;
-		*args++ = regs->b4;
-	case 2:
-		if (!n--)
-			break;
-		*args++ = regs->a6;
-	case 3:
-		if (!n--)
-			break;
-		*args++ = regs->b6;
-	case 4:
-		if (!n--)
-			break;
-		*args++ = regs->a8;
-	case 5:
-		if (!n--)
-			break;
-		*args++ = regs->b8;
-	case 6:
-		if (!n--)
-			break;
-	default:
-		BUG();
-	}
+	*args++ = regs->a4;
+	*args++ = regs->b4;
+	*args++ = regs->a6;
+	*args++ = regs->b6;
+	*args++ = regs->a8;
+	*args   = regs->b8;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		regs->a4 = *args++;
-	case 1:
-		if (!n--)
-			break;
-		regs->b4 = *args++;
-	case 2:
-		if (!n--)
-			break;
-		regs->a6 = *args++;
-	case 3:
-		if (!n--)
-			break;
-		regs->b6 = *args++;
-	case 4:
-		if (!n--)
-			break;
-		regs->a8 = *args++;
-	case 5:
-		if (!n--)
-			break;
-		regs->a9 = *args++;
-	case 6:
-		if (!n)
-			break;
-	default:
-		BUG();
-	}
+	regs->a4 = *args++;
+	regs->b4 = *args++;
+	regs->a6 = *args++;
+	regs->b6 = *args++;
+	regs->a8 = *args++;
+	regs->a9 = *args;
 }
 
 #endif /* __ASM_C6X_SYSCALLS_H */
diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index d637445737b7..bda0a446c63e 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -43,30 +43,20 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 
 static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args)
+		      unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	if (i == 0) {
-		args[0] = regs->orig_a0;
-		args++;
-		i++;
-		n--;
-	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	args[0] = regs->orig_a0;
+	args++;
+	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
 }
 
 static inline void
 syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, const unsigned long *args)
+		      const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	if (i == 0) {
-		regs->orig_a0 = args[0];
-		args++;
-		i++;
-		n--;
-	}
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	regs->orig_a0 = args[0];
+	args++;
+	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
 }
 
 static inline int
diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
index 924990401237..ddd483c6ca95 100644
--- a/arch/h8300/include/asm/syscall.h
+++ b/arch/h8300/include/asm/syscall.h
@@ -17,34 +17,14 @@ syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 
 static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args)
+		      unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	while (n > 0) {
-		switch (i) {
-		case 0:
-			*args++ = regs->er1;
-			break;
-		case 1:
-			*args++ = regs->er2;
-			break;
-		case 2:
-			*args++ = regs->er3;
-			break;
-		case 3:
-			*args++ = regs->er4;
-			break;
-		case 4:
-			*args++ = regs->er5;
-			break;
-		case 5:
-			*args++ = regs->er6;
-			break;
-		}
-		i++;
-		n--;
-	}
+	*args++ = regs->er1;
+	*args++ = regs->er2;
+	*args++ = regs->er3;
+	*args++ = regs->er4;
+	*args++ = regs->er5;
+	*args   = regs->er6;
 }
 
 
diff --git a/arch/hexagon/include/asm/syscall.h b/arch/hexagon/include/asm/syscall.h
index 4af9c7b6f13a..ae3a1e24fabd 100644
--- a/arch/hexagon/include/asm/syscall.h
+++ b/arch/hexagon/include/asm/syscall.h
@@ -37,10 +37,8 @@ static inline long syscall_get_nr(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(args, &(&regs->r00)[i], n * sizeof(args[0]));
+	memcpy(args, &(&regs->r00)[0], 6 * sizeof(args[0]));
 }
 #endif
diff --git a/arch/ia64/include/asm/syscall.h b/arch/ia64/include/asm/syscall.h
index 1d0b875fec44..0d9e7fab4a79 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -59,26 +59,19 @@ static inline void syscall_set_return_value(struct task_struct *task,
 }
 
 extern void ia64_syscall_get_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned int i, unsigned int n,
-	unsigned long *args, int rw);
+	struct pt_regs *regs, unsigned long *args, int rw);
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	ia64_syscall_get_set_arguments(task, regs, i, n, args, 0);
+	ia64_syscall_get_set_arguments(task, regs, args, 0);
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	ia64_syscall_get_set_arguments(task, regs, i, n, args, 1);
+	ia64_syscall_get_set_arguments(task, regs, args, 1);
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 6d50ede0ed69..bf9c24d9ce84 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -2179,12 +2179,11 @@ static void syscall_get_set_args_cb(struct unw_frame_info *info, void *data)
 }
 
 void ia64_syscall_get_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned int i, unsigned int n,
-	unsigned long *args, int rw)
+	struct pt_regs *regs, unsigned long *args, int rw)
 {
 	struct syscall_get_set_args data = {
-		.i = i,
-		.n = n,
+		.i = 0,
+		.n = 6,
 		.args = args,
 		.regs = regs,
 		.rw = rw,
diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 220decd605a4..833d3a53dab3 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -82,18 +82,22 @@ static inline void microblaze_set_syscall_arg(struct pt_regs *regs,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
+	unsigned int i = 0;
+	unsigned int n = 6;
+
 	while (n--)
 		*args++ = microblaze_get_syscall_arg(regs, i++);
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
+	unsigned int i = 0;
+	unsigned int n = 6;
+
 	while (n--)
 		microblaze_set_syscall_arg(regs, i++, *args++);
 }
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index 6cf8ffb5367e..a2b4748655df 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -116,9 +116,10 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
+	unsigned int i = 0;
+	unsigned int n = 6;
 	int ret;
 
 	/* O32 ABI syscall() */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 0057c910bc2f..3a62f80958e1 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1419,7 +1419,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 
 		sd.nr = syscall;
 		sd.arch = syscall_get_arch();
-		syscall_get_arguments(current, regs, 0, 6, args);
+		syscall_get_arguments(current, regs, args);
 		for (i = 0; i < 6; i++)
 			sd.args[i] = args[i];
 		sd.instruction_pointer = KSTK_EIP(current);
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index f7e5e86765fe..671ebd357496 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -108,81 +108,41 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * syscall_get_arguments - extract system call parameter values
  * @task:	task of interest, must be blocked
  * @regs:	task_pt_regs() of @task
- * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
  * @args:	array filled with argument values
  *
- * Fetches @n arguments to the system call starting with the @i'th argument
- * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
- * An arch inline version is probably optimal when @i and @n are constants.
+ * Fetches 6 arguments to the system call (from 0 through 5). The first
+ * argument is stored in @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- * It's invalid to call this with @i + @n > 6; we only support system calls
- * taking up to 6 arguments.
  */
 #define SYSCALL_MAX_ARGS 6
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n, unsigned long *args)
+			   unsigned long *args)
 {
-	if (n == 0)
-		return;
-	if (i + n > SYSCALL_MAX_ARGS) {
-		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
-		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
-		pr_warning("%s called with max args %d, handling only %d\n",
-			   __func__, i + n, SYSCALL_MAX_ARGS);
-		memset(args_bad, 0, n_bad * sizeof(args[0]));
-		memset(args_bad, 0, n_bad * sizeof(args[0]));
-	}
-
-	if (i == 0) {
-		args[0] = regs->orig_r0;
-		args++;
-		i++;
-		n--;
-	}
-
-	memcpy(args, &regs->uregs[0] + i, n * sizeof(args[0]));
+	args[0] = regs->orig_r0;
+	args++;
+	memcpy(args, &regs->uregs[0] + 1, 5 * sizeof(args[0]));
 }
 
 /**
  * syscall_set_arguments - change system call parameter value
  * @task:	task of interest, must be in system call entry tracing
  * @regs:	task_pt_regs() of @task
- * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
  * @args:	array of argument values to store
  *
- * Changes @n arguments to the system call starting with the @i'th argument.
- * Argument @i gets value @args[0], and so on.
- * An arch inline version is probably optimal when @i and @n are constants.
+ * Changes 6 arguments to the system call. The first argument gets value
+ * @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- * It's invalid to call this with @i + @n > 6; we only support system calls
- * taking up to 6 arguments.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n,
 			   const unsigned long *args)
 {
-	if (n == 0)
-		return;
-
-	if (i + n > SYSCALL_MAX_ARGS) {
-		pr_warn("%s called with max args %d, handling only %d\n",
-			__func__, i + n, SYSCALL_MAX_ARGS);
-		n = SYSCALL_MAX_ARGS - i;
-	}
-
-	if (i == 0) {
-		regs->orig_r0 = args[0];
-		args++;
-		i++;
-		n--;
-	}
+	regs->orig_r0 = args[0];
+	args++;
 
-	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
+	memcpy(&regs->uregs[0] + 1, args, 5 * sizeof(args[0]));
 }
 #endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 9de220854c4a..d7624ed06efb 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -58,81 +58,25 @@ static inline void syscall_set_return_value(struct task_struct *task,
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned int i, unsigned int n,
-	unsigned long *args)
+	struct pt_regs *regs, unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		*args++ = regs->r4;
-	case 1:
-		if (!n--)
-			break;
-		*args++ = regs->r5;
-	case 2:
-		if (!n--)
-			break;
-		*args++ = regs->r6;
-	case 3:
-		if (!n--)
-			break;
-		*args++ = regs->r7;
-	case 4:
-		if (!n--)
-			break;
-		*args++ = regs->r8;
-	case 5:
-		if (!n--)
-			break;
-		*args++ = regs->r9;
-	case 6:
-		if (!n--)
-			break;
-	default:
-		BUG();
-	}
+	*args++ = regs->r4;
+	*args++ = regs->r5;
+	*args++ = regs->r6;
+	*args++ = regs->r7;
+	*args++ = regs->r8;
+	*args   = regs->r9;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
-	struct pt_regs *regs, unsigned int i, unsigned int n,
-	const unsigned long *args)
+	struct pt_regs *regs, const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		regs->r4 = *args++;
-	case 1:
-		if (!n--)
-			break;
-		regs->r5 = *args++;
-	case 2:
-		if (!n--)
-			break;
-		regs->r6 = *args++;
-	case 3:
-		if (!n--)
-			break;
-		regs->r7 = *args++;
-	case 4:
-		if (!n--)
-			break;
-		regs->r8 = *args++;
-	case 5:
-		if (!n--)
-			break;
-		regs->r9 = *args++;
-	case 6:
-		if (!n)
-			break;
-	default:
-		BUG();
-	}
+	regs->r4 = *args++;
+	regs->r5 = *args++;
+	regs->r6 = *args++;
+	regs->r7 = *args++;
+	regs->r8 = *args++;
+	regs->r9 = *args;
 }
 
 #endif
diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
index 2db9f1cf0694..b4ff07c1baed 100644
--- a/arch/openrisc/include/asm/syscall.h
+++ b/arch/openrisc/include/asm/syscall.h
@@ -56,20 +56,16 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 
 static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args)
+		      unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	memcpy(args, &regs->gpr[3 + i], n * sizeof(args[0]));
+	memcpy(args, &regs->gpr[3], 6 * sizeof(args[0]));
 }
 
 static inline void
 syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, const unsigned long *args)
+		      const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
+	memcpy(&regs->gpr[3], args, 6 * sizeof(args[0]));
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 8bff1a58c97f..62a6d477fae0 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -18,29 +18,15 @@ static inline long syscall_get_nr(struct task_struct *tsk,
 }
 
 static inline void syscall_get_arguments(struct task_struct *tsk,
-					 struct pt_regs *regs, unsigned int i,
-					 unsigned int n, unsigned long *args)
+					 struct pt_regs *regs,
+					 unsigned long *args)
 {
-	BUG_ON(i);
-
-	switch (n) {
-	case 6:
-		args[5] = regs->gr[21];
-	case 5:
-		args[4] = regs->gr[22];
-	case 4:
-		args[3] = regs->gr[23];
-	case 3:
-		args[2] = regs->gr[24];
-	case 2:
-		args[1] = regs->gr[25];
-	case 1:
-		args[0] = regs->gr[26];
-	case 0:
-		break;
-	default:
-		BUG();
-	}
+	args[5] = regs->gr[21];
+	args[4] = regs->gr[22];
+	args[3] = regs->gr[23];
+	args[2] = regs->gr[24];
+	args[1] = regs->gr[25];
+	args[0] = regs->gr[26];
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 1a0e7a8b1c81..1243045bad2d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -65,22 +65,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	unsigned long val, mask = -1UL;
-
-	BUG_ON(i + n > 6);
+	unsigned int n = 6;
 
 #ifdef CONFIG_COMPAT
 	if (test_tsk_thread_flag(task, TIF_32BIT))
 		mask = 0xffffffff;
 #endif
 	while (n--) {
-		if (n == 0 && i == 0)
+		if (n == 0)
 			val = regs->orig_gpr3;
 		else
-			val = regs->gpr[3 + i + n];
+			val = regs->gpr[3 + n];
 
 		args[n] = val & mask;
 	}
@@ -88,15 +86,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(&regs->gpr[3 + i], args, n * sizeof(args[0]));
+	memcpy(&regs->gpr[3], args, 6 * sizeof(args[0]));
 
 	/* Also copy the first argument into orig_gpr3 */
-	if (i == 0 && n > 0)
-		regs->orig_gpr3 = args[0];
+	regs->orig_gpr3 = args[0];
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index bba3da6ef157..a3d5273ded7c 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -72,32 +72,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	if (i == 0) {
-		args[0] = regs->orig_a0;
-		args++;
-		i++;
-		n--;
-	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	args[0] = regs->orig_a0;
+	args++;
+	memcpy(args, &regs->a1, 5 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-        if (i == 0) {
-                regs->orig_a0 = args[0];
-                args++;
-                i++;
-                n--;
-        }
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	regs->orig_a0 = args[0];
+	args++;
+	memcpy(&regs->a1, args, 5 * sizeof(regs->a1));
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 96f9a9151fde..59c3e91f2cdb 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -56,40 +56,32 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	unsigned long mask = -1UL;
+	unsigned int n = 6;
 
-	/*
-	 * No arguments for this syscall, there's nothing to do.
-	 */
-	if (!n)
-		return;
-
-	BUG_ON(i + n > 6);
 #ifdef CONFIG_COMPAT
 	if (test_tsk_thread_flag(task, TIF_31BIT))
 		mask = 0xffffffff;
 #endif
 	while (n-- > 0)
-		if (i + n > 0)
-			args[n] = regs->gprs[2 + i + n] & mask;
-	if (i == 0)
-		args[0] = regs->orig_gpr2 & mask;
+		if (n > 0)
+			args[n] = regs->gprs[2 + n] & mask;
+
+	args[0] = regs->orig_gpr2 & mask;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
+	unsigned int n = 6;
+
 	while (n-- > 0)
-		if (i + n > 0)
-			regs->gprs[2 + i + n] = args[n];
-	if (i == 0)
-		regs->orig_gpr2 = args[0];
+		if (n > 0)
+			regs->gprs[2 + n] = args[n];
+	regs->orig_gpr2 = args[0];
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 6e118799831c..8c9d7e5e5dcc 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -48,51 +48,28 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	/*
-	 * Do this simply for now. If we need to start supporting
-	 * fetching arguments from arbitrary indices, this will need some
-	 * extra logic. Presently there are no in-tree users that depend
-	 * on this behaviour.
-	 */
-	BUG_ON(i);
 
 	/* Argument pattern is: R4, R5, R6, R7, R0, R1 */
-	switch (n) {
-	case 6: args[5] = regs->regs[1];
-	case 5: args[4] = regs->regs[0];
-	case 4: args[3] = regs->regs[7];
-	case 3: args[2] = regs->regs[6];
-	case 2: args[1] = regs->regs[5];
-	case 1:	args[0] = regs->regs[4];
-	case 0:
-		break;
-	default:
-		BUG();
-	}
+	args[5] = regs->regs[1];
+	args[4] = regs->regs[0];
+	args[3] = regs->regs[7];
+	args[2] = regs->regs[6];
+	args[1] = regs->regs[5];
+	args[0] = regs->regs[4];
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	/* Same note as above applies */
-	BUG_ON(i);
-
-	switch (n) {
-	case 6: regs->regs[1] = args[5];
-	case 5: regs->regs[0] = args[4];
-	case 4: regs->regs[7] = args[3];
-	case 3: regs->regs[6] = args[2];
-	case 2: regs->regs[5] = args[1];
-	case 1: regs->regs[4] = args[0];
-		break;
-	default:
-		BUG();
-	}
+	regs->regs[1] = args[5];
+	regs->regs[0] = args[4];
+	regs->regs[7] = args[3];
+	regs->regs[6] = args[2];
+	regs->regs[5] = args[1];
+	regs->regs[4] = args[0];
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index 43882580c7f9..22fad97da066 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -47,20 +47,16 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(args, &regs->regs[2 + i], n * sizeof(args[0]));
+	memcpy(args, &regs->regs[2], 6 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(&regs->regs[2 + i], args, n * sizeof(args[0]));
+	memcpy(&regs->regs[2], args, 6 * sizeof(args[0]));
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 053989e3f6a6..4d075434e816 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -96,11 +96,11 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	int zero_extend = 0;
 	unsigned int j;
+	unsigned int n = 6;
 
 #ifdef CONFIG_SPARC64
 	if (test_tsk_thread_flag(task, TIF_32BIT))
@@ -108,7 +108,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 #endif
 
 	for (j = 0; j < n; j++) {
-		unsigned long val = regs->u_regs[UREG_I0 + i + j];
+		unsigned long val = regs->u_regs[UREG_I0 + j];
 
 		if (zero_extend)
 			args[j] = (u32) val;
@@ -119,13 +119,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
-	unsigned int j;
+	unsigned int i;
 
-	for (j = 0; j < n; j++)
-		regs->u_regs[UREG_I0 + i + j] = args[j];
+	for (i = 0; i < 6; i++)
+		regs->u_regs[UREG_I0 + i] = args[i];
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/um/include/asm/syscall-generic.h b/arch/um/include/asm/syscall-generic.h
index 9fb9cf8cd39a..98e50c50c12e 100644
--- a/arch/um/include/asm/syscall-generic.h
+++ b/arch/um/include/asm/syscall-generic.h
@@ -53,84 +53,30 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	const struct uml_pt_regs *r = &regs->regs;
 
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG1(r);
-	case 1:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG2(r);
-	case 2:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG3(r);
-	case 3:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG4(r);
-	case 4:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG5(r);
-	case 5:
-		if (!n--)
-			break;
-		*args++ = UPT_SYSCALL_ARG6(r);
-	case 6:
-		if (!n--)
-			break;
-	default:
-		BUG();
-		break;
-	}
+	*args++ = UPT_SYSCALL_ARG1(r);
+	*args++ = UPT_SYSCALL_ARG2(r);
+	*args++ = UPT_SYSCALL_ARG3(r);
+	*args++ = UPT_SYSCALL_ARG4(r);
+	*args++ = UPT_SYSCALL_ARG5(r);
+	*args   = UPT_SYSCALL_ARG6(r);
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
 	struct uml_pt_regs *r = &regs->regs;
 
-	switch (i) {
-	case 0:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG1(r) = *args++;
-	case 1:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG2(r) = *args++;
-	case 2:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG3(r) = *args++;
-	case 3:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG4(r) = *args++;
-	case 4:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG5(r) = *args++;
-	case 5:
-		if (!n--)
-			break;
-		UPT_SYSCALL_ARG6(r) = *args++;
-	case 6:
-		if (!n--)
-			break;
-	default:
-		BUG();
-		break;
-	}
+	UPT_SYSCALL_ARG1(r) = *args++;
+	UPT_SYSCALL_ARG2(r) = *args++;
+	UPT_SYSCALL_ARG3(r) = *args++;
+	UPT_SYSCALL_ARG4(r) = *args++;
+	UPT_SYSCALL_ARG5(r) = *args++;
+	UPT_SYSCALL_ARG6(r) = *args;
 }
 
 /* See arch/x86/um/asm/syscall.h for syscall_get_arch() definition. */
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index d653139857af..4c305471ec33 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -91,11 +91,9 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(args, &regs->bx + i, n * sizeof(args[0]));
+	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
@@ -116,124 +114,50 @@ static inline int syscall_get_arch(void)
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread_info.status & TS_COMPAT)
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			*args++ = regs->bx;
-		case 1:
-			if (!n--) break;
-			*args++ = regs->cx;
-		case 2:
-			if (!n--) break;
-			*args++ = regs->dx;
-		case 3:
-			if (!n--) break;
-			*args++ = regs->si;
-		case 4:
-			if (!n--) break;
-			*args++ = regs->di;
-		case 5:
-			if (!n--) break;
-			*args++ = regs->bp;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
-	else
+	if (task->thread_info.status & TS_COMPAT) {
+		*args++ = regs->bx;
+		*args++ = regs->cx;
+		*args++ = regs->dx;
+		*args++ = regs->si;
+		*args++ = regs->di;
+		*args   = regs->bp;
+	} else
 # endif
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			*args++ = regs->di;
-		case 1:
-			if (!n--) break;
-			*args++ = regs->si;
-		case 2:
-			if (!n--) break;
-			*args++ = regs->dx;
-		case 3:
-			if (!n--) break;
-			*args++ = regs->r10;
-		case 4:
-			if (!n--) break;
-			*args++ = regs->r8;
-		case 5:
-			if (!n--) break;
-			*args++ = regs->r9;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
+	{
+		*args++ = regs->di;
+		*args++ = regs->si;
+		*args++ = regs->dx;
+		*args++ = regs->r10;
+		*args++ = regs->r8;
+		*args   = regs->r9;
+	}
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread_info.status & TS_COMPAT)
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			regs->bx = *args++;
-		case 1:
-			if (!n--) break;
-			regs->cx = *args++;
-		case 2:
-			if (!n--) break;
-			regs->dx = *args++;
-		case 3:
-			if (!n--) break;
-			regs->si = *args++;
-		case 4:
-			if (!n--) break;
-			regs->di = *args++;
-		case 5:
-			if (!n--) break;
-			regs->bp = *args++;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
-	else
+	if (task->thread_info.status & TS_COMPAT) {
+		regs->bx = *args++;
+		regs->cx = *args++;
+		regs->dx = *args++;
+		regs->si = *args++;
+		regs->di = *args++;
+		regs->bp = *args;
+	} else
 # endif
-		switch (i) {
-		case 0:
-			if (!n--) break;
-			regs->di = *args++;
-		case 1:
-			if (!n--) break;
-			regs->si = *args++;
-		case 2:
-			if (!n--) break;
-			regs->dx = *args++;
-		case 3:
-			if (!n--) break;
-			regs->r10 = *args++;
-		case 4:
-			if (!n--) break;
-			regs->r8 = *args++;
-		case 5:
-			if (!n--) break;
-			regs->r9 = *args++;
-		case 6:
-			if (!n--) break;
-		default:
-			BUG();
-			break;
-		}
+	{
+		regs->di = *args++;
+		regs->si = *args++;
+		regs->dx = *args++;
+		regs->r10 = *args++;
+		regs->r8 = *args++;
+		regs->r9 = *args;
+	}
 }
 
 static inline int syscall_get_arch(void)
diff --git a/arch/xtensa/include/asm/syscall.h b/arch/xtensa/include/asm/syscall.h
index a168bf81c7f4..91dc06d58060 100644
--- a/arch/xtensa/include/asm/syscall.h
+++ b/arch/xtensa/include/asm/syscall.h
@@ -59,45 +59,24 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	static const unsigned int reg[] = XTENSA_SYSCALL_ARGUMENT_REGS;
-	unsigned int j;
+	unsigned int i;
 
-	if (n == 0)
-		return;
-
-	WARN_ON_ONCE(i + n > SYSCALL_MAX_ARGS);
-
-	for (j = 0; j < n; ++j) {
-		if (i + j < SYSCALL_MAX_ARGS)
-			args[j] = regs->areg[reg[i + j]];
-		else
-			args[j] = 0;
-	}
+	for (i = 0; i < 6; ++i)
+		args[i] = regs->areg[reg[i]];
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
 	static const unsigned int reg[] = XTENSA_SYSCALL_ARGUMENT_REGS;
-	unsigned int j;
-
-	if (n == 0)
-		return;
-
-	if (WARN_ON_ONCE(i + n > SYSCALL_MAX_ARGS)) {
-		if (i < SYSCALL_MAX_ARGS)
-			n = SYSCALL_MAX_ARGS - i;
-		else
-			return;
-	}
+	unsigned int i;
 
-	for (j = 0; j < n; ++j)
-		regs->areg[reg[i + j]] = args[j];
+	for (i = 0; i < 6; ++i)
+		regs->areg[reg[i]] = args[i];
 }
 
 asmlinkage long xtensa_rt_sigreturn(struct pt_regs*);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..6a803a0b75df 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -616,24 +616,25 @@ static int proc_pid_limits(struct seq_file *m, struct pid_namespace *ns,
 static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 			    struct pid *pid, struct task_struct *task)
 {
-	long nr;
-	unsigned long args[6], sp, pc;
+	struct syscall_info info;
+	u64 *args = &info.data.args[0];
 	int res;
 
 	res = lock_trace(task);
 	if (res)
 		return res;
 
-	if (task_current_syscall(task, &nr, args, 6, &sp, &pc))
+	if (task_current_syscall(task, &info))
 		seq_puts(m, "running\n");
-	else if (nr < 0)
-		seq_printf(m, "%ld 0x%lx 0x%lx\n", nr, sp, pc);
+	else if (info.data.nr < 0)
+		seq_printf(m, "%d 0x%llx 0x%llx\n",
+			   info.data.nr, info.sp, info.data.instruction_pointer);
 	else
 		seq_printf(m,
-		       "%ld 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       nr,
+		       "%d 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx 0x%llx\n",
+		       info.data.nr,
 		       args[0], args[1], args[2], args[3], args[4], args[5],
-		       sp, pc);
+		       info.sp, info.data.instruction_pointer);
 	unlock_trace(task);
 
 	return 0;
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 0c938a4354f6..b88239e9efe4 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -105,41 +105,30 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * syscall_get_arguments - extract system call parameter values
  * @task:	task of interest, must be blocked
  * @regs:	task_pt_regs() of @task
- * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
  * @args:	array filled with argument values
  *
- * Fetches @n arguments to the system call starting with the @i'th argument
- * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
- * An arch inline version is probably optimal when @i and @n are constants.
+ * Fetches 6 arguments to the system call.  First argument is stored in
+*  @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- * It's invalid to call this with @i + @n > 6; we only support system calls
- * taking up to 6 arguments.
  */
 void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n, unsigned long *args);
+			   unsigned long *args);
 
 /**
  * syscall_set_arguments - change system call parameter value
  * @task:	task of interest, must be in system call entry tracing
  * @regs:	task_pt_regs() of @task
- * @i:		argument index [0,5]
- * @n:		number of arguments; n+i must be [1,6].
  * @args:	array of argument values to store
  *
- * Changes @n arguments to the system call starting with the @i'th argument.
- * Argument @i gets value @args[0], and so on.
- * An arch inline version is probably optimal when @i and @n are constants.
+ * Changes 6 arguments to the system call.
+ * The first argument gets value @args[0], and so on.
  *
  * It's only valid to call this when @task is stopped for tracing on
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
- * It's invalid to call this with @i + @n > 6; we only support system calls
- * taking up to 6 arguments.
  */
 void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n,
 			   const unsigned long *args);
 
 /**
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index edb9b040c94c..d5084ebd9f03 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -9,6 +9,13 @@
 #include <linux/bug.h>			/* For BUG_ON.  */
 #include <linux/pid_namespace.h>	/* For task_active_pid_ns.  */
 #include <uapi/linux/ptrace.h>
+#include <linux/seccomp.h>
+
+/* Add sp to seccomp_data, as seccomp is user API, we don't want to modify it */
+struct syscall_info {
+	__u64			sp;
+	struct seccomp_data	data;
+};
 
 extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 			    void *buf, int len, unsigned int gup_flags);
@@ -407,9 +414,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
 
-extern int task_current_syscall(struct task_struct *target, long *callno,
-				unsigned long args[6], unsigned int maxargs,
-				unsigned long *sp, unsigned long *pc);
+extern int task_current_syscall(struct task_struct *target, struct syscall_info *info);
 
 extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oact);
 #endif
diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index 44a3259ed4a5..b6e0cbc2c71f 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -28,7 +28,7 @@ TRACE_EVENT_FN(sys_enter,
 
 	TP_fast_assign(
 		__entry->id	= id;
-		syscall_get_arguments(current, regs, 0, 6, __entry->args);
+		syscall_get_arguments(current, regs, __entry->args);
 	),
 
 	TP_printk("NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)",
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 54a0347ca812..df27e499956a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -149,7 +149,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
 
 	sd->nr = syscall_get_nr(task, regs);
 	sd->arch = syscall_get_arch();
-	syscall_get_arguments(task, regs, 0, 6, args);
+	syscall_get_arguments(task, regs, args);
 	sd->args[0] = args[0];
 	sd->args[1] = args[1];
 	sd->args[2] = args[2];
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f93a56d2db27..fa8fbff736d6 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -314,6 +314,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	struct ring_buffer_event *event;
 	struct ring_buffer *buffer;
 	unsigned long irq_flags;
+	unsigned long args[6];
 	int pc;
 	int syscall_nr;
 	int size;
@@ -347,7 +348,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args, entry->args);
+	syscall_get_arguments(current, regs, args);
+	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    irq_flags, pc);
@@ -583,6 +585,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	struct syscall_metadata *sys_data;
 	struct syscall_trace_enter *rec;
 	struct hlist_head *head;
+	unsigned long args[6];
 	bool valid_prog_array;
 	int syscall_nr;
 	int rctx;
@@ -613,8 +616,8 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, sys_data->nb_args,
-			       (unsigned long *)&rec->args);
+	syscall_get_arguments(current, regs, args);
+	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	if ((valid_prog_array &&
 	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
diff --git a/lib/syscall.c b/lib/syscall.c
index 1a7077f20eae..fb328e7ccb08 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -5,16 +5,14 @@
 #include <linux/export.h>
 #include <asm/syscall.h>
 
-static int collect_syscall(struct task_struct *target, long *callno,
-			   unsigned long args[6], unsigned int maxargs,
-			   unsigned long *sp, unsigned long *pc)
+static int collect_syscall(struct task_struct *target, struct syscall_info *info)
 {
 	struct pt_regs *regs;
 
 	if (!try_get_task_stack(target)) {
 		/* Task has no stack, so the task isn't in a syscall. */
-		*sp = *pc = 0;
-		*callno = -1;
+		memset(info, 0, sizeof(*info));
+		info->data.nr = -1;
 		return 0;
 	}
 
@@ -24,12 +22,13 @@ static int collect_syscall(struct task_struct *target, long *callno,
 		return -EAGAIN;
 	}
 
-	*sp = user_stack_pointer(regs);
-	*pc = instruction_pointer(regs);
+	info->sp = user_stack_pointer(regs);
+	info->data.instruction_pointer = instruction_pointer(regs);
 
-	*callno = syscall_get_nr(target, regs);
-	if (*callno != -1L && maxargs > 0)
-		syscall_get_arguments(target, regs, 0, maxargs, args);
+	info->data.nr = syscall_get_nr(target, regs);
+	if (info->data.nr != -1L)
+		syscall_get_arguments(target, regs,
+				      (unsigned long *)&info->data.args[0]);
 
 	put_task_stack(target);
 	return 0;
@@ -38,41 +37,35 @@ static int collect_syscall(struct task_struct *target, long *callno,
 /**
  * task_current_syscall - Discover what a blocked task is doing.
  * @target:		thread to examine
- * @callno:		filled with system call number or -1
- * @args:		filled with @maxargs system call arguments
- * @maxargs:		number of elements in @args to fill
- * @sp:			filled with user stack pointer
- * @pc:			filled with user PC
+ * @info:		structure with the following fields:
+ *			 .sp        - filled with user stack pointer
+ *			 .data.nr   - filled with system call number or -1
+ *			 .data.args - filled with @maxargs system call arguments
+ *			 .data.instruction_pointer - filled with user PC
  *
- * If @target is blocked in a system call, returns zero with *@callno
- * set to the the call's number and @args filled in with its arguments.
- * Registers not used for system call arguments may not be available and
- * it is not kosher to use &struct user_regset calls while the system
+ * If @target is blocked in a system call, returns zero with @info.data.nr
+ * set to the the call's number and @info.data.args filled in with its
+ * arguments. Registers not used for system call arguments may not be available
+ * and it is not kosher to use &struct user_regset calls while the system
  * call is still in progress.  Note we may get this result if @target
  * has finished its system call but not yet returned to user mode, such
  * as when it's stopped for signal handling or syscall exit tracing.
  *
  * If @target is blocked in the kernel during a fault or exception,
- * returns zero with *@callno set to -1 and does not fill in @args.
- * If so, it's now safe to examine @target using &struct user_regset
- * get() calls as long as we're sure @target won't return to user mode.
+ * returns zero with *@info.data.nr set to -1 and does not fill in
+ * @info.data.args. If so, it's now safe to examine @target using
+ * &struct user_regset get() calls as long as we're sure @target won't return
+ * to user mode.
  *
  * Returns -%EAGAIN if @target does not remain blocked.
- *
- * Returns -%EINVAL if @maxargs is too large (maximum is six).
  */
-int task_current_syscall(struct task_struct *target, long *callno,
-			 unsigned long args[6], unsigned int maxargs,
-			 unsigned long *sp, unsigned long *pc)
+int task_current_syscall(struct task_struct *target, struct syscall_info *info)
 {
 	long state;
 	unsigned long ncsw;
 
-	if (unlikely(maxargs > 6))
-		return -EINVAL;
-
 	if (target == current)
-		return collect_syscall(target, callno, args, maxargs, sp, pc);
+		return collect_syscall(target, info);
 
 	state = target->state;
 	if (unlikely(!state))
@@ -80,7 +73,7 @@ int task_current_syscall(struct task_struct *target, long *callno,
 
 	ncsw = wait_task_inactive(target, state);
 	if (unlikely(!ncsw) ||
-	    unlikely(collect_syscall(target, callno, args, maxargs, sp, pc)) ||
+	    unlikely(collect_syscall(target, info)) ||
 	    unlikely(wait_task_inactive(target, state) != ncsw))
 		return -EAGAIN;
 
