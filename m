Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:34316 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab2CADDI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 22:03:08 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 36/36] PCI, pciehp: Remove not needed bus number range checking
Date: Wed, 29 Feb 2012 19:00:37 -0800
Message-ID: <1330570837-26638-37-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120301030037.tJiDBZB1pynxMSbheRaBwRVOkdMFJOqmM_VeAA9Iuro@z>

Found hotplug adding one EM with bridge fail, bios only leave one bus range
 for slot.

[ 1169.621444] pciehp: No bus number available for hot-added bridge 0000:55:00.0
[ 1169.633277] pcieport 0000:40:03.0: PCI bridge to [bus 55-55]

With busn_res tracking and allocating, we don't need that checking anymore.

Parent bridges' bus number will be extended safely.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/pciehp_pci.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 47d9dc0..e21171c 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -37,18 +37,8 @@
 static int __ref pciehp_add_bridge(struct pci_dev *dev)
 {
 	struct pci_bus *parent = dev->bus;
-	int pass, busnr, start = parent->secondary;
-	int end = parent->subordinate;
+	int pass, busnr = parent->secondary;
 
-	for (busnr = start; busnr <= end; busnr++) {
-		if (!pci_find_bus(pci_domain_nr(parent), busnr))
-			break;
-	}
-	if (busnr-- > end) {
-		err("No bus number available for hot-added bridge %s\n",
-				pci_name(dev));
-		return -1;
-	}
 	for (pass = 0; pass < 2; pass++)
 		busnr = pci_scan_bridge(parent, dev, busnr, pass);
 	if (!dev->subordinate)
-- 
1.7.7

