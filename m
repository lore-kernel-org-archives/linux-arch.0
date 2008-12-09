From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 04/12] x86/PCI: minor logic simplications
Date: Tue, 09 Dec 2008 16:11:57 -0700
Message-ID: <20081209231156.18153.70583.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

Test "pin" immediately to simplify the subsequent code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/x86/pci/irq.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 5d1ce1c..6547497 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1042,6 +1042,9 @@ static void __init pcibios_fixup_irqs(void)
 	dev = NULL;
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+		if (!pin)
+			continue;
+
 #ifdef CONFIG_X86_IO_APIC
 		/*
 		 * Recalculate IRQ numbers if we use the I/O APIC.
@@ -1049,9 +1052,6 @@ static void __init pcibios_fixup_irqs(void)
 		if (io_apic_assign_pci_irqs) {
 			int irq;
 
-			if (!pin)
-				continue;
-
 			/*
 			 * interrupt pins are numbered starting from 1
 			 */
@@ -1092,7 +1092,7 @@ static void __init pcibios_fixup_irqs(void)
 		/*
 		 * Still no IRQ? Try to lookup one...
 		 */
-		if (pin && !dev->irq)
+		if (!dev->irq)
 			pcibios_lookup_irq(dev, 0);
 	}
 }
