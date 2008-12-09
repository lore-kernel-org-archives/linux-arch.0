From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 01/12] PCI Hotplug: cpqphp: use config space PCI interrupt pin
	encoding
Date: Tue, 09 Dec 2008 16:11:41 -0700
Message-ID: <20081209231141.18153.43258.stgit@bob.kio>
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

This patch changes cpqphp to use interrupt pin values just as they
come from PCI config space, i.e., 1=INTA, ..., 4=INTD.

pcibios_set_irq_routing() takes pin arguments in the range 0=INTA, ...,
3=INTD, so we'll adjust the pin just before calling it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Alex Chiang <achiang@hp.com>
---
 drivers/pci/hotplug/cpqphp_ctrl.c |    4 ++--
 drivers/pci/hotplug/cpqphp_pci.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index a60a252..d947221 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -2604,7 +2604,7 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 			for (cloop = 0; cloop < 4; cloop++) {
 				if (irqs.valid_INT & (0x01 << cloop)) {
 					rc = cpqhp_set_irq(func->bus, func->device,
-							   0x0A + cloop, irqs.interrupt[cloop]);
+							   cloop + 1, irqs.interrupt[cloop]);
 					if (rc)
 						goto free_and_out;
 				}
@@ -2945,7 +2945,7 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
 		}
 
 		if (!behind_bridge) {
-			rc = cpqhp_set_irq(func->bus, func->device, temp_byte + 0x09, IRQ);
+			rc = cpqhp_set_irq(func->bus, func->device, temp_byte, IRQ);
 			if (rc)
 				return 1;
 		} else {
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 0902193..125d287 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -171,7 +171,7 @@ int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 		fakebus->number = bus_num;
 		dbg("%s: dev %d, bus %d, pin %d, num %d\n",
 		    __func__, dev_num, bus_num, int_pin, irq_num);
-		rc = pcibios_set_irq_routing(fakedev, int_pin - 0x0a, irq_num);
+		rc = pcibios_set_irq_routing(fakedev, int_pin - 1, irq_num);
 		kfree(fakedev);
 		kfree(fakebus);
 		dbg("%s: rc %d\n", __func__, rc);
