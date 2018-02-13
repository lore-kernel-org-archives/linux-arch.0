From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 23/37] nds32: Debugging support
Date: Tue, 13 Feb 2018 17:09:27 +0800
Message-ID: <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch adds ptrace support.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/uapi/asm/ptrace.h |  25 ++++++++
 arch/nds32/kernel/ptrace.c           | 119 +++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 arch/nds32/include/uapi/asm/ptrace.h
 create mode 100644 arch/nds32/kernel/ptrace.c

diff --git a/arch/nds32/include/uapi/asm/ptrace.h b/arch/nds32/include/uapi/asm/ptrace.h
new file mode 100644
index 000000000000..358c99e399d0
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/ptrace.h
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __UAPI_ASM_NDS32_PTRACE_H
+#define __UAPI_ASM_NDS32_PTRACE_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * User structures for general purpose register.
+ */
+struct user_pt_regs {
+	long uregs[26];
+	long fp;
+	long gp;
+	long lp;
+	long sp;
+	long ipc;
+	long lb;
+	long le;
+	long lc;
+	long syscallno;
+};
+#endif
+#endif
diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
new file mode 100644
index 000000000000..eaaf7a999b20
--- /dev/null
+++ b/arch/nds32/kernel/ptrace.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/ptrace.h>
+#include <linux/regset.h>
+#include <linux/tracehook.h>
+#include <linux/elf.h>
+#include <linux/sched/task_stack.h>
+
+enum nds32_regset {
+	REGSET_GPR,
+};
+
+static int gpr_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user * ubuf)
+{
+	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
+}
+
+static int gpr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user * ubuf)
+{
+	int err;
+	struct user_pt_regs newregs = task_pt_regs(target)->user_regs;
+
+	err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newregs, 0, -1);
+	if (err)
+		return err;
+
+	task_pt_regs(target)->user_regs = newregs;
+	return 0;
+}
+
+static const struct user_regset nds32_regsets[] = {
+	[REGSET_GPR] = {
+			.core_note_type = NT_PRSTATUS,
+			.n = sizeof(struct user_pt_regs) / sizeof(u32),
+			.size = sizeof(elf_greg_t),
+			.align = sizeof(elf_greg_t),
+			.get = gpr_get,
+			.set = gpr_set}
+};
+
+static const struct user_regset_view nds32_user_view = {
+	.name = "nds32",
+	.e_machine = EM_NDS32,
+	.regsets = nds32_regsets,
+	.n = ARRAY_SIZE(nds32_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &nds32_user_view;
+}
+
+void ptrace_disable(struct task_struct *child)
+{
+	user_disable_single_step(child);
+}
+
+/* do_ptrace()
+ *
+ * Provide ptrace defined service.
+ */
+long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
+		 unsigned long data)
+{
+	int ret = -EIO;
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
+void user_enable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs;
+	regs = task_pt_regs(child);
+	regs->ipsw |= PSW_mskHSS;
+	set_tsk_thread_flag(child, TIF_SINGLESTEP);
+}
+
+void user_disable_single_step(struct task_struct *child)
+{
+	struct pt_regs *regs;
+	regs = task_pt_regs(child);
+	regs->ipsw &= ~PSW_mskHSS;
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+}
+
+/* sys_trace()
+ *
+ * syscall trace handler.
+ */
+
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (tracehook_report_syscall_entry(regs))
+			forget_syscall(regs);
+	}
+	return regs->syscallno;
+}
+
+asmlinkage void syscall_trace_leave(struct pt_regs *regs)
+{
+	int step = test_thread_flag(TIF_SINGLESTEP);
+	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall_exit(regs, step);
+
+}
-- 
2.16.1
