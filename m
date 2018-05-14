From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 06/11] powerpc: Remove unused task argument from prctl functions
Date: Mon, 14 May 2018 18:14:22 +0100
Message-ID: <1526318067-4964-7-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-arch.vger.kernel.org

Some powerpc-specific prctl backends take a task argument that is
redundant, since the only thing ever passed is "current".

This patch gets rid of the redundant arguments.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h | 16 ++++++++--------
 arch/powerpc/kernel/process.c        | 30 +++++++++++++++---------------
 kernel/sys.c                         | 12 ++++++------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c4b36a4..313dec1 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -407,17 +407,17 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
 /* Get/set floating-point exception mode */
-#define GET_FPEXC_CTL(tsk, adr) get_fpexc_mode((tsk), (adr))
-#define SET_FPEXC_CTL(tsk, val) set_fpexc_mode((tsk), (val))
+#define GET_FPEXC_CTL(adr) get_fpexc_mode((adr))
+#define SET_FPEXC_CTL(val) set_fpexc_mode((val))
 
-extern int get_fpexc_mode(struct task_struct *tsk, unsigned long adr);
-extern int set_fpexc_mode(struct task_struct *tsk, unsigned int val);
+extern int get_fpexc_mode(unsigned long adr);
+extern int set_fpexc_mode(unsigned int val);
 
-#define GET_ENDIAN(tsk, adr) get_endian((tsk), (adr))
-#define SET_ENDIAN(tsk, val) set_endian((tsk), (val))
+#define GET_ENDIAN(adr) get_endian((adr))
+#define SET_ENDIAN(val) set_endian((val))
 
-extern int get_endian(struct task_struct *tsk, unsigned long adr);
-extern int set_endian(struct task_struct *tsk, unsigned int val);
+extern int get_endian(unsigned long adr);
+extern int set_endian(unsigned int val);
 
 #define GET_UNALIGN_CTL(tsk, adr)	get_unalign_ctl((tsk), (adr))
 #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13..0fcb2f5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1896,9 +1896,9 @@ EXPORT_SYMBOL(start_thread);
 #define PR_FP_ALL_EXCEPT (PR_FP_EXC_DIV | PR_FP_EXC_OVF | PR_FP_EXC_UND \
 		| PR_FP_EXC_RES | PR_FP_EXC_INV)
 
-int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
+int set_fpexc_mode(unsigned int val)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 
 	/* This is a bit hairy.  If we are an SPE enabled  processor
 	 * (have embedded fp) we store the IEEE exception enable flags in
@@ -1919,8 +1919,8 @@ int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 			 * anyway to restore the prctl settings from
 			 * the saved environment.
 			 */
-			tsk->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
-			tsk->thread.fpexc_mode = val &
+			current->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
+			current->thread.fpexc_mode = val &
 				(PR_FP_EXC_SW_ENABLE | PR_FP_ALL_EXCEPT);
 			return 0;
 		} else {
@@ -1938,18 +1938,18 @@ int set_fpexc_mode(struct task_struct *tsk, unsigned int val)
 	 * them does not change anything */
 	if (val > PR_FP_EXC_PRECISE)
 		return -EINVAL;
-	tsk->thread.fpexc_mode = __pack_fe01(val);
+	current->thread.fpexc_mode = __pack_fe01(val);
 	if (regs != NULL && (regs->msr & MSR_FP) != 0)
 		regs->msr = (regs->msr & ~(MSR_FE0|MSR_FE1))
-			| tsk->thread.fpexc_mode;
+			| current->thread.fpexc_mode;
 	return 0;
 }
 
-int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
+int get_fpexc_mode(unsigned long adr)
 {
 	unsigned int val;
 
-	if (tsk->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
+	if (current->thread.fpexc_mode & PR_FP_EXC_SW_ENABLE)
 #ifdef CONFIG_SPE
 		if (cpu_has_feature(CPU_FTR_SPE)) {
 			/*
@@ -1964,21 +1964,21 @@ int get_fpexc_mode(struct task_struct *tsk, unsigned long adr)
 			 * anyway to restore the prctl settings from
 			 * the saved environment.
 			 */
-			tsk->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
-			val = tsk->thread.fpexc_mode;
+			current->thread.spefscr_last = mfspr(SPRN_SPEFSCR);
+			val = current->thread.fpexc_mode;
 		} else
 			return -EINVAL;
 #else
 		return -EINVAL;
 #endif
 	else
-		val = __unpack_fe01(tsk->thread.fpexc_mode);
+		val = __unpack_fe01(current->thread.fpexc_mode);
 	return put_user(val, (unsigned int __user *) adr);
 }
 
-int set_endian(struct task_struct *tsk, unsigned int val)
+int set_endian(unsigned int val)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 
 	if ((val == PR_ENDIAN_LITTLE && !cpu_has_feature(CPU_FTR_REAL_LE)) ||
 	    (val == PR_ENDIAN_PPC_LITTLE && !cpu_has_feature(CPU_FTR_PPC_LE)))
@@ -1997,9 +1997,9 @@ int set_endian(struct task_struct *tsk, unsigned int val)
 	return 0;
 }
 
-int get_endian(struct task_struct *tsk, unsigned long adr)
+int get_endian(unsigned long adr)
 {
-	struct pt_regs *regs = tsk->thread.regs;
+	struct pt_regs *regs = current->thread.regs;
 	unsigned int val;
 
 	if (!cpu_has_feature(CPU_FTR_PPC_LE) &&
diff --git a/kernel/sys.c b/kernel/sys.c
index 994b5711..44e1c47 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -90,10 +90,10 @@
 # define GET_FPEXC_CTL(a, b)	(-EINVAL)
 #endif
 #ifndef GET_ENDIAN
-# define GET_ENDIAN(a, b)	(-EINVAL)
+# define GET_ENDIAN(b)		(-EINVAL)
 #endif
 #ifndef SET_ENDIAN
-# define SET_ENDIAN(a, b)	(-EINVAL)
+# define SET_ENDIAN(b)		(-EINVAL)
 #endif
 
 /*
@@ -2265,10 +2265,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = GET_FPEMU_CTL(me, arg2);
 		break;
 	case PR_SET_FPEXC:
-		error = SET_FPEXC_CTL(me, arg2);
+		error = SET_FPEXC_CTL(arg2);
 		break;
 	case PR_GET_FPEXC:
-		error = GET_FPEXC_CTL(me, arg2);
+		error = GET_FPEXC_CTL(arg2);
 		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
@@ -2291,10 +2291,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EFAULT;
 		break;
 	case PR_GET_ENDIAN:
-		error = GET_ENDIAN(me, arg2);
+		error = GET_ENDIAN(arg2);
 		break;
 	case PR_SET_ENDIAN:
-		error = SET_ENDIAN(me, arg2);
+		error = SET_ENDIAN(arg2);
 		break;
 	case PR_GET_SECCOMP:
 		error = prctl_get_seccomp();
-- 
2.1.4
