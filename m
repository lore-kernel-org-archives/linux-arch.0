From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 07/11] powerpc: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:23 +0100
Message-ID: <1526318067-4964-8-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-arch.vger.kernel.org

This patch moves the powerpc-specific prctl call implementations
out of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/include/asm/processor.h |  6 ------
 arch/powerpc/kernel/syscalls.c       | 17 +++++++++++++++++
 kernel/sys.c                         | 24 ------------------------
 4 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181..b94323e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -218,6 +218,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PRCTL_ARCH
 	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 313dec1..e1cd7ec 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -407,15 +407,9 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
 /* Get/set floating-point exception mode */
-#define GET_FPEXC_CTL(adr) get_fpexc_mode((adr))
-#define SET_FPEXC_CTL(val) set_fpexc_mode((val))
-
 extern int get_fpexc_mode(unsigned long adr);
 extern int set_fpexc_mode(unsigned int val);
 
-#define GET_ENDIAN(adr) get_endian((adr))
-#define SET_ENDIAN(val) set_endian((val))
-
 extern int get_endian(unsigned long adr);
 extern int set_endian(unsigned int val);
 
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 4662165..0d6a914 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -139,3 +139,20 @@ long sys_switch_endian(void)
 
 	return 0;
 }
+
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_SET_FPEXC:
+		return set_fpexc_mode(arg2);
+	case PR_GET_FPEXC:
+		return get_fpexc_mode(arg2);
+	case PR_GET_ENDIAN:
+		return get_endian(arg2);
+	case PR_SET_ENDIAN:
+		return set_endian(arg2);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/kernel/sys.c b/kernel/sys.c
index 44e1c47..b154561 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -83,18 +83,6 @@
 #ifndef GET_FPEMU_CTL
 # define GET_FPEMU_CTL(a, b)	(-EINVAL)
 #endif
-#ifndef SET_FPEXC_CTL
-# define SET_FPEXC_CTL(a, b)	(-EINVAL)
-#endif
-#ifndef GET_FPEXC_CTL
-# define GET_FPEXC_CTL(a, b)	(-EINVAL)
-#endif
-#ifndef GET_ENDIAN
-# define GET_ENDIAN(b)		(-EINVAL)
-#endif
-#ifndef SET_ENDIAN
-# define SET_ENDIAN(b)		(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2264,12 +2252,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FPEMU:
 		error = GET_FPEMU_CTL(me, arg2);
 		break;
-	case PR_SET_FPEXC:
-		error = SET_FPEXC_CTL(arg2);
-		break;
-	case PR_GET_FPEXC:
-		error = GET_FPEXC_CTL(arg2);
-		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
 		break;
@@ -2290,12 +2272,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
 			return -EFAULT;
 		break;
-	case PR_GET_ENDIAN:
-		error = GET_ENDIAN(arg2);
-		break;
-	case PR_SET_ENDIAN:
-		error = SET_ENDIAN(arg2);
-		break;
 	case PR_GET_SECCOMP:
 		error = prctl_get_seccomp();
 		break;
-- 
2.1.4
