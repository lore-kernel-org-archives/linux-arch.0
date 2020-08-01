From: guoren@kernel.org
Subject: [PATCH 12/13] csky: Add arch_show_interrupts for IPI interrupts
Date: Sat,  1 Aug 2020 01:14:12 +0000
Message-ID: <1596244453-98575-13-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Here is the result:

 cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 15:       1348       1299        952       1076  C-SKY SMP Intc  15  IPI Interrupt
 16:       1203       1825       1598       1307  C-SKY SMP Intc  16  csky_mp_timer
 43:        292          0          0          0  C-SKY SMP Intc  43  ttyS0
 57:        106          0          0          0  C-SKY SMP Intc  57  virtio0
IPI0:         0          0          0          0  Empty interrupts
IPI1:        19         41         45         27  Rescheduling interrupts
IPI2:      1330       1259        908       1050  Function call interrupts
IPI3:         0          0          0          0  Irq work interrupts

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/smp.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 60f2ab1..e7425e6 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -15,6 +15,7 @@
 #include <linux/irq_work.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
+#include <linux/seq_file.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/hotplug.h>
@@ -27,11 +28,6 @@
 #include <abi/fpu.h>
 #endif
 
-struct ipi_data_struct {
-	unsigned long bits ____cacheline_aligned;
-};
-static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
-
 enum ipi_message_type {
 	IPI_EMPTY,
 	IPI_RESCHEDULE,
@@ -40,8 +36,16 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
+struct ipi_data_struct {
+	unsigned long bits ____cacheline_aligned;
+	unsigned long stats[IPI_MAX] ____cacheline_aligned;
+};
+static DEFINE_PER_CPU(struct ipi_data_struct, ipi_data);
+
 static irqreturn_t handle_ipi(int irq, void *dev)
 {
+	unsigned long *stats = this_cpu_ptr(&ipi_data)->stats;
+
 	while (true) {
 		unsigned long ops;
 
@@ -49,14 +53,20 @@ static irqreturn_t handle_ipi(int irq, void *dev)
 		if (ops == 0)
 			return IRQ_HANDLED;
 
-		if (ops & (1 << IPI_RESCHEDULE))
+		if (ops & (1 << IPI_RESCHEDULE)) {
+			stats[IPI_RESCHEDULE]++;
 			scheduler_ipi();
+		}
 
-		if (ops & (1 << IPI_CALL_FUNC))
+		if (ops & (1 << IPI_CALL_FUNC)) {
+			stats[IPI_CALL_FUNC]++;
 			generic_smp_call_function_interrupt();
+		}
 
-		if (ops & (1 << IPI_IRQ_WORK))
+		if (ops & (1 << IPI_IRQ_WORK)) {
+			stats[IPI_IRQ_WORK]++;
 			irq_work_run();
+		}
 
 		BUG_ON((ops >> IPI_MAX) != 0);
 	}
@@ -88,6 +98,29 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 	send_arch_ipi(to_whom);
 }
 
+static const char * const ipi_names[] = {
+	[IPI_EMPTY]		= "Empty interrupts",
+	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
+	[IPI_CALL_FUNC]		= "Function call interrupts",
+	[IPI_IRQ_WORK]		= "Irq work interrupts",
+};
+
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < IPI_MAX; i++) {
+		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
+			   prec >= 4 ? " " : "");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10lu ",
+				per_cpu_ptr(&ipi_data, cpu)->stats[i]);
+		seq_printf(p, " %s\n", ipi_names[i]);
+	}
+
+	return 0;
+}
+
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
 {
 	send_ipi_message(mask, IPI_CALL_FUNC);
-- 
2.7.4
