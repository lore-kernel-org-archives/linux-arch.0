From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 15/18] arm64: ilp32: introduce ilp32-specific handlers for sigframe and ucontext
Date: Wed, 17 Aug 2016 14:46:40 +0300
Message-ID: <1471434403-25291-16-git-send-email-ynorov@caviumnetworks.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

From: Andrew Pinski <apinski@cavium.com>

ILP32 uses AARCH32 compat structures and syscall handlers for signals.
But ILP32 struct rt_sigframe  and ucontext differs from both LP64 and
AARCH32. So some specific mechanism is needed to take care of it.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_ilp32.h |  38 ++++++++
 arch/arm64/kernel/Makefile            |   3 +-
 arch/arm64/kernel/entry_ilp32.S       |  23 +++++
 arch/arm64/kernel/signal.c            |   3 +
 arch/arm64/kernel/signal_ilp32.c      | 171 ++++++++++++++++++++++++++++++++++
 5 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal_ilp32.c

diff --git a/arch/arm64/include/asm/signal_ilp32.h b/arch/arm64/include/asm/signal_ilp32.h
new file mode 100644
index 0000000..3c6d737
--- /dev/null
+++ b/arch/arm64/include/asm/signal_ilp32.h
@@ -0,0 +1,38 @@
+/*
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
+#include <asm/signal32_common.h>
+#include <asm/signal_common.h>
+
+#ifndef __ASM_SIGNAL_ILP32_H
+#define __ASM_SIGNAL_ILP32_H
+
+#ifdef CONFIG_ARM64_ILP32
+
+#include <linux/compat.h>
+
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs);
+
+#else
+
+static inline int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
+#endif /* __ASM_SIGNAL_ILP32_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 20e8e66..7038ffb 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,7 +27,8 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o 		\
+					   signal_ilp32.o entry_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o signal32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/entry_ilp32.S b/arch/arm64/kernel/entry_ilp32.S
new file mode 100644
index 0000000..5063172
--- /dev/null
+++ b/arch/arm64/kernel/entry_ilp32.S
@@ -0,0 +1,23 @@
+/*
+ * ILP32 system call wrappers
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
+
+ENTRY(ilp32_sys_rt_sigreturn_wrapper)
+	mov	x0, sp
+	b	ilp32_sys_rt_sigreturn
+ENDPROC(ilp32_sys_rt_sigreturn_wrapper)
+
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 5c73864..241bfeb 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -35,6 +35,7 @@
 #include <asm/signal32.h>
 #include <asm/vdso.h>
 #include <asm/signal_common.h>
+#include <asm/signal_ilp32.h>
 
 #define RT_SIGFRAME_FP_POS (offsetof(struct rt_sigframe, sig)	\
 			+ offsetof(struct sigframe, fp))
@@ -325,6 +326,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
 			ret = compat_setup_frame(usig, ksig, oldset, regs);
+	} else if (is_ilp32_compat_task()) {
+		ret = ilp32_setup_rt_frame(usig, ksig, oldset, regs);
 	} else {
 		ret = setup_rt_frame(usig, ksig, oldset, regs);
 	}
diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
new file mode 100644
index 0000000..7cc9122
--- /dev/null
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -0,0 +1,171 @@
+/*
+ * Based on arch/arm/kernel/signal.c
+ *
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 Cavium Networks.
+ * Yury Norov <ynorov@caviumnetworks.com>
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
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+#include <linux/ratelimit.h>
+
+#include <asm/esr.h>
+#include <asm/fpsimd.h>
+#include <asm/signal_ilp32.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ucontext.h>
+
+
+#define ILP32_RT_SIGFRAME_FP_POS (offsetof(struct ilp32_rt_sigframe, sig)	\
+			+ offsetof(struct ilp32_sigframe, fp))
+
+struct ilp32_ucontext {
+        u32		uc_flags;
+        u32		uc_link;
+        compat_stack_t  uc_stack;
+        compat_sigset_t uc_sigmask;
+        /* glibc uses a 1024-bit sigset_t */
+        __u8            __unused[1024 / 8 - sizeof(compat_sigset_t)];
+        /* last for future expansion */
+        struct sigcontext uc_mcontext;
+};
+
+struct ilp32_sigframe {
+	struct ilp32_ucontext uc;
+	u64 fp;
+	u64 lr;
+};
+
+struct ilp32_rt_sigframe {
+	struct compat_siginfo info;
+	struct ilp32_sigframe sig;
+};
+
+static int restore_ilp32_sigframe(struct pt_regs *regs,
+                            struct ilp32_sigframe __user *sf)
+{
+	sigset_t set;
+	int err;
+	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
+	if (err == 0)
+		set_current_blocked(&set);
+	err |= restore_sigcontext(regs, &sf->uc.uc_mcontext);
+	return err;
+}
+
+static int setup_ilp32_sigframe(struct ilp32_sigframe __user *sf,
+                          struct pt_regs *regs, sigset_t *set)
+{
+	int err = 0;
+	/* set up the stack frame for unwinding */
+	__put_user_error(regs->regs[29], &sf->fp, err);
+	__put_user_error(regs->regs[30], &sf->lr, err);
+
+	err |= put_sigset_t(&sf->uc.uc_sigmask, set);
+	err |= setup_sigcontext(&sf->uc.uc_mcontext, regs);
+	return err;
+}
+
+asmlinkage long ilp32_sys_rt_sigreturn(struct pt_regs *regs)
+{
+	struct ilp32_rt_sigframe __user *frame;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	/*
+	 * Since we stacked the signal on a 128-bit boundary,
+	 * then 'sp' should be word aligned here.  If it's
+	 * not, then the user is trying to mess with us.
+	 */
+	if (regs->sp & 15)
+		goto badframe;
+
+	frame = (struct ilp32_rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
+		goto badframe;
+
+	if (restore_ilp32_sigframe(regs, &frame->sig))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->sig.uc.uc_stack))
+		goto badframe;
+
+	return regs->regs[0];
+
+badframe:
+	if (show_unhandled_signals)
+		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
+				    current->comm, task_pid_nr(current), __func__,
+				    regs->pc, regs->sp);
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static struct ilp32_rt_sigframe __user *ilp32_get_sigframe(struct ksignal *ksig,
+					       struct pt_regs *regs)
+{
+	unsigned long sp, sp_top;
+	struct ilp32_rt_sigframe __user *frame;
+
+	sp = sp_top = sigsp(regs->sp, ksig);
+
+	sp = (sp - sizeof(struct ilp32_rt_sigframe)) & ~15;
+	frame = (struct ilp32_rt_sigframe __user *)sp;
+
+	/*
+	 * Check that we can actually write to the signal frame.
+	 */
+	if (!access_ok(VERIFY_WRITE, frame, sp_top - sp))
+		frame = NULL;
+
+	return frame;
+}
+
+/*
+ * ILP32 signal handling routines called from signal.c
+ */
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
+			  sigset_t *set, struct pt_regs *regs)
+{
+	struct ilp32_rt_sigframe __user *frame;
+	int err = 0;
+
+	frame = ilp32_get_sigframe(ksig, regs);
+
+	if (!frame)
+		return 1;
+
+	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
+
+	__put_user_error(0, &frame->sig.uc.uc_flags, err);
+	__put_user_error(0, &frame->sig.uc.uc_link, err);
+
+	err |= __compat_save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+	err |= setup_ilp32_sigframe(&frame->sig, regs, set);
+	if (err == 0) {
+		setup_return(regs, &ksig->ka, frame, ILP32_RT_SIGFRAME_FP_POS, usig);
+		regs->regs[1] = (unsigned long)&frame->info;
+		regs->regs[2] = (unsigned long)&frame->sig.uc;
+	}
+
+	return err;
+}
+
-- 
2.7.4

