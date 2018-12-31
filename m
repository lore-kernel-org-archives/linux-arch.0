From: guoren@kernel.org
Subject: [PATCH 08/14] csky: stacktrace supported.
Date: Mon, 31 Dec 2018 23:32:59 +0800
Message-ID: <1546270384-4590-7-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The gcc option "-mbacktrace" will push fp(r8),lr into stack and we could
unwind the stack with:
	fp = *fp
	lr = (unsigned int *)fp[1]

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Kconfig                   |  3 ++
 arch/csky/Makefile                  |  4 +++
 arch/csky/include/asm/thread_info.h |  4 +++
 arch/csky/kernel/Makefile           |  1 +
 arch/csky/kernel/process.c          | 29 +++++++++++--------
 arch/csky/kernel/stacktrace.c       | 57 +++++++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 12 deletions(-)
 create mode 100644 arch/csky/kernel/stacktrace.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 8bdbe92..65804d1 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -94,6 +94,9 @@ config MMU
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
+config STACKTRACE_SUPPORT
+	def_bool y
+
 config TIME_LOW_RES
 	def_bool y
 
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index c639fc1..3607a6e 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -47,6 +47,10 @@ ifeq ($(CSKYABI),abiv2)
 KBUILD_CFLAGS += -mno-stack-size
 endif
 
+ifdef CONFIG_STACKTRACE
+KBUILD_CFLAGS += -mbacktrace
+endif
+
 abidirs := $(patsubst %,arch/csky/%/,$(CSKYABI))
 KBUILD_CFLAGS += $(patsubst %,-I$(srctree)/%inc,$(abidirs))
 
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index a2c69a7..0e9d035 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -10,6 +10,7 @@
 #include <asm/types.h>
 #include <asm/page.h>
 #include <asm/processor.h>
+#include <abi/switch_context.h>
 
 struct thread_info {
 	struct task_struct	*task;
@@ -36,6 +37,9 @@ struct thread_info {
 
 #define THREAD_SIZE_ORDER (THREAD_SHIFT - PAGE_SHIFT)
 
+#define thread_saved_fp(tsk) \
+	((unsigned long)(((struct switch_stack *)(tsk->thread.ksp))->r8))
+
 static inline struct thread_info *current_thread_info(void)
 {
 	unsigned long sp;
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 4422de7..ba5ca48 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -6,3 +6,4 @@ obj-y += process.o cpu-probe.o ptrace.o dumpstack.o
 
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_SMP)			+= smp.o
+obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 8ed2002..e555740 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -93,26 +93,31 @@ int dump_task_regs(struct task_struct *tsk, elf_gregset_t *pr_regs)
 
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long esp, pc;
-	unsigned long stack_page;
+	unsigned long lr;
+	unsigned long *fp, *stack_start, *stack_end;
 	int count = 0;
 
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
 
-	stack_page = (unsigned long)p;
-	esp = p->thread.esp0;
+	stack_start = (unsigned long *)end_of_stack(p);
+	stack_end = (unsigned long *)(task_stack_page(p) + THREAD_SIZE);
+
+	fp = (unsigned long *) thread_saved_fp(p);
 	do {
-		if (esp < stack_page+sizeof(struct task_struct) ||
-		    esp >= 8184+stack_page)
+		if (fp < stack_start || fp > stack_end)
 			return 0;
-		/*FIXME: There's may be error here!*/
-		pc = ((unsigned long *)esp)[1];
-		/* FIXME: This depends on the order of these functions. */
-		if (!in_sched_functions(pc))
-			return pc;
-		esp = *(unsigned long *) esp;
+#ifdef CONFIG_STACKTRACE
+		lr = fp[1];
+		fp = (unsigned long *)fp[0];
+#else
+		lr = *fp++;
+#endif
+		if (!in_sched_functions(lr) &&
+		    __kernel_text_address(lr))
+			return lr;
 	} while (count++ < 16);
+
 	return 0;
 }
 EXPORT_SYMBOL(get_wchan);
diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.c
new file mode 100644
index 0000000..fec777a
--- /dev/null
+++ b/arch/csky/kernel/stacktrace.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd. */
+
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
+#include <linux/ftrace.h>
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(current, trace);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	unsigned long *fp, *stack_start, *stack_end;
+	unsigned long addr;
+	int skip = trace->skip;
+	int savesched;
+	int graph_idx = 0;
+
+	if (tsk == current) {
+		asm volatile("mov %0, r8\n":"=r"(fp));
+		savesched = 1;
+	} else {
+		fp = (unsigned long *)thread_saved_fp(tsk);
+		savesched = 0;
+	}
+
+	addr = (unsigned long) fp & THREAD_MASK;
+	stack_start = (unsigned long *) addr;
+	stack_end = (unsigned long *) (addr + THREAD_SIZE);
+
+	while (fp > stack_start && fp < stack_end) {
+		unsigned long lpp, fpp;
+
+		fpp = fp[0];
+		lpp = fp[1];
+		if (!__kernel_text_address(lpp))
+			break;
+		else
+			lpp = ftrace_graph_ret_addr(tsk, &graph_idx, lpp, NULL);
+
+		if (savesched || !in_sched_functions(lpp)) {
+			if (skip) {
+				skip--;
+			} else {
+				trace->entries[trace->nr_entries++] = lpp;
+				if (trace->nr_entries >= trace->max_entries)
+					break;
+			}
+		}
+		fp = (unsigned long *)fpp;
+	}
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-- 
2.7.4
