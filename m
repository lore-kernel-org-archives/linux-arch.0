From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 16/33] nds32: System calls handling
Date: Fri,  8 Dec 2017 17:11:59 +0800
Message-ID: <c0e6b3380d1bdf280d30a9ce657d125e637dd9fb.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45615 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbdLHJix (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 04:38:53 -0500
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>

From: Greentime Hu <greentime@andestech.com>

This patch adds support for system calls.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/syscall.h     |  203 ++++++++++++++++++++++++++++++++++
 arch/nds32/include/asm/syscalls.h    |   26 +++++
 arch/nds32/include/asm/unistd.h      |   19 ++++
 arch/nds32/include/uapi/asm/unistd.h |   25 +++++
 arch/nds32/kernel/ex-scall.S         |  119 ++++++++++++++++++++
 arch/nds32/kernel/sys_nds32.c        |   74 +++++++++++++
 arch/nds32/kernel/syscall_table.c    |   30 +++++
 7 files changed, 496 insertions(+)
 create mode 100644 arch/nds32/include/asm/syscall.h
 create mode 100644 arch/nds32/include/asm/syscalls.h
 create mode 100644 arch/nds32/include/asm/unistd.h
 create mode 100644 arch/nds32/include/uapi/asm/unistd.h
 create mode 100644 arch/nds32/kernel/ex-scall.S
 create mode 100644 arch/nds32/kernel/sys_nds32.c
 create mode 100644 arch/nds32/kernel/syscall_table.c

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
new file mode 100644
index 0000000..3066bae
--- /dev/null
+++ b/arch/nds32/include/asm/syscall.h
@@ -0,0 +1,203 @@
+/*
+ * Access to user system call parameters and results
+ *
+ * Copyright (C) 2008-2009 Red Hat, Inc.  All rights reserved.
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ *
+ * This file is a stub providing documentation for what functions
+ * asm-ARCH/syscall.h files need to define.  Most arch definitions
+ * will be simple inlines.
+ *
+ * All of these functions expect to be called with no locks,
+ * and only when the caller is sure that the task of interest
+ * cannot return to user mode while we are looking at it.
+ */
+
+#ifndef _ASM_NDS32_SYSCALL_H
+#define _ASM_NDS32_SYSCALL_H	1
+
+#include <linux/err.h>
+struct task_struct;
+struct pt_regs;
+
+/**
+ * syscall_get_nr - find what system call a task is executing
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * If @task is executing a system call or is at system call
+ * tracing about to attempt one, returns the system call number.
+ * If @task is not executing a system call, i.e. it's blocked
+ * inside the kernel for a fault or signal, returns -1.
+ *
+ * Note this returns int even on 64-bit machines.  Only 32 bits of
+ * system call number can be meaningful.  If the actual arch value
+ * is 64 bits, this truncates to 32 bits so 0xffffffff means -1.
+ *
+ * It's only valid to call this when @task is known to be blocked.
+ */
+int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->syscallno;
+}
+
+/**
+ * syscall_rollback - roll back registers after an aborted system call
+ * @task:	task of interest, must be in system call exit tracing
+ * @regs:	task_pt_regs() of @task
+ *
+ * It's only valid to call this when @task is stopped for system
+ * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
+ * after tracehook_report_syscall_entry() returned nonzero to prevent
+ * the system call from taking place.
+ *
+ * This rolls back the register state in @regs so it's as if the
+ * system call instruction was a no-op.  The registers containing
+ * the system call number and arguments are as they were before the
+ * system call instruction.  This may not be the same as what the
+ * register state looked like at system call entry tracing.
+ */
+void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
+{
+	regs->uregs[0] = regs->orig_r0;
+}
+
+/**
+ * syscall_get_error - check result of traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * Returns 0 if the system call succeeded, or -ERRORCODE if it failed.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+{
+	unsigned long error = regs->uregs[0];
+	return IS_ERR_VALUE(error) ? error : 0;
+}
+
+/**
+ * syscall_get_return_value - get the return value of a traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ *
+ * Returns the return value of the successful system call.
+ * This value is meaningless if syscall_get_error() returned nonzero.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+{
+	return regs->uregs[0];
+}
+
+/**
+ * syscall_set_return_value - change the return value of a traced system call
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ * @error:	negative error code, or zero to indicate success
+ * @val:	user return value if @error is zero
+ *
+ * This changes the results of the system call that user mode will see.
+ * If @error is zero, the user sees a successful system call with a
+ * return value of @val.  If @error is nonzero, it's a negated errno
+ * code; the user sees a failed system call with this errno code.
+ *
+ * It's only valid to call this when @task is stopped for tracing on exit
+ * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ */
+void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			      int error, long val)
+{
+	regs->uregs[0] = (long)error ? error : val;
+}
+
+/**
+ * syscall_get_arguments - extract system call parameter values
+ * @task:	task of interest, must be blocked
+ * @regs:	task_pt_regs() of @task
+ * @i:		argument index [0,5]
+ * @n:		number of arguments; n+i must be [1,6].
+ * @args:	array filled with argument values
+ *
+ * Fetches @n arguments to the system call starting with the @i'th argument
+ * (from 0 through 5).  Argument @i is stored in @args[0], and so on.
+ * An arch inline version is probably optimal when @i and @n are constants.
+ *
+ * It's only valid to call this when @task is stopped for tracing on
+ * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * It's invalid to call this with @i + @n > 6; we only support system calls
+ * taking up to 6 arguments.
+ */
+#define SYSCALL_MAX_ARGS 6
+void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			   unsigned int i, unsigned int n, unsigned long *args)
+{
+	if (n == 0)
+		return;
+	if (i + n > SYSCALL_MAX_ARGS) {
+		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
+		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
+		pr_warning("%s called with max args %d, handling only %d\n",
+			   __func__, i + n, SYSCALL_MAX_ARGS);
+		memset(args_bad, 0, n_bad * sizeof(args[0]));
+		memset(args_bad, 0, n_bad * sizeof(args[0]));
+	}
+
+	if (i == 0) {
+		args[0] = regs->orig_r0;
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(args, &regs->uregs[0] + i, n * sizeof(args[0]));
+}
+
+/**
+ * syscall_set_arguments - change system call parameter value
+ * @task:	task of interest, must be in system call entry tracing
+ * @regs:	task_pt_regs() of @task
+ * @i:		argument index [0,5]
+ * @n:		number of arguments; n+i must be [1,6].
+ * @args:	array of argument values to store
+ *
+ * Changes @n arguments to the system call starting with the @i'th argument.
+ * Argument @i gets value @args[0], and so on.
+ * An arch inline version is probably optimal when @i and @n are constants.
+ *
+ * It's only valid to call this when @task is stopped for tracing on
+ * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
+ * It's invalid to call this with @i + @n > 6; we only support system calls
+ * taking up to 6 arguments.
+ */
+void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+			   unsigned int i, unsigned int n,
+			   const unsigned long *args)
+{
+	if (n == 0)
+		return;
+
+	if (i + n > SYSCALL_MAX_ARGS) {
+		pr_warn("%s called with max args %d, handling only %d\n",
+			__func__, i + n, SYSCALL_MAX_ARGS);
+		n = SYSCALL_MAX_ARGS - i;
+	}
+
+	if (i == 0) {
+		regs->orig_r0 = args[0];
+		args++;
+		i++;
+		n--;
+	}
+
+	memcpy(&regs->uregs[0] + i, args, n * sizeof(args[0]));
+}
+#endif /* _ASM_NDS32_SYSCALL_H */
diff --git a/arch/nds32/include/asm/syscalls.h b/arch/nds32/include/asm/syscalls.h
new file mode 100644
index 0000000..bb0578a
--- /dev/null
+++ b/arch/nds32/include/asm/syscalls.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#ifndef __ASM_NDS32_SYSCALLS_H
+#define __ASM_NDS32_SYSCALLS_H
+
+asmlinkage long sys_cacheflush(unsigned long addr, unsigned long len, unsigned int op);
+asmlinkage long sys_fadvise64_64_wrapper(int fd, int advice, loff_t offset, loff_t len);
+asmlinkage long sys_rt_sigreturn_wrapper(void);
+
+#include <asm-generic/syscalls.h>
+
+#endif /* __ASM_NDS32_SYSCALLS_H */
diff --git a/arch/nds32/include/asm/unistd.h b/arch/nds32/include/asm/unistd.h
new file mode 100644
index 0000000..a66b8bb
--- /dev/null
+++ b/arch/nds32/include/asm/unistd.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#define __ARCH_WANT_SYS_CLONE
+
+#include <uapi/asm/unistd.h>
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
new file mode 100644
index 0000000..325ca3b
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#define __ARCH_WANT_SYNC_FILE_RANGE2
+
+/* Use the standard ABI for syscalls */
+#include <asm-generic/unistd.h>
+
+/* Additional NDS32 specific syscalls. */
+#define __NR_cacheflush		(__NR_arch_specific_syscall)
+#define __NR__llseek             __NR_llseek
+__SYSCALL(__NR_cacheflush, sys_cacheflush)
diff --git a/arch/nds32/kernel/ex-scall.S b/arch/nds32/kernel/ex-scall.S
new file mode 100644
index 0000000..0ad7833
--- /dev/null
+++ b/arch/nds32/kernel/ex-scall.S
@@ -0,0 +1,119 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+#include <asm/assembler.h>
+#include <asm/nds32.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/current.h>
+
+/*
+ * $r0 = previous task_struct,
+ * $r1 = next task_struct,
+ * previous and next are guaranteed not to be the same.
+ */
+
+ENTRY(__switch_to)
+
+	la	$p0, __entry_task
+	sw	$r1, [$p0]
+	move	$p1, $r0
+	addi	$p1, $p1, #THREAD_CPU_CONTEXT
+	smw.bi 	$r6, [$p1], $r14, #0xb		! push r6~r14, fp, lp, sp
+	move	$r25, $r1
+	addi	$r1, $r1, #THREAD_CPU_CONTEXT
+	lmw.bi 	$r6, [$r1], $r14, #0xb		! pop r6~r14, fp, lp, sp
+	ret
+
+/*
+ * These are the registers used in the syscall handler, and allow us
+ * to have in theory up to 6 arguments to a function - $r0 to $r5.
+ *
+ * We must set at least "tsk" and "tbl" when calling ret_with_reschedule.
+ */
+
+/*
+ * $r7 will be writen as syscall nr
+ * by retrieving from $ITYPE 'SWID' bitfiled
+ */
+	.macro	get_scno
+	lwi	$r7, [$sp + R15_OFFSET]
+	swi	$r7, [$sp + SYSCALLNO_OFFSET]
+	.endm
+
+	.macro	updateipc
+	addi	$r17, $r13, #4				! $r13 is $IPC
+	swi	$r17, [$sp + IPC_OFFSET]
+	.endm
+
+ENTRY(eh_syscall)
+	updateipc
+
+	get_scno
+	gie_enable
+
+ENTRY(eh_syscall_phase_2)
+	lwi	$p0, [tsk+#TSK_TI_FLAGS]		! check for syscall tracing
+
+	andi	$p1, $p0, #_TIF_WORK_SYSCALL_ENTRY	! are we tracing syscalls?
+	bnez	$p1, __sys_trace
+
+	la	$lp, ret_fast_syscall		! return address
+jmp_systbl:
+	addi	$p1, $r7, #-__NR_syscalls	! syscall number of syscall instruction is guarded by addembler
+	bgez	$p1, _SCNO_EXCEED		! call sys_* routine
+	la	tbl, sys_call_table		! load syscall table pointer
+	slli	$p1, $r7, #2
+	add	$p1, tbl, $p1
+	lwi	$p1, [$p1]
+	jr	$p1				! no return
+
+_SCNO_EXCEED:
+	movi	why, 0
+	ori	$r0, $r7, #0
+        ori	$r1, $sp, #0
+	b	bad_syscall
+
+/*
+ * This is the really slow path.  We're going to be doing
+ * context switches, and waiting for our parent to respond.
+ */
+__sys_trace:
+	move	$r1, $sp
+	move	$r0, $r7			! trace entry [IP = 0]
+	bal	syscall_trace_enter
+	move	$r7, $r0
+	la	$lp, __sys_trace_return		! return address
+
+	addi    $p1, $r7, #1
+	beqz    $p1, ret_slow_syscall		! fatal signal is pending
+
+	addi	$p1, $sp, #R0_OFFSET		! pointer to regs
+	lmw.bi	$r0, [$p1], $r5			! have to reload $r0 - $r5
+	b	jmp_systbl
+
+__sys_trace_return:
+	swi	$r0, [$sp+#R0_OFFSET]		! T: save returned $r0
+	move	$r0, $sp			! set pt_regs for syscall_trace_leave
+	bal	syscall_trace_leave
+	b	ret_slow_syscall
+
+ENTRY(sys_rt_sigreturn_wrapper)
+	addi	$r0, $sp, #0
+	b	sys_rt_sigreturn
+ENDPROC(sys_rt_sigreturn_wrapper)
diff --git a/arch/nds32/kernel/sys_nds32.c b/arch/nds32/kernel/sys_nds32.c
new file mode 100644
index 0000000..1900bbc
--- /dev/null
+++ b/arch/nds32/kernel/sys_nds32.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <linux/syscalls.h>
+
+#include <asm/uaccess.h>
+#include <asm/cachectl.h>
+#include <asm/proc-fns.h>
+
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+	       unsigned long, prot, unsigned long, flags,
+	       unsigned long, fd, unsigned long, pgoff)
+{
+	if (pgoff & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+			      pgoff >> (PAGE_SHIFT - 12));
+}
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+	       unsigned long, prot, unsigned long, flags,
+	       unsigned long, fd, unsigned long, pgoff)
+{
+	if (unlikely(pgoff & ~PAGE_MASK))
+		return -EINVAL;
+
+	return sys_mmap_pgoff(addr, len, prot, flags, fd,
+			      pgoff >> PAGE_SHIFT);
+}
+
+SYSCALL_DEFINE4(fadvise64_64_wrapper,int, fd, int, advice, loff_t, offset,
+					 loff_t, len)
+{
+	return sys_fadvise64_64(fd, offset, len, advice);
+}
+
+SYSCALL_DEFINE3(cacheflush, unsigned int, start, unsigned int, end, int, cache)
+{
+	struct vm_area_struct *vma;
+	bool flushi = true, wbd = true;
+
+	vma = find_vma(current->mm, start);
+	if (!vma)
+		return -EFAULT;
+	switch (cache) {
+	case ICACHE:
+		wbd = false;
+		break;
+	case DCACHE:
+		flushi = false;
+		break;
+	case BCACHE:
+		break;
+	default:
+		return -EINVAL;
+	}
+	cpu_cache_wbinval_range_check(vma, start, end, flushi, wbd);
+
+	return 0;
+}
diff --git a/arch/nds32/kernel/syscall_table.c b/arch/nds32/kernel/syscall_table.c
new file mode 100644
index 0000000..c1edc85
--- /dev/null
+++ b/arch/nds32/kernel/syscall_table.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
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
+#include <linux/syscalls.h>
+#include <linux/signal.h>
+#include <linux/unistd.h>
+#include <asm/syscalls.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call) [nr] = (call),
+
+#define sys_rt_sigreturn sys_rt_sigreturn_wrapper
+#define sys_fadvise64_64 sys_fadvise64_64_wrapper
+void *sys_call_table[__NR_syscalls] __aligned(8192) = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
1.7.9.5
