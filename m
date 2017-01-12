From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 07/10] arm64/sve: Add vector length inheritance control
Date: Thu, 12 Jan 2017 11:26:06 +0000
Message-ID: <1484220369-23970-8-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdALL1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:55 -0500
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>

Currently the vector length is inherited across both fork() and
exec().

Inheritance across fork() is desirable both for creating a copy of
a process (traditional fork) or creating a thread (where we want
all threads to share the same VL by default).

Inheritance across exec() is less desirable, because of the ABI
impact of large vector lengths on the size of the signal frame --
when running a new binary, there is no guarantee that the new
binary is compatible with these ABI changes.

This flag makes the vector length non-inherited by default.
Instead, the vector length is reset to a system default value,
unless the THREAD_VL_INHERIT flag has been set for the thread.

THREAD_VL_INHERIT is currently sticky: i.e., if set, it gets
inherited too.  This behaviour may be refined in future if it is
not flexible enough.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  7 +++++++
 arch/arm64/kernel/fpsimd.c         | 33 ++++++++++++++++++++++++++-------
 include/uapi/linux/prctl.h         |  5 +++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 96eada9..45ef11d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -27,6 +27,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/prctl.h>
 #include <linux/string.h>
 
 #include <asm/alternative.h>
@@ -84,11 +85,17 @@ struct thread_struct {
 #endif
 	struct fpsimd_state	fpsimd_state;
 	u16			sve_vl;		/* SVE vector length */
+	u16			sve_flags;	/* SVE related flags */
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
 };
 
+/* Flags for sve_flags (intentionally defined to match the prctl flags) */
+
+/* Inherit sve_vl and sve_flags across execve(): */
+#define THREAD_VL_INHERIT	PR_SVE_SET_VL_INHERIT
+
 #ifdef CONFIG_COMPAT
 #define task_user_tls(t)						\
 ({									\
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 32caca3..f010a1c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -292,12 +292,15 @@ void fpsimd_flush_thread(void)
 		 * User tasks must have a valid vector length set, but tasks
 		 * forked early (e.g., init) may not have one yet.
 		 * By now, we will know what the hardware supports, so set the
-		 * task vector length if it doesn't have one:
+		 * task vector length to default if doesn't have one, or if
+		 * the thread wasn't configured to inherit SVE configuration:
 		 */
-		if (!current->thread.sve_vl) {
+		if (!current->thread.sve_vl ||
+		    !(current->thread.sve_flags & THREAD_VL_INHERIT)) {
 			BUG_ON(!sve_vl_valid(sve_max_vl));
 
 			current->thread.sve_vl = sve_max_vl;
+			current->thread.sve_flags = 0;
 		}
 	}
 
@@ -506,10 +509,10 @@ int sve_set_vector_length(struct task_struct *task,
 	 */
 	if (!(flags & PR_SVE_SET_VL_THREAD) && get_nr_threads(task) != 1)
 		return -EINVAL;
-
 	flags &= ~(unsigned long)PR_SVE_SET_VL_THREAD;
-	if (flags)
-		return -EINVAL; /* No other flags defined yet */
+
+	if (flags & ~(unsigned long)PR_SVE_SET_VL_INHERIT)
+		return -EINVAL;
 
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
@@ -542,11 +545,27 @@ int sve_set_vector_length(struct task_struct *task,
 
 	task->thread.sve_vl = vl;
 
+	/* The THREAD_VL_* flag encodings match the relevant PR_* flags: */
+	task->thread.sve_flags = flags;
+
 	fpsimd_flush_task_state(task);
 
 	return 0;
 }
 
+/*
+ * Encode the current vector length and flags for return.
+ * This is only required for prctl(): ptrace has separate fields
+ */
+static int sve_prctl_status(struct task_struct const *task)
+{
+	int ret = task->thread.sve_vl;
+
+	ret |= task->thread.sve_vl << 16;
+
+	return ret;
+}
+
 /* PR_SVE_SET_VL */
 int sve_set_task_vl(struct task_struct *task,
 		    unsigned long vector_length, unsigned long flags)
@@ -565,7 +584,7 @@ int sve_set_task_vl(struct task_struct *task,
 	if (ret)
 		return ret;
 
-	return task->thread.sve_vl;
+	return sve_prctl_status(task);
 }
 
 /* PR_SVE_GET_VL */
@@ -574,7 +593,7 @@ int sve_get_task_vl(struct task_struct *task)
 	if (!(elf_hwcap & HWCAP_SVE))
 		return -EINVAL;
 
-	return task->thread.sve_vl;
+	return sve_prctl_status(task);
 }
 
 #endif /* CONFIG_ARM64_SVE */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c55530b..cff6214 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -200,6 +200,11 @@ struct prctl_mm_map {
 /* arm64 Scalable Vector Extension controls */
 #define PR_SVE_SET_VL			48	/* set task vector length */
 # define PR_SVE_SET_VL_THREAD		(1 << 1) /* set just this thread */
+# define PR_SVE_SET_VL_INHERIT		(1 << 2) /* inherit across exec */
 #define PR_SVE_GET_VL			49	/* get task vector length */
+/* Decode helpers for the return value from PR_SVE_GET_VL: */
+# define PR_SVE_GET_VL_LEN(ret)		((ret) & 0x3fff) /* vector length */
+# define PR_SVE_GET_VL_INHERIT		(PR_SVE_SET_VL_INHERIT << 16)
+/* For conveinence, PR_SVE_SET_VL returns the result in the same encoding */
 
 #endif /* _LINUX_PRCTL_H */
-- 
2.1.4
