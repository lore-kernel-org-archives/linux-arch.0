From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 02/10] arm64/sve: Track vector length for each task
Date: Thu, 12 Jan 2017 11:26:01 +0000
Message-ID: <1484220369-23970-3-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <gdb-return-45519-gdb-gdb=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>
List-Id: linux-arch.vger.kernel.org

In preparation for allowing each task to have its own independent
vector length, this patch adds a sve_vl field to thread_struct to
track it, and interrogates this instead of interrogating the
hardware when knowledge of the task's vector length is needed.

The hardware supported vector length is not known straight out of
boot, so init_task and other kernel tasks forked early may lack
this knowledge.

We only need this knowledge when in the context of a user task that
has SVE state (or that has just trapped while attempting to have
SVE state).  So, we can hook into exec() to set task vector length
if it wasn't known at boot/fork time, before the task enters
userspace.

There is no way to change sve_vl for a task yet, so all tasks still
execute with the hardware vector length.  Subsequent patches will
enable changing the vector length for tasks.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/fpsimd.c         | 44 ++++++++++++++++++++++++++------------
 arch/arm64/kernel/ptrace.c         |  4 ++--
 arch/arm64/kernel/signal.c         | 15 +++++++++----
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6f0f300..96eada9 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -83,6 +83,7 @@ struct thread_struct {
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
+	u16			sve_vl;		/* SVE vector length */
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index bdacfcd..6065707 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -99,6 +99,9 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 	WARN_ON(1);
 }
 
+/* Maximum supported vector length across all CPUs (initially poisoned) */
+int sve_max_vl = -1;
+
 #ifdef CONFIG_ARM64_SVE
 
 static void task_fpsimd_to_sve(struct task_struct *task);
@@ -156,9 +159,9 @@ void *__task_sve_state(struct task_struct *task)
 
 static void *__task_pffr(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 
-	BUG_ON(vl % 16);
+	BUG_ON(!sve_vl_valid(vl));
 	return (char *)__task_sve_state(task) + 34 * vl;
 }
 
@@ -272,6 +275,18 @@ void fpsimd_flush_thread(void)
 		memset(__task_sve_state(current), 0,
 		       arch_task_struct_size -
 		       ((char *)__task_sve_state(current) - (char *)current));
+
+		/*
+		 * User tasks must have a valid vector length set, but tasks
+		 * forked early (e.g., init) may not have one yet.
+		 * By now, we will know what the hardware supports, so set the
+		 * task vector length if it doesn't have one:
+		 */
+		if (!current->thread.sve_vl) {
+			BUG_ON(!sve_vl_valid(sve_max_vl));
+
+			current->thread.sve_vl = sve_max_vl;
+		}
 	}
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -310,16 +325,15 @@ static void __task_sve_to_fpsimd(struct task_struct *task, unsigned int vq)
 
 static void task_sve_to_fpsimd(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 	unsigned int vq;
 
 	if (!(elf_hwcap & HWCAP_SVE))
 		return;
 
-	BUG_ON(vl % 16);
-	vq = vl / 16;
-	BUG_ON(vq < 1 || vq > 16);
+	BUG_ON(!sve_vl_valid(vl));
 
+	vq = sve_vq_from_vl(vl);
 	__task_sve_to_fpsimd(task, vq);
 }
 
@@ -373,16 +387,15 @@ static void __task_fpsimd_to_sve(struct task_struct *task, unsigned int vq)
 
 static void task_fpsimd_to_sve(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 	unsigned int vq;
 
 	if (!(elf_hwcap & HWCAP_SVE))
 		return;
 
-	BUG_ON(vl % 16);
-	vq = vl / 16;
-	BUG_ON(vq < 1 || vq > 16);
+	BUG_ON(!sve_vl_valid(vl));
 
+	vq = sve_vq_from_vl(vl);
 	__task_fpsimd_to_sve(task, vq);
 }
 
@@ -463,8 +476,9 @@ static void __fpsimd_sync_from_fpsimd_zeropad(struct task_struct *task,
 
 void fpsimd_sync_from_fpsimd_zeropad(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 
+	BUG_ON(!sve_vl_valid(vl));
 	__fpsimd_sync_from_fpsimd_zeropad(task, sve_vq_from_vl(vl));
 }
 
@@ -606,11 +620,13 @@ void __init fpsimd_init_task_struct_size(void)
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    ((read_cpuid(ID_AA64PFR0_EL1) >> ID_AA64PFR0_SVE_SHIFT)
 	     & 0xf) == 1) {
-		arch_task_struct_size = sizeof(struct task_struct) +
-			35 * sve_get_vl();
+		/* FIXME: This should be the minimum across all CPUs */
+		sve_max_vl = sve_get_vl();
 
+		arch_task_struct_size = sizeof(struct task_struct) +
+			35 * sve_max_vl;
 		pr_info("SVE: enabled with maximum %u bits per vector\n",
-			sve_get_vl() * 8);
+			sve_max_vl * 8);
 	}
 }
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index fb8cef63..32debb8 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -736,7 +736,7 @@ static int sve_get(struct task_struct *target,
 	/* Header */
 	memset(&header, 0, sizeof(header));
 
-	header.vl = sve_get_vl();
+	header.vl = target->thread.sve_vl;
 
 	BUG_ON(!sve_vl_valid(header.vl));
 	vq = sve_vq_from_vl(header.vl);
@@ -830,7 +830,7 @@ static int sve_set(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	if (header.vl != sve_get_vl())
+	if (header.vl != target->thread.sve_vl)
 		return -EINVAL;
 
 	BUG_ON(!sve_vl_valid(header.vl));
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 9ef9953..7615c7d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -222,8 +222,11 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 {
 	int err = 0;
 	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
-	unsigned int vl = sve_get_vl();
-	unsigned int vq = sve_vq_from_vl(vl);
+	unsigned int vl = current->thread.sve_vl;
+	unsigned int vq;
+
+	BUG_ON(!sve_vl_valid(vl));
+	vq = sve_vq_from_vl(vl);
 
 	memset(reserved, 0, sizeof(reserved));
 
@@ -253,7 +256,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 		__task_sve_state(current);
 	struct fpsimd_state fpsimd;
 
-	if (vl != sve_get_vl())
+	if (vl != current->thread.sve_vl)
 		return -EINVAL;
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -543,7 +546,11 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 	}
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
-		unsigned int vq = sve_vq_from_vl(sve_get_vl());
+		unsigned int vl = current->thread.sve_vl;
+		unsigned int vq;
+
+		BUG_ON(!sve_vl_valid(vl));
+		vq = sve_vq_from_vl(vl);
 
 		BUG_ON(!(elf_hwcap & HWCAP_SVE));
 
-- 
2.1.4
