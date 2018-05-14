From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 04/11] MIPS: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:20 +0100
Message-ID: <1526318067-4964-5-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

This patch moves the MIPS-specific prctl call implementations out
of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
---
 arch/mips/Kconfig                 |  1 +
 arch/mips/include/asm/processor.h |  3 ---
 arch/mips/kernel/syscall.c        | 14 ++++++++++++++
 kernel/sys.c                      | 12 ------------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 225c95d..99eb2ef 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -61,6 +61,7 @@ config MIPS
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
+	select HAVE_PRCTL_ARCH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 8f06608..4a8079a 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -420,7 +420,4 @@ extern int mips_get_process_fp_mode(struct task_struct *task);
 extern int mips_set_process_fp_mode(struct task_struct *task,
 				    unsigned int value);
 
-#define GET_FP_MODE()			mips_get_process_fp_mode()
-#define SET_FP_MODE(value)		mips_set_process_fp_mode(value)
-
 #endif /* _ASM_PROCESSOR_H */
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 15f33f0..aa8157c 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -35,6 +35,7 @@
 #include <asm/cachectl.h>
 #include <asm/cacheflush.h>
 #include <asm/asm-offsets.h>
+#include <asm/processor.h>
 #include <asm/signal.h>
 #include <asm/sim.h>
 #include <asm/shmparam.h>
@@ -237,6 +238,19 @@ SYSCALL_DEFINE3(cachectl, char *, addr, int, nbytes, int, op)
 	return -ENOSYS;
 }
 
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_SET_FP_MODE:
+		return mips_set_process_fp_mode(arg2);
+	case PR_GET_FP_MODE:
+		return mips_get_process_fp_mode();
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * If we ever come here the user sp is bad.  Zap the process right away.
  * Due to the bad stack signaling wouldn't work.
diff --git a/kernel/sys.c b/kernel/sys.c
index 520d2e8..63228e7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -107,12 +107,6 @@
 #ifndef MPX_DISABLE_MANAGEMENT
 # define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
 #endif
-#ifndef GET_FP_MODE
-# define GET_FP_MODE()		(-EINVAL)
-#endif
-#ifndef SET_FP_MODE
-# define SET_FP_MODE(a)		(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2432,12 +2426,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = MPX_DISABLE_MANAGEMENT();
 		break;
-	case PR_SET_FP_MODE:
-		error = SET_FP_MODE(arg2);
-		break;
-	case PR_GET_FP_MODE:
-		error = GET_FP_MODE();
-		break;
 	default:
 		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
-- 
2.1.4
