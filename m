From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 30/30] PCI: Don't shrink too much for hotplug bridge
Date: Sun, 18 Mar 2012 22:43:01 -0700
Message-ID: <1332135781-13695-31-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Otherwise may have problem later if we plug pcie cards with bridges.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 01ba48e..38e0448 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -782,6 +782,7 @@ static int __devinit pci_bridge_check_busn_broken(struct pci_bus *bus,
 
 static unsigned int __devinit __pci_scan_child_bus(struct pci_bus *bus,
 						 int pass);
+#define HOTPLUG_BRIDGE_RESERVE_BUSNR 8
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
@@ -993,6 +994,11 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 		/*
 		 * Set the subordinate bus number to its real value.
 		 */
+		if (dev->is_hotplug_bridge && child->subordinate > max &&
+		    (max - child->secondary) < HOTPLUG_BRIDGE_RESERVE_BUSNR)
+			max = min_t(int, child->secondary +
+					 HOTPLUG_BRIDGE_RESERVE_BUSNR,
+				    child->subordinate);
 		shrink_size = child->subordinate - max;
 		child->subordinate = max;
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
-- 
1.7.7
