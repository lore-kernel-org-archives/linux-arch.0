From: guoren@kernel.org
Subject: [PATCH 09/14] csky: optimize kernel panic print.
Date: Mon, 31 Dec 2018 23:33:00 +0800
Message-ID: <1546270384-4590-8-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use STACKTRACE to optimize panic print more pretty and align registers
printing.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/dumpstack.c | 59 ++++++++++++++------------------------------
 arch/csky/kernel/ptrace.c    | 34 ++++++++++++++-----------
 arch/csky/mm/fault.c         |  4 +--
 3 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index a9a03ac..659253e 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -7,60 +7,39 @@ int kstack_depth_to_print = 48;
 
 void show_trace(unsigned long *stack)
 {
-	unsigned long *endstack;
+	unsigned long *stack_end;
+	unsigned long *stack_start;
+	unsigned long *fp;
 	unsigned long addr;
-	int i;
 
-	pr_info("Call Trace:\n");
-	addr = (unsigned long)stack + THREAD_SIZE - 1;
-	endstack = (unsigned long *)(addr & -THREAD_SIZE);
-	i = 0;
-	while (stack + 1 <= endstack) {
-		addr = *stack++;
-		/*
-		 * If the address is either in the text segment of the
-		 * kernel, or in the region which contains vmalloc'ed
-		 * memory, it *may* be the address of a calling
-		 * routine; if so, print it so that someone tracing
-		 * down the cause of the crash will be able to figure
-		 * out the call path that was taken.
-		 */
-		if (__kernel_text_address(addr)) {
-#ifndef CONFIG_KALLSYMS
-			if (i % 5 == 0)
-				pr_cont("\n       ");
+	addr = (unsigned long) stack & THREAD_MASK;
+	stack_start = (unsigned long *) addr;
+	stack_end = (unsigned long *) (addr + THREAD_SIZE);
+
+	fp = stack;
+	pr_info("\nCall Trace:");
+
+	while (fp > stack_start && fp < stack_end) {
+#ifdef CONFIG_STACKTRACE
+		addr	= fp[1];
+		fp	= (unsigned long *) fp[0];
+#else
+		addr	= *fp++;
 #endif
-			pr_cont(" [<%08lx>] %pS\n", addr, (void *)addr);
-			i++;
-		}
+		if (__kernel_text_address(addr))
+			pr_cont("\n[<%08lx>] %pS", addr, (void *)addr);
 	}
 	pr_cont("\n");
 }
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
-	unsigned long *p;
-	unsigned long *endstack;
-	int i;
-
 	if (!stack) {
 		if (task)
-			stack = (unsigned long *)task->thread.esp0;
+			stack = (unsigned long *)thread_saved_fp(task);
 		else
 			stack = (unsigned long *)&stack;
 	}
-	endstack = (unsigned long *)
-		(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
 
-	pr_info("Stack from %08lx:", (unsigned long)stack);
-	p = stack;
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (p + 1 > endstack)
-			break;
-		if (i % 8 == 0)
-			pr_cont("\n       ");
-		pr_cont(" %08lx", *p++);
-	}
-	pr_cont("\n");
 	show_trace(stack);
 }
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index a76d466..eb62e07 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -241,6 +241,7 @@ asmlinkage void syscall_trace(int why, struct pt_regs *regs)
 	regs->regs[SYSTRACE_SAVENUM] = saved_why;
 }
 
+extern void show_stack(struct task_struct *task, unsigned long *stack);
 void show_regs(struct pt_regs *fp)
 {
 	unsigned long   *sp;
@@ -263,35 +264,37 @@ void show_regs(struct pt_regs *fp)
 		       (int) (((unsigned long) current) + 2 * PAGE_SIZE));
 	}
 
-	pr_info("PC: 0x%08lx\n", (long)fp->pc);
+	pr_info("PC: 0x%08lx (%pS)\n", (long)fp->pc, (void *)fp->pc);
+	pr_info("LR: 0x%08lx (%pS)\n", (long)fp->lr, (void *)fp->lr);
+	pr_info("SP: 0x%08lx\n", (long)fp);
 	pr_info("orig_a0: 0x%08lx\n", fp->orig_a0);
 	pr_info("PSR: 0x%08lx\n", (long)fp->sr);
 
-	pr_info("a0: 0x%08lx  a1: 0x%08lx  a2: 0x%08lx  a3: 0x%08lx\n",
-	       fp->a0, fp->a1, fp->a2, fp->a3);
+	pr_info(" a0: 0x%08lx   a1: 0x%08lx   a2: 0x%08lx   a3: 0x%08lx\n",
+		fp->a0, fp->a1, fp->a2, fp->a3);
 #if defined(__CSKYABIV2__)
-	pr_info("r4: 0x%08lx  r5: 0x%08lx    r6: 0x%08lx    r7: 0x%08lx\n",
+	pr_info(" r4: 0x%08lx   r5: 0x%08lx   r6: 0x%08lx   r7: 0x%08lx\n",
 		fp->regs[0], fp->regs[1], fp->regs[2], fp->regs[3]);
-	pr_info("r8: 0x%08lx  r9: 0x%08lx   r10: 0x%08lx   r11: 0x%08lx\n",
+	pr_info(" r8: 0x%08lx   r9: 0x%08lx  r10: 0x%08lx  r11: 0x%08lx\n",
 		fp->regs[4], fp->regs[5], fp->regs[6], fp->regs[7]);
-	pr_info("r12 0x%08lx  r13: 0x%08lx   r15: 0x%08lx\n",
+	pr_info("r12: 0x%08lx  r13: 0x%08lx  r15: 0x%08lx\n",
 		fp->regs[8], fp->regs[9], fp->lr);
-	pr_info("r16:0x%08lx   r17: 0x%08lx   r18: 0x%08lx    r19: 0x%08lx\n",
+	pr_info("r16: 0x%08lx  r17: 0x%08lx  r18: 0x%08lx  r19: 0x%08lx\n",
 		fp->exregs[0], fp->exregs[1], fp->exregs[2], fp->exregs[3]);
-	pr_info("r20 0x%08lx   r21: 0x%08lx   r22: 0x%08lx    r23: 0x%08lx\n",
+	pr_info("r20: 0x%08lx  r21: 0x%08lx  r22: 0x%08lx  r23: 0x%08lx\n",
 		fp->exregs[4], fp->exregs[5], fp->exregs[6], fp->exregs[7]);
-	pr_info("r24 0x%08lx   r25: 0x%08lx   r26: 0x%08lx    r27: 0x%08lx\n",
+	pr_info("r24: 0x%08lx  r25: 0x%08lx  r26: 0x%08lx  r27: 0x%08lx\n",
 		fp->exregs[8], fp->exregs[9], fp->exregs[10], fp->exregs[11]);
-	pr_info("r28 0x%08lx   r29: 0x%08lx   r30: 0x%08lx    tls: 0x%08lx\n",
+	pr_info("r28: 0x%08lx  r29: 0x%08lx  r30: 0x%08lx  tls: 0x%08lx\n",
 		fp->exregs[12], fp->exregs[13], fp->exregs[14], fp->tls);
-	pr_info("hi 0x%08lx    lo: 0x%08lx\n",
+	pr_info(" hi: 0x%08lx   lo: 0x%08lx\n",
 		fp->rhi, fp->rlo);
 #else
-	pr_info("r6: 0x%08lx   r7: 0x%08lx   r8: 0x%08lx   r9: 0x%08lx\n",
+	pr_info(" r6: 0x%08lx   r7: 0x%08lx   r8: 0x%08lx   r9: 0x%08lx\n",
 		fp->regs[0], fp->regs[1], fp->regs[2], fp->regs[3]);
-	pr_info("r10: 0x%08lx   r11: 0x%08lx   r12: 0x%08lx   r13: 0x%08lx\n",
+	pr_info("r10: 0x%08lx  r11: 0x%08lx  r12: 0x%08lx  r13: 0x%08lx\n",
 		fp->regs[4], fp->regs[5], fp->regs[6], fp->regs[7]);
-	pr_info("r14 0x%08lx   r1: 0x%08lx   r15: 0x%08lx\n",
+	pr_info("r14: 0x%08lx   r1: 0x%08lx  r15: 0x%08lx\n",
 		fp->regs[8], fp->regs[9], fp->lr);
 #endif
 
@@ -313,4 +316,7 @@ void show_regs(struct pt_regs *fp)
 		pr_cont("%08x ", (int) *sp++);
 	}
 	pr_cont("\n");
+
+	show_stack(NULL, (unsigned long *)fp->regs[4]);
+	return;
 }
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7df57f9..6a94661 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -188,8 +188,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * terminate things with extreme prejudice.
 	 */
 	bust_spinlocks(1);
-	pr_alert("Unable to %s at vaddr: %08lx, epc: %08lx\n",
-		 __func__, address, regs->pc);
+	pr_alert("Unable to handle kernel paging request at virtual "
+		 "address 0x%08lx, pc: 0x%08lx\n", address, regs->pc);
 	die_if_kernel("Oops", regs, write);
 
 out_of_memory:
-- 
2.7.4
