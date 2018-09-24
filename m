From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 08/30] csky: Process management and Signal
Date: Mon, 24 Sep 2018 22:36:24 +0800
Message-ID: <a51eb26bd9442a3e4d09e9785ae5ccaf2555a534.1537789737.git.ren_guo@c-sky.com>
References: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1537789737.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds files related to task_switch, sigcontext, signal.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/abiv2/fpu.c                   | 281 +++++++++++++++++++++++++
 arch/csky/abiv2/inc/abi/fpu.h           |  66 ++++++
 arch/csky/include/asm/mmu_context.h     | 149 ++++++++++++++
 arch/csky/include/asm/processor.h       | 121 +++++++++++
 arch/csky/include/asm/switch_to.h       |  36 ++++
 arch/csky/include/asm/thread_info.h     |  75 +++++++
 arch/csky/include/uapi/asm/sigcontext.h |  14 ++
 arch/csky/kernel/process.c              | 135 ++++++++++++
 arch/csky/kernel/signal.c               | 351 ++++++++++++++++++++++++++++++++
 arch/csky/kernel/time.c                 |  11 +
 10 files changed, 1239 insertions(+)
 create mode 100644 arch/csky/abiv2/fpu.c
 create mode 100644 arch/csky/abiv2/inc/abi/fpu.h
 create mode 100644 arch/csky/include/asm/mmu_context.h
 create mode 100644 arch/csky/include/asm/processor.h
 create mode 100644 arch/csky/include/asm/switch_to.h
 create mode 100644 arch/csky/include/asm/thread_info.h
 create mode 100644 arch/csky/include/uapi/asm/sigcontext.h
 create mode 100644 arch/csky/kernel/process.c
 create mode 100644 arch/csky/kernel/signal.c
 create mode 100644 arch/csky/kernel/time.c

diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
new file mode 100644
index 0000000..8de6b2b
--- /dev/null
+++ b/arch/csky/abiv2/fpu.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/ptrace.h>
+#include <linux/uaccess.h>
+#include <abi/reg_ops.h>
+
+#define MTCR_MASK	0xFC00FFE0
+#define MFCR_MASK	0xFC00FFE0
+#define MTCR_DIST	0xC0006420
+#define MFCR_DIST	0xC0006020
+
+void __init init_fpu(void)
+{
+	mtcr("cr<1, 2>", 0);
+}
+
+/*
+ * fpu_libc_helper() is to help libc to excute:
+ *  - mfcr %a, cr<1, 2>
+ *  - mfcr %a, cr<2, 2>
+ *  - mtcr %a, cr<1, 2>
+ *  - mtcr %a, cr<2, 2>
+ */
+int fpu_libc_helper(struct pt_regs * regs)
+{
+	int fault;
+	unsigned long instrptr, regx = 0;
+	unsigned long index = 0, tmp = 0;
+	unsigned long tinstr = 0;
+	u16 instr_hi, instr_low;
+
+	instrptr = instruction_pointer(regs);
+	if (instrptr & 1) return 0;
+
+	fault = __get_user(instr_low, (u16 *)instrptr);
+	if (fault) return 0;
+
+	fault = __get_user(instr_hi, (u16 *)(instrptr + 2));
+	if (fault) return 0;
+
+	tinstr = instr_hi | ((unsigned long)instr_low << 16);
+
+	if (((tinstr >> 21) & 0x1F) != 2) return 0;
+
+	if ((tinstr & MTCR_MASK) == MTCR_DIST)
+	{
+		index = (tinstr >> 16) & 0x1F;
+		if(index > 13) return 0;
+
+		tmp = tinstr & 0x1F;
+		if (tmp > 2) return 0;
+
+		regx =  *(&regs->a0 + index);
+
+		if(tmp == 1)
+			mtcr("cr<1, 2>", regx);
+		else if (tmp == 2)
+			mtcr("cr<2, 2>", regx);
+		else
+			return 0;
+
+		regs->pc +=4;
+		return 1;
+	}
+
+	if ((tinstr & MFCR_MASK) == MFCR_DIST) {
+		index = tinstr & 0x1F;
+		if(index > 13) return 0;
+
+		tmp = ((tinstr >> 16) & 0x1F);
+		if (tmp > 2) return 0;
+
+		if (tmp == 1)
+			regx = mfcr("cr<1, 2>");
+		else if (tmp == 2)
+			regx = mfcr("cr<2, 2>");
+		else
+			return 0;
+
+		*(&regs->a0 + index) = regx;
+
+		regs->pc +=4;
+		return 1;
+	}
+
+	return 0;
+}
+
+void fpu_fpe(struct pt_regs * regs)
+{
+	int sig;
+	unsigned int fesr;
+	siginfo_t info;
+
+	fesr = mfcr("cr<2, 2>");
+
+	if(fesr & FPE_ILLE){
+		info.si_code = ILL_ILLOPC;
+		sig = SIGILL;
+	}
+	else if(fesr & FPE_IDC){
+		info.si_code = ILL_ILLOPN;
+		sig = SIGILL;
+	}
+	else if(fesr & FPE_FEC){
+		sig = SIGFPE;
+		if(fesr & FPE_IOC){
+			info.si_code = FPE_FLTINV;
+		}
+		else if(fesr & FPE_DZC){
+			info.si_code = FPE_FLTDIV;
+		}
+		else if(fesr & FPE_UFC){
+			info.si_code = FPE_FLTUND;
+		}
+		else if(fesr & FPE_OFC){
+			info.si_code = FPE_FLTOVF;
+		}
+		else if(fesr & FPE_IXC){
+			info.si_code = FPE_FLTRES;
+		}
+		else {
+			info.si_code = NSIGFPE;
+		}
+	}
+	else {
+		info.si_code = NSIGFPE;
+		sig = SIGFPE;
+	}
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void *)regs->pc;
+	force_sig_info(sig, &info, current);
+}
+
+#define FMFVR_FPU_REGS(vrx, vry)	\
+	"fmfvrl %0, "#vrx" \n"		\
+	"fmfvrh %1, "#vrx" \n"		\
+	"fmfvrl %2, "#vry" \n"		\
+	"fmfvrh %3, "#vry" \n"
+
+#define FMTVR_FPU_REGS(vrx, vry)	\
+	"fmtvrl "#vrx", %0 \n"		\
+	"fmtvrh "#vrx", %1 \n"		\
+	"fmtvrl "#vry", %2 \n"		\
+	"fmtvrh "#vry", %3 \n"
+
+#define STW_FPU_REGS(a, b, c, d)	\
+	"stw    %0, (%4, "#a") \n"	\
+	"stw    %1, (%4, "#b") \n"	\
+	"stw    %2, (%4, "#c") \n"	\
+	"stw    %3, (%4, "#d") \n"
+
+#define LDW_FPU_REGS(a, b, c, d)	\
+	"ldw    %0, (%4, "#a") \n"	\
+	"ldw    %1, (%4, "#b") \n"	\
+	"ldw    %2, (%4, "#c") \n"	\
+	"ldw    %3, (%4, "#d") \n"
+
+void save_to_user_fp(struct user_fp *user_fp)
+{
+	unsigned long flg;
+	unsigned long tmp1, tmp2;
+	unsigned long *fpregs;
+
+	local_irq_save(flg);
+
+	tmp1 = mfcr("cr<1, 2>");
+	tmp2 = mfcr("cr<2, 2>");
+
+	user_fp->fcr = tmp1;
+	user_fp->fesr = tmp2;
+
+	fpregs = &user_fp->vr[0];
+#ifdef CONFIG_CPU_HAS_FPUV2
+#ifdef CONFIG_CPU_HAS_VDSP
+	asm volatile(
+		"vstmu.32    vr0-vr3,   (%0) \n"
+		"vstmu.32    vr4-vr7,   (%0) \n"
+		"vstmu.32    vr8-vr11,  (%0) \n"
+		"vstmu.32    vr12-vr15, (%0) \n"
+		"fstmu.64    vr16-vr31, (%0) \n"
+		:"+a"(fpregs)
+		::"memory");
+#else
+	asm volatile(
+		"fstmu.64    vr0-vr31,  (%0) \n"
+		:"+a"(fpregs)
+		::"memory");
+#endif
+#else
+	{
+	unsigned long tmp3, tmp4;
+	asm volatile(
+		FMFVR_FPU_REGS(vr0, vr1)
+		STW_FPU_REGS(0, 4, 16, 20)
+		FMFVR_FPU_REGS(vr2, vr3)
+		STW_FPU_REGS(32, 36, 48, 52)
+		FMFVR_FPU_REGS(vr4, vr5)
+		STW_FPU_REGS(64, 68, 80, 84)
+		FMFVR_FPU_REGS(vr6, vr7)
+		STW_FPU_REGS(96, 100, 112, 116)
+		"addi	%4, 128\n"
+		FMFVR_FPU_REGS(vr8, vr9)
+		STW_FPU_REGS(0, 4, 16, 20)
+		FMFVR_FPU_REGS(vr10, vr11)
+		STW_FPU_REGS(32, 36, 48, 52)
+		FMFVR_FPU_REGS(vr12, vr13)
+		STW_FPU_REGS(64, 68, 80, 84)
+		FMFVR_FPU_REGS(vr14, vr15)
+		STW_FPU_REGS(96, 100, 112, 116)
+		:"=a"(tmp1),"=a"(tmp2),"=a"(tmp3),
+		"=a"(tmp4),"+a"(fpregs)
+		::"memory");
+	}
+#endif
+
+	local_irq_restore(flg);
+}
+
+void restore_from_user_fp(struct user_fp *user_fp)
+{
+	unsigned long flg;
+	unsigned long tmp1, tmp2;
+	unsigned long *fpregs;
+
+	local_irq_save(flg);
+
+	tmp1 = user_fp->fcr;
+	tmp2 = user_fp->fesr;
+
+	mtcr("cr<1, 2>", tmp1);
+	mtcr("cr<2, 2>", tmp2);
+
+	fpregs = &user_fp->vr[0];
+#ifdef CONFIG_CPU_HAS_FPUV2
+#ifdef CONFIG_CPU_HAS_VDSP
+	asm volatile(
+		"vldmu.32    vr0-vr3,   (%0) \n"
+		"vldmu.32    vr4-vr7,   (%0) \n"
+		"vldmu.32    vr8-vr11,  (%0) \n"
+		"vldmu.32    vr12-vr15, (%0) \n"
+		"fldmu.64    vr16-vr31, (%0) \n"
+		:"+a"(fpregs)
+		::"memory");
+#else
+	asm volatile(
+		"fldmu.64    vr0-vr31,  (%0) \n"
+		:"+a"(fpregs)
+		::"memory");
+#endif
+#else
+	{
+	unsigned long tmp3, tmp4;
+	asm volatile(
+		LDW_FPU_REGS(0, 4, 16, 20)
+		FMTVR_FPU_REGS(vr0, vr1)
+		LDW_FPU_REGS(32, 36, 48, 52)
+		FMTVR_FPU_REGS(vr2, vr3)
+		LDW_FPU_REGS(64, 68, 80, 84)
+		FMTVR_FPU_REGS(vr4, vr5)
+		LDW_FPU_REGS(96, 100, 112, 116)
+		FMTVR_FPU_REGS(vr6, vr7)
+		"addi	%4, 128\n"
+		LDW_FPU_REGS(0, 4, 16, 20)
+		FMTVR_FPU_REGS(vr8, vr9)
+		LDW_FPU_REGS(32, 36, 48, 52)
+		FMTVR_FPU_REGS(vr10, vr11)
+		LDW_FPU_REGS(64, 68, 80, 84)
+		FMTVR_FPU_REGS(vr12, vr13)
+		LDW_FPU_REGS(96, 100, 112, 116)
+		FMTVR_FPU_REGS(vr14, vr15)
+		:"=a"(tmp1),"=a"(tmp2),"=a"(tmp3),
+		"=a"(tmp4),"+a"(fpregs)
+		::"memory");
+	}
+#endif
+
+	local_irq_restore(flg);
+}
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
new file mode 100644
index 0000000..a35b45a
--- /dev/null
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_FPU_H
+#define __ASM_CSKY_FPU_H
+
+#include <asm/sigcontext.h>
+#include <asm/ptrace.h>
+
+int fpu_libc_helper(struct pt_regs *regs);
+void fpu_fpe(struct pt_regs *regs);
+void __init init_fpu(void);
+
+void save_to_user_fp(struct user_fp *user_fp);
+void restore_from_user_fp(struct user_fp *user_fp);
+
+/*
+ * Define the fesr bit for fpe handle.
+ */
+#define  FPE_ILLE  (1 << 16)    /* Illegal instruction  */
+#define  FPE_FEC   (1 << 7)     /* Input float-point arithmetic exception */
+#define  FPE_IDC   (1 << 5)     /* Input denormalized exception */
+#define  FPE_IXC   (1 << 4)     /* Inexact exception */
+#define  FPE_UFC   (1 << 3)     /* Underflow exception */
+#define  FPE_OFC   (1 << 2)     /* Overflow exception */
+#define  FPE_DZC   (1 << 1)     /* Divide by zero exception */
+#define  FPE_IOC   (1 << 0)     /* Invalid operation exception */
+#define  FPE_REGULAR_EXCEPTION (FPE_IXC | FPE_UFC | FPE_OFC | FPE_DZC | FPE_IOC)
+
+#ifdef CONFIG_OPEN_FPU_IDE
+#define IDE_STAT   (1 << 5)
+#else
+#define IDE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_IXE
+#define IXE_STAT   (1 << 4)
+#else
+#define IXE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_UFE
+#define UFE_STAT   (1 << 3)
+#else
+#define UFE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_OFE
+#define OFE_STAT   (1 << 2)
+#else
+#define OFE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_DZE
+#define DZE_STAT   (1 << 1)
+#else
+#define DZE_STAT   0
+#endif
+
+#ifdef CONFIG_OPEN_FPU_IOE
+#define IOE_STAT   (1 << 0)
+#else
+#define IOE_STAT   0
+#endif
+
+#endif /* __ASM_CSKY_FPU_H */
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
new file mode 100644
index 0000000..4d8cc34
--- /dev/null
+++ b/arch/csky/include/asm/mmu_context.h
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_MMU_CONTEXT_H
+#define __ASM_CSKY_MMU_CONTEXT_H
+
+#include <asm-generic/mm_hooks.h>
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <abi/ckmmu.h>
+
+static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
+{
+	pgd &= ~(1<<31);
+	pgd += PHYS_OFFSET;
+	pgd |= 1;
+	setup_pgd(pgd, kernel);
+}
+
+#define TLBMISS_HANDLER_SETUP_PGD(pgd) \
+	tlbmiss_handler_setup_pgd((unsigned long)pgd, 0)
+#define TLBMISS_HANDLER_SETUP_PGD_KERNEL(pgd) \
+	tlbmiss_handler_setup_pgd((unsigned long)pgd, 1)
+
+static inline unsigned long tlb_get_pgd(void)
+{
+	return ((get_pgd()|(1<<31)) - PHYS_OFFSET) & ~1;
+}
+
+#define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
+#define cpu_asid(cpu, mm)	(cpu_context((cpu), (mm)) & ASID_MASK)
+#define asid_cache(cpu)		(cpu_data[cpu].asid_cache)
+
+#define ASID_FIRST_VERSION	(1 << CONFIG_CPU_ASID_BITS)
+#define ASID_INC		0x1
+#define ASID_MASK		(ASID_FIRST_VERSION - 1)
+#define ASID_VERSION_MASK	~ASID_MASK
+
+#define destroy_context(mm)		do{}while(0)
+#define enter_lazy_tlb(mm,tsk)		do{}while(0)
+#define deactivate_mm(tsk,mm)		do{}while(0)
+
+/*
+ *  All unused by hardware upper bits will be considered
+ *  as a software asid extension.
+ */
+static inline void
+get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+{
+	unsigned long asid = asid_cache(cpu);
+
+	if (! ((asid += ASID_INC) & ASID_MASK) ) {
+		flush_tlb_all();	/* start new asid cycle */
+		if (!asid)		/* fix version if needed */
+			asid = ASID_FIRST_VERSION;
+	}
+	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
+}
+
+/*
+ * Initialize the context related info for a new mm_struct
+ * instance.
+ */
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	int i;
+
+	for_each_online_cpu(i)
+		cpu_context(i, mm) = 0;
+	return 0;
+}
+
+static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
+                             struct task_struct *tsk)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/* Check if our ASID is of an older version and thus invalid */
+	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
+		get_new_mmu_context(next, cpu);
+	write_mmu_entryhi(cpu_asid(cpu, next));
+	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+
+	/*
+	 * Mark current->active_mm as not "active" anymore.
+	 * We don't want to mislead possible IPI tlb flush routines.
+	 */
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+/*
+ * After we have set current->mm to a new value, this activates
+ * the context for the new mm so we see the new mappings.
+ */
+static inline void
+activate_mm(struct mm_struct *prev, struct mm_struct *next)
+{
+	unsigned long flags;
+	int cpu = smp_processor_id();
+
+	local_irq_save(flags);
+
+	/* Unconditionally get a new ASID.  */
+	get_new_mmu_context(next, cpu);
+
+	write_mmu_entryhi(cpu_asid(cpu, next));
+	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+
+	/* mark mmu ownership change */
+	cpumask_clear_cpu(cpu, mm_cpumask(prev));
+	cpumask_set_cpu(cpu, mm_cpumask(next));
+
+	local_irq_restore(flags);
+}
+
+/*
+ * If mm is currently active_mm, we can't really drop it. Instead,
+ * we will get a new one for it.
+ */
+static inline void
+drop_mmu_context(struct mm_struct *mm, unsigned cpu)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
+		get_new_mmu_context(mm, cpu);
+		write_mmu_entryhi(cpu_asid(cpu, mm));
+	} else {
+		/* will get a new context next time */
+		cpu_context(cpu, mm) = 0;
+	}
+
+	local_irq_restore(flags);
+}
+
+#endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
new file mode 100644
index 0000000..5d91620
--- /dev/null
+++ b/arch/csky/include/asm/processor.h
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_PROCESSOR_H
+#define __ASM_CSKY_PROCESSOR_H
+
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
+
+#include <linux/bitops.h>
+#include <asm/segment.h>
+#include <asm/ptrace.h>
+#include <asm/current.h>
+#include <asm/cache.h>
+#include <abi/reg_ops.h>
+#include <abi/regdef.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
+
+struct cpuinfo_csky {
+	unsigned long udelay_val;
+	unsigned long asid_cache;
+	/*
+	 * Capability and feature descriptor structure for CSKY CPU
+	 */
+	unsigned long options;
+	unsigned int processor_id[4];
+	unsigned int fpu_id;
+} __attribute__((aligned(SMP_CACHE_BYTES)));
+
+extern struct cpuinfo_csky cpu_data[];
+
+/*
+ * User space process size: 2GB. This is hardcoded into a few places,
+ * so don't change it unless you know what you are doing.  TASK_SIZE
+ * for a 64 bit kernel expandable to 8192EB, of which the current CSKY
+ * implementations will "only" be able to use 1TB ...
+ */
+#define TASK_SIZE       0x7fff8000UL
+
+#ifdef __KERNEL__
+#define STACK_TOP       TASK_SIZE
+#define STACK_TOP_MAX   STACK_TOP
+#endif
+
+/* This decides where the kernel will search for a free chunk of vm
+ * space during mmap's.
+ */
+#define TASK_UNMAPPED_BASE      (TASK_SIZE / 3)
+
+struct thread_struct {
+	unsigned long  ksp;       /* kernel stack pointer */
+	unsigned long  sr;        /* saved status register */
+	unsigned long  esp0;      /* points to SR of stack frame */
+	unsigned long  hi;
+	unsigned long  lo;
+
+	/* Other stuff associated with the thread. */
+	unsigned long address;      /* Last user fault */
+	unsigned long error_code;
+
+	/* FPU regs */
+	struct user_fp __attribute__((aligned(16))) user_fp;
+};
+
+#define INIT_THREAD  { \
+	.ksp = (unsigned long) init_thread_union.stack + THREAD_SIZE, \
+	.sr = DEFAULT_PSR_VALUE, \
+}
+
+/*
+ * Do necessary setup to start up a newly executed thread.
+ *
+ * pass the data segment into user programs if it exists,
+ * it can't hurt anything as far as I can tell
+ */
+#define start_thread(_regs, _pc, _usp)					\
+do {									\
+	set_fs(USER_DS); /* reads from user space */			\
+	(_regs)->pc = (_pc);						\
+	(_regs)->regs[1] = 0; /* ABIV1 is R7, uClibc_main rtdl arg */	\
+	(_regs)->regs[2] = 0;						\
+	(_regs)->regs[3] = 0; /* ABIV2 is R7, use it? */		\
+	(_regs)->sr &= ~PS_S;						\
+	(_regs)->usp = (_usp);						\
+} while(0)
+
+/* Forward declaration, a strange C thing */
+struct task_struct;
+
+/* Free all resources held by a thread. */
+static inline void release_thread(struct task_struct *dead_task)
+{
+}
+
+/* Prepare to copy thread state - unlazy all lazy status */
+#define prepare_to_copy(tsk)    do { } while (0)
+
+extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+
+#define copy_segments(tsk, mm)		do { } while (0)
+#define release_segments(mm)		do { } while (0)
+#define forget_segments()		do { } while (0)
+
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
+
+unsigned long get_wchan(struct task_struct *p);
+
+#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
+#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
+
+#define task_pt_regs(p) \
+	((struct pt_regs *)(THREAD_SIZE + p->stack) - 1)
+
+#define cpu_relax() barrier()
+
+#endif /* __ASM_CSKY_PROCESSOR_H */
diff --git a/arch/csky/include/asm/switch_to.h b/arch/csky/include/asm/switch_to.h
new file mode 100644
index 0000000..fe9983a
--- /dev/null
+++ b/arch/csky/include/asm/switch_to.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_SWITCH_TO_H
+#define __ASM_CSKY_SWITCH_TO_H
+
+#include <linux/thread_info.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+static inline void __switch_to_fpu(struct task_struct *prev,
+				   struct task_struct *next)
+{
+	save_to_user_fp(&prev->thread.user_fp);
+	restore_from_user_fp(&next->thread.user_fp);
+}
+#else
+static inline void __switch_to_fpu(struct task_struct *prev,
+				   struct task_struct *next)
+{}
+#endif
+
+/*
+ * Context switching is now performed out-of-line in switch_to.S
+ */
+extern struct task_struct *__switch_to(struct task_struct *,
+				       struct task_struct *);
+
+#define switch_to(prev, next, last)					\
+	do {								\
+		struct task_struct *__prev = (prev);			\
+		struct task_struct *__next = (next);			\
+		__switch_to_fpu(__prev, __next);			\
+		((last) = __switch_to((prev), (next)));			\
+	} while (0)
+
+#endif /* __ASM_CSKY_SWITCH_TO_H */
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
new file mode 100644
index 0000000..f2474bd
--- /dev/null
+++ b/arch/csky/include/asm/thread_info.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef _ASM_CSKY_THREAD_INFO_H
+#define _ASM_CSKY_THREAD_INFO_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/version.h>
+#include <asm/types.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+
+struct thread_info {
+	struct task_struct	*task;
+	void			*dump_exec_domain;
+	unsigned long		flags;
+	int			preempt_count;
+	unsigned long		tp_value;
+	mm_segment_t		addr_limit;
+	struct restart_block	restart_block;
+	struct pt_regs		*regs;
+	unsigned int		cpu;
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.task		= &tsk,			\
+	.preempt_count  = INIT_PREEMPT_COUNT,	\
+	.addr_limit     = KERNEL_DS,		\
+	.cpu		= 0,			\
+	.restart_block = {			\
+		.fn = do_no_restart_syscall,	\
+	},					\
+}
+
+#define THREAD_SIZE_ORDER (THREAD_SHIFT - PAGE_SHIFT)
+
+static inline struct thread_info *current_thread_info(void)
+{
+	unsigned long sp;
+
+	asm volatile("mov %0, sp\n":"=r"(sp));
+
+	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
+}
+
+#endif /* !__ASSEMBLY__ */
+
+/* entry.S relies on these definitions!
+ * bits 0-5 are tested at every exception exit
+ */
+#define TIF_SIGPENDING		0	/* signal pending */
+#define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
+#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_SYSCALL_TRACE	5	/* syscall trace active */
+#define TIF_DELAYED_TRACE	14	/* single step a syscall */
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_MEMDIE		18      /* is terminating due to OOM killer */
+#define TIF_FREEZE		19	/* thread is freezing for suspend */
+#define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
+#define TIF_SECCOMP		21	/* secure computing */
+
+#define _TIF_SIGPENDING         (1 << TIF_SIGPENDING)
+#define _TIF_NOTIFY_RESUME      (1 << TIF_NOTIFY_RESUME)
+#define _TIF_NEED_RESCHED       (1 << TIF_NEED_RESCHED)
+#define _TIF_SYSCALL_TRACE      (1 << TIF_SYSCALL_TRACE)
+#define _TIF_DELAYED_TRACE	(1 << TIF_DELAYED_TRACE)
+#define _TIF_POLLING_NRFLAG     (1 << TIF_POLLING_NRFLAG)
+#define _TIF_MEMDIE		(1 << TIF_MEMDIE)
+#define _TIF_FREEZE             (1 << TIF_FREEZE)
+#define _TIF_RESTORE_SIGMASK    (1 << TIF_RESTORE_SIGMASK)
+#define _TIF_SECCOMP            (1 << TIF_SECCOMP)
+
+#endif	/* _ASM_CSKY_THREAD_INFO_H */
diff --git a/arch/csky/include/uapi/asm/sigcontext.h b/arch/csky/include/uapi/asm/sigcontext.h
new file mode 100644
index 0000000..bc7ad14
--- /dev/null
+++ b/arch/csky/include/uapi/asm/sigcontext.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_SIGCONTEXT_H
+#define __ASM_CSKY_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+struct sigcontext {
+	struct pt_regs	sc_pt_regs;
+	struct user_fp	sc_user_fp;
+};
+
+#endif /* __ASM_CSKY_SIGCONTEXT_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
new file mode 100644
index 0000000..cbda6f1
--- /dev/null
+++ b/arch/csky/kernel/process.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/debug.h>
+#include <linux/delay.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <linux/ptrace.h>
+
+#include <asm/elf.h>
+#include <abi/reg_ops.h>
+
+struct cpuinfo_csky cpu_data[NR_CPUS];
+
+asmlinkage void ret_from_fork(void);
+asmlinkage void ret_from_kernel_thread(void);
+
+/*
+ * Some archs flush debug and FPU info here
+ */
+void flush_thread(void){}
+
+/*
+ * Return saved PC from a blocked thread
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	struct switch_stack *sw = (struct switch_stack *)tsk->thread.ksp;
+
+	return sw->r15;
+}
+
+int copy_thread(unsigned long clone_flags,
+		unsigned long usp,
+		unsigned long kthread_arg,
+		struct task_struct *p)
+{
+	struct switch_stack *childstack;
+	struct pt_regs *childregs = task_pt_regs(p);
+
+#ifdef CONFIG_CPU_HAS_FPU
+	save_to_user_fp(&p->thread.user_fp);
+#endif
+
+	childstack = ((struct switch_stack *) childregs) - 1;
+	memset(childstack, 0, sizeof(struct switch_stack));
+
+	/* setup ksp for switch_to !!! */
+	p->thread.ksp = (unsigned long)childstack;
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		memset(childregs, 0, sizeof(struct pt_regs));
+		childstack->r15 = (unsigned long) ret_from_kernel_thread;
+		childstack->r8 = kthread_arg;
+		childstack->r9 = usp;
+		childregs->sr = mfcr("psr");
+	} else {
+		*childregs = *(current_pt_regs());
+		if (usp)
+			childregs->usp = usp;
+		if (clone_flags & CLONE_SETTLS)
+			task_thread_info(p)->tp_value = childregs->tls
+						      = childregs->regs[0];
+
+		childregs->a0 = 0;
+		childstack->r15 = (unsigned long) ret_from_fork;
+	}
+
+	return 0;
+}
+
+/* Fill in the fpu structure for a core dump.  */
+int dump_fpu (struct pt_regs *regs, struct user_fp *fpu)
+{
+	memcpy(fpu, &current->thread.user_fp, sizeof(*fpu));
+	return 1;
+}
+EXPORT_SYMBOL(dump_fpu);
+
+int dump_task_regs(struct task_struct *tsk, elf_gregset_t *pr_regs)
+{
+	struct pt_regs *regs = task_pt_regs(tsk);
+
+	/* NOTE: usp is error value. */
+	ELF_CORE_COPY_REGS ((*pr_regs), regs)
+
+	return 1;
+}
+
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long esp, pc;
+	unsigned long stack_page;
+	int count = 0;
+	if (!p || p == current || p->state == TASK_RUNNING)
+		return 0;
+
+	stack_page = (unsigned long)p;
+	esp = p->thread.esp0;
+	do {
+		if (esp < stack_page+sizeof(struct task_struct) ||
+		    esp >= 8184+stack_page)
+			return 0;
+		/*FIXME: There's may be error here!*/
+		pc = ((unsigned long *)esp)[1];
+		/* FIXME: This depends on the order of these functions. */
+		if (!in_sched_functions(pc))
+			return pc;
+		esp = *(unsigned long *) esp;
+	} while (count++ < 16);
+	return 0;
+}
+EXPORT_SYMBOL(get_wchan);
+
+#ifndef CONFIG_CPU_PM_NONE
+void arch_cpu_idle(void)
+{
+#ifdef CONFIG_CPU_PM_WAIT
+	asm volatile("wait\n");
+#endif
+
+#ifdef CONFIG_CPU_PM_DOZE
+	asm volatile("doze\n");
+#endif
+
+#ifdef CONFIG_CPU_PM_STOP
+	asm volatile("stop\n");
+#endif
+	local_irq_enable();
+}
+#endif
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
new file mode 100644
index 0000000..a5c5c4c
--- /dev/null
+++ b/arch/csky/kernel/signal.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/kernel.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/ptrace.h>
+#include <linux/unistd.h>
+#include <linux/stddef.h>
+#include <linux/highuid.h>
+#include <linux/personality.h>
+#include <linux/tty.h>
+#include <linux/binfmts.h>
+#include <linux/tracehook.h>
+#include <linux/freezer.h>
+#include <linux/uaccess.h>
+
+#include <asm/setup.h>
+#include <asm/pgtable.h>
+#include <asm/traps.h>
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+
+#include <abi/regdef.h>
+
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+
+static int restore_fpu_state(struct sigcontext *sc)
+{
+	int err = 0;
+	struct user_fp user_fp;
+
+	err = copy_from_user(&user_fp, &sc->sc_user_fp, sizeof(user_fp));
+
+	restore_from_user_fp(&user_fp);
+
+	return err;
+}
+
+static int save_fpu_state(struct sigcontext *sc)
+{
+	struct user_fp user_fp;
+
+	save_to_user_fp(&user_fp);
+
+	return copy_to_user(&sc->sc_user_fp, &user_fp, sizeof(user_fp));
+}
+#else
+static inline int restore_fpu_state(struct sigcontext *sc){return 0;}
+static inline int save_fpu_state(struct sigcontext *sc){return 0;}
+#endif
+
+struct rt_sigframe
+{
+	int sig;
+	struct siginfo *pinfo;
+	void *puc;
+	struct siginfo info;
+	struct ucontext uc;
+};
+
+static int
+restore_sigframe(struct pt_regs *regs,
+		 struct sigcontext *sc, int *pr2)
+{
+	int err = 0;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->task->restart_block.fn = do_no_restart_syscall;
+
+	err |= copy_from_user(regs, &sc->sc_pt_regs, sizeof(struct pt_regs));
+
+	err |= restore_fpu_state(sc);
+
+	*pr2 = regs->a0;
+	return err;
+}
+
+asmlinkage int
+do_rt_sigreturn(void)
+{
+	sigset_t set;
+	int a0;
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe *frame = (struct rt_sigframe *)(regs->usp);
+
+	if (verify_area(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	sigdelsetmask(&set, (sigmask(SIGKILL) | sigmask(SIGSTOP)));
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = set;
+	recalc_sigpending( );
+	spin_unlock_irq(&current->sighand->siglock);
+
+	if (restore_sigframe(regs, &frame->uc.uc_mcontext, &a0))
+		goto badframe;
+
+	return a0;
+
+badframe:
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static int setup_sigframe(struct sigcontext *sc, struct pt_regs *regs)
+{
+	int err = 0;
+
+	err |= copy_to_user(&sc->sc_pt_regs, regs, sizeof(struct pt_regs));
+	err |= save_fpu_state(sc);
+
+	return err;
+}
+
+static inline void *
+get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
+{
+	unsigned long usp;
+
+	/* Default to using normal stack.  */
+	usp = regs->usp;
+
+	/* This is the X/Open sanctioned signal stack switching.  */
+	if ((ka->sa.sa_flags & SA_ONSTACK) && !sas_ss_flags(usp)) {
+		if (!on_sig_stack(usp))
+			usp = current->sas_ss_sp + current->sas_ss_size;
+	}
+	return (void *)((usp - frame_size) & -8UL);
+}
+
+static int setup_rt_frame (int sig, struct k_sigaction *ka, siginfo_t *info,
+		sigset_t *set, struct pt_regs *regs)
+{
+	struct rt_sigframe *frame;
+	int err = 0;
+
+	struct csky_vdso *vdso = current->mm->context.vdso;
+
+	frame = get_sigframe(ka, regs, sizeof(*frame));
+	if (!frame)
+		return 1;
+
+	err |= __put_user(sig, &frame->sig);
+	err |= __put_user(&frame->info, &frame->pinfo);
+	err |= __put_user(&frame->uc, &frame->puc);
+	err |= copy_siginfo_to_user(&frame->info, info);
+
+	/* Create the ucontext.  */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(0, &frame->uc.uc_link);
+	err |= __put_user((void *)current->sas_ss_sp,
+			&frame->uc.uc_stack.ss_sp);
+	err |= __put_user(sas_ss_flags(regs->usp),
+			&frame->uc.uc_stack.ss_flags);
+	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
+	err |= setup_sigframe(&frame->uc.uc_mcontext, regs);
+	err |= copy_to_user (&frame->uc.uc_sigmask, set, sizeof(*set));
+
+	if (err)
+		goto give_sigsegv;
+
+	/* Set up registers for signal handler */
+	regs->usp = (unsigned long) frame;
+	regs->pc = (unsigned long) ka->sa.sa_handler;
+	regs->lr = (unsigned long)vdso->rt_signal_retcode;
+
+adjust_stack:
+	regs->a0 = sig; /* first arg is signo */
+	regs->a1 = (unsigned long)(&(frame->info)); /* second arg is (siginfo_t*) */
+	regs->a2 = (unsigned long)(&(frame->uc));/* third arg pointer to ucontext */
+	return err;
+
+give_sigsegv:
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
+	goto adjust_stack;
+}
+
+/*
+ * OK, we're invoking a handler
+ */
+static int
+handle_signal(int sig, struct k_sigaction *ka, siginfo_t *info,
+		sigset_t *oldset, struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+	int ret;
+
+	/* set up the stack frame, regardless of SA_SIGINFO, and pass info anyway. */
+	ret = setup_rt_frame(sig, ka, info, oldset, regs);
+
+	if (ret != 0) {
+		force_sigsegv(sig, tsk);
+		return ret;
+	}
+
+	/* Block the signal if we were successful. */
+	spin_lock_irq(&current->sighand->siglock);
+	sigorsets(&current->blocked, &current->blocked, &ka->sa.sa_mask);
+	if (!(ka->sa.sa_flags & SA_NODEFER))
+		sigaddset(&current->blocked, sig);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	return 0;
+}
+
+/*
+ * Note that 'init' is a special process: it doesn't get signals it doesn't
+ * want to handle. Thus you cannot kill init even with a SIGKILL even by
+ * mistake.
+ *
+ * Note that we go through the signals twice: once to check the signals
+ * that the kernel can handle, and then we build all the user-level signal
+ * handling stack-frames in one go after that.
+ */
+static void do_signal(struct pt_regs *regs, int syscall)
+{
+	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
+	struct ksignal ksig;
+
+	/*
+	 * We want the common case to go fast, which
+	 * is why we may in certain cases get here from
+	 * kernel mode. Just return without doing anything
+	 * if so.
+	 */
+	if (!user_mode(regs))
+		return;
+
+	current->thread.esp0 = (unsigned long)regs;
+
+	/*
+	 * If we were from a system call, check for system call restarting...
+	 */
+	if (syscall) {
+		continue_addr = regs->pc;
+#if defined(__CSKYABIV2__)
+		restart_addr = continue_addr - 4;
+#else
+		restart_addr = continue_addr - 2;
+#endif
+		retval = regs->a0;
+
+		/*
+		 * Prepare for system call restart.  We do this here so that a
+		 * debugger will see the already changed.
+		 */
+		switch (retval) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->a0 = regs->orig_a0;
+			regs->pc = restart_addr;
+			break;
+		case -ERESTART_RESTARTBLOCK:
+			regs->a0 = -EINTR;
+			break;
+		}
+	}
+
+	if (try_to_freeze())
+		goto no_signal;
+
+	/*
+	 * Get the signal to deliver.  When running under ptrace, at this
+	 * point the debugger may change all our registers ...
+	 */
+	if (get_signal(&ksig)) {
+		sigset_t *oldset;
+
+		/*
+		 * Depending on the signal settings we may need to revert the
+		 * decision to restart the system call.  But skip this if a
+		 * debugger has chosen to restart at a different PC.
+		 */
+		if (regs->pc == restart_addr) {
+			if (retval == -ERESTARTNOHAND
+					|| (retval == -ERESTARTSYS
+						&& !(ksig.ka.sa.sa_flags & SA_RESTART))) {
+				regs->a0 = -EINTR;
+				regs->pc = continue_addr;
+			}
+		}
+
+		if (test_thread_flag(TIF_RESTORE_SIGMASK))
+			oldset = &current->saved_sigmask;
+		else
+			oldset = &current->blocked;
+		/* Whee!  Actually deliver the signal.  */
+		if (handle_signal(ksig.sig, &ksig.ka, &ksig.info, oldset, regs) == 0) {
+			/*
+			 * A signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag.
+			 */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+		return;
+	}
+
+no_signal:
+	if (syscall) {
+		/*
+		 * Handle restarting a different system call.  As above,
+		 * if a debugger has chosen to restart at a different PC,
+		 * ignore the restart.
+		 */
+		if (retval == -ERESTART_RESTARTBLOCK
+				&& regs->pc == continue_addr) {
+#if defined(__CSKYABIV2__)
+			regs->regs[3] = __NR_restart_syscall;
+			regs->pc -= 4;
+#else
+			regs->regs[9] = __NR_restart_syscall;
+			regs->pc -= 2;
+#endif
+		}
+
+		/* If there's no signal to deliver, we just put the saved sigmask
+		 * back.
+		 */
+		if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+			sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+		}
+	}
+}
+
+asmlinkage void
+do_notify_resume(unsigned int thread_flags, struct pt_regs *regs, int syscall)
+{
+	if (thread_flags & _TIF_SIGPENDING)
+		do_signal(regs, syscall);
+
+	if (thread_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
+}
diff --git a/arch/csky/kernel/time.c b/arch/csky/kernel/time.c
new file mode 100644
index 0000000..b5fc944
--- /dev/null
+++ b/arch/csky/kernel/time.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+
+void __init time_init(void)
+{
+	of_clk_init(NULL);
+	timer_probe();
+}
-- 
2.7.4
