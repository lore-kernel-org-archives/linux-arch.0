From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 03/10] arm64/sve: Set CPU vector length to match current task
Date: Thu, 12 Jan 2017 11:26:02 +0000
Message-ID: <1484220369-23970-4-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Return-path: <libc-alpha-return-76729-glibc-alpha=m.gmane.org@sourceware.org>
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

This patch adds the necessary code to configure the CPU for the
task's vector length, whenever SVE state is loaded for a task.

No special action is needed on sched-out: only user tasks with SVE
state care what the CPU's VL is set to.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h       |  3 ++-
 arch/arm64/include/asm/fpsimdmacros.h |  7 ++++++-
 arch/arm64/kernel/entry-fpsimd.S      |  2 +-
 arch/arm64/kernel/fpsimd.c            | 10 +++++++---
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index e13259e..22d09c0 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -100,7 +100,8 @@ extern void __init fpsimd_init_task_struct_size(void);
 
 extern void *__task_sve_state(struct task_struct *task);
 extern void sve_save_state(void *state, u32 *pfpsr);
-extern void sve_load_state(void const *state, u32 const *pfpsr);
+extern void sve_load_state(void const *state, u32 const *pfpsr,
+			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
 
 /*
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e2bb032..7b53bc1 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -254,7 +254,12 @@
 	.purgem savep
 .endm
 
-.macro sve_load nb, xpfpsr, ntmp
+.macro sve_load nb, xpfpsr, xvqminus1 ntmp
+	mrs_s	x\ntmp, ZCR_EL1
+	bic	x\ntmp, x\ntmp, ZCR_EL1_LEN_MASK
+	orr	x\ntmp, x\ntmp, \xvqminus1
+	msr_s	ZCR_EL1, x\ntmp	// self-synchronising
+
 	.macro loadz n
 		_zldrv	\n, \nb, (\n) - 34
 	.endm
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 5dcec55..0a3fdcb 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -73,7 +73,7 @@ ENTRY(sve_save_state)
 ENDPROC(sve_save_state)
 
 ENTRY(sve_load_state)
-	sve_load 0, x1, 2
+	sve_load 0, x1, x2, 3
 	ret
 ENDPROC(sve_load_state)
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 6065707..ab2bb62 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -175,10 +175,14 @@ extern void *__task_pffr(struct task_struct *task);
 static void task_fpsimd_load(struct task_struct *task)
 {
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_tsk_thread_flag(task, TIF_SVE))
+	    test_tsk_thread_flag(task, TIF_SVE)) {
+		unsigned int vl = task->thread.sve_vl;
+
+		BUG_ON(!sve_vl_valid(vl));
 		sve_load_state(__task_pffr(task),
-			       &task->thread.fpsimd_state.fpsr);
-	else
+			       &task->thread.fpsimd_state.fpsr,
+			       sve_vq_from_vl(vl) - 1);
+	} else
 		fpsimd_load_state(&task->thread.fpsimd_state);
 
 	/*
-- 
2.1.4
