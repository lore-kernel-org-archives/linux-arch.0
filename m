From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v11 10/30] PCI: Add default busn_res for pci_scan_bus()
Date: Sun, 18 Mar 2012 22:42:41 -0700
Message-ID: <1332135781-13695-11-git-send-email-yinghai@kernel.org>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2378531..8a77b8b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1785,6 +1785,7 @@ struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
 	if (b)
 		b->subordinate = pci_scan_child_bus(b);
@@ -1802,6 +1803,7 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 
 	pci_add_resource(&resources, &ioport_resource);
 	pci_add_resource(&resources, &iomem_resource);
+	pci_add_resource(&resources, &busn_resource);
 	b = pci_create_root_bus(NULL, bus, ops, sysdata, &resources);
 	if (b) {
 		b->subordinate = pci_scan_child_bus(b);
-- 
1.7.7
