From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length control and reporting
Date: Thu, 12 Jan 2017 11:26:07 +0000
Message-ID: <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbdALL1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:55 -0500
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>

This patch adds support for manipulating a task's vector length at
runtime via ptrace.

As a simplification, we turn the task back into an FPSIMD-only task
when changing the vector length.  If the register data is written
too, we then turn the task back into an SVE task, with changed
task_struct layout for the SVE data, before the actual data writing
is done.

Because the vector length is now variable, sve_get() now needs to
return the real maximum for user_sve_header.max_vl, since .vl may
be less than this (that's the whole point).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h      |  1 +
 arch/arm64/include/uapi/asm/ptrace.h |  5 +++++
 arch/arm64/kernel/ptrace.c           | 25 +++++++++++++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 1ec2363..0f1b068 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -105,6 +105,7 @@ extern void sve_load_state(void const *state, u32 const *pfpsr,
 extern unsigned int sve_get_vl(void);
 extern int sve_set_vector_length(struct task_struct *task,
 				 unsigned long vl, unsigned long flags);
+extern int sve_max_vl;
 
 /*
  * FPSIMD/SVE synchronisation helpers for ptrace:
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 48b57a0..bcb542d 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -64,6 +64,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/prctl.h>
+
 /*
  * User structures for general purpose, floating point and debug registers.
  */
@@ -108,6 +110,9 @@ struct user_sve_header {
 #define SVE_PT_REGS_FPSIMD		0
 #define SVE_PT_REGS_SVE			SVE_PT_REGS_MASK
 
+#define SVE_PT_VL_THREAD		PR_SVE_SET_VL_THREAD
+#define SVE_PT_VL_INHERIT		PR_SVE_SET_VL_INHERIT
+
 
 /*
  * The remainder of the SVE state follows struct user_sve_header.  The
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 32debb8..7e40039 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -741,14 +741,15 @@ static int sve_get(struct task_struct *target,
 	BUG_ON(!sve_vl_valid(header.vl));
 	vq = sve_vq_from_vl(header.vl);
 
-	/* Until runtime or per-task vector length changing is supported: */
-	header.max_vl = header.vl;
+	BUG_ON(!sve_vl_valid(sve_max_vl));
+	header.max_vl = sve_max_vl;
 
 	header.flags = test_tsk_thread_flag(target, TIF_SVE) ?
 		SVE_PT_REGS_SVE : SVE_PT_REGS_FPSIMD;
 
 	header.size = SVE_PT_SIZE(vq, header.flags);
-	header.max_size = SVE_PT_SIZE(vq, SVE_PT_REGS_SVE);
+	header.max_size = SVE_PT_SIZE(sve_vq_from_vl(header.max_vl),
+				      SVE_PT_REGS_SVE);
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &header,
 				  0, sizeof(header));
@@ -830,14 +831,18 @@ static int sve_set(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	if (header.vl != target->thread.sve_vl)
-		return -EINVAL;
-
-	BUG_ON(!sve_vl_valid(header.vl));
-	vq = sve_vq_from_vl(header.vl);
+	/*
+	 * Apart from PT_SVE_REGS_MASK, all PT_SVE_* flags are consumed by
+	 * sve_set_vector_length(), which will also validate them for us:
+	 */
+	ret = sve_set_vector_length(target, header.vl,
+				    header.flags & ~SVE_PT_REGS_MASK);
+	if (ret)
+		goto out;
 
-	if (header.flags & ~SVE_PT_REGS_MASK)
-		return -EINVAL;
+	/* Actual VL set may be less than the user asked for: */
+	BUG_ON(!sve_vl_valid(target->thread.sve_vl));
+	vq = sve_vq_from_vl(target->thread.sve_vl);
 
 	/* Registers: FPSIMD-only case */
 
-- 
2.1.4
