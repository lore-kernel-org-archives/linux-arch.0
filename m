Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44102 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729647AbeIRTVi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:38 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
Date: Tue, 18 Sep 2018 21:48:14 +0800
Message-ID: <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537276837.git.ren_guo@c-sky.com>
References: <cover.1537276837.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180918134814.bLjPZHIM4iJgW_kAFNDgLNA3FTc53CWSlkQmZuLxjsQ@z>

 - remove irq_mapping from smp.c to irq-driver
 - Add set_ipi_irq_mapping api to irq-driver
 - update asm/smp.h

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/smp.h |  4 ++++
 arch/csky/kernel/smp.c      | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
index 9a53abf..fed3a5a 100644
--- a/arch/csky/include/asm/smp.h
+++ b/arch/csky/include/asm/smp.h
@@ -7,6 +7,8 @@
 
 #ifdef CONFIG_SMP
 
+#define IPI_IRQ	15
+
 void __init setup_smp(void);
 
 void __init setup_smp_ipi(void);
@@ -19,6 +21,8 @@ void arch_send_call_function_single_ipi(int cpu);
 
 void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long));
 
+void __init set_ipi_irq_mapping(int (*func)(void));
+
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 #endif /* CONFIG_SMP */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 522c73f..f8343f6 100644
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
@@ -121,13 +119,23 @@ void __init enable_smp_ipi(void)
 	enable_percpu_irq(IPI_IRQ, 0);
 }
 
+static int (*arch_ipi_irq_mapping)(void) = NULL;
+
+void __init set_ipi_irq_mapping(int (*func)(void))
+{
+	if (arch_ipi_irq_mapping)
+		return;
+
+	arch_ipi_irq_mapping = func;
+}
+
 void __init setup_smp_ipi(void)
 {
-	int rc;
+	int rc, irq;
 
-	irq_create_mapping(NULL, IPI_IRQ);
+	irq = arch_ipi_irq_mapping();
 
-	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
+	rc = request_percpu_irq(irq, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
 	if (rc)
 		panic("%s IRQ request failed\n", __func__);
 
-- 
2.7.4
