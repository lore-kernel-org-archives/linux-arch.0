Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37824 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753819AbdJaPwO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Oct 2017 11:52:14 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v5 22/30] arm64/sve: Add prctl controls for userspace vector length management
Date: Tue, 31 Oct 2017 15:51:14 +0000
Message-ID: <1509465082-30427-23-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171031155114.U54Aqx8STdZHGq9iNdqiyRdBkNe-VUuf_bCJyP_zSPk@z>

This patch adds two arm64-specific prctls, to permit userspace to
control its vector length:

 * PR_SVE_SET_VL: set the thread's SVE vector length and vector
   length inheritance mode.

 * PR_SVE_GET_VL: get the same information.

Although these prctls resemble instruction set features in the SVE
architecture, they provide additional control: the vector length
inheritance mode is Linux-specific and nothing to do with the
architecture, and the architecture does not permit EL0 to set its
own vector length directly.  Both can be used in portable tools
without requiring the use of SVE instructions.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alex Bennée <alex.bennee@linaro.org>

---

**Dropped at v3** Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
See v3 posting for history.
---
 arch/arm64/include/asm/fpsimd.h    | 14 +++++++++++
 arch/arm64/include/asm/processor.h |  4 +++
 arch/arm64/kernel/fpsimd.c         | 50 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/prctl.h         |  4 +++
 kernel/sys.c                       | 12 +++++++++
 5 files changed, 84 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index d754e5a..b868412 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -17,6 +17,7 @@
 #define __ASM_FP_H
 
 #include <asm/ptrace.h>
+#include <asm/errno.h>
 
 #ifndef __ASSEMBLY__
 
@@ -98,6 +99,9 @@ extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 extern int sve_set_vector_length(struct task_struct *task,
 				 unsigned long vl, unsigned long flags);
 
+extern int sve_set_current_vl(unsigned long arg);
+extern int sve_get_current_vl(void);
+
 /*
  * Probing and setup functions.
  * Calls to these functions must be serialised with one another.
@@ -114,6 +118,16 @@ static inline void fpsimd_release_task(struct task_struct *task) { }
 static inline void sve_sync_to_fpsimd(struct task_struct *task) { }
 static inline void sve_sync_from_fpsimd_zeropad(struct task_struct *task) { }
 
+static inline int sve_set_current_vl(unsigned long arg)
+{
+	return -EINVAL;
+}
+
+static inline int sve_get_current_vl(void)
+{
+	return -EINVAL;
+}
+
 static inline void sve_init_vq_map(void) { }
 static inline void sve_update_vq_map(void) { }
 static inline int sve_verify_vq_map(void) { return 0; }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c6fddb0..023cacb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -217,5 +217,9 @@ static inline void spin_lock_prefetch(const void *ptr)
 int cpu_enable_pan(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
+/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
+#define SVE_SET_VL(arg)	sve_set_current_vl(arg)
+#define SVE_GET_VL()	sve_get_current_vl()
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5715622..cbb2c63 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -29,6 +29,7 @@
 #include <linux/irqflags.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/prctl.h>
 #include <linux/preempt.h>
 #include <linux/prctl.h>
 #include <linux/ptrace.h>
@@ -558,6 +559,55 @@ int sve_set_vector_length(struct task_struct *task,
 }
 
 /*
+ * Encode the current vector length and flags for return.
+ * This is only required for prctl(): ptrace has separate fields
+ *
+ * flags are as for sve_set_vector_length().
+ */
+static int sve_prctl_status(unsigned long flags)
+{
+	int ret;
+
+	if (flags & PR_SVE_SET_VL_ONEXEC)
+		ret = current->thread.sve_vl_onexec;
+	else
+		ret = current->thread.sve_vl;
+
+	if (test_thread_flag(TIF_SVE_VL_INHERIT))
+		ret |= PR_SVE_VL_INHERIT;
+
+	return ret;
+}
+
+/* PR_SVE_SET_VL */
+int sve_set_current_vl(unsigned long arg)
+{
+	unsigned long vl, flags;
+	int ret;
+
+	vl = arg & PR_SVE_VL_LEN_MASK;
+	flags = arg & ~vl;
+
+	if (!system_supports_sve())
+		return -EINVAL;
+
+	ret = sve_set_vector_length(current, vl, flags);
+	if (ret)
+		return ret;
+
+	return sve_prctl_status(flags);
+}
+
+/* PR_SVE_GET_VL */
+int sve_get_current_vl(void)
+{
+	if (!system_supports_sve())
+		return -EINVAL;
+
+	return sve_prctl_status(0);
+}
+
+/*
  * Bitmap for temporary storage of the per-CPU set of supported vector lengths
  * during secondary boot.
  */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1b64901..1ef9370 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -198,7 +198,11 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
 /* arm64 Scalable Vector Extension controls */
+/* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
+#define PR_SVE_SET_VL			48	/* set task vector length */
 # define PR_SVE_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SVE_GET_VL			49	/* get task vector length */
+/* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 9aebc29..c541916 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -110,6 +110,12 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
+#ifndef SVE_SET_VL
+# define SVE_SET_VL(a)		(-EINVAL)
+#endif
+#ifndef SVE_GET_VL
+# define SVE_GET_VL()		(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2385,6 +2391,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
+	case PR_SVE_SET_VL:
+		error = SVE_SET_VL(arg2);
+		break;
+	case PR_SVE_GET_VL:
+		error = SVE_GET_VL();
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.1.4
