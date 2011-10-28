From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 13/34] microblaze/PCI: fix pci_bus_for_each_resource() usage
Date: Fri, 28 Oct 2011 16:26:36 -0600
Message-ID: <20111028222636.30729.59421.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35640 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab1J1W0j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:39 -0400
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

The pci_bus_for_each_resource() iterator sets "res" itself, so there's
no need to look it up in the bus->resource[] table.

Logically part of 89a74ecccd and 8a66da71fa.

CC: Michal Simek <monstr@monstr.eu>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/pci/pci-common.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 4cfae20..9df5e5b 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1018,7 +1018,6 @@ static void __devinit pcibios_fixup_bridge(struct pci_bus *bus)
 	struct pci_dev *dev = bus->self;
 
 	pci_bus_for_each_resource(bus, res, i) {
-		res = bus->resource[i];
 		if (!res)
 			continue;
 		if (!res->flags)
@@ -1218,7 +1217,6 @@ void pcibios_allocate_bus_resources(struct pci_bus *bus)
 		 pci_domain_nr(bus), bus->number);
 
 	pci_bus_for_each_resource(bus, res, i) {
-		res = bus->resource[i];
 		if (!res || !res->flags
 		    || res->start > res->end || res->parent)
 			continue;
