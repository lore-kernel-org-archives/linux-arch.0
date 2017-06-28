From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 28 Jun 2017 11:55:37 -0700
Message-ID: <20170628185538.1804-9-palmer@dabbelt.com>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35141 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdF1S4T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 14:56:19 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so10062201pfs.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Jun 2017 11:56:14 -0700 (PDT)
In-Reply-To: <20170628185538.1804-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>

This patch contains code that is in some way visible to the user:
including via system calls, the VDSO, module loading and signal
handling.  It also contains some generic code that is ABI visible.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/mmu.h              |  26 +++
 arch/riscv/include/asm/ptrace.h           | 116 ++++++++++++
 arch/riscv/include/asm/syscall.h          |  90 ++++++++++
 arch/riscv/include/asm/syscalls.h         |  25 +++
 arch/riscv/include/asm/unistd.h           |  16 ++
 arch/riscv/include/asm/vdso.h             |  32 ++++
 arch/riscv/include/uapi/asm/auxvec.h      |  24 +++
 arch/riscv/include/uapi/asm/bitsperlong.h |  25 +++
 arch/riscv/include/uapi/asm/byteorder.h   |  23 +++
 arch/riscv/include/uapi/asm/elf.h         |  83 +++++++++
 arch/riscv/include/uapi/asm/ptrace.h      |  87 +++++++++
 arch/riscv/include/uapi/asm/sigcontext.h  |  29 +++
 arch/riscv/include/uapi/asm/siginfo.h     |  24 +++
 arch/riscv/include/uapi/asm/ucontext.h    |  35 ++++
 arch/riscv/include/uapi/asm/unistd.h      |  26 +++
 arch/riscv/kernel/module.c                | 215 ++++++++++++++++++++++
 arch/riscv/kernel/ptrace.c                | 147 +++++++++++++++
 arch/riscv/kernel/riscv_ksyms.c           |  15 ++
 arch/riscv/kernel/signal.c                | 288 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/sys_riscv.c             |  87 +++++++++
 arch/riscv/kernel/syscall_table.c         |  25 +++
 arch/riscv/kernel/vdso/.gitignore         |   1 +
 arch/riscv/kernel/vdso/cmpxchg32.S        |  40 +++++
 arch/riscv/kernel/vdso/cmpxchg64.S        |  40 +++++
 arch/riscv/kernel/vdso/sigreturn.S        |  24 +++
 arch/riscv/kernel/vdso/vdso.S             |  27 +++
 26 files changed, 1570 insertions(+)
 create mode 100644 arch/riscv/include/asm/mmu.h
 create mode 100644 arch/riscv/include/asm/ptrace.h
 create mode 100644 arch/riscv/include/asm/syscall.h
 create mode 100644 arch/riscv/include/asm/syscalls.h
 create mode 100644 arch/riscv/include/asm/unistd.h
 create mode 100644 arch/riscv/include/asm/vdso.h
 create mode 100644 arch/riscv/include/uapi/asm/auxvec.h
 create mode 100644 arch/riscv/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/riscv/include/uapi/asm/byteorder.h
 create mode 100644 arch/riscv/include/uapi/asm/elf.h
 create mode 100644 arch/riscv/include/uapi/asm/ptrace.h
 create mode 100644 arch/riscv/include/uapi/asm/sigcontext.h
 create mode 100644 arch/riscv/include/uapi/asm/siginfo.h
 create mode 100644 arch/riscv/include/uapi/asm/ucontext.h
 create mode 100644 arch/riscv/include/uapi/asm/unistd.h
 create mode 100644 arch/riscv/kernel/module.c
 create mode 100644 arch/riscv/kernel/ptrace.c
 create mode 100644 arch/riscv/kernel/riscv_ksyms.c
 create mode 100644 arch/riscv/kernel/signal.c
 create mode 100644 arch/riscv/kernel/sys_riscv.c
 create mode 100644 arch/riscv/kernel/syscall_table.c
 create mode 100644 arch/riscv/kernel/vdso/.gitignore
 create mode 100644 arch/riscv/kernel/vdso/cmpxchg32.S
 create mode 100644 arch/riscv/kernel/vdso/cmpxchg64.S
 create mode 100644 arch/riscv/kernel/vdso/sigreturn.S
 create mode 100644 arch/riscv/kernel/vdso/vdso.S

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
new file mode 100644
index 000000000000..66805cba9a27
--- /dev/null
+++ b/arch/riscv/include/asm/mmu.h
@@ -0,0 +1,26 @@
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
+
+#ifndef _ASM_RISCV_MMU_H
+#define _ASM_RISCV_MMU_H
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	void *vdso;
+} mm_context_t;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
new file mode 100644
index 000000000000..340201868842
--- /dev/null
+++ b/arch/riscv/include/asm/ptrace.h
@@ -0,0 +1,116 @@
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
+#ifndef _ASM_RISCV_PTRACE_H
+#define _ASM_RISCV_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+#include <asm/csr.h>
+
+#ifndef __ASSEMBLY__
+
+struct pt_regs {
+	unsigned long sepc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+	/* Supervisor CSRs */
+	unsigned long sstatus;
+	unsigned long sbadaddr;
+	unsigned long scause;
+};
+
+#ifdef CONFIG_64BIT
+#define REG_FMT "%016lx"
+#else
+#define REG_FMT "%08lx"
+#endif
+
+#define user_mode(regs) (((regs)->sstatus & SR_PS) == 0)
+
+
+/* Helpers for working with the instruction pointer */
+#define GET_IP(regs) ((regs)->sepc)
+#define SET_IP(regs, val) (GET_IP(regs) = (val))
+
+static inline unsigned long instruction_pointer(struct pt_regs *regs)
+{
+	return GET_IP(regs);
+}
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	SET_IP(regs, val);
+}
+
+#define profile_pc(regs) instruction_pointer(regs)
+
+/* Helpers for working with the user stack pointer */
+#define GET_USP(regs) ((regs)->sp)
+#define SET_USP(regs, val) (GET_USP(regs) = (val))
+
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return GET_USP(regs);
+}
+static inline void user_stack_pointer_set(struct pt_regs *regs,
+					  unsigned long val)
+{
+	SET_USP(regs, val);
+}
+
+/* Helpers for working with the frame pointer */
+#define GET_FP(regs) ((regs)->s0)
+#define SET_FP(regs, val) (GET_FP(regs) = (val))
+
+static inline unsigned long frame_pointer(struct pt_regs *regs)
+{
+	return GET_FP(regs);
+}
+static inline void frame_pointer_set(struct pt_regs *regs,
+				     unsigned long val)
+{
+	SET_FP(regs, val);
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
new file mode 100644
index 000000000000..c70f0e7a06b8
--- /dev/null
+++ b/arch/riscv/include/asm/syscall.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
+ * Copyright 2010 Tilera Corporation. All Rights Reserved.
+ * Copyright 2015 Regents of the University of California, Berkeley
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
+ * See asm-generic/syscall.h for descriptions of what we must do here.
+ */
+
+#ifndef _ASM_RISCV_SYSCALL_H
+#define _ASM_RISCV_SYSCALL_H
+
+#include <linux/sched.h>
+#include <linux/err.h>
+
+/* The array of function pointers for syscalls. */
+extern void *sys_call_table[];
+
+/*
+ * Only the low 32 bits of orig_r0 are meaningful, so we return int.
+ * This importantly ignores the high bits on 64-bit, so comparisons
+ * sign-extend the low 32 bits.
+ */
+static inline int syscall_get_nr(struct task_struct *task,
+				 struct pt_regs *regs)
+{
+	return regs->a7;
+}
+
+static inline void syscall_set_nr(struct task_struct *task,
+				  struct pt_regs *regs,
+				  int sysno)
+{
+	regs->a7 = sysno;
+}
+
+static inline void syscall_rollback(struct task_struct *task,
+				    struct pt_regs *regs)
+{
+	/* FIXME: We can't do this... */
+}
+
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	unsigned long error = regs->a0;
+
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
+static inline void syscall_set_return_value(struct task_struct *task,
+					    struct pt_regs *regs,
+					    int error, long val)
+{
+	regs->a0 = (long) error ?: val;
+}
+
+static inline void syscall_get_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	memcpy(args, &regs->a0 + i * sizeof(regs->a0), n * sizeof(args[0]));
+}
+
+static inline void syscall_set_arguments(struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned int i, unsigned int n,
+					 const unsigned long *args)
+{
+	BUG_ON(i + n > 6);
+	memcpy(&regs->a0 + i * sizeof(regs->a0), args, n * sizeof(regs->a0));
+}
+
+#endif	/* _ASM_TILE_SYSCALL_H */
diff --git a/arch/riscv/include/asm/syscalls.h b/arch/riscv/include/asm/syscalls.h
new file mode 100644
index 000000000000..d85267c4f7ea
--- /dev/null
+++ b/arch/riscv/include/asm/syscalls.h
@@ -0,0 +1,25 @@
+/*
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
+#ifndef _ASM_RISCV_SYSCALLS_H
+#define _ASM_RISCV_SYSCALLS_H
+
+#include <linux/linkage.h>
+
+#include <asm-generic/syscalls.h>
+
+/* kernel/sys_riscv.c */
+asmlinkage long sys_sysriscv(unsigned long, unsigned long,
+	unsigned long, unsigned long);
+
+#endif /* _ASM_RISCV_SYSCALLS_H */
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
new file mode 100644
index 000000000000..9f250ed007cd
--- /dev/null
+++ b/arch/riscv/include/asm/unistd.h
@@ -0,0 +1,16 @@
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
+#define __ARCH_HAVE_MMU
+#define __ARCH_WANT_SYS_CLONE
+#include <uapi/asm/unistd.h>
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
new file mode 100644
index 000000000000..95768a3810a7
--- /dev/null
+++ b/arch/riscv/include/asm/vdso.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2012 ARM Limited
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_RISCV_VDSO_H
+#define _ASM_RISCV_VDSO_H
+
+#include <linux/types.h>
+
+struct vdso_data {
+};
+
+#define VDSO_SYMBOL(base, name)					\
+({								\
+	extern const char __vdso_##name[];			\
+	(void __user *)((unsigned long)(base) + __vdso_##name);	\
+})
+
+#endif /* _ASM_RISCV_VDSO_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
new file mode 100644
index 000000000000..1376515547cd
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef _UAPI_ASM_RISCV_AUXVEC_H
+#define _UAPI_ASM_RISCV_AUXVEC_H
+
+/* vDSO location */
+#define AT_SYSINFO_EHDR 33
+
+#endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/include/uapi/asm/bitsperlong.h b/arch/riscv/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..0b3cb52fd29d
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef _UAPI_ASM_RISCV_BITSPERLONG_H
+#define _UAPI_ASM_RISCV_BITSPERLONG_H
+
+#define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_RISCV_BITSPERLONG_H */
diff --git a/arch/riscv/include/uapi/asm/byteorder.h b/arch/riscv/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..4ca38af2cd32
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/byteorder.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef _UAPI_ASM_RISCV_BYTEORDER_H
+#define _UAPI_ASM_RISCV_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif /* _UAPI_ASM_RISCV_BYTEORDER_H */
diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
new file mode 100644
index 000000000000..a510edfa8226
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2003 Matjaz Breskvar <phoenix@bsemi.com>
+ * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _UAPI_ASM_ELF_H
+#define _UAPI_ASM_ELF_H
+
+#include <asm/ptrace.h>
+
+/* ELF register definitions */
+typedef unsigned long elf_greg_t;
+typedef struct user_regs_struct elf_gregset_t;
+#define ELF_NGREG (sizeof(elf_gregset_t) / sizeof(elf_greg_t))
+
+typedef union __riscv_fp_state elf_fpregset_t;
+
+#define ELF_RISCV_R_SYM(r_info) ((r_info) >> 32)
+#define ELF_RISCV_R_TYPE(r_info) ((r_info) & 0xffffffff)
+
+/*
+ * RISC-V relocation types
+ */
+
+/* Relocation types used by the dynamic linker */
+#define R_RISCV_NONE		0
+#define R_RISCV_32		1
+#define R_RISCV_64		2
+#define R_RISCV_RELATIVE	3
+#define R_RISCV_COPY		4
+#define R_RISCV_JUMP_SLOT	5
+#define R_RISCV_TLS_DTPMOD32	6
+#define R_RISCV_TLS_DTPMOD64	7
+#define R_RISCV_TLS_DTPREL32	8
+#define R_RISCV_TLS_DTPREL64	9
+#define R_RISCV_TLS_TPREL32	10
+#define R_RISCV_TLS_TPREL64	11
+
+/* Relocation types not used by the dynamic linker */
+#define R_RISCV_BRANCH		16
+#define R_RISCV_JAL		17
+#define R_RISCV_CALL		18
+#define R_RISCV_CALL_PLT	19
+#define R_RISCV_GOT_HI20	20
+#define R_RISCV_TLS_GOT_HI20	21
+#define R_RISCV_TLS_GD_HI20	22
+#define R_RISCV_PCREL_HI20	23
+#define R_RISCV_PCREL_LO12_I	24
+#define R_RISCV_PCREL_LO12_S	25
+#define R_RISCV_HI20		26
+#define R_RISCV_LO12_I		27
+#define R_RISCV_LO12_S		28
+#define R_RISCV_TPREL_HI20	29
+#define R_RISCV_TPREL_LO12_I	30
+#define R_RISCV_TPREL_LO12_S	31
+#define R_RISCV_TPREL_ADD	32
+#define R_RISCV_ADD8		33
+#define R_RISCV_ADD16		34
+#define R_RISCV_ADD32		35
+#define R_RISCV_ADD64		36
+#define R_RISCV_SUB8		37
+#define R_RISCV_SUB16		38
+#define R_RISCV_SUB32		39
+#define R_RISCV_SUB64		40
+#define R_RISCV_GNU_VTINHERIT	41
+#define R_RISCV_GNU_VTENTRY	42
+#define R_RISCV_ALIGN		43
+#define R_RISCV_RVC_BRANCH	44
+#define R_RISCV_RVC_JUMP	45
+#define R_RISCV_LUI		46
+#define R_RISCV_GPREL_I		47
+#define R_RISCV_GPREL_S		48
+#define R_RISCV_TPREL_I		49
+#define R_RISCV_TPREL_S		50
+#define R_RISCV_RELAX		51
+
+#endif /* _UAPI_ASM_ELF_H */
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..01aee1654eae
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -0,0 +1,87 @@
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
+#ifndef _UAPI_ASM_RISCV_PTRACE_H
+#define _UAPI_ASM_RISCV_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* User-mode register state for core dumps, ptrace, sigcontext
+ *
+ * This decouples struct pt_regs from the userspace ABI.
+ * struct user_regs_struct must form a prefix of struct pt_regs.
+ */
+struct user_regs_struct {
+	unsigned long pc;
+	unsigned long ra;
+	unsigned long sp;
+	unsigned long gp;
+	unsigned long tp;
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long t2;
+	unsigned long s0;
+	unsigned long s1;
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long a2;
+	unsigned long a3;
+	unsigned long a4;
+	unsigned long a5;
+	unsigned long a6;
+	unsigned long a7;
+	unsigned long s2;
+	unsigned long s3;
+	unsigned long s4;
+	unsigned long s5;
+	unsigned long s6;
+	unsigned long s7;
+	unsigned long s8;
+	unsigned long s9;
+	unsigned long s10;
+	unsigned long s11;
+	unsigned long t3;
+	unsigned long t4;
+	unsigned long t5;
+	unsigned long t6;
+};
+
+struct __riscv_f_ext_state {
+	__u32 f[32];
+	__u32 fcsr;
+};
+
+struct __riscv_d_ext_state {
+	__u64 f[32];
+	__u32 fcsr;
+};
+
+struct __riscv_q_ext_state {
+	__u64 f[64] __attribute__((aligned(16)));
+	__u32 fcsr;
+	/* Reserved for expansion of sigcontext structure.  Currently zeroed
+	 * upon signal, and must be zero upon sigreturn.  */
+	__u32 reserved[3];
+};
+
+union __riscv_fp_state {
+	struct __riscv_f_ext_state f;
+	struct __riscv_d_ext_state d;
+	struct __riscv_q_ext_state q;
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..805b015402ef
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -0,0 +1,29 @@
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
+#ifndef _UAPI_ASM_RISCV_SIGCONTEXT_H
+#define _UAPI_ASM_RISCV_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+/* Signal context structure
+ *
+ * This contains the context saved before a signal handler is invoked;
+ * it is restored by sys_sigreturn / sys_rt_sigreturn.
+ */
+struct sigcontext {
+	struct user_regs_struct sc_regs;
+	union __riscv_fp_state sc_fpregs;
+};
+
+#endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
diff --git a/arch/riscv/include/uapi/asm/siginfo.h b/arch/riscv/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..f96849aac662
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/siginfo.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 SiFive, Inc.
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
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#define __ARCH_SI_PREAMBLE_SIZE	(__SIZEOF_POINTER__ == 4 ? 12 : 16)
+
+#include <asm-generic/siginfo.h>
+
+#endif
diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
new file mode 100644
index 000000000000..52eff9febcfd
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2017 SiFive, Inc.
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
+ *
+ * This file was copied from arch/arm64/include/uapi/asm/ucontext.h
+ */
+#ifndef _UAPI__ASM_UCONTEXT_H
+#define _UAPI__ASM_UCONTEXT_H
+
+#include <linux/types.h>
+
+struct ucontext {
+	unsigned long	  uc_flags;
+	struct ucontext	 *uc_link;
+	stack_t		  uc_stack;
+	sigset_t	  uc_sigmask;
+	/* glibc uses a 1024-bit sigset_t */
+	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
+	/* last for future expansion */
+	struct sigcontext uc_mcontext;
+};
+
+#endif /* _UAPI__ASM_UCONTEXT_H */
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
new file mode 100644
index 000000000000..7e3909ac3c18
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -0,0 +1,26 @@
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
+/* FIXME: This exists for now in order to maintain compatibility with our
+ * pre-upstream glibc, and will be removed for our real Linux submission.
+ */
+#define __ARCH_WANT_RENAMEAT
+
+#include <asm-generic/unistd.h>
+
+/*
+ * These system calls add support for AMOs on RISC-V systems without support
+ * for the A extension.
+ */
+#define __NR_sysriscv_cmpxchg32		(__NR_arch_specific_syscall + 0)
+#define __NR_sysriscv_cmpxchg64		(__NR_arch_specific_syscall + 1)
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
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
new file mode 100644
index 000000000000..23cc81ec9e94
--- /dev/null
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -0,0 +1,15 @@
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
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
new file mode 100644
index 000000000000..f32a568ce25b
--- /dev/null
+++ b/arch/riscv/kernel/signal.c
@@ -0,0 +1,288 @@
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
+static long restore_d_state(struct pt_regs *regs,
+	struct __riscv_d_ext_state __user *state)
+{
+	long err;
+	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
+	if (likely(!err))
+		fstate_restore(current, regs);
+	return err;
+}
+
+static long save_d_state(struct pt_regs *regs,
+	struct __riscv_d_ext_state __user *state)
+{
+	fstate_save(current, regs);
+	return __copy_to_user(state, &current->thread.fstate, sizeof(*state));
+}
+
+static long restore_sigcontext(struct pt_regs *regs,
+	struct sigcontext __user *sc)
+{
+	long err;
+	size_t i;
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+	if (unlikely(err))
+		return err;
+	/* Restore the floating-point state. */
+	err = restore_d_state(regs, &sc->sc_fpregs.d);
+	if (unlikely(err))
+		return err;
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++) {
+		u32 value;
+		err = __get_user(value, &sc->sc_fpregs.q.reserved[i]);
+		if (unlikely(err))
+			break;
+		if (value != 0)
+			return -EINVAL;
+	}
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
+static long setup_sigcontext(struct rt_sigframe __user *frame,
+	struct pt_regs *regs)
+{
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
+	long err;
+	size_t i;
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+	/* Save the floating-point state. */
+	err |= save_d_state(regs, &sc->sc_fpregs.d);
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc->sc_fpregs.q.reserved); i++)
+		err |= __put_user(0, &sc->sc_fpregs.q.reserved[i]);
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
+	err |= setup_sigcontext(frame, regs);
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
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
new file mode 100644
index 000000000000..ab699efe636e
--- /dev/null
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2014 Darius Rad <darius@bluespec.com>
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
+SYSCALL_DEFINE3(sysriscv_cmpxchg32, unsigned long, arg1, unsigned long, arg2,
+		unsigned long, arg3)
+{
+	unsigned long flags;
+	unsigned long prev;
+	unsigned int *ptr;
+	unsigned int err;
+
+	ptr = (unsigned int *)arg1;
+	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
+		return -EFAULT;
+
+	preempt_disable();
+	raw_local_irq_save(flags);
+	err = __get_user(prev, ptr);
+	if (likely(!err && prev == arg2))
+		err = __put_user(arg3, ptr);
+	raw_local_irq_restore(flags);
+	preempt_enable();
+
+	return unlikely(err) ? err : prev;
+}
+
+SYSCALL_DEFINE3(sysriscv_cmpxchg64, unsigned long, arg1, unsigned long, arg2,
+		unsigned long, arg3)
+{
+	unsigned long flags;
+	unsigned long prev;
+	unsigned int *ptr;
+	unsigned int err;
+
+	ptr = (unsigned int *)arg1;
+	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
+		return -EFAULT;
+
+	preempt_disable();
+	raw_local_irq_save(flags);
+	err = __get_user(prev, ptr);
+	if (likely(!err && prev == arg2))
+		err = __put_user(arg3, ptr);
+	raw_local_irq_restore(flags);
+	preempt_enable();
+
+	return unlikely(err) ? err : prev;
+}
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
diff --git a/arch/riscv/kernel/vdso/.gitignore b/arch/riscv/kernel/vdso/.gitignore
new file mode 100644
index 000000000000..f8b69d84238e
--- /dev/null
+++ b/arch/riscv/kernel/vdso/.gitignore
@@ -0,0 +1 @@
+vdso.lds
diff --git a/arch/riscv/kernel/vdso/cmpxchg32.S b/arch/riscv/kernel/vdso/cmpxchg32.S
new file mode 100644
index 000000000000..387deb4e852c
--- /dev/null
+++ b/arch/riscv/kernel/vdso/cmpxchg32.S
@@ -0,0 +1,40 @@
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
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+	.text
+ENTRY(__vdso_cmpxchg32)
+	.cfi_startproc
+#ifdef CONFIG_ISA_A
+/*
+ * a0: ptr
+ * a1: compare value
+ * a2: exchange value
+ */
+0:
+	lr.w.aqrl t0, 0(a0)
+	bne       t0, a1, 1f
+	sc.w.aqrl t1, a2, 0(a0)
+	bnez      t1, 0b
+1:
+	mv        a0, t0
+	ret
+#else
+	li a7, __NR_sysriscv_cmpxchg32
+	scall
+	ret
+#endif
+	.cfi_endproc
+ENDPROC(__vdso_cmpxchg32)
diff --git a/arch/riscv/kernel/vdso/cmpxchg64.S b/arch/riscv/kernel/vdso/cmpxchg64.S
new file mode 100644
index 000000000000..6286842f78c0
--- /dev/null
+++ b/arch/riscv/kernel/vdso/cmpxchg64.S
@@ -0,0 +1,40 @@
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
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+	.text
+ENTRY(__vdso_cmpxchg64)
+	.cfi_startproc
+#ifdef CONFIG_ISA_A
+/*
+ * a0: ptr
+ * a1: compare value
+ * a2: exchange value
+ */
+0:
+	lr.d.aqrl t0, 0(a0)
+	bne       t0, a1, 1f
+	sc.d.aqrl t1, a2, 0(a0)
+	bnez      t1, 0b
+1:
+	mv        a0, t0
+	ret
+#else
+	li a7, __NR_sysriscv_cmpxchg64
+	scall
+	ret
+#endif
+	.cfi_endproc
+ENDPROC(__vdso_cmpxchg64)
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
-- 
2.13.0
