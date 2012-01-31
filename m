Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:59694 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab2AaHnh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2012 02:43:37 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/14] PCI: Strict checking of valid range for bridge
Date: Mon, 30 Jan 2012 23:42:49 -0800
Message-ID: <1327995772-11388-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
References: <1327995772-11388-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120131074249.H6zgh4zHUiRkPvs7R4_ydOgdU7L69bPFfbikS3Z_j2o@z>

children bridges busn range should be able to be allocated from parent bus range.

to avoid overlapping between sibling bridges on same bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 10aa6d1..b9459c5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -784,6 +784,31 @@ reduce_needed_size:
 	return ret;
 }
 
+static int __devinit pci_bridge_check_busn_broken(struct pci_bus *bus,
+				struct pci_dev *dev,
+				int secondary, int subordinate)
+{
+	int broken = 0;
+
+	struct resource busn_res;
+	int ret;
+
+	memset(&busn_res, 0, sizeof(struct resource));
+	dev_printk(KERN_DEBUG, &dev->dev,
+		 "check if busn %02x-%02x is in busn_res: %pR\n",
+		 secondary, subordinate, &bus->busn_res);
+	ret = allocate_resource(&bus->busn_res, &busn_res,
+			 (subordinate - secondary + 1),
+			 (pci_domain_nr(bus)<<8) | secondary,
+			 (pci_domain_nr(bus)<<8) | subordinate,
+			 1, NULL, NULL);
+	if (ret)
+		broken = 1;
+	else
+		release_resource(&busn_res);
+
+	return broken;
+}
 /*
  * If it's a bridge, configure it and scan the bus behind it.
  * For CardBus bridges, we don't scan behind as the devices will
-- 
1.7.7

