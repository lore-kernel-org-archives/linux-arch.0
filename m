From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 14/40] metag: Ptrace
Date: Wed, 31 Oct 2012 16:13:55 +0000
Message-ID: <1351700061-7203-15-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:31270 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935780Ab2JaQPR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:17 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

We use the non-generic interface at the moment (exposing the TBX context
structures to userland), pending conversion to the generic ptrace
interface.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/include/asm/hw_breakpoints.h |   30 ++
 arch/metag/include/asm/ptrace.h         |   50 +++
 arch/metag/kernel/hw_breakpoints.c      |  102 +++++++
 arch/metag/kernel/ptrace.c              |  503 +++++++++++++++++++++++++++++++
 4 files changed, 685 insertions(+), 0 deletions(-)
 create mode 100644 arch/metag/include/asm/hw_breakpoints.h
 create mode 100644 arch/metag/include/asm/ptrace.h
 create mode 100644 arch/metag/kernel/hw_breakpoints.c
 create mode 100644 arch/metag/kernel/ptrace.c

diff --git a/arch/metag/include/asm/hw_breakpoints.h b/arch/metag/include/asm/hw_breakpoints.h
new file mode 100644
index 0000000..80c46ac
--- /dev/null
+++ b/arch/metag/include/asm/hw_breakpoints.h
@@ -0,0 +1,30 @@
+#ifndef __HW_BREAKPOINT_H__
+#define __HW_BREAKPOINT_H__
+
+enum {
+	META_HWBP_CONT_REGS_BASE = CODEB0ADDR,
+	META_HWBP_CONT_REGS_STRIDE = 8,
+	META_HWBP_CONT_REGS_COUNT = 20,
+	META_HWBP_WRITTEN = 1,
+	META_HWBP_DATA_END = -1
+};
+
+#ifdef __KERNEL__
+
+struct meta_hw_breakpoint_item {
+	unsigned long ctx;
+	unsigned int next;
+};
+
+struct meta_hw_breakpoint {
+	struct meta_hw_breakpoint_item bp[META_HWBP_CONT_REGS_COUNT];
+	unsigned int written, start;
+};
+
+struct meta_hw_breakpoint *create_hwbp(void);
+void setup_hwbp_controller(struct meta_hw_breakpoint *hwbp);
+void restore_hwbp_controller(struct meta_hw_breakpoint *hwbp);
+
+#endif
+
+#endif /* __HW_BREAKPOINT_H__ */
diff --git a/arch/metag/include/asm/ptrace.h b/arch/metag/include/asm/ptrace.h
new file mode 100644
index 0000000..2d29ad0
--- /dev/null
+++ b/arch/metag/include/asm/ptrace.h
@@ -0,0 +1,50 @@
+#ifndef _METAG_PTRACE_H
+#define _METAG_PTRACE_H
+
+#define METAG_ALL_VALUES
+#define METAC_ALL_VALUES
+#include <asm/tbx/machine.inc>
+#include <asm/tbx/metagtbx.h>
+
+#define PTRACE_GETREGS			12
+#define PTRACE_SETREGS			13
+/* x86 use the below numbers */
+#define PTRACE_GETFPREGS		14
+#define PTRACE_SETFPREGS		15
+/* 16 & 17 are earmarked by generic as PTRACE_ATTACH/DETACH respectively */
+
+#define PTRACE_CLEAR_BP			-1
+#define PTRACE_PEEK_BP			100
+#define PTRACE_POKE_BP			101
+#define PTRACE_GETEXTREGS		102
+#define PTRACE_SETEXTREGS		103
+
+
+
+#ifndef __ASSEMBLY__
+
+/* this struct defines the way the registers are stored on the
+   stack during a system call. */
+
+struct pt_regs {
+	TBICTX ctx;
+	TBICTXEXTCB0 extcb0[5];
+};
+
+#ifdef __KERNEL__
+
+#define user_mode(regs) (((regs)->ctx.SaveMask & TBICTX_PRIV_BIT) > 0)
+
+#define instruction_pointer(regs) ((unsigned long)(regs)->ctx.CurrPC)
+#define profile_pc(regs) instruction_pointer(regs)
+
+#define task_pt_regs(task) \
+	((struct pt_regs *)(task_stack_page(task) + \
+			    sizeof(struct thread_info)))
+
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_leave(struct pt_regs *regs);
+
+#endif /* __KERNEL__ */
+#endif /* __ASSEMBLY__ */
+#endif /* _METAG_PTRACE_H */
diff --git a/arch/metag/kernel/hw_breakpoints.c b/arch/metag/kernel/hw_breakpoints.c
new file mode 100644
index 0000000..bd44b58
--- /dev/null
+++ b/arch/metag/kernel/hw_breakpoints.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2005,2006,2007,2008,2010,2012 Imagination Technologies Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <asm/hw_breakpoints.h>
+
+/*
+ * Allocate and initialise a breakpoint control block
+ */
+struct meta_hw_breakpoint *create_hwbp(void)
+{
+	struct meta_hw_breakpoint *temp;
+
+	temp = kzalloc(sizeof(struct meta_hw_breakpoint), GFP_KERNEL);
+	if (temp)
+		temp->start = META_HWBP_DATA_END;
+
+	return temp;
+}
+
+/*
+ * Sets up the hardware breakpoint controller
+ * only write to the registers that we have data for
+ * having first saved what was there before
+ */
+void setup_hwbp_controller(struct meta_hw_breakpoint *hwbp)
+{
+	unsigned long address, temp;
+	unsigned int reg;
+
+	reg = hwbp->start;
+	while (reg != META_HWBP_DATA_END) {
+		address = (META_HWBP_CONT_REGS_BASE +
+			   (META_HWBP_CONT_REGS_STRIDE * reg));
+		temp = readl(address);
+		writel(hwbp->bp[reg].ctx, address);
+		hwbp->bp[reg].ctx = temp;
+		hwbp->written |= META_HWBP_WRITTEN;
+		reg = hwbp->bp[reg].next;
+	}
+}
+
+/*
+ * Restores the hw break controller to it's original condition
+ * Only restore if we've previously written to it
+ * and only restore the registers we wrote to
+ * Save the current state of the controller before restoring the original values
+ */
+void restore_hwbp_controller(struct meta_hw_breakpoint *hwbp)
+{
+	unsigned long address, temp;
+	unsigned int reg;
+
+	reg = hwbp->start;
+	while (reg != META_HWBP_DATA_END) {
+		address = (META_HWBP_CONT_REGS_BASE +
+			   (META_HWBP_CONT_REGS_STRIDE * reg));
+		temp = readl(address);
+		writel(hwbp->bp[reg].ctx, address);
+		hwbp->bp[reg].ctx = temp;
+		reg = hwbp->bp[reg].next;
+	}
+	hwbp->written &= ~META_HWBP_WRITTEN;
+}
+
+/*
+ * Clear the hardware breakpoint controller by
+ * writing the original values back to it
+ * We only restore the registers we've disturbed
+ * And free the breakpoint data
+ */
+static void clear_hwbp_controller(struct meta_hw_breakpoint *hwbp)
+{
+	unsigned long address;
+	unsigned int reg;
+
+	if (hwbp) {
+		reg = hwbp->start;
+		while (reg != META_HWBP_DATA_END) {
+			address = (META_HWBP_CONT_REGS_BASE +
+				   (META_HWBP_CONT_REGS_STRIDE * reg));
+			writel(hwbp->bp[reg].ctx, address);
+			reg = hwbp->bp[reg].next;
+		}
+		kfree(hwbp);
+	}
+}
+
+/*
+ * Hook into the exit function to clear the breakpoint controller
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	struct meta_hw_breakpoint *hwbp = tsk->thread.hwbp_context;
+
+	tsk->thread.hwbp_context = NULL;
+	clear_hwbp_controller(hwbp);
+}
diff --git a/arch/metag/kernel/ptrace.c b/arch/metag/kernel/ptrace.c
new file mode 100644
index 0000000..d9cc60f
--- /dev/null
+++ b/arch/metag/kernel/ptrace.c
@@ -0,0 +1,503 @@
+/*
+ *  Copyright (C) 2005,2006,2007,2008,2009,2012 Imagination Technologies Ltd.
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of
+ * this archive for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/ptrace.h>
+#include <linux/user.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+#include <linux/uaccess.h>
+#include <trace/syscall.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+enum metag_regset {
+	REGSET_GENERAL,
+	REGSET_FP,
+	REGSET_EXT,
+};
+
+
+/*
+ * Read 32-bit data from bp context in the task struct
+ */
+static int ptrace_read_bp(struct task_struct *tsk, unsigned long addr,
+			    unsigned long __user *data)
+{
+	unsigned long tmp = 0;
+
+	if (tsk->thread.hwbp_context)
+		tmp = tsk->thread.hwbp_context->bp[addr].ctx;
+
+	return put_user(tmp, data);
+}
+
+/*
+ * Write 32-bit data to bp context in the task struct
+ * creating the struct if required
+ * return 0 success, 1 on fail
+ */
+static int ptrace_write_bp(struct task_struct *tsk, unsigned long addr,
+			     unsigned long data)
+{
+
+	if (!tsk->thread.hwbp_context) {
+		tsk->thread.hwbp_context = create_hwbp();
+		if (!tsk->thread.hwbp_context)
+			return 1;
+	}
+
+	if (addr == PTRACE_CLEAR_BP) {
+		tsk->thread.hwbp_context->start = META_HWBP_DATA_END;
+		return 0;
+	 }
+
+	tsk->thread.hwbp_context->bp[addr].next = tsk->thread.hwbp_context->start;
+	tsk->thread.hwbp_context->start = addr;
+	tsk->thread.hwbp_context->bp[addr].ctx = data;
+	return 0;
+}
+
+/*
+ * Read an actual register from the tast_struct area.
+ */
+static int __peek_user(struct task_struct *task, int offset)
+{
+	int *regp;
+
+	/* Find stored regblock in stack after task struct */
+	regp = (int *) (task_pt_regs(task));
+
+	/* Align to 8 bytes - Meta stacks are always 8byte aligned */
+	regp = (int *) (((int) regp + 7) & ~7UL);
+
+	return *(int *) ((int) regp + offset);
+}
+
+/*
+ * Write contents of register REGNO in task TASK.
+ */
+static int __poke_user(struct task_struct *task, int offset, unsigned long data)
+{
+	int *regp;
+
+	/* Find stored regblock in stack after task struct */
+	regp = (int *) (task_pt_regs(task));
+
+	/* Align to 8 bytes - Meta stacks are always 8byte aligned */
+	regp = (int *) (((int) regp + 7) & ~7UL);
+
+	*(int *) ((int) regp + offset) = (int) data;
+	return 0;
+}
+
+
+/*
+ * Called by kernel/ptrace.c when detaching..
+ *
+ * Make sure single step bits etc are not set.
+ */
+void ptrace_disable(struct task_struct *child)
+{
+	/* nothing to do.. */
+}
+
+/*
+ * Read the word at offset "off" into the "struct user".  We
+ * actually access the pt_regs stored on the kernel stack.
+ */
+static int ptrace_read_user(struct task_struct *tsk, unsigned long off,
+			    unsigned long __user *data)
+{
+	unsigned long tmp = 0;
+
+	if (off & 3)
+		return -EIO;
+
+	if (off < sizeof(struct pt_regs))
+		tmp = __peek_user(tsk, off);
+
+	return put_user(tmp, data);
+}
+
+static int ptrace_write_user(struct task_struct *tsk, unsigned long off,
+			     unsigned long data)
+{
+	int ret = -EIO;
+
+	if (off & 3)
+		return -EIO;
+
+	if (off < sizeof(struct pt_regs)) {
+		if (__poke_user(tsk, off, data))
+			return -EIO;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * user_regset definitions.
+ */
+
+static int metag_regs_get(struct task_struct *target,
+			  const struct user_regset *regset,
+			  unsigned int pos, unsigned int count,
+			  void *kbuf, void __user *ubuf)
+{
+	if (kbuf) {
+		unsigned long *k = kbuf;
+		while (count > 0) {
+			*k++ = __peek_user(target, pos);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		unsigned long __user *u = ubuf;
+		while (count > 0) {
+			if (__put_user(__peek_user(target, pos), u++))
+				return -EFAULT;
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+	return 0;
+}
+
+static int metag_regs_set(struct task_struct *target,
+			  const struct user_regset *regset,
+			  unsigned int pos, unsigned int count,
+			  const void *kbuf, const void __user *ubuf)
+{
+	int rc = 0;
+
+	if (kbuf) {
+		const unsigned long *k = kbuf;
+		while (count > 0 && !rc) {
+			rc = __poke_user(target, pos, *k++);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		const unsigned long  __user *u = ubuf;
+		while (count > 0 && !rc) {
+			unsigned long word;
+			rc = __get_user(word, u++);
+			if (rc)
+				break;
+			rc = __poke_user(target, pos, word);
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+
+	return rc;
+}
+
+#ifdef CONFIG_META_DSP
+/*
+ * Expand the saved TBI extended context into a kernel extended context
+ * structure. This makes it easier to process by userspace applications.
+ */
+static void expand_ext_context(int flags, struct meta_ext_context *in,
+			       struct meta_ext_context *out)
+{
+	/*
+	 * We assume that the following flags are set:
+	 *
+	 * TBICTX_XEXT_BIT - if this wasn't then we'd not have an extended
+	 *      context to expand.
+	 * TBICTX_XMCC_BIT - a bit set to signify that this task is a MECC
+	 *      task, however has no real use in the kernel.
+	 *
+	 * However, if the extended context bit is not set, then silently
+	 * leave.
+	 */
+	unsigned char *pos = (unsigned char *)in;
+
+	if (!(flags & TBICTX_XEXT_BIT))
+		return;
+
+	/* Copy the TBICTX_XEXT context */
+	memcpy(&(out->regs.ctx), pos, sizeof(TBIEXTCTX));
+	pos += sizeof(TBIEXTCTX);
+
+	/* Copy the TBICTX_XDX8 registers */
+	if (flags & TBICTX_XDX8_BIT) {
+		memcpy(&(out->regs.bb8), pos, sizeof(TBICTXEXTBB8));
+		pos += sizeof(TBICTXEXTBB8);
+	}
+
+	/* Ax.4 -> Ax.7 context */
+	if (flags & TBICTX_XAXX_BIT) {
+		memcpy(&(out->regs.ax[0]), pos, TBICTXEXTAXX_BYTES);
+		pos += TBICTXEXTAXX_BYTES;
+	}
+
+	/* Hardware loop */
+	if (flags & TBICTX_XHL2_BIT) {
+		memcpy(&(out->regs.hl2), pos, sizeof(TBICTXEXTHL2));
+		pos += sizeof(TBICTXEXTHL2);
+	}
+
+	/* Per-thread DSP registers */
+	if (flags & TBICTX_XTDP_BIT) {
+		memcpy(&(out->regs.ext), pos, sizeof(TBICTXEXTTDPR));
+		pos += sizeof(TBICTXEXTTDPR);
+	}
+
+	/*
+	 * There are two pointer variables in the meta_dsp_context which are
+	 * of no immediate interest to us at this moment in time:
+	 *      void *ram[2], and
+	 *      unsigned int ram_sz[2].
+	 * These describe the address and size of the DSP RAMs used in the
+	 * task - whether they are useful is a poignant question.
+	 */
+}
+
+static int metag_ext_ctx_get(struct task_struct *target,
+			  const struct user_regset *regset,
+			  unsigned int pos, unsigned int count,
+			  void *kbuf, void __user *ubuf)
+{
+	unsigned long dsp_size = sizeof(struct meta_ext_context);
+	struct meta_ext_context *dsp_ctx;
+	int ret = 0;
+
+	if (target->thread.dsp_context) {
+		dsp_ctx = kzalloc(dsp_size, GFP_KERNEL);
+		if (!dsp_ctx) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		/* Expand the DSP context if necessary */
+		expand_ext_context((target->thread.user_flags >> 16),
+				target->thread.dsp_context, dsp_ctx);
+		if (kbuf) {
+			unsigned long *k = kbuf;
+			memcpy(k, dsp_ctx, dsp_size);
+		} else {
+			unsigned long __user *u = ubuf;
+			ret = copy_to_user(u, dsp_ctx, dsp_size);
+			if (ret)
+				ret = -EFAULT;
+		}
+		kfree(dsp_ctx);
+	}
+out:
+	return ret;
+}
+
+static int compress_ext_context(unsigned int flags, struct meta_ext_context *in,
+				unsigned char *out)
+{
+	/* No extended flag set, no point to compress the context */
+	if (!(flags & TBICTX_XEXT_BIT))
+		return -EINVAL;
+
+	/* No need to copy XEXT struct, as it's already in place */
+	memcpy(out, &(in->regs.ctx), sizeof(TBIEXTCTX));
+	out += sizeof(TBIEXTCTX);
+
+	/* Copy the TBICTX_XDX8 registers */
+	if (flags & TBICTX_XDX8_BIT) {
+		memcpy(out, &(in->regs.bb8), sizeof(TBICTXEXTBB8));
+		out += sizeof(TBICTXEXTBB8);
+	}
+
+	/* Ax.4 -> Ax.7 context */
+	if (flags & TBICTX_XAXX_BIT) {
+		memcpy(out, &(in->regs.ax[0]), TBICTXEXTAXX_BYTES);
+		out += TBICTXEXTAXX_BYTES;
+	}
+
+	/* Hardware loop */
+	if (flags & TBICTX_XHL2_BIT) {
+		memcpy(out, &(in->regs.hl2), sizeof(TBICTXEXTHL2));
+		out += sizeof(TBICTXEXTHL2);
+	}
+
+	/* Per-thread DSP registers */
+	if (flags & TBICTX_XTDP_BIT) {
+		memcpy(out, &(in->regs.ext), sizeof(TBICTXEXTTDPR));
+		out += sizeof(TBICTXEXTTDPR);
+	}
+
+	return 0;
+}
+
+static int metag_ext_ctx_set(struct task_struct *target,
+		  const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	struct meta_ext_context *dsp_ctx = NULL;
+	const unsigned int dsp_size = sizeof(struct meta_ext_context);
+	unsigned int flags;
+	int ret = 0;
+
+	if (!target->thread.dsp_context) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* get a temporary context made */
+	dsp_ctx = kzalloc(dsp_size, GFP_KERNEL);
+	if (!dsp_ctx) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	if (kbuf) {
+		const unsigned long *k = kbuf;
+		memcpy(dsp_ctx, k, dsp_size);
+	} else {
+		const unsigned long  __user *u = ubuf;
+		if (!access_ok(VERIFY_READ, u, dsp_size)) {
+			ret = -EFAULT;
+			goto err;
+		}
+		copy_from_user(dsp_ctx, u, dsp_size);
+	}
+
+	/* Compress into the thread extended context */
+	flags = (target->thread.user_flags >> 16);
+	compress_ext_context(flags, dsp_ctx,
+			(unsigned char *)target->thread.dsp_context);
+
+err:
+	kfree(dsp_ctx);
+
+done:
+	return ret;
+}
+#endif
+
+static const struct user_regset metag_regsets[] = {
+	[REGSET_GENERAL] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = sizeof(struct pt_regs) / sizeof(long),
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.get = metag_regs_get,
+		.set = metag_regs_set,
+	},
+#ifdef CONFIG_META_DSP
+	[REGSET_EXT] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = sizeof(struct meta_ext_context) / sizeof(long),
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.get = metag_ext_ctx_get,
+		.set = metag_ext_ctx_set,
+	},
+#endif
+};
+
+static const struct user_regset_view user_metag_view = {
+	.name = "metag",
+	.e_machine = EM_METAG,
+	.regsets = metag_regsets,
+	.n = ARRAY_SIZE(metag_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_metag_view;
+}
+
+long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
+		 unsigned long data)
+{
+	int ret;
+	unsigned long __user *datap = (void __user *)data;
+
+	switch (request) {
+	/*
+	 * read the word at location addr in the USER area.
+	 */
+	case PTRACE_PEEKUSR:
+		ret = ptrace_read_user(child, addr, datap);
+		break;
+
+	/*
+	 * write the word at location addr in the USER area.
+	 */
+	case PTRACE_POKEUSR:
+		ret = ptrace_write_user(child, addr, data);
+		break;
+
+	case PTRACE_PEEK_BP:
+		ret = ptrace_read_bp(child, addr, datap);
+		break;
+
+	case PTRACE_POKE_BP:
+		ret = ptrace_write_bp(child, addr, data);
+		break;
+
+	case PTRACE_GETREGS:	/* Get all gp regs from the child. */
+		return copy_regset_to_user(child, &user_metag_view,
+					   REGSET_GENERAL,
+					   0, sizeof(struct pt_regs),
+					   (void __user *)datap);
+
+	case PTRACE_SETREGS:	/* Set all gp regs in the child. */
+		return copy_regset_from_user(child, &user_metag_view,
+					     REGSET_GENERAL,
+					     0, sizeof(struct pt_regs),
+					     (const void __user *)datap);
+
+#ifdef CONFIG_META_DSP
+	case PTRACE_GETEXTREGS:	/* Get all extended context regs */
+		return copy_regset_to_user(child, &user_metag_view,
+				REGSET_EXT, 0, sizeof(struct meta_ext_context),
+				(void __user *)datap);
+		break;
+
+	case PTRACE_SETEXTREGS:	/* Set all gp regs in the child. */
+		return copy_regset_from_user(child, &user_metag_view,
+				REGSET_EXT, 0, sizeof(struct meta_ext_context),
+				(const void __user *)datap);
+		break;
+#endif
+
+	default:
+		ret = ptrace_request(child, request, addr, data);
+		break;
+	}
+
+	return ret;
+}
+
+int syscall_trace_enter(struct pt_regs *regs)
+{
+	int ret = 0;
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		ret = tracehook_report_syscall_entry(regs);
+
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_enter(regs, regs->ctx.DX[0].U1);
+
+	return ret ? 0 : regs->ctx.DX[0].U1;
+}
+
+void syscall_trace_leave(struct pt_regs *regs)
+{
+	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_exit(regs, regs->ctx.DX[0].U1);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, 0);
+}
-- 
1.7.7.6
