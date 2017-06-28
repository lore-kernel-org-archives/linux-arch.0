From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/9] RISC-V: Init and Halt Code
Date: Wed, 28 Jun 2017 11:55:30 -0700
Message-ID: <20170628185538.1804-2-palmer@dabbelt.com>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32825 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF1Szz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 14:55:55 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so9162377pgb.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Jun 2017 11:55:54 -0700 (PDT)
In-Reply-To: <20170628185538.1804-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>

This contains the various __init C functions, the initial assembly
kernel entry point, and the code to reset the system.  When a file was
init-related, it contains

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/bug.h   |  88 +++++++++++++++
 arch/riscv/include/asm/cache.h |  22 ++++
 arch/riscv/include/asm/smp.h   |  41 +++++++
 arch/riscv/kernel/cacheinfo.c  | 105 ++++++++++++++++++
 arch/riscv/kernel/cpu.c        |  89 +++++++++++++++
 arch/riscv/kernel/head.S       | 147 +++++++++++++++++++++++++
 arch/riscv/kernel/irq.c        |  20 ++++
 arch/riscv/kernel/reset.c      |  36 +++++++
 arch/riscv/kernel/setup.c      | 240 +++++++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/smp.c        | 110 +++++++++++++++++++
 arch/riscv/kernel/smpboot.c    | 103 ++++++++++++++++++
 arch/riscv/kernel/time.c       |  61 +++++++++++
 arch/riscv/kernel/traps.c      | 183 +++++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso.c       | 125 +++++++++++++++++++++
 arch/riscv/mm/init.c           |  70 ++++++++++++
 15 files changed, 1440 insertions(+)
 create mode 100644 arch/riscv/include/asm/bug.h
 create mode 100644 arch/riscv/include/asm/cache.h
 create mode 100644 arch/riscv/include/asm/smp.h
 create mode 100644 arch/riscv/kernel/cacheinfo.c
 create mode 100644 arch/riscv/kernel/cpu.c
 create mode 100644 arch/riscv/kernel/head.S
 create mode 100644 arch/riscv/kernel/irq.c
 create mode 100644 arch/riscv/kernel/reset.c
 create mode 100644 arch/riscv/kernel/setup.c
 create mode 100644 arch/riscv/kernel/smp.c
 create mode 100644 arch/riscv/kernel/smpboot.c
 create mode 100644 arch/riscv/kernel/time.c
 create mode 100644 arch/riscv/kernel/traps.c
 create mode 100644 arch/riscv/kernel/vdso.c
 create mode 100644 arch/riscv/mm/init.c

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
new file mode 100644
index 000000000000..e2f690c20729
--- /dev/null
+++ b/arch/riscv/include/asm/bug.h
@@ -0,0 +1,88 @@
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
+#ifndef _ASM_RISCV_BUG_H
+#define _ASM_RISCV_BUG_H
+
+#include <linux/compiler.h>
+#include <linux/const.h>
+#include <linux/types.h>
+
+#include <asm/asm.h>
+
+#ifdef CONFIG_GENERIC_BUG
+#define __BUG_INSN	_AC(0x00100073, UL) /* sbreak */
+
+#ifndef __ASSEMBLY__
+typedef u32 bug_insn_t;
+
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+#define __BUG_ENTRY_ADDR	INT " 1b - 2b"
+#define __BUG_ENTRY_FILE	INT " %0 - 2b"
+#else
+#define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
+#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR "\n\t"		\
+	__BUG_ENTRY_FILE "\n\t"		\
+	SHORT " %1"
+#else
+#define __BUG_ENTRY			\
+	__BUG_ENTRY_ADDR
+#endif
+
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ (					\
+		"1:\n\t"					\
+			"sbreak\n"				\
+			".pushsection __bug_table,\"a\"\n\t"	\
+		"2:\n\t"					\
+			__BUG_ENTRY "\n\t"			\
+			".org 2b + %2\n\t"			\
+			".popsection"				\
+		:						\
+		: "i" (__FILE__), "i" (__LINE__),		\
+		  "i" (sizeof(struct bug_entry)));		\
+	unreachable();						\
+} while (0)
+#endif /* !__ASSEMBLY__ */
+#else /* CONFIG_GENERIC_BUG */
+#ifndef __ASSEMBLY__
+#define BUG()							\
+do {								\
+	__asm__ __volatile__ ("sbreak\n");			\
+	unreachable();						\
+} while (0)
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_GENERIC_BUG */
+
+#define HAVE_ARCH_BUG
+
+#include <asm-generic/bug.h>
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs;
+struct task_struct;
+
+extern void die(struct pt_regs *regs, const char *str);
+extern void do_trap(struct pt_regs *regs, int signo, int code,
+	unsigned long addr, struct task_struct *tsk);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_BUG_H */
diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
new file mode 100644
index 000000000000..e8f0d1110d74
--- /dev/null
+++ b/arch/riscv/include/asm/cache.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2017 Chen Liqin <liqin.chen@sunplusct.com>
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
+#ifndef _ASM_RISCV_CACHE_H
+#define _ASM_RISCV_CACHE_H
+
+#define L1_CACHE_SHIFT		6
+
+#define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
+
+#endif /* _ASM_RISCV_CACHE_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
new file mode 100644
index 000000000000..f61f8c25f95b
--- /dev/null
+++ b/arch/riscv/include/asm/smp.h
@@ -0,0 +1,41 @@
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
+#ifndef _ASM_RISCV_SMP_H
+#define _ASM_RISCV_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+
+#ifdef CONFIG_SMP
+
+/* SMP initialization hook for setup_arch */
+void __init init_clockevent(void);
+
+/* SMP initialization hook for setup_arch */
+void __init setup_smp(void);
+
+/* Hook for the generic smp_call_function_many() routine. */
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+/* Hook for the generic smp_call_function_single() routine. */
+void arch_send_call_function_single_ipi(int cpu);
+
+#define raw_smp_processor_id() (current_thread_info()->cpu)
+
+/* Interprocessor interrupt handler */
+irqreturn_t handle_ipi(void);
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
new file mode 100644
index 000000000000..10ed2749e246
--- /dev/null
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -0,0 +1,105 @@
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
+	/* not a sector cache */
+	this_leaf->physical_line_partition = 1;
+	/* TODO: Add to DTS */
+	this_leaf->attributes =
+		CACHE_WRITE_BACK
+		| CACHE_READ_ALLOCATE
+		| CACHE_WRITE_ALLOCATE;
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
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
new file mode 100644
index 000000000000..b4a71ec5906f
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
+		mb();
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
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
new file mode 100644
index 000000000000..6bba2e6f2a84
--- /dev/null
+++ b/arch/riscv/kernel/time.c
@@ -0,0 +1,61 @@
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
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/delay.h>
+#include <linux/timer_riscv.h>
+
+#include <asm/sbi.h>
+
+unsigned long riscv_timebase;
+
+static int next_event(unsigned long delta, struct clock_event_device *ce)
+{
+	BUG_ON(ce != timer_riscv_device(smp_processor_id()));
+	sbi_set_timer(get_cycles64() + delta);
+	return 0;
+}
+
+static unsigned long long rdtime(struct clocksource *cs)
+{
+	BUG_ON(cs != timer_riscv_source(smp_processor_id()));
+	return get_cycles64();
+}
+
+void riscv_timer_interrupt(void)
+{
+	int cpu = smp_processor_id();
+	struct clock_event_device *evdev = timer_riscv_device(cpu);
+
+	evdev->event_handler(evdev);
+}
+
+void __init time_init(void)
+{
+	struct device_node *cpu;
+	u32 prop;
+	int cpu_id = smp_processor_id();
+
+	cpu = of_find_node_by_path("/cpus");
+	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
+		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
+	riscv_timebase = prop;
+
+	lpj_fine = riscv_timebase / HZ;
+
+	timer_riscv_init(cpu_id, riscv_timebase, &rdtime, &next_event);
+
+	csr_set(sie, SIE_STIE);
+}
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
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
new file mode 100644
index 000000000000..9f4bee5e51fd
--- /dev/null
+++ b/arch/riscv/mm/init.c
@@ -0,0 +1,70 @@
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
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/initrd.h>
+#include <linux/memblock.h>
+#include <linux/swap.h>
+
+#include <asm/tlbflush.h>
+#include <asm/sections.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+static void __init zone_sizes_init(void)
+{
+	unsigned long zones_size[MAX_NR_ZONES];
+
+	memset(zones_size, 0, sizeof(zones_size));
+	zones_size[ZONE_NORMAL] = max_mapnr;
+	free_area_init_node(0, zones_size, pfn_base, NULL);
+}
+
+void setup_zero_page(void)
+{
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+}
+
+void __init paging_init(void)
+{
+	init_mm.pgd = (pgd_t *)pfn_to_virt(csr_read(sptbr));
+
+	setup_zero_page();
+	local_flush_tlb_all();
+	zone_sizes_init();
+}
+
+void __init mem_init(void)
+{
+#ifdef CONFIG_FLATMEM
+	BUG_ON(!mem_map);
+#endif /* CONFIG_FLATMEM */
+
+	high_memory = (void *)(__va(PFN_PHYS(max_low_pfn)));
+	free_all_bootmem();
+
+	mem_init_print_info(NULL);
+}
+
+void free_initmem(void)
+{
+	free_initmem_default(0);
+}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
-- 
2.13.0
