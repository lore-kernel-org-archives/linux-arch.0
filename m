From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC][ATCH 3/3] syscalls: Remove start and number from syscall_get_arguments() args
Date: Mon, 07 Nov 2016 16:26:37 -0500
Message-ID: <20161107213233.754809394@goodmis.org>
References: <20161107212634.529267342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-syscalls-Remove-start-and-number-from-syscall_get_ar.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
function call syscall_get_arguments() implemented in x86 was horribly
written and not optimized for the standard case of passing in 0 and 6 for
the starting index and the number of system calls to get. When looking at
all the users of this function, I discovered that all instances pass in only
0 and 6 for these arguments. Instead of having this function handle
different cases that are never used, simply rewrite it to return the first 6
arguments of a system call.

This should help out the performance of tracing system calls by ptrace,
ftrace and perf.

Reported-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arc/include/asm/syscall.h        |  7 ++--
 arch/arm/include/asm/syscall.h        | 23 ++---------
 arch/arm64/include/asm/syscall.h      | 22 ++---------
 arch/blackfin/include/asm/syscall.h   | 22 +++++++----
 arch/c6x/include/asm/syscall.h        | 41 ++++----------------
 arch/frv/include/asm/syscall.h        | 26 +++----------
 arch/h8300/include/asm/syscall.h      | 34 ++++-------------
 arch/hexagon/include/asm/syscall.h    |  4 +-
 arch/ia64/include/asm/syscall.h       |  5 +--
 arch/metag/include/asm/syscall.h      |  4 +-
 arch/microblaze/include/asm/syscall.h |  4 +-
 arch/mips/include/asm/syscall.h       |  3 +-
 arch/mn10300/include/asm/syscall.h    | 32 +++-------------
 arch/nios2/include/asm/syscall.h      | 42 ++++----------------
 arch/openrisc/include/asm/syscall.h   |  6 +--
 arch/parisc/include/asm/syscall.h     | 30 ++++-----------
 arch/powerpc/include/asm/syscall.h    |  8 ++--
 arch/s390/include/asm/syscall.h       | 11 +++---
 arch/sh/include/asm/syscall_32.h      | 26 +++----------
 arch/sh/include/asm/syscall_64.h      |  4 +-
 arch/sparc/include/asm/syscall.h      |  4 +-
 arch/tile/include/asm/syscall.h       |  4 +-
 arch/um/include/asm/syscall-generic.h | 39 +++----------------
 arch/x86/include/asm/syscall.h        | 72 ++++++++---------------------------
 include/asm-generic/syscall.h         | 11 ++----
 include/trace/events/syscalls.h       |  2 +-
 kernel/seccomp.c                      |  2 +-
 kernel/trace/trace_syscalls.c         |  4 +-
 lib/syscall.c                         |  2 +-
 29 files changed, 124 insertions(+), 370 deletions(-)

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
index e86c985b8c7a..1521b465b581 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -54,29 +54,14 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
+	unsigned int n;
 
-	if (i == 0) {
-		args[0] = regs->ARM_ORIG_r0;
-		args++;
-		i++;
-		n--;
-	}
+	args[0] = regs->ARM_ORIG_r0;
+	args++;
 
-	memcpy(args, &regs->ARM_r0 + i, n * sizeof(args[0]));
+	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574468f0..fb6668df435b 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -59,28 +59,12 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
+	args[0] = regs->orig_x0;
+	args++;
 
-	memcpy(args, &regs->regs[i], n * sizeof(args[0]));
+	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/blackfin/include/asm/syscall.h b/arch/blackfin/include/asm/syscall.h
index 4921a4815cce..cef32063f54b 100644
--- a/arch/blackfin/include/asm/syscall.h
+++ b/arch/blackfin/include/asm/syscall.h
@@ -57,30 +57,36 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  *	syscall_get_arguments()
  *	@task:   unused
  *	@regs:   the register layout to extract syscall arguments from
- *	@i:      first syscall argument to extract
- *	@n:      number of syscall arguments to extract
  *	@args:   array to return the syscall arguments in
  *
- * args[0] gets i'th argument, args[n - 1] gets the i+n-1'th argument
+ * Gets the 6 arguments of the system call
  */
 static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-                      unsigned int i, unsigned int n, unsigned long *args)
+                      unsigned long *args)
 {
 	/*
 	 * Assume the ptrace layout doesn't change -- r5 is first in memory,
 	 * then r4, ..., then r0.  So we simply reverse the ptrace register
 	 * array in memory to store into the args array.
 	 */
-	long *aregs = &regs->r0 - i;
-
-	BUG_ON(i > 5 || i + n > 6);
+	long *aregs = &regs->r0;
+	unsigned int n = 6;
 
 	while (n--)
 		*args++ = *aregs--;
 }
 
-/* See syscall_get_arguments() comments */
+/**
+ *	syscall_set_arguments()
+ *	@task:   unused
+ *	@regs:   the register layout to extract syscall arguments from
+ *	@i:      first syscall argument to extract
+ *	@n:      number of syscall arguments to extract
+ *	@args:   array to return the syscall arguments in
+ *
+ * args[0] gets i'th argument, args[n - 1] gets the i+n-1'th argument
+ */
 static inline void
 syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
                       unsigned int i, unsigned int n, const unsigned long *args)
diff --git a/arch/c6x/include/asm/syscall.h b/arch/c6x/include/asm/syscall.h
index ae2be315ee9c..06db3251926b 100644
--- a/arch/c6x/include/asm/syscall.h
+++ b/arch/c6x/include/asm/syscall.h
@@ -46,40 +46,15 @@ static inline void syscall_set_return_value(struct task_struct *task,
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
diff --git a/arch/frv/include/asm/syscall.h b/arch/frv/include/asm/syscall.h
index 70689eb29b98..4778fa399f52 100644
--- a/arch/frv/include/asm/syscall.h
+++ b/arch/frv/include/asm/syscall.h
@@ -71,29 +71,15 @@ static inline void syscall_set_return_value(struct task_struct *task,
  */
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
-
 	/* Argument pattern is: GR8, GR9, GR10, GR11, GR12, GR13 */
-	switch (n) {
-	case 6: args[5] = regs->gr13;
-	case 5: args[4] = regs->gr12;
-	case 4: args[3] = regs->gr11;
-	case 3: args[2] = regs->gr10;
-	case 2: args[1] = regs->gr9;
-	case 1:	args[0] = regs->gr8;
-		break;
-	default:
-		BUG();
-	}
+	args[5] = regs->gr13;
+	args[4] = regs->gr12;
+	args[3] = regs->gr11;
+	args[2] = regs->gr10;
+	args[1] = regs->gr9;
+	args[0] = regs->gr8;
 }
 
 /*
diff --git a/arch/h8300/include/asm/syscall.h b/arch/h8300/include/asm/syscall.h
index b41f688d02cf..c0bb2e4c152f 100644
--- a/arch/h8300/include/asm/syscall.h
+++ b/arch/h8300/include/asm/syscall.h
@@ -16,34 +16,14 @@ syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 
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
index 1d0b875fec44..8204c1ff70ce 100644
--- a/arch/ia64/include/asm/syscall.h
+++ b/arch/ia64/include/asm/syscall.h
@@ -63,12 +63,9 @@ extern void ia64_syscall_get_set_arguments(struct task_struct *task,
 	unsigned long *args, int rw);
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-
-	ia64_syscall_get_set_arguments(task, regs, i, n, args, 0);
+	ia64_syscall_get_set_arguments(task, regs, 0, 6, args, 0);
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/metag/include/asm/syscall.h b/arch/metag/include/asm/syscall.h
index 24fc97939f77..981bf74c2ec5 100644
--- a/arch/metag/include/asm/syscall.h
+++ b/arch/metag/include/asm/syscall.h
@@ -66,13 +66,11 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	unsigned int reg, j;
-	BUG_ON(i + n > 6);
 
-	for (j = i, reg = 6 - i; j < (i + n); j++, reg--) {
+	for (j = 0, reg = 6; j < 6; j++, reg--) {
 		if (reg % 2)
 			args[j] = regs->ctx.DX[(reg + 1) / 2].U0;
 		else
diff --git a/arch/microblaze/include/asm/syscall.h b/arch/microblaze/include/asm/syscall.h
index 04a5bece8168..ec2b0be2076e 100644
--- a/arch/microblaze/include/asm/syscall.h
+++ b/arch/microblaze/include/asm/syscall.h
@@ -81,9 +81,11 @@ static inline void microblaze_set_syscall_arg(struct pt_regs *regs,
 
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
diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/syscall.h
index d87882513ee3..279878f58191 100644
--- a/arch/mips/include/asm/syscall.h
+++ b/arch/mips/include/asm/syscall.h
@@ -94,9 +94,10 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
+	unsigned int i = 0;
+	unsigned int n = 6;
 	int ret;
 	/* O32 ABI syscall() - Either 64-bit with O32 or 32-bit */
 	if ((IS_ENABLED(CONFIG_32BIT) ||
diff --git a/arch/mn10300/include/asm/syscall.h b/arch/mn10300/include/asm/syscall.h
index b44b0bb75a01..0b2767144a60 100644
--- a/arch/mn10300/include/asm/syscall.h
+++ b/arch/mn10300/include/asm/syscall.h
@@ -52,34 +52,14 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	switch (i) {
-	case 0:
-		if (!n--) break;
-		*args++ = regs->a0;
-	case 1:
-		if (!n--) break;
-		*args++ = regs->d1;
-	case 2:
-		if (!n--) break;
-		*args++ = regs->a3;
-	case 3:
-		if (!n--) break;
-		*args++ = regs->a2;
-	case 4:
-		if (!n--) break;
-		*args++ = regs->d3;
-	case 5:
-		if (!n--) break;
-		*args++ = regs->d2;
-	case 6:
-		if (!n--) break;
-	default:
-		BUG();
-		break;
-	}
+	*args++ = regs->a0;
+	*args++ = regs->d1;
+	*args++ = regs->a3;
+	*args++ = regs->a2;
+	*args++ = regs->d3;
+	*args   = regs->d2;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/nios2/include/asm/syscall.h b/arch/nios2/include/asm/syscall.h
index 9de220854c4a..964603805cbd 100644
--- a/arch/nios2/include/asm/syscall.h
+++ b/arch/nios2/include/asm/syscall.h
@@ -58,42 +58,14 @@ static inline void syscall_set_return_value(struct task_struct *task,
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
+	*args++ = regs->r9;
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/openrisc/include/asm/syscall.h b/arch/openrisc/include/asm/syscall.h
index 2db9f1cf0694..72607860cd55 100644
--- a/arch/openrisc/include/asm/syscall.h
+++ b/arch/openrisc/include/asm/syscall.h
@@ -56,11 +56,9 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
 
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
diff --git a/arch/parisc/include/asm/syscall.h b/arch/parisc/include/asm/syscall.h
index 5e0b4e6bd99d..f7296bf30eb4 100644
--- a/arch/parisc/include/asm/syscall.h
+++ b/arch/parisc/include/asm/syscall.h
@@ -17,29 +17,15 @@ static inline long syscall_get_nr(struct task_struct *tsk,
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
index ab9f3f0a8637..70dcb199c47c 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -66,22 +66,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 6ba0bf928909..2b520aa8ad62 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -59,21 +59,20 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 	unsigned long mask = -1UL;
+	unsigned int n = 6;
 
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
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 95be3b0ce0ac..09f4942c1b11 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -47,30 +47,16 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index c6a797b90b80..0c5d28f47827 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -46,11 +46,9 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 1757cd6c521b..419ed27ae60b 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -95,11 +95,11 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
@@ -107,7 +107,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 #endif
 
 	for (j = 0; j < n; j++) {
-		unsigned long val = regs->u_regs[UREG_I0 + i + j];
+		unsigned long val = regs->u_regs[UREG_I0 + j];
 
 		if (zero_extend)
 			args[j] = (u32) val;
diff --git a/arch/tile/include/asm/syscall.h b/arch/tile/include/asm/syscall.h
index 373d73064ea1..42c6204b3c30 100644
--- a/arch/tile/include/asm/syscall.h
+++ b/arch/tile/include/asm/syscall.h
@@ -76,11 +76,9 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
-	BUG_ON(i + n > 6);
-	memcpy(args, &regs[i], n * sizeof(args[0]));
+	memcpy(args, &regs[0], 6 * sizeof(args[0]));
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/arch/um/include/asm/syscall-generic.h b/arch/um/include/asm/syscall-generic.h
index 9fb9cf8cd39a..25d00acd1322 100644
--- a/arch/um/include/asm/syscall-generic.h
+++ b/arch/um/include/asm/syscall-generic.h
@@ -53,43 +53,16 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index e3c95e8e61c5..050891169b51 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -87,11 +87,9 @@ static inline void syscall_set_return_value(struct task_struct *task,
 
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
@@ -112,63 +110,25 @@ static inline int syscall_get_arch(void)
 
 static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
-					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
 # ifdef CONFIG_IA32_EMULATION
-	if (task->thread.status & TS_COMPAT)
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
+	if (task->thread.status & TS_COMPAT) {
+		*args++ = regs->bx;
+		*args++ = regs->cx;
+		*args++ = regs->dx;
+		*args++ = regs->si;
+		*args++ = regs->di;
+		*args   = regs->bp;
+	} else {
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
+		*args++ = regs->di;
+		*args++ = regs->si;
+		*args++ = regs->dx;
+		*args++ = regs->r10;
+		*args++ = regs->r8;
+		*args   = regs->r9;
+	}
 }
 
 static inline void syscall_set_arguments(struct task_struct *task,
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 0c938a4354f6..269e9412ef42 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -105,21 +105,16 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
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
diff --git a/include/trace/events/syscalls.h b/include/trace/events/syscalls.h
index 14e49c798135..72aa1694a6cf 100644
--- a/include/trace/events/syscalls.h
+++ b/include/trace/events/syscalls.h
@@ -26,7 +26,7 @@ TRACE_EVENT_FN(sys_enter,
 
 	TP_fast_assign(
 		__entry->id	= id;
-		syscall_get_arguments(current, regs, 0, 6, __entry->args);
+		syscall_get_arguments(current, regs, __entry->args);
 	),
 
 	TP_printk("NR %ld (%lx, %lx, %lx, %lx, %lx, %lx)",
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0db7c8a2afe2..31d1a3c04bec 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -75,7 +75,7 @@ static void populate_seccomp_data(struct seccomp_data *sd)
 
 	sd->nr = syscall_get_nr(task, regs);
 	sd->arch = syscall_get_arch();
-	syscall_get_arguments(task, regs, 0, 6, args);
+	syscall_get_arguments(task, regs, args);
 	sd->args[0] = args[0];
 	sd->args[1] = args[1];
 	sd->args[2] = args[2];
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 52c1503cedfa..3aff1f5e7fc3 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -347,7 +347,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 
 	entry = ring_buffer_event_data(event);
 	entry->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, 6, args);
+	syscall_get_arguments(current, regs, args);
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
@@ -595,7 +595,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 		return;
 
 	rec->nr = syscall_nr;
-	syscall_get_arguments(current, regs, 0, 6, args);
+	syscall_get_arguments(current, regs, args);
 	memcpy(&rec->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
 	perf_trace_buf_submit(rec, size, rctx,
diff --git a/lib/syscall.c b/lib/syscall.c
index cbd376c66bbc..cc83c9e2d682 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -26,7 +26,7 @@ static int collect_syscall(struct task_struct *target, long *callno,
 
 	*callno = syscall_get_nr(target, regs);
 	if (*callno != -1L)
-		syscall_get_arguments(target, regs, 0, 6, args);
+		syscall_get_arguments(target, regs, args);
 
 	put_task_stack(target);
 	return 0;
-- 
2.9.3
