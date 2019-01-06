From: G SatishKumar <gsatish.ldd@gmail.com>
Subject: [PATCH] RISCV:IRQ: Support IRQ_WORK interrupts with self IPI
Date: Sun,  6 Jan 2019 19:02:58 +0530
Message-ID: <1546781578-8126-1-git-send-email-gsatish.ldd@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, palmer@sifive.com, linux-arch@vger.kernel.org, G SatishKumar <gsatish.ldd@gmail.com>
List-Id: linux-arch.vger.kernel.org

	This patch adds, IRQ Work interrupts support to RISCV arch.

	This patch is based on the arm32 patch ARM 7872/1
	which ports cleanly.

	Done set of changes based on RISCV SMP process.

	commit bf18525fd793 ("ARM: 7872/1: Support arch_irq_work_raise()
		via self IPIs")
	Author: Stephen Boyd <sboyd at codeaurora.org>
	Date:   Tue Oct 29 20:32:56 2013 +0100

	By default, IRQ work is run from the tick interrupt (see
	irq_work_run() in update_process_times()). When we're in full
	NOHZ mode, restarting the tick requires the use of IRQ work and
	if the only place we run IRQ work is in the tick interrupt we
	have an unbreakable cycle. Implement arch_irq_work_raise() via
	self IPIs to break this cycle and get the tick started again.
	Note that we implement this via IPIs which are only available on
	SMP builds. This shouldn't be a problem because full NOHZ is only
	supported on SMP builds anyway.

root@(none):~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  8:        134        112         73         75  SiFive PLIC   8  virtio0
 10:        123        131        142        126  SiFive PLIC  10  ttyS0
IPI0:       798        549        285        373  Rescheduling interrupts
IPI1:        53          8        101        181  Function call interrupts
IPI2:         0          0          0          0  IRQ work interrupts
Err:          0

Signed-off-by: G SatishKumar <gsatish.ldd@gmail.com>
---
 arch/riscv/kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 57b1383..8953e73 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -23,6 +23,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/irq_work.h>
 
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -31,6 +32,7 @@
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
+	IPI_IRQ_WORK,
 	IPI_MAX
 };
 
@@ -94,6 +96,11 @@ void riscv_software_interrupt(void)
 			generic_smp_call_function_interrupt();
 		}
 
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
+			irq_work_run();
+		}
+
 		BUG_ON((ops >> IPI_MAX) != 0);
 
 		/* Order data access and bit testing. */
@@ -121,6 +128,7 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_IRQ_WORK]		= "IRQ work interrupts"
 };
 
 void show_ipi_stats(struct seq_file *p, int prec)
@@ -162,6 +170,14 @@ void smp_send_reschedule(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_message(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
+
 /*
  * Performs an icache flush for the given MM context.  RISC-V has no direct
  * mechanism for instruction cache shoot downs, so instead we send an IPI that
-- 
2.7.4
