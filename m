From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 06/12] PCI: alpha: use generic pci_swizzle_interrupt_pin()
Date: Tue, 09 Dec 2008 16:12:07 -0700
Message-ID: <20081209231207.18153.99362.stgit@bob.kio>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:29425 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbYLIXMJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Dec 2008 18:12:09 -0500
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/alpha/kernel/pci.c          |    2 +-
 arch/alpha/kernel/pci_impl.h     |    9 ++-------
 arch/alpha/kernel/sys_dp264.c    |    2 +-
 arch/alpha/kernel/sys_eiger.c    |    2 +-
 arch/alpha/kernel/sys_miata.c    |    2 +-
 arch/alpha/kernel/sys_noritake.c |    2 +-
 arch/alpha/kernel/sys_ruffian.c  |    2 +-
 arch/alpha/kernel/sys_sable.c    |    2 +-
 8 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index ff8cb63..b03d9f4 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -328,7 +328,7 @@ common_swizzle(struct pci_dev *dev, u8 *pinp)
 	u8 pin = *pinp;
 
 	while (dev->bus->parent) {
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 		/* Move up the chain of bridges. */
 		dev = dev->bus->self;
         }
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index f8b7499..7336651 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -106,16 +106,11 @@ struct pci_iommu_arena;
  *   Where A = pin 1, B = pin 2 and so on and pin=0 = default = A.
  *   Thus, each swizzle is ((pin-1) + (device#-4)) % 4
  *
- *   The following code swizzles for exactly one bridge.  The routine
+ *   pci_swizzle_interrupt_pin() swizzles for exactly one bridge.  The routine
  *   common_swizzle below handles multiple bridges.  But there are a
- *   couple boards that do strange things, so we define this here.
+ *   couple boards that do strange things.
  */
 
-static inline u8 bridge_swizzle(u8 pin, u8 slot) 
-{
-	return (((pin-1) + slot) % 4) + 1;
-}
-
 
 /* The following macro is used to implement the table-based irq mapping
    function for all single-bus Alphas.  */
diff --git a/arch/alpha/kernel/sys_dp264.c b/arch/alpha/kernel/sys_dp264.c
index c71b0fd..1d707a7 100644
--- a/arch/alpha/kernel/sys_dp264.c
+++ b/arch/alpha/kernel/sys_dp264.c
@@ -481,7 +481,7 @@ monet_swizzle(struct pci_dev *dev, u8 *pinp)
 				slot = PCI_SLOT(dev->devfn);
 				break;
 			}
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn)) ;
+			pin = pci_swizzle_interrupt_pin(dev, pin);
 
 			/* Move up the chain of bridges.  */
 			dev = dev->bus->self;
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 7ef3b6f..baf60f3 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -204,7 +204,7 @@ eiger_swizzle(struct pci_dev *dev, u8 *pinp)
 			break;
 		}
 		/* Must be a card-based bridge.  */
-		pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+		pin = pci_swizzle_interrupt_pin(dev, pin);
 
 		/* Move up the chain of bridges.  */
 		dev = dev->bus->self;
diff --git a/arch/alpha/kernel/sys_miata.c b/arch/alpha/kernel/sys_miata.c
index 910b43c..61ccd95 100644
--- a/arch/alpha/kernel/sys_miata.c
+++ b/arch/alpha/kernel/sys_miata.c
@@ -219,7 +219,7 @@ miata_swizzle(struct pci_dev *dev, u8 *pinp)
 				slot = PCI_SLOT(dev->devfn) + 9;
 				break;
 			}
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+			pin = pci_swizzle_interrupt_pin(dev, pin);
 
 			/* Move up the chain of bridges.  */
 			dev = dev->bus->self;
diff --git a/arch/alpha/kernel/sys_noritake.c b/arch/alpha/kernel/sys_noritake.c
index eb2a1d6..538876b 100644
--- a/arch/alpha/kernel/sys_noritake.c
+++ b/arch/alpha/kernel/sys_noritake.c
@@ -257,7 +257,7 @@ noritake_swizzle(struct pci_dev *dev, u8 *pinp)
 				slot = PCI_SLOT(dev->devfn) + 15;
 				break;
 			}
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn)) ;
+			pin = pci_swizzle_interrupt_pin(dev, pin);
 
 			/* Move up the chain of bridges.  */
 			dev = dev->bus->self;
diff --git a/arch/alpha/kernel/sys_ruffian.c b/arch/alpha/kernel/sys_ruffian.c
index 5b99cf3..f15a329 100644
--- a/arch/alpha/kernel/sys_ruffian.c
+++ b/arch/alpha/kernel/sys_ruffian.c
@@ -160,7 +160,7 @@ ruffian_swizzle(struct pci_dev *dev, u8 *pinp)
 				slot = PCI_SLOT(dev->devfn) + 10;
 				break;
 			}
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn));
+			pin = pci_swizzle_interrupt_pin(dev, pin);
 
 			/* Move up the chain of bridges.  */
 			dev = dev->bus->self;
diff --git a/arch/alpha/kernel/sys_sable.c b/arch/alpha/kernel/sys_sable.c
index a4555f4..d232e42 100644
--- a/arch/alpha/kernel/sys_sable.c
+++ b/arch/alpha/kernel/sys_sable.c
@@ -425,7 +425,7 @@ lynx_swizzle(struct pci_dev *dev, u8 *pinp)
 				slot = PCI_SLOT(dev->devfn) + 11;
 				break;
 			}
-			pin = bridge_swizzle(pin, PCI_SLOT(dev->devfn)) ;
+			pin = pci_swizzle_interrupt_pin(dev, pin);
 
 			/* Move up the chain of bridges.  */
 			dev = dev->bus->self;
