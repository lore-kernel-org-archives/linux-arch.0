From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 18/20] x86: remove arch_probe_nr_irqs
Date: Sun, 21 Mar 2010 00:13:19 -0700
Message-ID: <1269155601-18247-19-git-send-email-yinghai@kernel.org>
References: <1269155601-18247-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269155601-18247-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Je
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

so keep nr_irqs == NR_IRQS

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index c03bcd4..ed8002b 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3917,28 +3917,6 @@ void __init probe_nr_irqs_gsi(void)
 	printk(KERN_DEBUG "nr_irqs_gsi: %d\n", nr_irqs_gsi);
 }
 
-#ifdef CONFIG_SPARSE_IRQ
-int __init arch_probe_nr_irqs(void)
-{
-	int nr;
-
-	if (nr_irqs > (NR_VECTORS * nr_cpu_ids))
-		nr_irqs = NR_VECTORS * nr_cpu_ids;
-
-	nr = nr_irqs_gsi + 8 * nr_cpu_ids;
-#if defined(CONFIG_PCI_MSI) || defined(CONFIG_HT_IRQ)
-	/*
-	 * for MSI and HT dyn irq
-	 */
-	nr += nr_irqs_gsi * 16;
-#endif
-	if (nr < nr_irqs)
-		nr_irqs = nr;
-
-	return 0;
-}
-#endif
-
 static int __io_apic_set_pci_routing(struct device *dev, int irq,
 				struct io_apic_irq_attr *irq_attr)
 {
-- 
1.6.4.2
