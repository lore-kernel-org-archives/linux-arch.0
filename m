From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 09/11] ia64: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:25 +0100
Message-ID: <1526318067-4964-10-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
List-Id: linux-arch.vger.kernel.org

This patch moves the ia64-specific prctl call implementations out
of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/Kconfig                 |  1 +
 arch/ia64/include/asm/processor.h | 12 ------------
 arch/ia64/kernel/sys_ia64.c       | 22 ++++++++++++++++++++++
 kernel/sys.c                      | 12 ------------
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index bbe12a0..a673dd7 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -54,6 +54,7 @@ config IA64
 	select MODULES_USE_ELF_RELA
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_PRCTL_ARCH
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 0489b80..e40242e 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -259,18 +259,6 @@ typedef struct {
 		 (int __user *) (addr));							\
 })
 
-#define SET_FPEMU_CTL(value)									\
-({												\
-	current->thread.flags = ((current->thread.flags & ~IA64_THREAD_FPEMU_MASK)		\
-			  | (((value) << IA64_THREAD_FPEMU_SHIFT) & IA64_THREAD_FPEMU_MASK));	\
-	0;											\
-})
-#define GET_FPEMU_CTL(addr)									\
-({												\
-	put_user((current->thread.flags & IA64_THREAD_FPEMU_MASK) >> IA64_THREAD_FPEMU_SHIFT,	\
-		 (int __user *) (addr));							\
-})
-
 struct thread_struct {
 	__u32 flags;			/* various thread flags (see IA64_THREAD_*) */
 	/* writing on_ustack is performance-critical, so it's worth spending 8 bits on it... */
diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index 9ebe1d6..d996585 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -15,11 +15,13 @@
 #include <linux/sched/task_stack.h>
 #include <linux/shm.h>
 #include <linux/file.h>		/* doh, must come after sched.h... */
+#include <liunx/prctl.h>
 #include <linux/smp.h>
 #include <linux/syscalls.h>
 #include <linux/highuid.h>
 #include <linux/hugetlb.h>
 
+#include <asm/processor.h>
 #include <asm/shmparam.h>
 #include <linux/uaccess.h>
 
@@ -184,3 +186,23 @@ sys_pciconfig_write (unsigned long bus, unsigned long dfn, unsigned long off, un
 }
 
 #endif /* CONFIG_PCI */
+
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	int res;
+
+	switch (option) {
+	case PR_SET_FPEMU:
+		current->thread.flags &= ~IA64_THREAD_FPEMU_MASK;
+		current->thread.flags |= (arg2 << IA64_THREAD_FPEMU_SHIFT) &
+			IA64_THREAD_FPEMU_MASK;
+		return 0;
+	case PR_GET_FPEMU:
+		res = (current->thread.flags & IA64_THREAD_FPEMU_MASK) >>
+			IA64_THREAD_FPEMU_SHIFT;
+		return put_user(res, (int __user *)arg2);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/kernel/sys.c b/kernel/sys.c
index 5549505..8111c0d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -77,12 +77,6 @@
 #ifndef GET_UNALIGN_CTL
 # define GET_UNALIGN_CTL(a, b)	(-EINVAL)
 #endif
-#ifndef SET_FPEMU_CTL
-# define SET_FPEMU_CTL(a)	(-EINVAL)
-#endif
-#ifndef GET_FPEMU_CTL
-# define GET_FPEMU_CTL(a)	(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2246,12 +2240,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_UNALIGN:
 		error = GET_UNALIGN_CTL(me, arg2);
 		break;
-	case PR_SET_FPEMU:
-		error = SET_FPEMU_CTL(arg2);
-		break;
-	case PR_GET_FPEMU:
-		error = GET_FPEMU_CTL(arg2);
-		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
 		break;
-- 
2.1.4
