From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 05/11] x86: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:21 +0100
Message-ID: <1526318067-4964-6-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

This patch moves the x86-specific prctl call implementations out
of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/include/asm/processor.h |  6 ------
 arch/x86/kernel/Makefile         |  1 +
 arch/x86/kernel/sys.c            | 26 ++++++++++++++++++++++++++
 kernel/sys.c                     | 28 ----------------------------
 5 files changed, 28 insertions(+), 34 deletions(-)
 create mode 100644 arch/x86/kernel/sys.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492..7bae36a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -176,6 +176,7 @@ config X86
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PRCTL_ARCH
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 21a1149..0ecdda4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -924,18 +924,12 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 #define KSTK_EIP(task)		(task_pt_regs(task)->ip)
 
 /* Get/set a process' ability to use the timestamp counter instruction */
-#define GET_TSC_CTL(adr)	get_tsc_mode((adr))
-#define SET_TSC_CTL(val)	set_tsc_mode((val))
-
 extern int get_tsc_mode(unsigned long adr);
 extern int set_tsc_mode(unsigned int val);
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 /* Register/unregister a process' MPX related resource */
-#define MPX_ENABLE_MANAGEMENT()	mpx_enable_management()
-#define MPX_DISABLE_MANAGEMENT()	mpx_disable_management()
-
 #ifdef CONFIG_X86_INTEL_MPX
 extern int mpx_enable_management(void);
 extern int mpx_disable_management(void);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 02d6f5c..636e40d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
+obj-y			+= sys.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
diff --git a/arch/x86/kernel/sys.c b/arch/x86/kernel/sys.c
new file mode 100644
index 0000000..3be4d16
--- /dev/null
+++ b/arch/x86/kernel/sys.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/errno.h>
+#include <linux/prctl.h>
+#include <asm/processor.h>
+
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_GET_TSC:
+		return get_tsc_mode(arg2);
+	case PR_SET_TSC:
+		return set_tsc_mode(arg2);
+	case PR_MPX_ENABLE_MANAGEMENT:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		return mpx_enable_management();
+	case PR_MPX_DISABLE_MANAGEMENT:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		return mpx_disable_management();
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/kernel/sys.c b/kernel/sys.c
index 63228e7..994b5711 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -95,18 +95,6 @@
 #ifndef SET_ENDIAN
 # define SET_ENDIAN(a, b)	(-EINVAL)
 #endif
-#ifndef GET_TSC_CTL
-# define GET_TSC_CTL(a)		(-EINVAL)
-#endif
-#ifndef SET_TSC_CTL
-# define SET_TSC_CTL(a)		(-EINVAL)
-#endif
-#ifndef MPX_ENABLE_MANAGEMENT
-# define MPX_ENABLE_MANAGEMENT()	(-EINVAL)
-#endif
-#ifndef MPX_DISABLE_MANAGEMENT
-# define MPX_DISABLE_MANAGEMENT()	(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2314,12 +2302,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_SECCOMP:
 		error = prctl_set_seccomp(arg2, (char __user *)arg3);
 		break;
-	case PR_GET_TSC:
-		error = GET_TSC_CTL(arg2);
-		break;
-	case PR_SET_TSC:
-		error = SET_TSC_CTL(arg2);
-		break;
 	case PR_TASK_PERF_EVENTS_DISABLE:
 		error = perf_event_task_disable();
 		break;
@@ -2416,16 +2398,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
 		up_write(&me->mm->mmap_sem);
 		break;
-	case PR_MPX_ENABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_ENABLE_MANAGEMENT();
-		break;
-	case PR_MPX_DISABLE_MANAGEMENT:
-		if (arg2 || arg3 || arg4 || arg5)
-			return -EINVAL;
-		error = MPX_DISABLE_MANAGEMENT();
-		break;
 	default:
 		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
-- 
2.1.4
