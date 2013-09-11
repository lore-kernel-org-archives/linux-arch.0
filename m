From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 17/25] smp, sh: kill SMP single function call interrupt
Date: Thu, 12 Sep 2013 00:07:21 +0800
Message-ID: <1378915649-16395-18-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <lethal@linux-sh.org>, Shaohua Li <shli@kernel.org>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
similar to smp_call_function_single()" has unified the way to handle
single and multiple cross-CPU function calls. Now only one interrupt
is needed for architecture specific code to support generic SMP function
call interfaces, so kill the redundant single function call interrupt.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/sh/include/asm/smp.h | 1 -
 arch/sh/kernel/smp.c      | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/smp.h b/arch/sh/include/asm/smp.h
index 78b0d0f4..93ce87b 100644
--- a/arch/sh/include/asm/smp.h
+++ b/arch/sh/include/asm/smp.h
@@ -25,7 +25,6 @@ extern int __cpu_logical_map[NR_CPUS];
 enum {
 	SMP_MSG_FUNCTION,
 	SMP_MSG_RESCHEDULE,
-	SMP_MSG_FUNCTION_SINGLE,
 	SMP_MSG_TIMER,
 
 	SMP_MSG_NR,	/* must be last */
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 86a7936..c944d5d 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -282,7 +282,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	mp_ops->send_ipi(cpu, SMP_MSG_FUNCTION_SINGLE);
+	mp_ops->send_ipi(cpu, SMP_MSG_FUNCTION);
 }
 
 void smp_timer_broadcast(const struct cpumask *mask)
@@ -309,9 +309,6 @@ void smp_message_recv(unsigned int msg)
 	case SMP_MSG_RESCHEDULE:
 		scheduler_ipi();
 		break;
-	case SMP_MSG_FUNCTION_SINGLE:
-		generic_smp_call_function_single_interrupt();
-		break;
 	case SMP_MSG_TIMER:
 		ipi_timer();
 		break;
-- 
1.8.1.2
