From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 09/25] smp, m32r: kill SMP single function call interrupt
Date: Thu, 12 Sep 2013 00:07:13 +0800
Message-ID: <1378915649-16395-10-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Hirokazu Takata <takata@linux-m32r.org>, Shaohua Li <shli@kernel.org>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
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
 arch/m32r/include/asm/smp.h | 1 -
 arch/m32r/kernel/smp.c      | 9 +--------
 arch/m32r/kernel/traps.c    | 3 +--
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/m32r/include/asm/smp.h b/arch/m32r/include/asm/smp.h
index c689b82..3a502d4 100644
--- a/arch/m32r/include/asm/smp.h
+++ b/arch/m32r/include/asm/smp.h
@@ -98,7 +98,6 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 #define LOCAL_TIMER_IPI		(M32R_IRQ_IPI3-M32R_IRQ_IPI0)
 #define INVALIDATE_CACHE_IPI	(M32R_IRQ_IPI4-M32R_IRQ_IPI0)
 #define CPU_BOOT_IPI		(M32R_IRQ_IPI5-M32R_IRQ_IPI0)
-#define CALL_FUNC_SINGLE_IPI	(M32R_IRQ_IPI6-M32R_IRQ_IPI0)
 
 #define IPI_SHIFT	(0)
 #define NR_IPIS		(8)
diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
index ce7aea3..c6d0bb9 100644
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -542,7 +542,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	send_IPI_mask(cpumask_of(cpu), CALL_FUNC_SINGLE_IPI, 0);
+	send_IPI_mask(cpumask_of(cpu), CALL_FUNCTION_IPI, 0);
 }
 
 /*==========================================================================*
@@ -569,13 +569,6 @@ void smp_call_function_interrupt(void)
 	irq_exit();
 }
 
-void smp_call_function_single_interrupt(void)
-{
-	irq_enter();
-	generic_smp_call_function_single_interrupt();
-	irq_exit();
-}
-
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 /* Timer Routines                                                            */
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
diff --git a/arch/m32r/kernel/traps.c b/arch/m32r/kernel/traps.c
index a7a424f..f5d911d 100644
--- a/arch/m32r/kernel/traps.c
+++ b/arch/m32r/kernel/traps.c
@@ -39,7 +39,6 @@ extern void smp_invalidate_interrupt(void);
 extern void smp_call_function_interrupt(void);
 extern void smp_ipi_timer_interrupt(void);
 extern void smp_flush_cache_all_interrupt(void);
-extern void smp_call_function_single_interrupt(void);
 
 /*
  * for Boot AP function
@@ -104,7 +103,7 @@ static void set_eit_vector_entries(void)
 	eit_vector[187] = (unsigned long)smp_ipi_timer_interrupt;
 	eit_vector[188] = (unsigned long)smp_flush_cache_all_interrupt;
 	eit_vector[189] = 0;	/* CPU_BOOT_IPI */
-	eit_vector[190] = (unsigned long)smp_call_function_single_interrupt;
+	eit_vector[190] = 0;
 	eit_vector[191] = 0;
 #endif
 	_flush_cache_copyback_all();
-- 
1.8.1.2
