From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 16/17] RISC-V: Add kernel subdirectory
Date: Tue,  6 Jun 2017 16:00:06 -0700
Message-ID: <20170606230007.19101-17-palmer__10210.537716239$1496790156$gmane$org@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
List-Id: linux-arch.vger.kernel.org

These files were mostly based on the score port, but many of them are
very ISA specific.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/kernel/.gitignore       |   1 +
 arch/riscv/kernel/Makefile         |  16 ++
 arch/riscv/kernel/asm-offsets.c    | 316 +++++++++++++++++++++++++++
 arch/riscv/kernel/cacheinfo.c      | 103 +++++++++
 arch/riscv/kernel/cpu.c            |  89 ++++++++
 arch/riscv/kernel/entry.S          | 437 +++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S           | 147 +++++++++++++
 arch/riscv/kernel/irq.c            |  20 ++
 arch/riscv/kernel/module.c         | 215 ++++++++++++++++++
 arch/riscv/kernel/process.c        | 132 +++++++++++
 arch/riscv/kernel/ptrace.c         | 147 +++++++++++++
 arch/riscv/kernel/reset.c          |  36 +++
 arch/riscv/kernel/riscv_ksyms.c    |  16 ++
 arch/riscv/kernel/setup.c          | 240 ++++++++++++++++++++
 arch/riscv/kernel/signal.c         | 257 ++++++++++++++++++++++
 arch/riscv/kernel/smp.c            | 110 ++++++++++
 arch/riscv/kernel/smpboot.c        | 103 +++++++++
 arch/riscv/kernel/stacktrace.c     | 177 +++++++++++++++
 arch/riscv/kernel/sys_riscv.c      |  85 ++++++++
 arch/riscv/kernel/syscall_table.c  |  25 +++
 arch/riscv/kernel/traps.c          | 183 ++++++++++++++++
 arch/riscv/kernel/vdso.c           | 125 +++++++++++
 arch/riscv/kernel/vdso/.gitignore  |   1 +
 arch/riscv/kernel/vdso/Makefile    |  61 ++++++
 arch/riscv/kernel/vdso/sigreturn.S |  24 ++
 arch/riscv/kernel/vdso/vdso.S      |  27 +++
 arch/riscv/kernel/vdso/vdso.lds.S  |  76 +++++++
 arch/riscv/kernel/vmlinux.lds.S    |  92 ++++++++
 28 files changed, 3261 insertions(+)
 create mode 100644 arch/riscv/kernel/.gitignore
 create mode 100644 arch/riscv/kernel/Makefile
 create mode 100644 arch/riscv/kernel/asm-offsets.c
 create mode 100644 arch/riscv/kernel/cacheinfo.c
 create mode 100644 arch/riscv/kernel/cpu.c
 create mode 100644 arch/riscv/kernel/entry.S
 create mode 100644 arch/riscv/kernel/head.S
 create mode 100644 arch/riscv/kernel/irq.c
 create mode 100644 arch/riscv/kernel/module.c
 create mode 100644 arch/riscv/kernel/process.c
 create mode 100644 arch/riscv/kernel/ptrace.c
 create mode 100644 arch/riscv/kernel/reset.c
 create mode 100644 arch/riscv/kernel/riscv_ksyms.c
 create mode 100644 arch/riscv/kernel/setup.c
 create mode 100644 arch/riscv/kernel/signal.c
 create mode 100644 arch/riscv/kernel/smp.c
 create mode 100644 arch/riscv/kernel/smpboot.c
 create mode 100644 arch/riscv/kernel/stacktrace.c
 create mode 100644 arch/riscv/kernel/sys_riscv.c
 create mode 100644 arch/riscv/kernel/syscall_table.c
 create mode 100644 arch/riscv/kernel/traps.c
 create mode 100644 arch/riscv/kernel/vdso.c
 create mode 100644 arch/riscv/kernel/vdso/.gitignore
 create mode 100644 arch/riscv/kernel/vdso/Makefile
 create mode 100644 arch/riscv/kernel/vdso/sigreturn.S
 create mode 100644 arch/riscv/kernel/vdso/vdso.S
 create mode 100644 arch/riscv/kernel/vdso/vdso.lds.S
 create mode 100644 arch/riscv/kernel/vmlinux.lds.S

diff --git a/arch/riscv/kernel/.gitignore b/arch/riscv/kernel/.gitignore
new file mode 100644
index 000000000000..b51634f6a7cd
--- /dev/null
+++ b/arch/riscv/kernel/.gitignore
@@ -0,0 +1 @@
+/vmlinux.lds
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
new file mode 100644
index 000000000000..b6de129d4a23
--- /dev/null
+++ b/arch/riscv/kernel/Makefile
@@ -0,0 +1,16 @@
+#
+# Makefile for the RISC-V Linux kernel
+#
+
+extra-y := head.o vmlinux.lds
+
+obj-y	:= cpu.o entry.o irq.o process.o ptrace.o reset.o setup.o \
+	   signal.o syscall_table.o sys_riscv.o traps.o \
+	   riscv_ksyms.o stacktrace.o vdso.o cacheinfo.o vdso/
+
+CFLAGS_setup.o := -mcmodel=medany
+
+obj-$(CONFIG_SMP)		+= smpboot.o smp.o
+obj-$(CONFIG_MODULES)		+= module.o
+
+clean:
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
new file mode 100644
index 000000000000..2ead5037528c
--- /dev/null
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -0,0 +1,316 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/kbuild.h>
+#include <linux/sched.h>
+#include <asm/thread_info.h>
+#include <asm/ptrace.h>
+
+void asm_offsets(void)
+{
+	OFFSET(TASK_THREAD_RA, task_struct, thread.ra);
+	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
+	OFFSET(TASK_THREAD_S0, task_struct, thread.s[0]);
+	OFFSET(TASK_THREAD_S1, task_struct, thread.s[1]);
+	OFFSET(TASK_THREAD_S2, task_struct, thread.s[2]);
+	OFFSET(TASK_THREAD_S3, task_struct, thread.s[3]);
+	OFFSET(TASK_THREAD_S4, task_struct, thread.s[4]);
+	OFFSET(TASK_THREAD_S5, task_struct, thread.s[5]);
+	OFFSET(TASK_THREAD_S6, task_struct, thread.s[6]);
+	OFFSET(TASK_THREAD_S7, task_struct, thread.s[7]);
+	OFFSET(TASK_THREAD_S8, task_struct, thread.s[8]);
+	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
+	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
+	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
+	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
+	OFFSET(TASK_STACK, task_struct, stack);
+	OFFSET(TASK_TI, task_struct, thread_info);
+	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
+	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
+
+	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
+	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
+	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
+	OFFSET(TASK_THREAD_F3,  task_struct, thread.fstate.f[3]);
+	OFFSET(TASK_THREAD_F4,  task_struct, thread.fstate.f[4]);
+	OFFSET(TASK_THREAD_F5,  task_struct, thread.fstate.f[5]);
+	OFFSET(TASK_THREAD_F6,  task_struct, thread.fstate.f[6]);
+	OFFSET(TASK_THREAD_F7,  task_struct, thread.fstate.f[7]);
+	OFFSET(TASK_THREAD_F8,  task_struct, thread.fstate.f[8]);
+	OFFSET(TASK_THREAD_F9,  task_struct, thread.fstate.f[9]);
+	OFFSET(TASK_THREAD_F10, task_struct, thread.fstate.f[10]);
+	OFFSET(TASK_THREAD_F11, task_struct, thread.fstate.f[11]);
+	OFFSET(TASK_THREAD_F12, task_struct, thread.fstate.f[12]);
+	OFFSET(TASK_THREAD_F13, task_struct, thread.fstate.f[13]);
+	OFFSET(TASK_THREAD_F14, task_struct, thread.fstate.f[14]);
+	OFFSET(TASK_THREAD_F15, task_struct, thread.fstate.f[15]);
+	OFFSET(TASK_THREAD_F16, task_struct, thread.fstate.f[16]);
+	OFFSET(TASK_THREAD_F17, task_struct, thread.fstate.f[17]);
+	OFFSET(TASK_THREAD_F18, task_struct, thread.fstate.f[18]);
+	OFFSET(TASK_THREAD_F19, task_struct, thread.fstate.f[19]);
+	OFFSET(TASK_THREAD_F20, task_struct, thread.fstate.f[20]);
+	OFFSET(TASK_THREAD_F21, task_struct, thread.fstate.f[21]);
+	OFFSET(TASK_THREAD_F22, task_struct, thread.fstate.f[22]);
+	OFFSET(TASK_THREAD_F23, task_struct, thread.fstate.f[23]);
+	OFFSET(TASK_THREAD_F24, task_struct, thread.fstate.f[24]);
+	OFFSET(TASK_THREAD_F25, task_struct, thread.fstate.f[25]);
+	OFFSET(TASK_THREAD_F26, task_struct, thread.fstate.f[26]);
+	OFFSET(TASK_THREAD_F27, task_struct, thread.fstate.f[27]);
+	OFFSET(TASK_THREAD_F28, task_struct, thread.fstate.f[28]);
+	OFFSET(TASK_THREAD_F29, task_struct, thread.fstate.f[29]);
+	OFFSET(TASK_THREAD_F30, task_struct, thread.fstate.f[30]);
+	OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
+	OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
+
+	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	OFFSET(PT_SEPC, pt_regs, sepc);
+	OFFSET(PT_RA, pt_regs, ra);
+	OFFSET(PT_FP, pt_regs, s0);
+	OFFSET(PT_S0, pt_regs, s0);
+	OFFSET(PT_S1, pt_regs, s1);
+	OFFSET(PT_S2, pt_regs, s2);
+	OFFSET(PT_S3, pt_regs, s3);
+	OFFSET(PT_S4, pt_regs, s4);
+	OFFSET(PT_S5, pt_regs, s5);
+	OFFSET(PT_S6, pt_regs, s6);
+	OFFSET(PT_S7, pt_regs, s7);
+	OFFSET(PT_S8, pt_regs, s8);
+	OFFSET(PT_S9, pt_regs, s9);
+	OFFSET(PT_S10, pt_regs, s10);
+	OFFSET(PT_S11, pt_regs, s11);
+	OFFSET(PT_SP, pt_regs, sp);
+	OFFSET(PT_TP, pt_regs, tp);
+	OFFSET(PT_A0, pt_regs, a0);
+	OFFSET(PT_A1, pt_regs, a1);
+	OFFSET(PT_A2, pt_regs, a2);
+	OFFSET(PT_A3, pt_regs, a3);
+	OFFSET(PT_A4, pt_regs, a4);
+	OFFSET(PT_A5, pt_regs, a5);
+	OFFSET(PT_A6, pt_regs, a6);
+	OFFSET(PT_A7, pt_regs, a7);
+	OFFSET(PT_T0, pt_regs, t0);
+	OFFSET(PT_T1, pt_regs, t1);
+	OFFSET(PT_T2, pt_regs, t2);
+	OFFSET(PT_T3, pt_regs, t3);
+	OFFSET(PT_T4, pt_regs, t4);
+	OFFSET(PT_T5, pt_regs, t5);
+	OFFSET(PT_T6, pt_regs, t6);
+	OFFSET(PT_GP, pt_regs, gp);
+	OFFSET(PT_SSTATUS, pt_regs, sstatus);
+	OFFSET(PT_SBADADDR, pt_regs, sbadaddr);
+	OFFSET(PT_SCAUSE, pt_regs, scause);
+
+	/* THREAD_{F,X}* might be larger than a S-type offset can handle, but
+	 * these are used in performance-sensitive assembly so we can't resort
+	 * to loading the long immediate every time.
+	 */
+	DEFINE(TASK_THREAD_RA_RA,
+		  offsetof(struct task_struct, thread.ra)
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_SP_RA,
+		  offsetof(struct task_struct, thread.sp)
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S0_RA,
+		  offsetof(struct task_struct, thread.s[0])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S1_RA,
+		  offsetof(struct task_struct, thread.s[1])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S2_RA,
+		  offsetof(struct task_struct, thread.s[2])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S3_RA,
+		  offsetof(struct task_struct, thread.s[3])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S4_RA,
+		  offsetof(struct task_struct, thread.s[4])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S5_RA,
+		  offsetof(struct task_struct, thread.s[5])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S6_RA,
+		  offsetof(struct task_struct, thread.s[6])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S7_RA,
+		  offsetof(struct task_struct, thread.s[7])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S8_RA,
+		  offsetof(struct task_struct, thread.s[8])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S9_RA,
+		  offsetof(struct task_struct, thread.s[9])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S10_RA,
+		  offsetof(struct task_struct, thread.s[10])
+		- offsetof(struct task_struct, thread.ra)
+	);
+	DEFINE(TASK_THREAD_S11_RA,
+		  offsetof(struct task_struct, thread.s[11])
+		- offsetof(struct task_struct, thread.ra)
+	);
+
+	DEFINE(TASK_THREAD_F0_F0,
+		  offsetof(struct task_struct, thread.fstate.f[0])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F1_F0,
+		  offsetof(struct task_struct, thread.fstate.f[1])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F2_F0,
+		  offsetof(struct task_struct, thread.fstate.f[2])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F3_F0,
+		  offsetof(struct task_struct, thread.fstate.f[3])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F4_F0,
+		  offsetof(struct task_struct, thread.fstate.f[4])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F5_F0,
+		  offsetof(struct task_struct, thread.fstate.f[5])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F6_F0,
+		  offsetof(struct task_struct, thread.fstate.f[6])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F7_F0,
+		  offsetof(struct task_struct, thread.fstate.f[7])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F8_F0,
+		  offsetof(struct task_struct, thread.fstate.f[8])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F9_F0,
+		  offsetof(struct task_struct, thread.fstate.f[9])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F10_F0,
+		  offsetof(struct task_struct, thread.fstate.f[10])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F11_F0,
+		  offsetof(struct task_struct, thread.fstate.f[11])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F12_F0,
+		  offsetof(struct task_struct, thread.fstate.f[12])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F13_F0,
+		  offsetof(struct task_struct, thread.fstate.f[13])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F14_F0,
+		  offsetof(struct task_struct, thread.fstate.f[14])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F15_F0,
+		  offsetof(struct task_struct, thread.fstate.f[15])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F16_F0,
+		  offsetof(struct task_struct, thread.fstate.f[16])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F17_F0,
+		  offsetof(struct task_struct, thread.fstate.f[17])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F18_F0,
+		  offsetof(struct task_struct, thread.fstate.f[18])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F19_F0,
+		  offsetof(struct task_struct, thread.fstate.f[19])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F20_F0,
+		  offsetof(struct task_struct, thread.fstate.f[20])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F21_F0,
+		  offsetof(struct task_struct, thread.fstate.f[21])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F22_F0,
+		  offsetof(struct task_struct, thread.fstate.f[22])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F23_F0,
+		  offsetof(struct task_struct, thread.fstate.f[23])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F24_F0,
+		  offsetof(struct task_struct, thread.fstate.f[24])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F25_F0,
+		  offsetof(struct task_struct, thread.fstate.f[25])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F26_F0,
+		  offsetof(struct task_struct, thread.fstate.f[26])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F27_F0,
+		  offsetof(struct task_struct, thread.fstate.f[27])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F28_F0,
+		  offsetof(struct task_struct, thread.fstate.f[28])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F29_F0,
+		  offsetof(struct task_struct, thread.fstate.f[29])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F30_F0,
+		  offsetof(struct task_struct, thread.fstate.f[30])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_F31_F0,
+		  offsetof(struct task_struct, thread.fstate.f[31])
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+	DEFINE(TASK_THREAD_FCSR_F0,
+		  offsetof(struct task_struct, thread.fstate.fcsr)
+		- offsetof(struct task_struct, thread.fstate.f[0])
+	);
+
+	/* The assembler needs access to THREAD_SIZE as well. */
+	DEFINE(ASM_THREAD_SIZE, THREAD_SIZE);
+
+	/* We allocate a pt_regs on the stack when entering the kernel.  This
+	 * ensures the alignment is sane.
+	 */
+	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
+}
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
new file mode 100644
index 000000000000..76ed95850a22
--- /dev/null
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+static void ci_leaf_init(struct cacheinfo *this_leaf,
+			 struct device_node *node,
+			 enum cache_type type, unsigned int level)
+{
+	this_leaf->of_node = node;
+	this_leaf->level = level;
+	this_leaf->type = type;
+	this_leaf->physical_line_partition = 1; // not a sector cache
+	this_leaf->attributes =
+		CACHE_WRITE_BACK
+		| CACHE_READ_ALLOCATE
+		| CACHE_WRITE_ALLOCATE; // TODO: add to DTS
+}
+
+static int __init_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	int levels = 0, leaves = 0, level;
+
+	if (of_property_read_bool(np, "cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "i-cache-size"))
+		++leaves;
+	if (of_property_read_bool(np, "d-cache-size"))
+		++leaves;
+	if (leaves > 0)
+		levels = 1;
+
+	while ((np = of_find_next_cache_node(np))) {
+		if (!of_device_is_compatible(np, "cache"))
+			break;
+		if (of_property_read_u32(np, "cache-level", &level))
+			break;
+		if (level <= levels)
+			break;
+		if (of_property_read_bool(np, "cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "i-cache-size"))
+			++leaves;
+		if (of_property_read_bool(np, "d-cache-size"))
+			++leaves;
+		levels = level;
+	}
+
+	this_cpu_ci->num_levels = levels;
+	this_cpu_ci->num_leaves = leaves;
+	return 0;
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	struct device_node *np = of_cpu_device_node_get(cpu);
+	int levels = 1, level = 1;
+
+	if (of_property_read_bool(np, "cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+	if (of_property_read_bool(np, "i-cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+	if (of_property_read_bool(np, "d-cache-size"))
+		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+
+	while ((np = of_find_next_cache_node(np))) {
+		if (!of_device_is_compatible(np, "cache"))
+			break;
+		if (of_property_read_u32(np, "cache-level", &level))
+			break;
+		if (level <= levels)
+			break;
+		if (of_property_read_bool(np, "cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
+		if (of_property_read_bool(np, "i-cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
+		if (of_property_read_bool(np, "d-cache-size"))
+			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
+		levels = level;
+	}
+
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
new file mode 100644
index 000000000000..20004bd7a216
--- /dev/null
+++ b/arch/riscv/kernel/cpu.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/seq_file.h>
+#include <linux/of.h>
+
+/* Return -1 if not a valid hart */
+int riscv_of_processor_hart(struct device_node *node)
+{
+	const char *isa, *status;
+	u32 hart;
+
+	if (!of_device_is_compatible(node, "riscv"))
+		return -(ENODEV);
+	if (of_property_read_u32(node, "reg", &hart)
+	    || hart >= NR_CPUS)
+		return -(ENODEV);
+	if (of_property_read_string(node, "status", &status)
+	    || strcmp(status, "okay"))
+		return -(ENODEV);
+	if (of_property_read_string(node, "riscv,isa", &isa)
+	    || isa[0] != 'r'
+	    || isa[1] != 'v')
+		return -(ENODEV);
+
+	return hart;
+}
+
+#ifdef CONFIG_PROC_FS
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	if ((*pos) < nr_cpu_ids)
+		return (void *)(uintptr_t)(1 + *pos);
+	return NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+static int c_show(struct seq_file *m, void *v)
+{
+	unsigned long hart_id = (unsigned long)v - 1;
+	struct device_node *node = of_get_cpu_node(hart_id, NULL);
+	const char *compat, *isa, *mmu;
+
+	seq_printf(m, "hart\t: %lu\n", hart_id);
+	if (!of_property_read_string(node, "riscv,isa", &isa)
+	    && isa[0] == 'r'
+	    && isa[1] == 'v')
+		seq_printf(m, "isa\t: %s\n", isa);
+	if (!of_property_read_string(node, "mmu-type", &mmu)
+	    && !strncmp(mmu, "riscv,", 6))
+		seq_printf(m, "mmu\t: %s\n", mmu+6);
+	if (!of_property_read_string(node, "compatible", &compat)
+	    && strcmp(compat, "riscv"))
+		seq_printf(m, "uarch\t: %s\n", compat);
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= c_show
+};
+
+#endif /* CONFIG_PROC_FS */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
new file mode 100644
index 000000000000..0be9ca33e8fc
--- /dev/null
+++ b/arch/riscv/kernel/entry.S
@@ -0,0 +1,437 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/unistd.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+	.text
+	.altmacro
+
+/* Prepares to enter a system call or exception by saving all registers to the
+ * stack.
+ */
+	.macro SAVE_ALL
+	LOCAL _restore_kernel_tpsp
+	LOCAL _save_context
+
+	/* If coming from userspace, preserve the user thread pointer and load
+	   the kernel thread pointer.  If we came from the kernel, sscratch
+	   will contain 0, and we should continue on the current TP. */
+	csrrw tp, sscratch, tp
+	bnez tp, _save_context
+
+_restore_kernel_tpsp:
+	csrr tp, sscratch
+	REG_S sp, TASK_TI_KERNEL_SP(tp)
+_save_context:
+	REG_S sp, TASK_TI_USER_SP(tp)
+	REG_L sp, TASK_TI_KERNEL_SP(tp)
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+	REG_S x1,  PT_RA(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+
+	/* Disable FPU to detect illegal usage of
+	   floating point in kernel space */
+	li t0, SR_FS
+
+	REG_L s0, TASK_TI_USER_SP(tp)
+	csrrc s1, sstatus, t0
+	csrr s2, sepc
+	csrr s3, sbadaddr
+	csrr s4, scause
+	csrr s5, sscratch
+	REG_S s0, PT_SP(sp)
+	REG_S s1, PT_SSTATUS(sp)
+	REG_S s2, PT_SEPC(sp)
+	REG_S s3, PT_SBADADDR(sp)
+	REG_S s4, PT_SCAUSE(sp)
+	REG_S s5, PT_TP(sp)
+	.endm
+
+/* Prepares to return from a system call or exception by restoring all
+ * registers from the stack.
+ */
+	.macro RESTORE_ALL
+	REG_L a0, PT_SSTATUS(sp)
+	REG_L a2, PT_SEPC(sp)
+	csrw sstatus, a0
+	csrw sepc, a2
+
+	REG_L x1,  PT_RA(sp)
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
+
+	REG_L x2,  PT_SP(sp)
+	.endm
+
+ENTRY(handle_exception)
+	SAVE_ALL
+
+	/* Set sscratch register to 0, so that if a recursive exception
+	   occurs, the exception vector knows it came from the kernel */
+	csrw sscratch, x0
+
+	la gp, __global_pointer$
+
+	la ra, ret_from_exception
+	/* MSB of cause differentiates between
+	   interrupts and exceptions */
+	bge s4, zero, 1f
+
+	/* Handle interrupts */
+	slli a0, s4, 1
+	srli a0, a0, 1
+	move a1, sp /* pt_regs */
+	tail do_IRQ
+1:
+	/* Handle syscalls */
+	li t0, EXC_SYSCALL
+	beq s4, t0, handle_syscall
+
+	/* Handle other exceptions */
+	slli t0, s4, RISCV_LGPTR
+	la t1, excp_vect_table
+	la t2, excp_vect_table_end
+	move a0, sp /* pt_regs */
+	add t0, t1, t0
+	/* Check if exception code lies within bounds */
+	bgeu t0, t2, 1f
+	REG_L t0, 0(t0)
+	jr t0
+1:
+	tail do_trap_unknown
+
+handle_syscall:
+	/* Advance SEPC to avoid executing the original
+	   scall instruction on sret */
+	addi s2, s2, 0x4
+	REG_S s2, PT_SEPC(sp)
+	/* System calls run with interrupts enabled */
+	csrs sstatus, SR_IE
+	/* Trace syscalls, but only if requested by the user. */
+	REG_L t0, TASK_TI_FLAGS(tp)
+	andi t0, t0, _TIF_SYSCALL_TRACE
+	bnez t0, handle_syscall_trace_enter
+check_syscall_nr:
+	/* Check to make sure we don't jump to a bogus syscall number. */
+	li t0, __NR_syscalls
+	la s0, sys_ni_syscall
+	/* Syscall number held in a7 */
+	bgeu a7, t0, 1f
+	la s0, sys_call_table
+	slli t0, a7, RISCV_LGPTR
+	add s0, s0, t0
+	REG_L s0, 0(s0)
+1:
+	jalr s0
+
+ret_from_syscall:
+	/* Set user a0 to kernel a0 */
+	REG_S a0, PT_A0(sp)
+	/* Trace syscalls, but only if requested by the user. */
+	REG_L t0, TASK_TI_FLAGS(tp)
+	andi t0, t0, _TIF_SYSCALL_TRACE
+	bnez t0, handle_syscall_trace_exit
+
+ret_from_exception:
+	REG_L s0, PT_SSTATUS(sp)
+	csrc sstatus, SR_IE
+	andi s0, s0, SR_PS
+	bnez s0, restore_all
+
+resume_userspace:
+	/* Interrupts must be disabled here so flags are checked atomically */
+	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
+	andi s1, s0, _TIF_WORK_MASK
+	bnez s1, work_pending
+
+	/* Save unwound kernel stack pointer in thread_info */
+	addi s0, sp, PT_SIZE_ON_STACK
+	REG_S s0, TASK_TI_KERNEL_SP(tp)
+
+	/* Save TP into sscratch, so we can find the kernel data structures
+	 * again. */
+	csrw sscratch, tp
+
+restore_all:
+	RESTORE_ALL
+	sret
+
+work_pending:
+	/* Enter slow path for supplementary processing */
+	la ra, ret_from_exception
+	andi s1, s0, _TIF_NEED_RESCHED
+	bnez s1, work_resched
+work_notifysig:
+	/* Handle pending signals and notify-resume requests */
+	csrs sstatus, SR_IE /* Enable interrupts for do_notify_resume() */
+	move a0, sp /* pt_regs */
+	move a1, s0 /* current_thread_info->flags */
+	tail do_notify_resume
+work_resched:
+	tail schedule
+
+/* Slow paths for ptrace. */
+handle_syscall_trace_enter:
+	move a0, sp
+	call do_syscall_trace_enter
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+	REG_L a6, PT_A6(sp)
+	REG_L a7, PT_A7(sp)
+	j check_syscall_nr
+handle_syscall_trace_exit:
+	move a0, sp
+	call do_syscall_trace_exit
+	j ret_from_exception
+
+END(handle_exception)
+
+ENTRY(ret_from_fork)
+	la ra, ret_from_exception
+	tail schedule_tail
+ENDPROC(ret_from_fork)
+
+ENTRY(ret_from_kernel_thread)
+	call schedule_tail
+	/* Call fn(arg) */
+	la ra, ret_from_exception
+	move a0, s1
+	jr s0
+ENDPROC(ret_from_kernel_thread)
+
+
+/*
+ * Integer register context switch
+ * The callee-saved registers must be saved and restored.
+ *
+ *   a0: previous task_struct (must be preserved across the switch)
+ *   a1: next task_struct
+ */
+ENTRY(__switch_to)
+	/* Save context into prev->thread */
+	li    a2,  TASK_THREAD_RA
+	add   a0, a0, a2
+	add   a2, a1, a2
+	REG_S ra,  TASK_THREAD_RA_RA(a0)
+	REG_S sp,  TASK_THREAD_SP_RA(a0)
+	REG_S s0,  TASK_THREAD_S0_RA(a0)
+	REG_S s1,  TASK_THREAD_S1_RA(a0)
+	REG_S s2,  TASK_THREAD_S2_RA(a0)
+	REG_S s3,  TASK_THREAD_S3_RA(a0)
+	REG_S s4,  TASK_THREAD_S4_RA(a0)
+	REG_S s5,  TASK_THREAD_S5_RA(a0)
+	REG_S s6,  TASK_THREAD_S6_RA(a0)
+	REG_S s7,  TASK_THREAD_S7_RA(a0)
+	REG_S s8,  TASK_THREAD_S8_RA(a0)
+	REG_S s9,  TASK_THREAD_S9_RA(a0)
+	REG_S s10, TASK_THREAD_S10_RA(a0)
+	REG_S s11, TASK_THREAD_S11_RA(a0)
+	/* Restore context from next->thread */
+	REG_L ra,  TASK_THREAD_RA_RA(a2)
+	REG_L sp,  TASK_THREAD_SP_RA(a2)
+	REG_L s0,  TASK_THREAD_S0_RA(a2)
+	REG_L s1,  TASK_THREAD_S1_RA(a2)
+	REG_L s2,  TASK_THREAD_S2_RA(a2)
+	REG_L s3,  TASK_THREAD_S3_RA(a2)
+	REG_L s4,  TASK_THREAD_S4_RA(a2)
+	REG_L s5,  TASK_THREAD_S5_RA(a2)
+	REG_L s6,  TASK_THREAD_S6_RA(a2)
+	REG_L s7,  TASK_THREAD_S7_RA(a2)
+	REG_L s8,  TASK_THREAD_S8_RA(a2)
+	REG_L s9,  TASK_THREAD_S9_RA(a2)
+	REG_L s10, TASK_THREAD_S10_RA(a2)
+	REG_L s11, TASK_THREAD_S11_RA(a2)
+#if TASK_TI != 0
+#error "TASK_TI != 0: tp will contain a 'struct thread_info', not a 'struct task_struct' so get_current() won't work."
+	addi tp, a1, TASK_TI
+#else
+	move tp, a1
+#endif
+	ret
+ENDPROC(__switch_to)
+
+ENTRY(__fstate_save)
+	li  a2,  TASK_THREAD_F0
+	add a0, a0, a2
+	li t1, SR_FS
+	csrs sstatus, t1
+	frcsr t0
+	fsd f0,  TASK_THREAD_F0_F0(a0)
+	fsd f1,  TASK_THREAD_F1_F0(a0)
+	fsd f2,  TASK_THREAD_F2_F0(a0)
+	fsd f3,  TASK_THREAD_F3_F0(a0)
+	fsd f4,  TASK_THREAD_F4_F0(a0)
+	fsd f5,  TASK_THREAD_F5_F0(a0)
+	fsd f6,  TASK_THREAD_F6_F0(a0)
+	fsd f7,  TASK_THREAD_F7_F0(a0)
+	fsd f8,  TASK_THREAD_F8_F0(a0)
+	fsd f9,  TASK_THREAD_F9_F0(a0)
+	fsd f10, TASK_THREAD_F10_F0(a0)
+	fsd f11, TASK_THREAD_F11_F0(a0)
+	fsd f12, TASK_THREAD_F12_F0(a0)
+	fsd f13, TASK_THREAD_F13_F0(a0)
+	fsd f14, TASK_THREAD_F14_F0(a0)
+	fsd f15, TASK_THREAD_F15_F0(a0)
+	fsd f16, TASK_THREAD_F16_F0(a0)
+	fsd f17, TASK_THREAD_F17_F0(a0)
+	fsd f18, TASK_THREAD_F18_F0(a0)
+	fsd f19, TASK_THREAD_F19_F0(a0)
+	fsd f20, TASK_THREAD_F20_F0(a0)
+	fsd f21, TASK_THREAD_F21_F0(a0)
+	fsd f22, TASK_THREAD_F22_F0(a0)
+	fsd f23, TASK_THREAD_F23_F0(a0)
+	fsd f24, TASK_THREAD_F24_F0(a0)
+	fsd f25, TASK_THREAD_F25_F0(a0)
+	fsd f26, TASK_THREAD_F26_F0(a0)
+	fsd f27, TASK_THREAD_F27_F0(a0)
+	fsd f28, TASK_THREAD_F28_F0(a0)
+	fsd f29, TASK_THREAD_F29_F0(a0)
+	fsd f30, TASK_THREAD_F30_F0(a0)
+	fsd f31, TASK_THREAD_F31_F0(a0)
+	sw t0, TASK_THREAD_FCSR_F0(a0)
+	csrc sstatus, t1
+	ret
+ENDPROC(__fstate_save)
+
+ENTRY(__fstate_restore)
+	li  a2,  TASK_THREAD_F0
+	add a0, a0, a2
+	li t1, SR_FS
+	lw t0, TASK_THREAD_FCSR_F0(a0)
+	csrs sstatus, t1
+	fld f0,  TASK_THREAD_F0_F0(a0)
+	fld f1,  TASK_THREAD_F1_F0(a0)
+	fld f2,  TASK_THREAD_F2_F0(a0)
+	fld f3,  TASK_THREAD_F3_F0(a0)
+	fld f4,  TASK_THREAD_F4_F0(a0)
+	fld f5,  TASK_THREAD_F5_F0(a0)
+	fld f6,  TASK_THREAD_F6_F0(a0)
+	fld f7,  TASK_THREAD_F7_F0(a0)
+	fld f8,  TASK_THREAD_F8_F0(a0)
+	fld f9,  TASK_THREAD_F9_F0(a0)
+	fld f10, TASK_THREAD_F10_F0(a0)
+	fld f11, TASK_THREAD_F11_F0(a0)
+	fld f12, TASK_THREAD_F12_F0(a0)
+	fld f13, TASK_THREAD_F13_F0(a0)
+	fld f14, TASK_THREAD_F14_F0(a0)
+	fld f15, TASK_THREAD_F15_F0(a0)
+	fld f16, TASK_THREAD_F16_F0(a0)
+	fld f17, TASK_THREAD_F17_F0(a0)
+	fld f18, TASK_THREAD_F18_F0(a0)
+	fld f19, TASK_THREAD_F19_F0(a0)
+	fld f20, TASK_THREAD_F20_F0(a0)
+	fld f21, TASK_THREAD_F21_F0(a0)
+	fld f22, TASK_THREAD_F22_F0(a0)
+	fld f23, TASK_THREAD_F23_F0(a0)
+	fld f24, TASK_THREAD_F24_F0(a0)
+	fld f25, TASK_THREAD_F25_F0(a0)
+	fld f26, TASK_THREAD_F26_F0(a0)
+	fld f27, TASK_THREAD_F27_F0(a0)
+	fld f28, TASK_THREAD_F28_F0(a0)
+	fld f29, TASK_THREAD_F29_F0(a0)
+	fld f30, TASK_THREAD_F30_F0(a0)
+	fld f31, TASK_THREAD_F31_F0(a0)
+	fscsr t0
+	csrc sstatus, t1
+	ret
+ENDPROC(__fstate_restore)
+
+
+	.section ".rodata"
+	/* Exception vector table */
+ENTRY(excp_vect_table)
+	RISCV_PTR do_trap_insn_misaligned
+	RISCV_PTR do_trap_insn_fault
+	RISCV_PTR do_trap_insn_illegal
+	RISCV_PTR do_trap_break
+	RISCV_PTR do_trap_load_misaligned
+	RISCV_PTR do_trap_load_fault
+	RISCV_PTR do_trap_store_misaligned
+	RISCV_PTR do_trap_store_fault
+	RISCV_PTR do_trap_ecall_u /* system call, gets intercepted */
+	RISCV_PTR do_trap_ecall_s
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_trap_ecall_m
+	RISCV_PTR do_page_fault   /* instruction page fault */
+	RISCV_PTR do_page_fault   /* load page fault */
+	RISCV_PTR do_trap_unknown
+	RISCV_PTR do_page_fault   /* store page fault */
+excp_vect_table_end:
+END(excp_vect_table)
+
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
new file mode 100644
index 000000000000..608e57d4531f
--- /dev/null
+++ b/arch/riscv/kernel/head.S
@@ -0,0 +1,147 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+#include <asm/asm.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/csr.h>
+
+__INIT
+ENTRY(_start)
+	/* Mask all interrupts */
+	csrw sie, zero
+
+	/* Disable FPU to detect illegal usage of
+	   floating point in kernel space */
+	li t0, SR_FS
+	csrc sstatus, t0
+
+#ifndef CONFIG_RV_PUM
+	/* Allow access to user memory */
+	li t0, SR_SUM
+	csrs sstatus, t0
+#endif
+
+#ifdef CONFIG_ISA_A
+	/* Pick one hart to run the main boot sequence */
+	la a3, hart_lottery
+	li a2, 1
+	amoadd.w a3, a2, (a3)
+	bnez a3, .Lsecondary_start
+#else
+	/* We don't have atomic support, so the boot hart must be picked
+	 * staticly.  Hart 0 is the only sane choice.
+	 */
+	bnez a0, .Lsecondary_park
+#endif
+
+	/* Save hart ID and DTB physical address */
+	mv s0, a0
+	mv s1, a1
+
+	/* Initialize page tables and relocate to virtual addresses */
+	la sp, init_thread_union + THREAD_SIZE
+	call setup_vm
+	call relocate
+
+	/* Restore C environment */
+	la tp, init_task
+
+	la sp, init_thread_union
+	li a0, ASM_THREAD_SIZE
+	add sp, sp, a0
+
+	/* Start the kernel */
+	mv a0, s0
+	mv a1, s1
+	call sbi_save
+	tail start_kernel
+
+relocate:
+	/* Relocate return address */
+	li a1, PAGE_OFFSET
+	la a0, _start
+	sub a1, a1, a0
+	add ra, ra, a1
+
+	/* Point stvec to virtual address of intruction after sptbr write */
+	la a0, 1f
+	add a0, a0, a1
+	csrw stvec, a0
+
+	/* Compute sptbr for kernel page tables, but don't load it yet */
+	la a2, swapper_pg_dir
+	srl a2, a2, PAGE_SHIFT
+	li a1, SPTBR_MODE
+	or a2, a2, a1
+
+	/* Load trampoline page directory, which will cause us to trap to
+	   stvec if VA != PA, or simply fall through if VA == PA */
+	la a0, trampoline_pg_dir
+	srl a0, a0, PAGE_SHIFT
+	or a0, a0, a1
+	sfence.vma
+	csrw sptbr, a0
+1:
+	/* Set trap vector to spin forever to help debug */
+	la a0, .Lsecondary_park
+	csrw stvec, a0
+
+	/* Load the global pointer */
+	la gp, __global_pointer$
+
+	/* Switch to kernel page tables */
+	csrw sptbr, a2
+
+	ret
+
+.Lsecondary_start:
+#ifdef CONFIG_SMP
+	li a1, CONFIG_NR_CPUS
+	bgeu a0, a1, .Lsecondary_park
+
+	la a1, __cpu_up_stack_pointer
+	slli a0, a0, LGREG
+	add a0, a0, a1
+
+.Lwait_for_cpu_up:
+	REG_L sp, (a0)
+	beqz sp, .Lwait_for_cpu_up
+	fence
+
+	/* Enable virtual memory and relocate to virtual address */
+	call relocate
+
+	/* Initialize task_struct pointer */
+	li tp, -THREAD_SIZE
+	add tp, tp, sp
+
+	tail smp_callin
+#endif
+
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+END(_start)
+
+__PAGE_ALIGNED_BSS
+	/* Empty zero page */
+	.balign PAGE_SIZE
+ENTRY(empty_zero_page)
+	.fill (empty_zero_page + PAGE_SIZE) - ., 1, 0x00
+END(empty_zero_page)
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
new file mode 100644
index 000000000000..737d7cce2c6d
--- /dev/null
+++ b/arch/riscv/kernel/irq.c
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/irqchip.h>
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
new file mode 100644
index 000000000000..753cb9894feb
--- /dev/null
+++ b/arch/riscv/kernel/module.c
@@ -0,0 +1,215 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  Copyright (C) 2017 Zihao Yu
+ */
+
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/moduleloader.h>
+
+static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u64 *)location = v;
+	return 0;
+}
+
+static int apply_r_riscv_branch_rela(struct module *me, u32 *location,
+				     Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	u32 imm12 = (offset & 0x1000) << (31 - 12);
+	u32 imm11 = (offset & 0x800) >> (11 - 7);
+	u32 imm10_5 = (offset & 0x7e0) << (30 - 10);
+	u32 imm4_1 = (offset & 0x1e) << (11 - 4);
+
+	*location = (*location & 0x1fff07f) | imm12 | imm11 | imm10_5 | imm4_1;
+	return 0;
+}
+
+static int apply_r_riscv_jal_rela(struct module *me, u32 *location,
+				  Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	u32 imm20 = (offset & 0x100000) << (31 - 20);
+	u32 imm19_12 = (offset & 0xff000);
+	u32 imm11 = (offset & 0x800) << (20 - 11);
+	u32 imm10_1 = (offset & 0x7fe) << (30 - 10);
+
+	*location = (*location & 0xfff) | imm20 | imm19_12 | imm11 | imm10_1;
+	return 0;
+}
+
+static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
+					 Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	s32 hi20;
+
+	if (offset != (s32)offset) {
+		pr_err(
+		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  me->name, v, location);
+		return -EINVAL;
+	}
+
+	hi20 = (offset + 0x800) & 0xfffff000;
+	*location = (*location & 0xfff) | hi20;
+	return 0;
+}
+
+static int apply_r_riscv_pcrel_lo12_i_rela(struct module *me, u32 *location,
+					   Elf_Addr v)
+{
+	/* v is the lo12 value to fill. It is calculated before calling this
+	 * handler.
+	 */
+	*location = (*location & 0xfffff) | ((v & 0xfff) << 20);
+	return 0;
+}
+
+static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, u32 *location,
+					   Elf_Addr v)
+{
+	/* v is the lo12 value to fill. It is calculated before calling this
+	 * handler.
+	 */
+	u32 imm11_5 = (v & 0xfe0) << (31 - 11);
+	u32 imm4_0 = (v & 0x1f) << (11 - 4);
+
+	*location = (*location & 0x1fff07f) | imm11_5 | imm4_0;
+	return 0;
+}
+
+static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	s32 fill_v = offset;
+	u32 hi20, lo12;
+
+	if (offset != fill_v) {
+		pr_err(
+		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  me->name, v, location);
+		return -EINVAL;
+	}
+
+	hi20 = (offset + 0x800) & 0xfffff000;
+	lo12 = (offset - hi20) & 0xfff;
+	*location = (*location & 0xfff) | hi20;
+	*(location + 1) = (*(location + 1) & 0xfffff) | (lo12 << 20);
+	return 0;
+}
+
+static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	return 0;
+}
+
+static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
+				Elf_Addr v) = {
+	[R_RISCV_64]			= apply_r_riscv_64_rela,
+	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
+	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
+	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
+	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
+	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
+	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
+	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
+};
+
+int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
+		       unsigned int symindex, unsigned int relsec,
+		       struct module *me)
+{
+	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
+	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
+	Elf_Sym *sym;
+	u32 *location;
+	unsigned int i, type;
+	Elf_Addr v;
+	int res;
+
+	pr_debug("Applying relocate section %u to %u\n", relsec,
+	       sechdrs[relsec].sh_info);
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+		/* This is where to make the change */
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		/* This is the symbol it is referring to */
+		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
+			+ ELF_RISCV_R_SYM(rel[i].r_info);
+		if (IS_ERR_VALUE(sym->st_value)) {
+			/* Ignore unresolved weak symbol */
+			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
+				continue;
+			printk(KERN_WARNING "%s: Unknown symbol %s\n",
+			       me->name, strtab + sym->st_name);
+			return -ENOENT;
+		}
+
+		type = ELF_RISCV_R_TYPE(rel[i].r_info);
+
+		if (type < ARRAY_SIZE(reloc_handlers_rela))
+			handler = reloc_handlers_rela[type];
+		else
+			handler = NULL;
+
+		if (!handler) {
+			pr_err("%s: Unknown relocation type %u\n",
+			       me->name, type);
+			return -EINVAL;
+		}
+
+		v = sym->st_value + rel[i].r_addend;
+
+		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
+			unsigned int j;
+
+			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
+				u64 hi20_loc =
+					sechdrs[sechdrs[relsec].sh_info].sh_addr
+					+ rel[j].r_offset;
+				/* Find the corresponding HI20 PC-relative relocation entry */
+				if (hi20_loc == sym->st_value) {
+					Elf_Sym *hi20_sym =
+						(Elf_Sym *)sechdrs[symindex].sh_addr
+						+ ELF_RISCV_R_SYM(rel[j].r_info);
+					u64 hi20_sym_val =
+						hi20_sym->st_value
+						+ rel[j].r_addend;
+					/* Calculate lo12 */
+					s64 offset = hi20_sym_val - hi20_loc;
+					s32 hi20 = (offset + 0x800) & 0xfffff000;
+					s32 lo12 = offset - hi20;
+					v = lo12;
+					break;
+				}
+			}
+			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
+				pr_err(
+				  "%s: Can not find HI20 PC-relative relocation information\n",
+				  me->name);
+				return -EINVAL;
+			}
+		}
+
+		res = handler(me, location, v);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
new file mode 100644
index 000000000000..c10146ae317d
--- /dev/null
+++ b/arch/riscv/kernel/process.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/tick.h>
+#include <linux/ptrace.h>
+
+#include <asm/unistd.h>
+#include <asm/uaccess.h>
+#include <asm/processor.h>
+#include <asm/csr.h>
+#include <asm/string.h>
+#include <asm/switch_to.h>
+
+extern asmlinkage void ret_from_fork(void);
+extern asmlinkage void ret_from_kernel_thread(void);
+
+void arch_cpu_idle(void)
+{
+	wait_for_interrupt();
+	local_irq_enable();
+}
+
+void show_regs(struct pt_regs *regs)
+{
+	show_regs_print_info(KERN_DEFAULT);
+
+	printk(KERN_CONT "sepc: " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
+		regs->sepc, regs->ra, regs->sp);
+	printk(KERN_CONT " gp : " REG_FMT " tp : " REG_FMT " t0 : " REG_FMT "\n",
+		regs->gp, regs->tp, regs->t0);
+	printk(KERN_CONT " t1 : " REG_FMT " t2 : " REG_FMT " s0 : " REG_FMT "\n",
+		regs->t1, regs->t2, regs->s0);
+	printk(KERN_CONT " s1 : " REG_FMT " a0 : " REG_FMT " a1 : " REG_FMT "\n",
+		regs->s1, regs->a0, regs->a1);
+	printk(KERN_CONT " a2 : " REG_FMT " a3 : " REG_FMT " a4 : " REG_FMT "\n",
+		regs->a2, regs->a3, regs->a4);
+	printk(KERN_CONT " a5 : " REG_FMT " a6 : " REG_FMT " a7 : " REG_FMT "\n",
+		regs->a5, regs->a6, regs->a7);
+	printk(KERN_CONT " s2 : " REG_FMT " s3 : " REG_FMT " s4 : " REG_FMT "\n",
+		regs->s2, regs->s3, regs->s4);
+	printk(KERN_CONT " s5 : " REG_FMT " s6 : " REG_FMT " s7 : " REG_FMT "\n",
+		regs->s5, regs->s6, regs->s7);
+	printk(KERN_CONT " s8 : " REG_FMT " s9 : " REG_FMT " s10: " REG_FMT "\n",
+		regs->s8, regs->s9, regs->s10);
+	printk(KERN_CONT " s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
+		regs->s11, regs->t3, regs->t4);
+	printk(KERN_CONT " t5 : " REG_FMT " t6 : " REG_FMT "\n",
+		regs->t5, regs->t6);
+
+	printk(KERN_CONT "sstatus: " REG_FMT " sbadaddr: " REG_FMT " scause: " REG_FMT "\n",
+		regs->sstatus, regs->sbadaddr, regs->scause);
+}
+
+void start_thread(struct pt_regs *regs, unsigned long pc,
+	unsigned long sp)
+{
+	regs->sstatus = SR_PIE /* User mode, irqs on */ | SR_FS_INITIAL;
+#ifndef CONFIG_RV_PUM
+	regs->sstatus |= SR_SUM
+#endif
+	regs->sepc = pc;
+	regs->sp = sp;
+	set_fs(USER_DS);
+}
+
+void flush_thread(void)
+{
+	/* Reset FPU context
+	 *	frm: round to nearest, ties to even (IEEE default)
+	 *	fflags: accrued exceptions cleared
+	 */
+	memset(&current->thread.fstate, 0,
+		sizeof(struct user_fpregs_struct));
+}
+
+int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
+{
+	fstate_save(src, task_pt_regs(src));
+	*dst = *src;
+	return 0;
+}
+
+int copy_thread(unsigned long clone_flags, unsigned long usp,
+	unsigned long arg, struct task_struct *p)
+{
+	struct pt_regs *childregs = task_pt_regs(p);
+
+	/* p->thread holds context to be restored by __switch_to() */
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		/* Kernel thread */
+		const register unsigned long gp __asm__ ("gp");
+		memset(childregs, 0, sizeof(struct pt_regs));
+		childregs->gp = gp;
+		childregs->sstatus = SR_PS | SR_PIE; /* Supervisor, irqs on */
+
+		p->thread.ra = (unsigned long)ret_from_kernel_thread;
+		p->thread.s[0] = usp; /* fn */
+		p->thread.s[1] = arg;
+	} else {
+		*childregs = *(current_pt_regs());
+		if (usp) /* User fork */
+			childregs->sp = usp;
+		if (clone_flags & CLONE_SETTLS)
+			childregs->tp = childregs->a5;
+		childregs->a0 = 0; /* Return value of fork() */
+		p->thread.ra = (unsigned long)ret_from_fork;
+	}
+	p->thread.sp = (unsigned long)childregs; /* kernel sp */
+	return 0;
+}
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
new file mode 100644
index 000000000000..69b3b2d10664
--- /dev/null
+++ b/arch/riscv/kernel/ptrace.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright 2010 Tilera Corporation. All Rights Reserved.
+ * Copyright 2015 Regents of the University of California
+ * Copyright 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ * Copied from arch/tile/kernel/ptrace.c
+ */
+
+#include <asm/ptrace.h>
+#include <asm/syscall.h>
+#include <asm/thread_info.h>
+#include <linux/ptrace.h>
+#include <linux/elf.h>
+#include <linux/regset.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/tracehook.h>
+#include <trace/events/syscalls.h>
+
+enum riscv_regset {
+	REGSET_X,
+};
+
+/*
+ * Get registers from task and ready the result for userspace.
+ */
+static char *getregs(struct task_struct *child, struct pt_regs *uregs)
+{
+	*uregs = *task_pt_regs(child);
+	return (char *)uregs;
+}
+
+/* Put registers back to task. */
+static void putregs(struct task_struct *child, struct pt_regs *uregs)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	*regs = *uregs;
+}
+
+static int riscv_gpr_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	struct pt_regs regs;
+
+	getregs(target, &regs);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &regs, 0,
+				   sizeof(regs));
+}
+
+static int riscv_gpr_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	struct pt_regs regs;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0,
+				 sizeof(regs));
+	if (ret)
+		return ret;
+
+	putregs(target, &regs);
+
+	return 0;
+}
+
+
+static const struct user_regset riscv_user_regset[] = {
+	[REGSET_X] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(elf_greg_t),
+		.align = sizeof(elf_greg_t),
+		.get = &riscv_gpr_get,
+		.set = &riscv_gpr_set,
+	},
+};
+
+static const struct user_regset_view riscv_user_native_view = {
+	.name = "riscv",
+	.e_machine = EM_RISCV,
+	.regsets = riscv_user_regset,
+	.n = ARRAY_SIZE(riscv_user_regset),
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &riscv_user_native_view;
+}
+
+void ptrace_disable(struct task_struct *child)
+{
+	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+}
+
+long arch_ptrace(struct task_struct *child, long request,
+		 unsigned long addr, unsigned long data)
+{
+	long ret = -EIO;
+
+	switch (request) {
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+
+	return ret;
+}
+
+/* Allows PTRACE_SYSCALL to work.  These are called from entry.S in
+ * {handle,ret_from}_syscall.
+ */
+void do_syscall_trace_enter(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		if (tracehook_report_syscall_entry(regs))
+			syscall_set_nr(current, regs, -1);
+
+#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall_get_nr(current, regs));
+#endif
+}
+
+void do_syscall_trace_exit(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, 0);
+
+#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, regs->regs[0]);
+#endif
+}
diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
new file mode 100644
index 000000000000..2a53d26ffdd6
--- /dev/null
+++ b/arch/riscv/kernel/reset.c
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/reboot.h>
+#include <linux/export.h>
+#include <asm/sbi.h>
+
+void (*pm_power_off)(void) = machine_power_off;
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_restart(char *cmd)
+{
+	do_kernel_restart(cmd);
+	while (1);
+}
+
+void machine_halt(void)
+{
+	machine_power_off();
+}
+
+void machine_power_off(void)
+{
+	sbi_shutdown();
+	while (1);
+}
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
new file mode 100644
index 000000000000..ab0db6d48101
--- /dev/null
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2017 Zihao Yu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/export.h>
+#include <linux/uaccess.h>
+
+/*
+ * Assembly functions that may be used (directly or indirectly) by modules
+ */
+EXPORT_SYMBOL(__copy_user);
+
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
new file mode 100644
index 000000000000..9ed70e84d74e
--- /dev/null
+++ b/arch/riscv/kernel/setup.c
@@ -0,0 +1,240 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+#include <linux/sched.h>
+#include <linux/initrd.h>
+#include <linux/console.h>
+#include <linux/screen_info.h>
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+#include <linux/sched/task.h>
+
+#include <asm/setup.h>
+#include <asm/sections.h>
+#include <asm/pgtable.h>
+#include <asm/smp.h>
+#include <asm/sbi.h>
+#include <asm/tlbflush.h>
+#include <asm/thread_info.h>
+
+#ifdef CONFIG_DUMMY_CONSOLE
+struct screen_info screen_info = {
+	.orig_video_lines	= 30,
+	.orig_video_cols	= 80,
+	.orig_video_mode	= 0,
+	.orig_video_ega_bx	= 0,
+	.orig_video_isVGA	= 1,
+	.orig_video_points	= 8
+};
+#endif
+
+#ifdef CONFIG_CMDLINE_BOOL
+static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+#endif /* CONFIG_CMDLINE_BOOL */
+
+unsigned long va_pa_offset;
+unsigned long pfn_base;
+
+/* The lucky hart to first increment this variable will boot the other cores */
+atomic_t hart_lottery;
+
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	extern char __initramfs_start[];
+	extern unsigned long __initramfs_size;
+	unsigned long size;
+
+	if (__initramfs_size > 0) {
+		initrd_start = (unsigned long)(&__initramfs_start);
+		initrd_end = initrd_start + __initramfs_size;
+	}
+
+	if (initrd_start >= initrd_end) {
+		printk(KERN_INFO "initrd not found or empty");
+		goto disable;
+	}
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		printk(KERN_ERR "initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	size =  initrd_end - initrd_start;
+	memblock_reserve(__pa(initrd_start), size);
+	initrd_below_start_ok = 1;
+
+	printk(KERN_INFO "Initial ramdisk at: 0x%p (%lu bytes)\n",
+		(void *)(initrd_start), size);
+	return;
+disable:
+	printk(KERN_CONT " - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
+pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
+pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
+pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+#endif
+
+asmlinkage void __init setup_vm(void)
+{
+	extern char _start;
+	uintptr_t i;
+	uintptr_t pa = (uintptr_t) &_start;
+	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
+
+	va_pa_offset = PAGE_OFFSET - pa;
+	pfn_base = PFN_DOWN(pa);
+
+	/* Sanity check alignment and size */
+	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
+	BUG_ON((pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN((uintptr_t)trampoline_pmd),
+			__pgprot(_PAGE_TABLE));
+	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(pa), prot);
+
+	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =
+			pfn_pgd(PFN_DOWN((uintptr_t)swapper_pmd) + i,
+				__pgprot(_PAGE_TABLE));
+	}
+	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
+		swapper_pmd[i] = pfn_pmd(PFN_DOWN(pa + i * PMD_SIZE), prot);
+#else
+	trampoline_pg_dir[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
+		pfn_pgd(PFN_DOWN(pa), prot);
+
+	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
+		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
+		swapper_pg_dir[o] =
+			pfn_pgd(PFN_DOWN(pa + i * PGDIR_SIZE), prot);
+	}
+#endif
+}
+
+void __init sbi_save(unsigned int hartid, void *dtb)
+{
+	early_init_dt_scan(__va(dtb));
+}
+
+/* Allow the user to manually add a memory region (in case DTS is broken); "mem_end=nn[KkMmGg]" */
+static int __init mem_end_override(char *p)
+{
+	resource_size_t base, end;
+
+	if (!p)
+		return -EINVAL;
+	base = (uintptr_t) __pa(PAGE_OFFSET);
+	end = memparse(p, &p) & PMD_MASK;
+	if (end == 0)
+		return -EINVAL;
+	memblock_add(base, end - base);
+	return 0;
+}
+early_param("mem_end", mem_end_override);
+
+static void __init setup_bootmem(void)
+{
+	struct memblock_region *reg;
+	phys_addr_t mem_size = 0;
+
+	/* Find the memory region containing the kernel */
+	for_each_memblock(memory, reg) {
+		phys_addr_t vmlinux_end = __pa(_end);
+		phys_addr_t end = reg->base + reg->size;
+
+		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
+			/* Reserve from the start of the region to the end of
+			 * the kernel
+			 */
+			memblock_reserve(reg->base, vmlinux_end - reg->base);
+			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
+		}
+	}
+	BUG_ON(mem_size == 0);
+
+	set_max_mapnr(PFN_DOWN(mem_size));
+	max_low_pfn = pfn_base + PFN_DOWN(mem_size);
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+	memblock_allow_resize();
+	memblock_dump_all();
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+#ifdef CONFIG_CMDLINE_BOOL
+#ifdef CONFIG_CMDLINE_OVERRIDE
+	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+#else
+	if (builtin_cmdline[0] != '\0') {
+		/* Append bootloader command line to built-in */
+		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
+	}
+#endif /* CONFIG_CMDLINE_OVERRIDE */
+#endif /* CONFIG_CMDLINE_BOOL */
+	*cmdline_p = boot_command_line;
+
+	parse_early_param();
+
+	init_mm.start_code = (unsigned long) _stext;
+	init_mm.end_code   = (unsigned long) _etext;
+	init_mm.end_data   = (unsigned long) _edata;
+	init_mm.brk        = (unsigned long) _end;
+
+	setup_bootmem();
+	paging_init();
+	unflatten_device_tree();
+
+#ifdef CONFIG_SMP
+	setup_smp();
+#endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+}
+
+static int __init riscv_device_init(void)
+{
+	return of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+subsys_initcall_sync(riscv_device_init);
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
new file mode 100644
index 000000000000..ea14c47f28ac
--- /dev/null
+++ b/arch/riscv/kernel/signal.c
@@ -0,0 +1,257 @@
+/*
+ * Copyright (C) 2009 Sunplus Core Technology Co., Ltd.
+ *  Chen Liqin <liqin.chen@sunplusct.com>
+ *  Lennox Wu <lennox.wu@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ */
+
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/tracehook.h>
+#include <linux/linkage.h>
+
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+#include <asm/switch_to.h>
+#include <asm/csr.h>
+
+#define DEBUG_SIG 0
+
+struct rt_sigframe {
+	struct siginfo info;
+	struct ucontext uc;
+};
+
+static long restore_sigcontext(struct pt_regs *regs,
+	struct sigcontext __user *sc)
+{
+	struct task_struct *task = current;
+	long err;
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+	err |= __copy_from_user(&task->thread.fstate, &sc->sc_fpregs,
+		sizeof(sc->sc_fpregs));
+	if (likely(!err))
+		fstate_restore(task, regs);
+	return err;
+}
+
+SYSCALL_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->a0;
+
+badframe:
+	task = current;
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			frame, (void *)regs->sepc, (void *)regs->sp);
+	}
+	force_sig(SIGSEGV, task);
+	return 0;
+}
+
+static long setup_sigcontext(struct sigcontext __user *sc,
+	struct pt_regs *regs)
+{
+	struct task_struct *task = current;
+	long err;
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+	fstate_save(task, regs);
+	err |= __copy_to_user(&sc->sc_fpregs, &task->thread.fstate,
+		sizeof(sc->sc_fpregs));
+	return err;
+}
+
+static inline void __user *get_sigframe(struct ksignal *ksig,
+	struct pt_regs *regs, size_t framesize)
+{
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame. */
+	sp &= ~0xfUL;
+
+	return (void __user *)sp;
+}
+
+
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+	struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+	long err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		return -EFAULT;
+
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+
+	/* Create the ucontext. */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
+	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
+
+	/* Set up to return from userspace. */
+	regs->ra = (unsigned long)VDSO_SYMBOL(
+		current->mm->context.vdso, rt_sigreturn);
+
+	/*
+	 * Set up registers for signal handler.
+	 * Registers that we don't modify keep the value they had from
+	 * user-space at the time we took the signal.
+	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
+	 * since some things rely on this (e.g. glibc's debug/segfault.c).
+	 */
+	regs->sepc = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->sp = (unsigned long)frame;
+	regs->a0 = ksig->sig;                     /* a0: signal number */
+	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
+	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
+
+#if DEBUG_SIG
+	pr_info("SIG deliver (%s:%d): sig=%d pc=%p ra=%p sp=%p\n",
+		current->comm, task_pid_nr(current), ksig->sig,
+		(void *)regs->sepc, (void *)regs->ra, frame);
+#endif
+
+	return 0;
+}
+
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+
+	/* Are we from a system call? */
+	if (regs->scause == EXC_SYSCALL) {
+		/* If so, check system call restarting.. */
+		switch (regs->a0) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->a0 = -EINTR;
+			break;
+
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->a0 = -EINTR;
+				break;
+			}
+			/* fallthrough */
+		case -ERESTARTNOINTR:
+			regs->sepc -= 0x4;
+			break;
+		}
+	}
+
+	/* Set up the stack frame */
+	ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, 0);
+}
+
+static void do_signal(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		/* Actually deliver the signal */
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/* Did we come from a system call? */
+	if (regs->scause == EXC_SYSCALL) {
+		/* Restart the system call - no handlers present */
+		switch (regs->a0) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			regs->sepc -= 0x4;
+			break;
+		case -ERESTART_RESTARTBLOCK:
+			regs->a7 = __NR_restart_syscall;
+			regs->sepc -= 0x4;
+			break;
+		}
+	}
+
+	/* If there is no signal to deliver, we just put the saved
+	 * sigmask back.
+	 */
+	restore_saved_sigmask();
+}
+
+/*
+ * notification of userspace execution resumption
+ * - triggered by the _TIF_WORK_MASK flags
+ */
+asmlinkage void do_notify_resume(struct pt_regs *regs,
+	unsigned long thread_info_flags)
+{
+	/* Handle pending signal delivery */
+	if (thread_info_flags & _TIF_SIGPENDING)
+		do_signal(regs);
+
+	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
+		clear_thread_flag(TIF_NOTIFY_RESUME);
+		tracehook_notify_resume(regs);
+	}
+}
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
new file mode 100644
index 000000000000..b65c0e1020e3
--- /dev/null
+++ b/arch/riscv/kernel/smp.c
@@ -0,0 +1,110 @@
+/*
+ * SMP initialisation and IPI support
+ * Based on arch/arm64/kernel/smp.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+
+#include <asm/sbi.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+
+/* A collection of single bit ipi messages.  */
+static struct {
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_MAX
+};
+
+irqreturn_t handle_ipi(void)
+{
+	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+
+	/* Clear pending IPI */
+	csr_clear(sip, SIE_SSIE);
+
+	while (true) {
+		unsigned long ops;
+
+		/* Order bit clearing and data access. */
+		mb(); // test
+
+		ops = xchg(pending_ipis, 0);
+		if (ops == 0)
+			return IRQ_HANDLED;
+
+		if (ops & (1 << IPI_RESCHEDULE))
+			scheduler_ipi();
+
+		if (ops & (1 << IPI_CALL_FUNC))
+			generic_smp_call_function_interrupt();
+
+		BUG_ON((ops >> IPI_MAX) != 0);
+
+		/* Order data access and bit testing. */
+		mb();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void
+send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
+{
+	int i;
+
+	mb();
+	for_each_cpu(i, to_whom)
+		set_bit(operation, &ipi_data[i].bits);
+
+	mb();
+	sbi_send_ipi(cpumask_bits(to_whom));
+}
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+static void ipi_stop(void *unused)
+{
+	while (1)
+		wait_for_interrupt();
+}
+
+void smp_send_stop(void)
+{
+	on_each_cpu(ipi_stop, NULL, 1);
+}
+
+void smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
new file mode 100644
index 000000000000..7043bbbfbc1e
--- /dev/null
+++ b/arch/riscv/kernel/smpboot.c
@@ -0,0 +1,103 @@
+/*
+ * SMP initialisation and IPI support
+ * Based on arch/arm64/kernel/smp.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2015 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/sched/task_stack.h>
+#include <asm/mmu_context.h>
+#include <asm/tlbflush.h>
+#include <asm/sections.h>
+#include <asm/sbi.h>
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+void __init setup_smp(void)
+{
+	struct device_node *dn = NULL;
+	int hart, im_okay_therefore_i_am = 0;
+
+	while ((dn = of_find_node_by_type(dn, "cpu"))) {
+		hart = riscv_of_processor_hart(dn);
+		if (hart >= 0) {
+			set_cpu_possible(hart, true);
+			set_cpu_present(hart, true);
+			if (hart == smp_processor_id()) {
+				BUG_ON(im_okay_therefore_i_am);
+				im_okay_therefore_i_am = 1;
+			}
+		}
+	}
+
+	BUG_ON(!im_okay_therefore_i_am);
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	/* Signal cpu to start */
+	mb();
+	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
+
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+/*
+ * C entry point for a secondary processor.
+ */
+asmlinkage void __init smp_callin(void)
+{
+	struct mm_struct *mm = &init_mm;
+
+	/* All kernel threads share the same mm context.  */
+	atomic_inc(&mm->mm_count);
+	current->active_mm = mm;
+
+	trap_init();
+	init_clockevent();
+	notify_cpu_starting(smp_processor_id());
+	set_cpu_online(smp_processor_id(), 1);
+	local_flush_tlb_all();
+	local_irq_enable();
+	preempt_disable();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
new file mode 100644
index 000000000000..109f5120d5c7
--- /dev/null
+++ b/arch/riscv/kernel/stacktrace.c
@@ -0,0 +1,177 @@
+/*
+ * Copyright (C) 2008 ARM Limited
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/export.h>
+#include <linux/kallsyms.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stacktrace.h>
+
+#ifdef CONFIG_FRAME_POINTER
+
+struct stackframe {
+	unsigned long fp;
+	unsigned long ra;
+};
+
+static void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
+{
+	unsigned long fp, sp, pc;
+
+	if (regs) {
+		fp = GET_FP(regs);
+		sp = GET_USP(regs);
+		pc = GET_IP(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		fp = (unsigned long)__builtin_frame_address(0);
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
+	} else {
+		/* task blocked in __switch_to */
+		fp = task->thread.s[0];
+		sp = task->thread.sp;
+		pc = task->thread.ra;
+	}
+
+	for (;;) {
+		unsigned long low, high;
+		struct stackframe *frame;
+
+		if (unlikely(!__kernel_text_address(pc) || fn(pc, arg)))
+			break;
+
+		/* Validate frame pointer */
+		low = sp + sizeof(struct stackframe);
+		high = ALIGN(sp, THREAD_SIZE);
+		if (unlikely(fp < low || fp > high || fp & 0x7))
+			break;
+		/* Unwind stack frame */
+		frame = (struct stackframe *)fp - 1;
+		sp = fp;
+		fp = frame->fp;
+		pc = frame->ra - 0x4;
+	}
+}
+
+#else /* !CONFIG_FRAME_POINTER */
+
+static void notrace walk_stackframe(struct task_struct *task,
+	struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
+{
+	unsigned long sp, pc;
+	unsigned long *ksp;
+
+	if (regs) {
+		sp = GET_USP(regs);
+		pc = GET_IP(regs);
+	} else if (task == NULL || task == current) {
+		const register unsigned long current_sp __asm__ ("sp");
+		sp = current_sp;
+		pc = (unsigned long)walk_stackframe;
+	} else {
+		/* task blocked in __switch_to */
+		sp = task->thread.sp;
+		pc = task->thread.ra;
+	}
+
+	if (unlikely(sp & 0x7))
+		return;
+
+	ksp = (unsigned long *)sp;
+	while (!kstack_end(ksp)) {
+		if (__kernel_text_address(pc) && unlikely(fn(pc, arg)))
+			break;
+		pc = (*ksp++) - 0x4;
+	}
+}
+
+#endif /* CONFIG_FRAME_POINTER */
+
+
+static bool print_trace_address(unsigned long pc, void *arg)
+{
+	print_ip_sym(pc);
+	return false;
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	printk("Call Trace:\n");
+	walk_stackframe(task, NULL, print_trace_address, NULL);
+}
+
+
+static bool save_wchan(unsigned long pc, void *arg)
+{
+	if (!in_sched_functions(pc)) {
+		unsigned long *p = arg;
+		*p = pc;
+		return true;
+	}
+	return false;
+}
+
+unsigned long get_wchan(struct task_struct *task)
+{
+	unsigned long pc = 0;
+
+	if (likely(task && task != current && task->state != TASK_RUNNING))
+		walk_stackframe(task, NULL, save_wchan, &pc);
+	return pc;
+}
+
+
+#ifdef CONFIG_STACKTRACE
+
+static bool __save_trace(unsigned long pc, void *arg, bool nosched)
+{
+	struct stack_trace *trace = arg;
+
+	if (unlikely(nosched && in_sched_functions(pc)))
+		return false;
+	if (unlikely(trace->skip > 0)) {
+		trace->skip--;
+		return false;
+	}
+
+	trace->entries[trace->nr_entries++] = pc;
+	return (trace->nr_entries >= trace->max_entries);
+}
+
+static bool save_trace(unsigned long pc, void *arg)
+{
+	return __save_trace(pc, arg, false);
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	walk_stackframe(tsk, NULL, save_trace, trace);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void save_stack_trace(struct stack_trace *trace)
+{
+	save_stack_trace_tsk(NULL, trace);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+#endif /* CONFIG_STACKTRACE */
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
new file mode 100644
index 000000000000..33d40a5da4a1
--- /dev/null
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2014 Darius Rad <darius@bluespec.com>
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/syscalls.h>
+#include <asm/unistd.h>
+
+#ifdef CONFIG_64BIT
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags,
+	unsigned long, fd, off_t, offset)
+{
+	if (unlikely(offset & (~PAGE_MASK)))
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
+}
+#else
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags,
+	unsigned long, fd, off_t, offset)
+{
+	/* Note that the shift for mmap2 is constant (12),
+	 * regardless of PAGE_SIZE
+	 */
+	if (unlikely(offset & (~PAGE_MASK >> 12)))
+		return -EINVAL;
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+		offset >> (PAGE_SHIFT - 12));
+}
+#endif /* !CONFIG_64BIT */
+
+#ifdef CONFIG_SYSRISCV_ATOMIC
+SYSCALL_DEFINE4(sysriscv, unsigned long, cmd, unsigned long, arg1,
+	unsigned long, arg2, unsigned long, arg3)
+{
+	unsigned long flags;
+	unsigned long prev;
+	unsigned int *ptr;
+	unsigned int err;
+
+	switch (cmd) {
+	case RISCV_ATOMIC_CMPXCHG:
+		ptr = (unsigned int *)arg1;
+		if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
+			return -EFAULT;
+
+		preempt_disable();
+		raw_local_irq_save(flags);
+		err = __get_user(prev, ptr);
+		if (likely(!err && prev == arg2))
+			err = __put_user(arg3, ptr);
+		raw_local_irq_restore(flags);
+		preempt_enable();
+
+		return unlikely(err) ? err : prev;
+
+	case RISCV_ATOMIC_CMPXCHG64:
+		ptr = (unsigned int *)arg1;
+		if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
+			return -EFAULT;
+
+		preempt_disable();
+		raw_local_irq_save(flags);
+		err = __get_user(prev, ptr);
+		if (likely(!err && prev == arg2))
+			err = __put_user(arg3, ptr);
+		raw_local_irq_restore(flags);
+		preempt_enable();
+
+		return unlikely(err) ? err : prev;
+	}
+
+	return -EINVAL;
+}
+#endif /* CONFIG_SYSRISCV_ATOMIC */
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
new file mode 100644
index 000000000000..8fa239b67cbc
--- /dev/null
+++ b/arch/riscv/kernel/syscall_table.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2009 Arnd Bergmann <arnd@arndb.de>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/syscalls.h>
+
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)	[nr] = (call),
+
+void *sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
new file mode 100644
index 000000000000..3a4698199ecf
--- /dev/null
+++ b/arch/riscv/kernel/traps.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/signal.h>
+#include <linux/signal.h>
+#include <linux/kdebug.h>
+#include <linux/uaccess.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/csr.h>
+
+int show_unhandled_signals = 1;
+
+extern asmlinkage void handle_exception(void);
+
+static DEFINE_SPINLOCK(die_lock);
+
+void die(struct pt_regs *regs, const char *str)
+{
+	static int die_counter;
+	int ret;
+
+	oops_enter();
+
+	spin_lock_irq(&die_lock);
+	console_verbose();
+	bust_spinlocks(1);
+
+	pr_emerg("%s [#%d]\n", str, ++die_counter);
+	print_modules();
+	show_regs(regs);
+
+	ret = notify_die(DIE_OOPS, str, regs, 0, regs->scause, SIGSEGV);
+
+	bust_spinlocks(0);
+	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+	spin_unlock_irq(&die_lock);
+	oops_exit();
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+	if (panic_on_oops)
+		panic("Fatal exception");
+	if (ret != NOTIFY_STOP)
+		do_exit(SIGSEGV);
+}
+
+static inline void do_trap_siginfo(int signo, int code,
+	unsigned long addr, struct task_struct *tsk)
+{
+	siginfo_t info;
+
+	info.si_signo = signo;
+	info.si_errno = 0;
+	info.si_code = code;
+	info.si_addr = (void __user *)addr;
+	force_sig_info(signo, &info, tsk);
+}
+
+void do_trap(struct pt_regs *regs, int signo, int code,
+	unsigned long addr, struct task_struct *tsk)
+{
+	if (show_unhandled_signals && unhandled_signal(tsk, signo)
+	    && printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
+			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+		print_vma_addr(KERN_CONT " in ", GET_IP(regs));
+		pr_cont("\n");
+		show_regs(regs);
+	}
+
+	do_trap_siginfo(signo, code, addr, tsk);
+}
+
+static void do_trap_error(struct pt_regs *regs, int signo, int code,
+	unsigned long addr, const char *str)
+{
+	if (user_mode(regs)) {
+		do_trap(regs, signo, code, addr, current);
+	} else {
+		if (!fixup_exception(regs))
+			die(regs, str);
+	}
+}
+
+#define DO_ERROR_INFO(name, signo, code, str)				\
+asmlinkage void name(struct pt_regs *regs)				\
+{									\
+	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
+}
+
+DO_ERROR_INFO(do_trap_unknown,
+	SIGILL, ILL_ILLTRP, "unknown exception");
+DO_ERROR_INFO(do_trap_insn_misaligned,
+	SIGBUS, BUS_ADRALN, "instruction address misaligned");
+DO_ERROR_INFO(do_trap_insn_fault,
+	SIGBUS, BUS_ADRALN, "instruction access fault");
+DO_ERROR_INFO(do_trap_insn_illegal,
+	SIGILL, ILL_ILLOPC, "illegal instruction");
+DO_ERROR_INFO(do_trap_load_misaligned,
+	SIGBUS, BUS_ADRALN, "load address misaligned");
+DO_ERROR_INFO(do_trap_load_fault,
+	SIGSEGV, SEGV_ACCERR, "load access fault");
+DO_ERROR_INFO(do_trap_store_misaligned,
+	SIGBUS, BUS_ADRALN, "store (or AMO) address misaligned");
+DO_ERROR_INFO(do_trap_store_fault,
+	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
+DO_ERROR_INFO(do_trap_ecall_u,
+	SIGILL, ILL_ILLTRP, "environment call from U-mode");
+DO_ERROR_INFO(do_trap_ecall_s,
+	SIGILL, ILL_ILLTRP, "environment call from S-mode");
+DO_ERROR_INFO(do_trap_ecall_m,
+	SIGILL, ILL_ILLTRP, "environment call from M-mode");
+
+asmlinkage void do_trap_break(struct pt_regs *regs)
+{
+#ifdef CONFIG_GENERIC_BUG
+	if (!user_mode(regs)) {
+		enum bug_trap_type type;
+
+		type = report_bug(regs->sepc, regs);
+		switch (type) {
+		case BUG_TRAP_TYPE_NONE:
+			break;
+		case BUG_TRAP_TYPE_WARN:
+			regs->sepc += sizeof(bug_insn_t);
+			return;
+		case BUG_TRAP_TYPE_BUG:
+			die(regs, "Kernel BUG");
+		}
+	}
+#endif /* CONFIG_GENERIC_BUG */
+
+	do_trap_siginfo(SIGTRAP, TRAP_BRKPT, regs->sepc, current);
+	regs->sepc += 0x4;
+}
+
+#ifdef CONFIG_GENERIC_BUG
+int is_valid_bugaddr(unsigned long pc)
+{
+	bug_insn_t insn;
+
+	if (pc < PAGE_OFFSET)
+		return 0;
+	if (probe_kernel_address((bug_insn_t __user *)pc, insn))
+		return 0;
+	return (insn == __BUG_INSN);
+}
+#endif /* CONFIG_GENERIC_BUG */
+
+void __init trap_init(void)
+{
+	int hart = smp_processor_id();
+
+	/* Set sup0 scratch register to 0, indicating to exception vector
+	 * that we are presently executing in the kernel
+	 */
+	csr_write(sscratch, 0);
+	/* Set the exception vector address */
+	csr_write(stvec, &handle_exception);
+	/* Enable software interrupts and setup initial mask */
+	csr_write(sie,
+		  SIE_SSIE | atomic_long_read(&per_cpu(riscv_early_sie, hart))
+		);
+}
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
new file mode 100644
index 000000000000..e8a178df8144
--- /dev/null
+++ b/arch/riscv/kernel/vdso.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ * Copyright (C) 2012 ARM Limited
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/binfmts.h>
+#include <linux/err.h>
+
+#include <asm/vdso.h>
+
+extern char vdso_start[], vdso_end[];
+
+static unsigned int vdso_pages;
+static struct page **vdso_pagelist;
+
+/*
+ * The vDSO data page.
+ */
+static union {
+	struct vdso_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_data_store __page_aligned_data;
+struct vdso_data *vdso_data = &vdso_data_store.data;
+
+static int __init vdso_init(void)
+{
+	unsigned int i;
+
+	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
+	vdso_pagelist =
+		kcalloc(vdso_pages + 1, sizeof(struct page *), GFP_KERNEL);
+	if (unlikely(vdso_pagelist == NULL)) {
+		pr_err("vdso: pagelist allocation failed\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < vdso_pages; i++) {
+		struct page *pg;
+
+		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
+		ClearPageReserved(pg);
+		vdso_pagelist[i] = pg;
+	}
+	vdso_pagelist[i] = virt_to_page(vdso_data);
+
+	return 0;
+}
+arch_initcall(vdso_init);
+
+int arch_setup_additional_pages(struct linux_binprm *bprm,
+	int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_base, vdso_len;
+	int ret;
+
+	vdso_len = (vdso_pages + 1) << PAGE_SHIFT;
+
+	down_write(&mm->mmap_sem);
+	vdso_base = get_unmapped_area(NULL, 0, vdso_len, 0, 0);
+	if (unlikely(IS_ERR_VALUE(vdso_base))) {
+		ret = vdso_base;
+		goto end;
+	}
+
+	/*
+	 * Put vDSO base into mm struct. We need to do this before calling
+	 * install_special_mapping or the perf counter mmap tracking code
+	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
+	 */
+	mm->context.vdso = (void *)vdso_base;
+
+	ret = install_special_mapping(mm, vdso_base, vdso_len,
+		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
+		vdso_pagelist);
+
+	if (unlikely(ret))
+		mm->context.vdso = NULL;
+
+end:
+	up_write(&mm->mmap_sem);
+	return ret;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
+		return "[vdso]";
+	return NULL;
+}
+
+/*
+ * Function stubs to prevent linker errors when AT_SYSINFO_EHDR is defined
+ */
+
+int in_gate_area_no_mm(unsigned long addr)
+{
+	return 0;
+}
+
+int in_gate_area(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
diff --git a/arch/riscv/kernel/vdso/.gitignore b/arch/riscv/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..f8b69d84238e
--- /dev/null
+++ b/arch/riscv/kernel/vdso/.gitignore
@@ -0,0 +1 @@
+vdso.lds
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
new file mode 100644
index 000000000000..04f3ec75b217
--- /dev/null
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -0,0 +1,61 @@
+# Derived from arch/{arm64,tile}/kernel/vdso/Makefile
+
+obj-vdso := sigreturn.o
+
+# Build rules
+targets := $(obj-vdso) vdso.so vdso.so.dbg
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+
+#ccflags-y := -shared -fno-common -fno-builtin
+#ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
+		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+
+CFLAGS_vdso.so = $(c_flags)
+CFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
+	$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+CFLAGS_vdso_syms.o = -r
+
+obj-y += vdso.o
+
+# We also create a special relocatable object that should mirror the symbol
+# table and layout of the linked DSO.  With ld -R we can then refer to
+# these symbols in the kernel code rather than hand-coded addresses.
+extra-y += vdso.lds vdso-syms.o
+$(obj)/built-in.o: $(obj)/vdso-syms.o
+$(obj)/built-in.o: ld_flags += -R $(obj)/vdso-syms.o
+
+CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+
+# Force dependency
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# Link rule for the *.so file; *.lds must be first
+$(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso)
+	$(call if_changed,vdsold)
+$(obj)/vdso-syms.o: $(src)/vdso.lds $(obj-vdso)
+	$(call if_changed,vdsold)
+
+# Strip rule for the *.so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Assembly rules for the *.S files
+$(obj-vdso): %.o: %.S
+	$(call if_changed_dep,vdsoas)
+
+# Actual build commands
+quiet_cmd_vdsold = VDSOLD  $@
+      cmd_vdsold = $(CC) $(c_flags) -nostdlib $(CFLAGS_$(@F)) -Wl,-n -Wl,-T $^ -o $@
+quiet_cmd_vdsoas = VDSOAS  $@
+      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
+
+# Install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/riscv/kernel/vdso/sigreturn.S b/arch/riscv/kernel/vdso/sigreturn.S
new file mode 100644
index 000000000000..f5aa3d72acfb
--- /dev/null
+++ b/arch/riscv/kernel/vdso/sigreturn.S
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+	.text
+ENTRY(__vdso_rt_sigreturn)
+	.cfi_startproc
+	.cfi_signal_frame
+	li a7, __NR_rt_sigreturn
+	scall
+	.cfi_endproc
+ENDPROC(__vdso_rt_sigreturn)
diff --git a/arch/riscv/kernel/vdso/vdso.S b/arch/riscv/kernel/vdso/vdso.S
new file mode 100644
index 000000000000..7055de5f9174
--- /dev/null
+++ b/arch/riscv/kernel/vdso/vdso.S
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_start, vdso_end
+	.balign PAGE_SIZE
+vdso_start:
+	.incbin "arch/riscv/kernel/vdso/vdso.so"
+	.balign PAGE_SIZE
+vdso_end:
+
+	.previous
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
new file mode 100644
index 000000000000..24942cb25694
--- /dev/null
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+OUTPUT_ARCH(riscv)
+
+SECTIONS
+{
+	. = SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+
+	/*
+	 * This linker script is used both with -r and with -shared.
+	 * For the layouts to match, we need to skip more than enough
+	 * space for the dynamic symbol table, etc. If this amount is
+	 * insufficient, ld -shared will error; simply increase it here.
+	 */
+	. = 0x800;
+	.text		: { *(.text .text.*) }		:text
+
+	.data		: {
+		*(.got.plt) *(.got)
+		*(.data .data.* .gnu.linkonce.d.*)
+		*(.dynbss)
+		*(.bss .bss.* .gnu.linkonce.b.*)
+	}
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	LINUX_2.6 {
+	global:
+		__vdso_rt_sigreturn;
+	local: *;
+	};
+}
+
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
new file mode 100644
index 000000000000..ece84991609c
--- /dev/null
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#define LOAD_OFFSET PAGE_OFFSET
+#include <asm/vmlinux.lds.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+
+OUTPUT_ARCH(riscv)
+ENTRY(_start)
+
+jiffies = jiffies_64;
+
+SECTIONS
+{
+	/* Beginning of code and text segment */
+	. = LOAD_OFFSET;
+	_start = .;
+	__init_begin = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	/* we have to discard exit text and such at runtime, not link time */
+	.exit.text :
+	{
+		EXIT_TEXT
+	}
+	.exit.data :
+	{
+		EXIT_DATA
+	}
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	__init_end = .;
+
+	.text : {
+		_text = .;
+		_stext = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		ENTRY_TEXT
+		IRQENTRY_TEXT
+		*(.fixup)
+		_etext = .;
+	}
+
+	/* Start of data section */
+	_sdata = .;
+	RO_DATA_SECTION(L1_CACHE_BYTES)
+	.srodata : {
+		*(.srodata*)
+	}
+
+	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	.sdata : {
+		__global_pointer$ = . + 0x800;
+		*(.sdata*)
+		/* End of data section */
+		_edata = .;
+		*(.sbss*)
+	}
+
+	BSS_SECTION(0, 0, 0)
+
+	EXCEPTION_TABLE(0x10)
+	NOTES
+
+	.rel.dyn : {
+		*(.rel.dyn*)
+	}
+
+	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
-- 
2.13.0
