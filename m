Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38190 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLVv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:51 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 2/6] csky: remove irq_mapping from smp.c
Date: Thu, 20 Sep 2018 13:39:28 +0800
Message-ID: <7fea6f7e58728eef8248c8c5e518f45e6043ba4b.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180920053928.Xk1zVRtwlyepRKWbkmE_rVi_SGh0AYkMHwRuG0BTT9o@z>

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
