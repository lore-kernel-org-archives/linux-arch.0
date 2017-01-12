From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 01/10] prctl: Add skeleton for PR_SVE_{SET,GET}_VL controls
Date: Thu, 12 Jan 2017 11:26:00 +0000
Message-ID: <1484220369-23970-2-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <libc-alpha-return-76726-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>
List-Id: linux-arch.vger.kernel.org

This patch adds a do-nothing skeleton for the arm64 Scalable Vector
Extension control prctls.

These prctls are only avilable with

    CONFIG_ARM64=y
    CONFIG_ARM64_SVE=y

Otherwise they will compile out and return -EINVAL if attempted
from userspace.

The backend functions sve_{set,get}_task_vl() will be fleshed out
with actual functionality in subsequent patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

There will probably also be a call to discover the signal frame size
(MINSIGSTKSZ equivalent) for the current configuration, something like

 * PR_GET_MINSIGSTKSZ

This series doesn't add this yet: only the PR_SVE_{SET,GET}_VL prctls
are provided.


 arch/arm64/include/asm/fpsimd.h    | 19 +++++++++++++++++++
 arch/arm64/include/asm/processor.h |  4 ++++
 arch/arm64/kernel/fpsimd.c         | 13 +++++++++++++
 include/uapi/linux/prctl.h         |  4 ++++
 kernel/sys.c                       | 12 ++++++++++++
 5 files changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 88bcf69..e13259e 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -17,6 +17,7 @@
 #define __ASM_FP_H
 
 #include <asm/ptrace.h>
+#include <asm/errno.h>
 
 #ifndef __ASSEMBLY__
 
@@ -110,12 +111,30 @@ extern unsigned int sve_get_vl(void);
 extern void fpsimd_sync_to_sve(struct task_struct *task);
 
 #ifdef CONFIG_ARM64_SVE
+
 extern void fpsimd_sync_to_fpsimd(struct task_struct *task);
 extern void fpsimd_sync_from_fpsimd_zeropad(struct task_struct *task);
+extern int sve_set_task_vl(struct task_struct *task,
+			   unsigned long vector_length, unsigned long flags);
+extern int sve_get_task_vl(struct task_struct *task);
+
 #else /* !CONFIG_ARM64_SVE */
+
 static void __maybe_unused fpsimd_sync_to_fpsimd(struct task_struct *task) { }
 static void __maybe_unused fpsimd_sync_from_fpsimd_zeropad(
 	struct task_struct *task) { }
+
+static int __maybe_unused sve_set_task_vl(struct task_struct *task,
+	unsigned long vector_length, unsigned long flags)
+{
+	return -EINVAL;
+}
+
+static int __maybe_unused sve_get_task_vl(struct task_struct *task)
+{
+	return -EINVAL;
+}
+
 #endif /* !CONFIG_ARM64_SVE */
 
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 747c65a..6f0f300 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -190,4 +190,8 @@ int cpu_enable_pan(void *__unused);
 int cpu_enable_uao(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+#define SVE_SET_VL(task, vector_length, flags) \
+	sve_set_task_vl(task, vector_length, flags)
+#define SVE_GET_VL(task) sve_get_task_vl(task)
+
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2c113e4..bdacfcd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -468,6 +468,19 @@ void fpsimd_sync_from_fpsimd_zeropad(struct task_struct *task)
 	__fpsimd_sync_from_fpsimd_zeropad(task, sve_vq_from_vl(vl));
 }
 
+/* PR_SVE_SET_VL */
+int sve_set_task_vl(struct task_struct *task,
+		    unsigned long vector_length, unsigned long flags)
+{
+	return -EINVAL;
+}
+
+/* PR_SVE_GET_VL */
+int sve_get_task_vl(struct task_struct *task)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_ARM64_SVE */
 
 #ifdef CONFIG_KERNEL_MODE_NEON
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a8d0759..e32e2da 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -197,4 +197,8 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/* arm64 Scalable Vector Extension controls */
+#define PR_SVE_SET_VL			48	/* set task vector length */
+#define PR_SVE_GET_VL			49	/* get task vector length */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 842914e..5f50385 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -103,6 +103,12 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
+#ifndef SVE_SET_VL
+# define SVE_SET_VL(a,b,c)	(-EINVAL)
+#endif
+#ifndef SVE_GET_VL
+# define SVE_GET_VL(a)		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2261,6 +2267,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_SVE_SET_VL:
+		error = SVE_SET_VL(me, arg2, arg3);
+		break;
+	case PR_SVE_GET_VL:
+		error = SVE_GET_VL(me);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.1.4
