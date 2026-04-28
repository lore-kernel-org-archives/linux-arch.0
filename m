Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B92401494;
	Tue, 28 Apr 2026 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360850; cv=none; b=XULKFpI+vObnNQ/lzU9KHAdoj3T+MghT3da0byxo5zZ+OMM8wYdf1EbqRbUPK2b5+8/H/w1xAm6ZWdqT+uh+SSfCmwK9b4ujhljfxVxDPz/DVtMrr4CZXXua7GmjyVn08YlHBYSf7Par7C+lP5hhUSczXdVB5E0/qZnMhXo74Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360850; c=relaxed/simple;
	bh=hYxY8SCoakMlLzUVUE3q+gWYSfJMlm/kbycQTSIQEp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS6n0h4iqXXqKMyhTBZH+duh7KVPLm7SEJkg7YE+pb4WDP51pVxTsAmq/wzZvWejDtMLf/B10ff2+CZSYP0HI46+EDmVmg19KAxWCWVn1JBXHmU6RD9Fa+X+4PHmEyCS2WtOY+ix04O12p5p4LlX5YA7CUVhp+vxKx2TbRPao4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxX+vDX_Bp3KgEAA--.15696S3;
	Tue, 28 Apr 2026 15:20:35 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcK3X_BpkWV2AA--.26183S3;
	Tue, 28 Apr 2026 15:20:25 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Date: Tue, 28 Apr 2026 15:20:19 +0800
Message-ID: <20260428072021.7289-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260428072021.7289-1-yangtiezhu@loongson.cn>
References: <20260428072021.7289-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcK3X_BpkWV2AA--.26183S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3tFWDWw13AFWrCryxtw43urX_yoW8Ar15Wo
	WakF1jyr18XF4Uua98twn8tFW5Xr1qyrWkZ3yavanxGa17A347XryUGr43tFy3Xas7Wa1D
	C343uw4vv3s7trn7l-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUUU

Like other architectures such as x86, arm64, riscv, powerpc and s390,
select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
stack into task_struct. This follows modern kernel standards and also
makes the system more secure.

With this patch, thread_info is included in task_struct at an offset
of 0 instead of being placed at the bottom of the kernel stack. Thus,
the $tp register points to both thread_info and task_struct.

To support this, introduce a per-CPU variable __entry_task to store
the pointer to the current task_struct. This decouples the recovery
of the $tp register from the stack pointer during exception entry.
Relying on SP for task identification is insecure since the SP can be
controlled or corrupted by userspace.

Then initialize __entry_task for both the primary and secondary CPUs
during arch-specific setup and SMP boot paths, modify SAVE_SOME and
handle_syscall to restore the $tp register from __entry_task, and use
la_abs absolute addressing for __entry_task access in assembly to
bypass relocation limits within exception handling sections. Also,
add entry_task_switch() to update __entry_task during switch_to().

Additionally, add reg02 ($tp) to thread_struct and initialize it in
both INIT_THREAD and copy_thread() to ensure that the "current" task
pointer is correctly set up for the initial idle task and all future
child processes. While __switch_to() directly updates $tp from a1 for
efficiency, storing it in thread_struct ensures correct restoration
for new processes and in non-standard switch paths.

Furthermore, initialize reg03 ($sp) in INIT_THREAD to set the initial
kernel stack pointer for the idle task. This ensures the idle task has
a valid stack to use when the system first starts or whenever it is
switched back to.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                   |  1 +
 arch/loongarch/include/asm/current.h     | 22 ++++++++++++
 arch/loongarch/include/asm/processor.h   | 44 +++---------------------
 arch/loongarch/include/asm/ptrace.h      |  6 ----
 arch/loongarch/include/asm/smp.h         |  3 +-
 arch/loongarch/include/asm/stackframe.h  |  9 +++--
 arch/loongarch/include/asm/switch_to.h   | 15 ++++++--
 arch/loongarch/include/asm/thread_info.h | 13 +------
 arch/loongarch/kernel/asm-offsets.c      |  7 ++--
 arch/loongarch/kernel/entry.S            |  7 ++--
 arch/loongarch/kernel/head.S             | 18 ++++++----
 arch/loongarch/kernel/process.c          |  6 ++++
 arch/loongarch/kernel/relocate.c         |  2 +-
 arch/loongarch/kernel/setup.c            |  3 ++
 arch/loongarch/kernel/smp.c              |  8 +++--
 arch/loongarch/kernel/switch.S           |  9 ++---
 16 files changed, 89 insertions(+), 84 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3b042dbb2c41..ea29d5d17588 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -210,6 +210,7 @@ config LOONGARCH
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_EXCEPTION_TRACE
 	select SWIOTLB if 64BIT
+	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select USE_PERCPU_NUMA_NODE_ID
 	select USER_STACKTRACE_SUPPORT
diff --git a/arch/loongarch/include/asm/current.h b/arch/loongarch/include/asm/current.h
new file mode 100644
index 000000000000..c03cf0abb863
--- /dev/null
+++ b/arch/loongarch/include/asm/current.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_LOONGARCH_CURRENT_H
+#define __ASM_LOONGARCH_CURRENT_H
+
+#include <linux/compiler.h>
+
+#ifndef __ASSEMBLER__
+
+struct task_struct;
+
+register struct task_struct *current_thread_pointer __asm__("$tp");
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return current_thread_pointer;
+}
+
+#define current get_current()
+
+#endif /* __ASSEMBLER__ */
+
+#endif /* __ASM_LOONGARCH_CURRENT_H */
diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
index ce8b953f8c79..df927a4318cc 100644
--- a/arch/loongarch/include/asm/processor.h
+++ b/arch/loongarch/include/asm/processor.h
@@ -109,7 +109,7 @@ struct loongarch_vdso_info;
  */
 struct thread_struct {
 	/* Main processor registers. */
-	unsigned long reg01, reg03, reg22; /* ra sp fp */
+	unsigned long reg01, reg02, reg03, reg22; /* ra tp sp fp */
 	unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
 	unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */
 
@@ -145,45 +145,9 @@ struct thread_struct {
 #define thread_saved_ra(tsk)	(tsk->thread.sched_ra)
 #define thread_saved_fp(tsk)	(tsk->thread.sched_cfa)
 
-#define INIT_THREAD  {						\
-	/*							\
-	 * Main processor registers				\
-	 */							\
-	.reg01			= 0,				\
-	.reg03			= 0,				\
-	.reg22			= 0,				\
-	.reg23			= 0,				\
-	.reg24			= 0,				\
-	.reg25			= 0,				\
-	.reg26			= 0,				\
-	.reg27			= 0,				\
-	.reg28			= 0,				\
-	.reg29			= 0,				\
-	.reg30			= 0,				\
-	.reg31			= 0,				\
-	.sched_ra		= 0,				\
-	.sched_cfa		= 0,				\
-	.csr_crmd		= 0,				\
-	.csr_prmd		= 0,				\
-	.csr_euen		= 0,				\
-	.csr_ecfg		= 0,				\
-	.csr_badvaddr		= 0,				\
-	/*							\
-	 * Other stuff associated with the process		\
-	 */							\
-	.trap_nr		= 0,				\
-	.error_code		= 0,				\
-	/*							\
-	 * FPU & vector registers				\
-	 */							\
-	.fpu			= {				\
-		.fcc		= 0,				\
-		.fcsr		= 0,				\
-		.ftop		= 0,				\
-		.fpr		= {{{0,},},},			\
-	},							\
-	.hbp_break		= {0},				\
-	.hbp_watch		= {0},				\
+#define INIT_THREAD  {							\
+	.reg02 = (unsigned long)&init_task,				\
+	.reg03 = (unsigned long)&init_stack + sizeof(init_stack),	\
 }
 
 struct task_struct;
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index e5d21e836d99..37f53629d3c7 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -170,12 +170,6 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 		die(str, regs);
 }
 
-#define current_pt_regs()						\
-({									\
-	unsigned long sp = (unsigned long)__builtin_frame_address(0);	\
-	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1) - 1;		\
-})
-
 /* Helpers for working with the user stack pointer */
 
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 3a47f52959a8..761cc0016df8 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -82,7 +82,8 @@ struct seq_file;
 
 struct secondary_data {
 	unsigned long stack;
-	unsigned long thread_info;
+	unsigned long task;
+	unsigned long offset;
 };
 extern struct secondary_data cpuboot_data;
 
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index ecc8e50fffa8..eeda5dcc982e 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -191,8 +191,13 @@
 	andi	t0, t0, 0x3	/* extract pplv bit */
 	beqz	t0, 9f
 
-	LONG_LI	tp, ~_THREAD_MASK
-	and	tp, tp, sp
+	la_abs      t1, __entry_task
+#ifdef CONFIG_SMP
+	csrrd       t0, PERCPU_BASE_KS
+	LONG_ADD    t1, t1, t0
+#endif
+	LONG_L      tp, t1, 0
+
 	cfi_st  u0, PT_R21, \docfi
 	csrrd	u0, PERCPU_BASE_KS
 9:
diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
index 5b225aff3ba2..9932429cfe17 100644
--- a/arch/loongarch/include/asm/switch_to.h
+++ b/arch/loongarch/include/asm/switch_to.h
@@ -5,17 +5,25 @@
 #ifndef _ASM_SWITCH_TO_H
 #define _ASM_SWITCH_TO_H
 
+#include <linux/percpu.h>
+
 #include <asm/cpu-features.h>
 #include <asm/fpu.h>
 #include <asm/lbt.h>
 
 struct task_struct;
 
+DECLARE_PER_CPU(struct task_struct *, __entry_task);
+
+static inline void entry_task_switch(struct task_struct *next)
+{
+	__this_cpu_write(__entry_task, next);
+}
+
 /**
  * __switch_to - switch execution of a task
  * @prev:	The task previously executed.
  * @next:	The task to begin executing.
- * @next_ti:	task_thread_info(next).
  * @sched_ra:	__schedule return address.
  * @sched_cfa:	__schedule call frame address.
  *
@@ -23,7 +31,7 @@ struct task_struct;
  * the context of next. Returns prev.
  */
 extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
-			struct task_struct *next, struct thread_info *next_ti,
+			struct task_struct *next,
 			void *sched_ra, void *sched_cfa);
 
 /*
@@ -37,7 +45,8 @@ do {										\
 	lose_fpu_inatomic(1, prev);						\
 	lose_lbt_inatomic(1, prev);						\
 	hw_breakpoint_thread_switch(next);					\
-	(last) = __switch_to(prev, next, task_thread_info(next),		\
+	entry_task_switch(next);						\
+	(last) = __switch_to(prev, next,					\
 		 __builtin_return_address(0), __builtin_frame_address(0));	\
 } while (0)
 
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 4d7117fcdc78..2c95a5134976 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -22,9 +22,7 @@
  *   must also be changed
  */
 struct thread_info {
-	struct task_struct	*task;		/* main task structure */
 	unsigned long		flags;		/* low level flags */
-	unsigned long		tp_value;	/* thread pointer */
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;	/* 0 => preemptible, <0 => BUG */
 	struct pt_regs		*regs;
@@ -37,20 +35,11 @@ struct thread_info {
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.task		= &tsk,			\
-	.flags		= _TIF_FIXADE,		\
+	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
-/* How to get the thread information struct from C. */
-register struct thread_info *__current_thread_info __asm__("$tp");
-
-static inline struct thread_info *current_thread_info(void)
-{
-	return __current_thread_info;
-}
-
 register unsigned long current_stack_pointer __asm__("$sp");
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 2cc953f113ac..55f4ffc1aca5 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -70,7 +70,7 @@ static void __used output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
 	OFFSET(TASK_STATE, task_struct, __state);
-	OFFSET(TASK_THREAD_INFO, task_struct, stack);
+	OFFSET(TASK_STACK, task_struct, stack);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
 	OFFSET(TASK_PID, task_struct, pid);
@@ -84,9 +84,7 @@ static void __used output_task_defines(void)
 static void __used output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
-	OFFSET(TI_TASK, thread_info, task);
 	OFFSET(TI_FLAGS, thread_info, flags);
-	OFFSET(TI_TP_VALUE, thread_info, tp_value);
 	OFFSET(TI_CPU, thread_info, cpu);
 	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
 	OFFSET(TI_REGS, thread_info, regs);
@@ -267,7 +265,8 @@ static void __used output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
 	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
-	OFFSET(CPU_BOOT_TINFO, secondary_data, thread_info);
+	OFFSET(CPU_BOOT_TASK, secondary_data, task);
+	OFFSET(CPU_BOOT_OFFSET, secondary_data, offset);
 	BLANK();
 }
 #endif
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index b53d333a7c42..b099672eab60 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -67,8 +67,11 @@ SYM_CODE_START(handle_syscall)
 #endif
 
 	move		u0, t0
-	LONG_LI		tp, ~_THREAD_MASK
-	and		tp, tp, sp
+	la_abs		t1, __entry_task
+#ifdef CONFIG_SMP
+	LONG_ADD	t1, t1, u0
+#endif
+	LONG_L		tp, t1, 0
 
 	move		a0, sp
 	bl		do_syscall
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4eed7bc312a8..ec67faab907b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -74,10 +74,11 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	/* GPR21 used for percpu base (runtime), initialized as 0 */
 	move		u0, zero
 
-	la.pcrel	tp, init_thread_union
-	/* Set the SP after an empty pt_regs.  */
-	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
-	PTR_ADD		sp, sp, tp
+	la.pcrel	tp, init_task
+	la.pcrel	t0, init_stack
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
+	PTR_ADDI	sp, t0, -PT_SIZE
 	set_saved_sp	sp, t0, t1
 
 #ifdef CONFIG_RELOCATABLE
@@ -86,8 +87,10 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 #ifdef CONFIG_RANDOMIZE_BASE
 	/* Repoint the sp into the new kernel */
-	PTR_LI		sp, (_THREAD_SIZE - PT_SIZE)
-	PTR_ADD		sp, sp, tp
+	LONG_LPTR	t0, tp, TASK_STACK
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
+	PTR_ADDI	sp, t0, -PT_SIZE
 	set_saved_sp	sp, t0, t1
 
 	/* Jump to the new kernel: new_pc = current_pc + random_offset */
@@ -128,7 +131,8 @@ SYM_CODE_START(smpboot_entry)
 #endif
 	la.pcrel	t0, cpuboot_data
 	ld.d		sp, t0, CPU_BOOT_STACK
-	ld.d		tp, t0, CPU_BOOT_TINFO
+	ld.d		tp, t0, CPU_BOOT_TASK
+	ld.d		u0, t0, CPU_BOOT_OFFSET
 
 	bl		start_secondary
 	ASM_BUG()
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 5505fc355e1b..71c9c6468e60 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -54,6 +54,9 @@
 #include <asm/vdso.h>
 #include <asm/vdso/vdso.h>
 
+DEFINE_PER_CPU(struct task_struct *, __entry_task);
+EXPORT_PER_CPU_SYMBOL_GPL(__entry_task);
+
 #ifdef CONFIG_STACKPROTECTOR
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
@@ -223,6 +226,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (clone_flags & CLONE_SETTLS)
 		childregs->regs[2] = tls;
 
+	/* Set tp to the new task structure for context switching */
+	p->thread.reg02 = (unsigned long)p;
+
 out:
 	ptrace_hw_copy_thread(p);
 	clear_tsk_thread_flag(p, TIF_USEDFPU);
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 16f6a9b39659..a9ef38459629 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -263,7 +263,7 @@ unsigned long __init relocate_kernel(void)
 		reloc_offset += random_offset;
 
 		/* The current thread is now within the relocated kernel */
-		__current_thread_info = RELOCATED_KASLR(__current_thread_info);
+		current_thread_pointer = RELOCATED_KASLR(current_thread_pointer);
 
 		update_reloc_offset(&reloc_offset, random_offset);
 	}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 839b23edee87..5d434c5612ab 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -46,6 +46,7 @@
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/switch_to.h>
 #include <asm/time.h>
 #include <asm/unwind.h>
 
@@ -617,4 +618,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_KASAN
 	kasan_init();
 #endif
+
+	entry_task_switch(&init_task);
 }
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 64a048f1b880..e8b0d2fc2a9a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -34,6 +34,7 @@
 #include <asm/paravirt.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
+#include <asm/switch_to.h>
 #include <asm/time.h>
 
 int __cpu_number_map[NR_CPUS];   /* Map physical to logical */
@@ -400,8 +401,9 @@ void loongson_boot_secondary(int cpu, struct task_struct *idle)
 	pr_info("Booting CPU#%d...\n", cpu);
 
 	entry = __pa_symbol((unsigned long)&smpboot_entry);
-	cpuboot_data.stack = (unsigned long)__KSTK_TOS(idle);
-	cpuboot_data.thread_info = (unsigned long)task_thread_info(idle);
+	cpuboot_data.stack = (unsigned long)task_pt_regs(idle);
+	cpuboot_data.task = (unsigned long)idle;
+	cpuboot_data.offset = per_cpu_offset(cpu);
 
 	csr_mail_send(entry, cpu_logical_map(cpu), 0);
 
@@ -686,6 +688,8 @@ asmlinkage void start_secondary(void)
 	 */
 	complete(&cpu_running);
 
+	entry_task_switch(current);
+
 	/*
 	 * irq will be enabled in loongson_smp_finish(), enabling it too
 	 * early is dangerous.
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index f377d8f5c51a..644348e05f6a 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -12,7 +12,7 @@
 
 /*
  * task_struct *__switch_to(task_struct *prev, task_struct *next,
- *			    struct thread_info *next_ti, void *sched_ra, void *sched_cfa)
+ *			    void *sched_ra, void *sched_cfa)
  */
 	.align	5
 SYM_FUNC_START(__switch_to)
@@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
 	LONG_SPTR	t8, t7, 0
 #endif
 
-	move	tp, a2
+	move	tp, a1
 	cpu_restore_nonscratch a1
 
-	li.w		t0, _THREAD_SIZE
-	PTR_ADD		t0, t0, tp
+	LONG_LPTR	t0, tp, TASK_STACK
+	PTR_LI		t1, _THREAD_SIZE
+	PTR_ADD		t0, t0, t1
 	set_saved_sp	t0, t1, t2
 
 	LONG_LPTR	t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
-- 
2.42.0

