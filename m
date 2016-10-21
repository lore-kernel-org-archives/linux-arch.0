From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 13/18] arm64: signal: share lp64 signal routines to ilp32
Date: Fri, 21 Oct 2016 23:33:12 +0300
Message-ID: <1477081997-4770-14-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, ynorov@caviumnetworks.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

After that, it will be possible to reuse it in ilp32.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
---
 arch/arm64/include/asm/signal_common.h | 33 ++++++++++++
 arch/arm64/kernel/signal.c             | 93 +++++++++++++++++++++-------------
 2 files changed, 92 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal_common.h

diff --git a/arch/arm64/include/asm/signal_common.h b/arch/arm64/include/asm/signal_common.h
new file mode 100644
index 0000000..756ed2c
--- /dev/null
+++ b/arch/arm64/include/asm/signal_common.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2016 Cavium Networks.
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
+#ifndef __ASM_SIGNAL_COMMON_H
+#define __ASM_SIGNAL_COMMON_H
+
+#include <linux/uaccess.h>
+#include <asm/ucontext.h>
+#include <asm/fpsimd.h>
+
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx);
+int restore_fpsimd_context(struct fpsimd_context __user *ctx);
+int setup_sigcontext(struct sigcontext __user *uc_mcontext, struct pt_regs *regs);
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sf);
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			void __user *frame, off_t sigframe_off, int usig);
+
+#endif /* __ASM_SIGNAL_COMMON_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f90cdf5..478d6c5 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -34,18 +34,26 @@
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
+#include <asm/signal_common.h>
+
+#define RT_SIGFRAME_FP_POS (offsetof(struct rt_sigframe, sig)	\
+			+ offsetof(struct sigframe, fp))
+
+struct sigframe {
+	struct ucontext uc;
+	u64 fp;
+	u64 lr;
+};
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
  */
 struct rt_sigframe {
 	struct siginfo info;
-	struct ucontext uc;
-	u64 fp;
-	u64 lr;
+	struct sigframe sig;
 };
 
-static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
 	int err;
@@ -65,7 +73,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct fpsimd_state fpsimd;
 	__u32 magic, size;
@@ -93,22 +101,30 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 }
 
 static int restore_sigframe(struct pt_regs *regs,
-			    struct rt_sigframe __user *sf)
+			    struct sigframe __user *sf)
 {
 	sigset_t set;
-	int i, err;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-
+	int err;
 	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
 	if (err == 0)
 		set_current_blocked(&set);
 
+	err |= restore_sigcontext(regs, &sf->uc.uc_mcontext);
+	return err;
+}
+
+
+int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *uc_mcontext)
+{
+	int i, err = 0;
+	void *aux = uc_mcontext->__reserved;
+
 	for (i = 0; i < 31; i++)
-		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+		__get_user_error(regs->regs[i], &uc_mcontext->regs[i],
 				 err);
-	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+	__get_user_error(regs->sp, &uc_mcontext->sp, err);
+	__get_user_error(regs->pc, &uc_mcontext->pc, err);
+	__get_user_error(regs->pstate, &uc_mcontext->pstate, err);
 
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
@@ -145,10 +161,10 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
 		goto badframe;
 
-	if (restore_sigframe(regs, frame))
+	if (restore_sigframe(regs, &frame->sig))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_altstack(&frame->sig.uc.uc_stack))
 		goto badframe;
 
 	return regs->regs[0];
@@ -162,27 +178,36 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
-static int setup_sigframe(struct rt_sigframe __user *sf,
+static int setup_sigframe(struct sigframe __user *sf,
 			  struct pt_regs *regs, sigset_t *set)
 {
-	int i, err = 0;
-	void *aux = sf->uc.uc_mcontext.__reserved;
-	struct _aarch64_ctx *end;
+	int err = 0;
 
 	/* set up the stack frame for unwinding */
 	__put_user_error(regs->regs[29], &sf->fp, err);
 	__put_user_error(regs->regs[30], &sf->lr, err);
+	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+	err |= setup_sigcontext(&sf->uc.uc_mcontext, regs);
+
+	return err;
+}
+
+int setup_sigcontext(struct sigcontext __user *uc_mcontext,
+			struct pt_regs *regs)
+{
+	void *aux = uc_mcontext->__reserved;
+	struct _aarch64_ctx *end;
+	int i, err = 0;
 
 	for (i = 0; i < 31; i++)
-		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+		__put_user_error(regs->regs[i], &uc_mcontext->regs[i],
 				 err);
-	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
 
-	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
+	__put_user_error(regs->sp, &uc_mcontext->sp, err);
+	__put_user_error(regs->pc, &uc_mcontext->pc, err);
+	__put_user_error(regs->pstate, &uc_mcontext->pstate, err);
 
-	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
+	__put_user_error(current->thread.fault_address, &uc_mcontext->fault_address, err);
 
 	if (err == 0) {
 		struct fpsimd_context *fpsimd_ctx =
@@ -229,14 +254,14 @@ static struct rt_sigframe __user *get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
-			 void __user *frame, int usig)
+void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			 void __user *frame, off_t fp_pos, int usig)
 {
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
 	regs->sp = (unsigned long)frame;
-	regs->regs[29] = regs->sp + offsetof(struct rt_sigframe, fp);
+	regs->regs[29] = regs->sp + fp_pos;
 	regs->pc = (unsigned long)ka->sa.sa_handler;
 
 	if (ka->sa.sa_flags & SA_RESTORER)
@@ -257,17 +282,17 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	if (!frame)
 		return 1;
 
-	__put_user_error(0, &frame->uc.uc_flags, err);
-	__put_user_error(NULL, &frame->uc.uc_link, err);
+	__put_user_error(0, &frame->sig.uc.uc_flags, err);
+	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
 
-	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(frame, regs, set);
+	err |= __save_altstack(&frame->sig.uc.uc_stack, regs->sp);
+	err |= setup_sigframe(&frame->sig, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, frame, usig);
+		setup_return(regs, &ksig->ka, frame, RT_SIGFRAME_FP_POS, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
-			regs->regs[2] = (unsigned long)&frame->uc;
+			regs->regs[2] = (unsigned long)&frame->sig.uc;
 		}
 	}
 
-- 
2.7.4
