Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:25974 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964791Ab2B2XIo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Feb 2012 18:08:44 -0500
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 25/39] PCI: add default res for pci_scan_bus
Date: Wed, 29 Feb 2012 15:07:24 -0800
Message-ID: <1330556858-11768-26-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20120229230724.0624KAKCD7do_LWsB3STc4fEdMVlxUeXIKtZR7P2QcI@z>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1149109..1c07aba 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1784,6 +1784,7 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
 	if (b)
 		b->subordinate = pci_scan_child_bus(b);
@@ -1801,6 +1802,7 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
 	if (b) {
 		b->subordinate = pci_scan_child_bus(b);
-- 
1.7.7

