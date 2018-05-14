From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 02/11] arm64: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:18 +0100
Message-ID: <1526318067-4964-3-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

This patch moves the arm64-specific prctl call implementations out
of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/processor.h |  4 ----
 arch/arm64/kernel/sys.c            | 15 +++++++++++++++
 kernel/sys.c                       | 12 ------------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..6b706af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -123,6 +123,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PRCTL_ARCH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7675989..b1d262f 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -244,9 +244,5 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
 void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
 
-/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
-#define SVE_SET_VL(arg)	sve_set_current_vl(arg)
-#define SVE_GET_VL()	sve_get_current_vl()
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 72981ba..597ff35 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -22,10 +22,12 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/export.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			 unsigned long prot, unsigned long flags,
@@ -45,6 +47,19 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	return sys_personality(personality);
 }
 
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_SVE_SET_VL:
+		return sve_set_current_vl(arg2);
+	case PR_SVE_GET_VL:
+		return sve_get_current_vl();
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Wrappers to pass the pt_regs argument.
  */
diff --git a/kernel/sys.c b/kernel/sys.c
index 5077f1e..f917d78 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -113,12 +113,6 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
-#ifndef SVE_SET_VL
-# define SVE_SET_VL(a)		(-EINVAL)
-#endif
-#ifndef SVE_GET_VL
-# define SVE_GET_VL()		(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2444,12 +2438,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
-	case PR_SVE_SET_VL:
-		error = SVE_SET_VL(arg2);
-		break;
-	case PR_SVE_GET_VL:
-		error = SVE_GET_VL();
-		break;
 	default:
 		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
-- 
2.1.4
