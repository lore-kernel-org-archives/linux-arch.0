From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 10/12] PCI: powerpc: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:27 -0700
Message-ID: <20081209231227.18153.14913.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:11820 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406AbYLIXM2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:12:28 -0500
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/powerpc/kernel/prom_parse.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index a11d689..a377abe 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -232,11 +232,6 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
 
-static u8 of_irq_pci_swizzle(u8 slot, u8 pin)
-{
-	return (((pin - 1) + slot) % 4) + 1;
-}
-
 int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 {
 	struct device_node *dn, *ppnode;
@@ -306,7 +301,7 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 		/* We can only get here if we hit a P2P bridge with no node,
 		 * let's do standard swizzling and try again
 		 */
-		lspec = of_irq_pci_swizzle(PCI_SLOT(pdev->devfn), lspec);
+		lspec = pci_swizzle_interrupt_pin(pdev, lspec);
 		pdev = ppdev;
 	}
 
