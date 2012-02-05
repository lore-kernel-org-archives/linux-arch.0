Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:61858 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab2BEHAn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2012 02:00:43 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 23/24] PCI: make pci_rescan_bus_bridge_resize use pci_scan_bridge instead
Date: Sat,  4 Feb 2012 22:58:07 -0800
Message-ID: <1328425088-6562-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120205065807.vOJzE6ZETsZoH9wRLBMOIFsvkZyn_9cI7PSMADJ9Akk@z>

So after remove all children and then using setpci change bus register and rescan
bridge could use new set bus number.

Otherwise need to rescan parent bus, it would have too much overhead.

also need to use pci_bus_add_single_device to make sure new change bus have directory
 /sys/../.../pci_bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 61df44d..e85b823 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1972,14 +1972,16 @@ EXPORT_SYMBOL(pci_scan_bus);
  */
 unsigned int __ref pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 {
-	unsigned int max;
-	struct pci_bus *bus = bridge->subordinate;
+	unsigned int max = 0;
+	int pass;
+	struct pci_bus *bus = bridge->bus;
 
-	max = pci_scan_child_bus(bus);
+	for (pass = 0; pass < 2; pass++)
+		max = pci_scan_bridge(bus, bridge, max, pass);
 
 	pci_assign_unassigned_bridge_resources(bridge);
 
-	pci_bus_add_devices(bus);
+	pci_bus_add_single_device(bridge);
 
 	return max;
 }
-- 
1.7.7

