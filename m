From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date: Tue, 18 Dec 2018 10:53:59 -0800
Message-ID: <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

signal handling core calls ARCH show_regs() with preemption disabled
which causes __might_sleep functions such as mmput leading to lockdep
splat.  Workaround by re-enabling preemption temporarily.

This may not be as bad as it sounds since the preemption disabling
itself was introduced for a supressing smp_processor_id() warning in x86
code by commit 3a9f84d354ce ("signals, debug: fix BUG: using
smp_processor_id() in preemptible code in print_fatal_signal()")

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/troubleshoot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 2885bec71fb8..c650d3de13e1 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -177,6 +177,12 @@ void show_regs(struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	struct callee_regs *cregs;
 
+	/*
+	 * generic code calls us with preemption disabled, but some calls
+	 * here could sleep, so re-enable to avoid lockdep splat
+	 */
+	preempt_enable();
+
 	print_task_path_n_nm(tsk);
 	show_regs_print_info(KERN_INFO);
 
@@ -219,6 +225,8 @@ void show_regs(struct pt_regs *regs)
 	cregs = (struct callee_regs *)current->thread.callee_reg;
 	if (cregs)
 		show_callee_regs(cregs);
+
+	preempt_disable();
 }
 
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
-- 
2.7.4
