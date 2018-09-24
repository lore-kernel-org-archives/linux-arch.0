From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 21/30] csky: remove irq_mapping from smp.c
Date: Tue, 25 Sep 2018 07:39:24 +0800
Message-ID: <7fea6f7e58728eef8248c8c5e518f45e6043ba4b.1537789737.git.ren_guo@c-sky.com>
References: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

 - Add irq_mapping return check
 - Move IPI_IRQ into irq-driver
 - remove irq_mapping from smp.c to irq-driver
 - Add set_ipi_irq_mapping api to irq-driver
 - update asm/smp.h

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/smp.h |  4 +++-
 arch/csky/kernel/smp.c      | 27 +++++++++++++++++++--------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 9a53abf..f3e4f24 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -17,7 +17,9 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
 void arch_send_call_function_single_ipi(int cpu);
 
-void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long));
+void __init set_send_ipi(void (*func)(const unsigned long *));
+
+void __init set_ipi_irq_mapping(int (*func)(void));
 
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 522c73f..14877e2 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -20,8 +20,6 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-#define IPI_IRQ	15
-
 static struct {
 	unsigned long bits ____cacheline_aligned;
 } ipi_data[NR_CPUS] __cacheline_aligned;
@@ -56,9 +54,9 @@ static irqreturn_t handle_ipi(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
+static void (*send_arch_ipi)(const unsigned long *mask) = NULL;
 
-void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
+void __init set_send_ipi(void (*func)(const unsigned long *))
 {
 	if (send_arch_ipi)
 		return;
@@ -75,7 +73,7 @@ send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 		set_bit(operation, &ipi_data[i].bits);
 
 	smp_mb();
-	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
+	send_arch_ipi(cpumask_bits(to_whom));
 }
 
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
@@ -115,19 +113,32 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 }
 
 static int ipi_dummy_dev;
+static int ipi_irq;
 
 void __init enable_smp_ipi(void)
 {
-	enable_percpu_irq(IPI_IRQ, 0);
+	enable_percpu_irq(ipi_irq, 0);
+}
+
+static int (*arch_ipi_irq_mapping)(void) = NULL;
+
+void __init set_ipi_irq_mapping(int (*func)(void))
+{
+	if (arch_ipi_irq_mapping)
+		return;
+
+	arch_ipi_irq_mapping = func;
 }
 
 void __init setup_smp_ipi(void)
 {
 	int rc;
 
-	irq_create_mapping(NULL, IPI_IRQ);
+	ipi_irq = arch_ipi_irq_mapping();
+	if (ipi_irq == 0)
+		panic("%s IRQ mapping failed\n", __func__);
 
-	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
+	rc = request_percpu_irq(ipi_irq, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
 	if (rc)
 		panic("%s IRQ request failed\n", __func__);
 
-- 
2.7.4
