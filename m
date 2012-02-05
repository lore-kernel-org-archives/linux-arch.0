Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:61809 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab2BEHA2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2012 02:00:28 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 15/24] PCI: kill pci_fixup_parent_subordinate_busnr()
Date: Sat,  4 Feb 2012 22:57:59 -0800
Message-ID: <1328425088-6562-16-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120205065759.LLTYSCSbYDYP1NVx1HkqdonxTqiOSF-PhKTObabUUgI@z>

Now we can safely extend parent top and shrink them according iobusn_resource tree.

Don't need that any more.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c4ed9cb..0aa5693 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -608,22 +608,6 @@ struct pci_bus *__ref pci_add_new_bus(struct pci_bus *parent, struct pci_dev *de
 	return child;
 }
 
-static void pci_fixup_parent_subordinate_busnr(struct pci_bus *child, int max)
-{
-	struct pci_bus *parent = child->parent;
-
-	/* Attempts to fix that up are really dangerous unless
-	   we're going to re-assign all bus numbers. */
-	if (!pcibios_assign_all_busses())
-		return;
-
-	while (parent->parent && parent->subordinate < max) {
-		parent->subordinate = max;
-		pci_write_config_byte(parent->self, PCI_SUBORDINATE_BUS, max);
-		parent = parent->parent;
-	}
-}
-
 static void __devinit pci_bus_update_top(struct pci_bus *parent,
 		 long size, struct resource *parent_res)
 {
@@ -956,23 +940,7 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 		if (!is_cardbus) {
 			child->bridge_ctl = bctl;
-			/*
-			 * Adjust subordinate busnr in parent buses.
-			 * We do this before scanning for children because
-			 * some devices may not be detected if the bios
-			 * was lazy.
-			 */
-			pci_fixup_parent_subordinate_busnr(child, max);
-			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
-			/*
-			 * now fix it up again since we have found
-			 * the real value of max.
-			 */
-			pci_fixup_parent_subordinate_busnr(child, max);
-
-		} else {
-			pci_fixup_parent_subordinate_busnr(child, max);
 		}
 		/*
 		 * Set the subordinate bus number to its real value.
-- 
1.7.7

