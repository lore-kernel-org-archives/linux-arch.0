Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:35537 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab1J1W0I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:26:08 -0400
Subject: [PATCH v3 07/34] PCI: deprecate pci_scan_bus_parented()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:26:05 -0600
Message-ID: <20111028222605.30729.48907.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Message-ID: <20111028222605.O7d3s543Mz18qr_qymN9VcZ0esniOB3aFUPG0tUzSJ4@z>

Users of pci_scan_bus_parented() should be converted to use either
    pci_scan_root_bus() (preferred, but also calls pci_bus_add_devices)
or
    pci_create_root_bus()
    pci_scan_child_bus()

Since pci_scan_bus_parented(), I'm marking it deprecated now and will
actually remove it later.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 drivers/pci/probe.c                        |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index d5ac362..d5848d1 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -609,3 +609,15 @@ When:	3.5
 Why:	The iwlagn module has been renamed iwlwifi.  The alias will be around
 	for backward compatibility for several cycles and then dropped.
 Who:	Don Fry <donald.h.fry@intel.com>
+
+----------------------------
+
+What:	pci_scan_bus_parented()
+When:	3.5
+Why:	The pci_scan_bus_parented() interface creates a new root bus.  The
+	bus is created with default resources (ioport_resource and
+	iomem_resource) that are always wrong, so we rely on arch code to
+	correct them later.  Callers of pci_scan_bus_parented() should
+	convert to using pci_scan_root_bus() so they can supply a list of
+	bus resources when the bus is created.
+Who:	Bjorn Helgaas <bhelgaas@google.com>
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 72261a7..2863865 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1643,6 +1643,7 @@ struct pci_bus *pci_create_bus(struct device *parent,
 	return b;
 }
 
+/* Deprecated; use pci_scan_root_bus() instead */
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
 		int bus, struct pci_ops *ops, void *sysdata)
 {

