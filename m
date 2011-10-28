Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:10139 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642Ab1J1W2U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Oct 2011 18:28:20 -0400
Subject: [PATCH v3 32/34] x86/PCI: convert to pci_create_root_bus() and
	pci_scan_root_bus()
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 28 Oct 2011 16:28:14 -0600
Message-ID: <20111028222814.30729.72855.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Yinghai Lu <yinghai.lu@oracle.com>
Message-ID: <20111028222814.8idt3zGV8a8msg-0athhSTdJPxHj2vODaDJ-ei8B-Jg@z>

x86 has two kinds of PCI root bus scanning:

(1) ACPI-based, using _CRS resources.  This used pci_create_bus(), not
    pci_scan_bus(), because ACPI hotplug needed to split the
    pci_bus_add_devices() into a separate host bridge .start() method.

    This patch parses the _CRS resources earlier, so we can build a list of
    resources and pass it to pci_create_root_bus().

    Note that as before, we parse the _CRS even if we aren't going to use
    it so we can print it for debugging purposes.

(2) All other, which used either default resources (ioport_resource and
    iomem_resource) or information read from the hardware via amd_bus.c or
    similar.  This used pci_scan_bus().

    This patch converts x86_pci_root_bus_res_quirks() (previously called
    from pcibios_fixup_bus()) to x86_pci_root_bus_resources(), which builds
    a list of resources before we call pci_scan_root_bus().

    We also use x86_pci_root_bus_resources() if we have ACPI but are
    ignoring _CRS.

CC: Yinghai Lu <yinghai.lu@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/include/asm/topology.h |    2 +-
 arch/x86/pci/acpi.c             |   28 ++++++++++++++--------------
 arch/x86/pci/bus_numa.c         |   31 ++++++++++++++++++-------------
 arch/x86/pci/common.c           |   19 ++++++++++++-------
 4 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index c006924..5f83b13 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -174,7 +174,7 @@ static inline void arch_fix_phys_package_id(int num, u32 slot)
 }
 
 struct pci_bus;
-void x86_pci_root_bus_res_quirks(struct pci_bus *b);
+void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
 #ifdef CONFIG_SMP
 #define mc_capable()	((boot_cpu_data.x86_max_cores > 1) && \
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index bac9b94..a794ba0 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -12,7 +12,7 @@ struct pci_root_info {
 	char *name;
 	unsigned int res_num;
 	struct resource *res;
-	struct pci_bus *bus;
+	struct list_head *resources;
 	int busnum;
 };
 
@@ -258,23 +258,20 @@ static void add_resources(struct pci_root_info *info)
 				 "ignoring host bridge window %pR (conflicts with %s %pR)\n",
 				 res, conflict->name, conflict);
 		else
-			pci_bus_add_resource(info->bus, res, 0);
+			pci_add_resource(info->resources, res);
 	}
 }
 
 static void
 get_current_resources(struct acpi_device *device, int busnum,
-			int domain, struct pci_bus *bus)
+		      int domain, struct list_head *resources)
 {
 	struct pci_root_info info;
 	size_t size;
 
-	if (pci_use_crs)
-		pci_bus_remove_resources(bus);
-
 	info.bridge = device;
-	info.bus = bus;
 	info.res_num = 0;
+	info.resources = resources;
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, count_resource,
 				&info);
 	if (!info.res_num)
@@ -283,7 +280,7 @@ get_current_resources(struct acpi_device *device, int busnum,
 	size = sizeof(*info.res) * info.res_num;
 	info.res = kmalloc(size, GFP_KERNEL);
 	if (!info.res)
-		goto res_alloc_fail;
+		return;
 
 	info.name = kasprintf(GFP_KERNEL, "PCI Bus %04x:%02x", domain, busnum);
 	if (!info.name)
@@ -301,8 +298,6 @@ get_current_resources(struct acpi_device *device, int busnum,
 
 name_alloc_fail:
 	kfree(info.res);
-res_alloc_fail:
-	return;
 }
 
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
@@ -310,6 +305,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct acpi_device *device = root->device;
 	int domain = root->segment;
 	int busnum = root->secondary.start;
+	LIST_HEAD(resources);
 	struct pci_bus *bus;
 	struct pci_sysdata *sd;
 	int node;
@@ -364,11 +360,15 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
 		memcpy(bus->sysdata, sd, sizeof(*sd));
 		kfree(sd);
 	} else {
-		bus = pci_create_bus(NULL, busnum, &pci_root_ops, sd);
-		if (bus) {
-			get_current_resources(device, busnum, domain, bus);
+		get_current_resources(device, busnum, domain, &resources);
+		if (list_empty(&resources))
+			x86_pci_root_bus_resources(busnum, &resources);
+		bus = pci_create_root_bus(NULL, busnum, &pci_root_ops, sd,
+					  &resources);
+		if (bus)
 			bus->subordinate = pci_scan_child_bus(bus);
-		}
+		else
+			pci_free_resource_list(&resources);
 	}
 
 	/* After the PCI-E bus has been walked and all devices discovered,
diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 64a1228..fd3f655 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -7,45 +7,50 @@
 int pci_root_num;
 struct pci_root_info pci_root_info[PCI_ROOT_NR];
 
-void x86_pci_root_bus_res_quirks(struct pci_bus *b)
+void x86_pci_root_bus_resources(int bus, struct list_head *resources)
 {
 	int i;
 	int j;
 	struct pci_root_info *info;
 
-	/* don't go for it if _CRS is used already */
-	if (b->resource[0] != &ioport_resource ||
-	    b->resource[1] != &iomem_resource)
-		return;
-
 	if (!pci_root_num)
-		return;
+		goto default_resources;
 
 	for (i = 0; i < pci_root_num; i++) {
-		if (pci_root_info[i].bus_min == b->number)
+		if (pci_root_info[i].bus_min == bus)
 			break;
 	}
 
 	if (i == pci_root_num)
-		return;
+		goto default_resources;
 
-	printk(KERN_DEBUG "PCI: peer root bus %02x res updated from pci conf\n",
-			b->number);
+	printk(KERN_DEBUG "PCI: root bus %02x: hardware-probed resources\n",
+	       bus);
 
-	pci_bus_remove_resources(b);
 	info = &pci_root_info[i];
 	for (j = 0; j < info->res_num; j++) {
 		struct resource *res;
 		struct resource *root;
 
 		res = &info->res[j];
-		pci_bus_add_resource(b, res, 0);
+		pci_add_resource(resources, res);
 		if (res->flags & IORESOURCE_IO)
 			root = &ioport_resource;
 		else
 			root = &iomem_resource;
 		insert_resource(root, res);
 	}
+	return;
+
+default_resources:
+	/*
+	 * We don't have any host bridge aperture information from the
+	 * "native host bridge drivers," e.g., amd_bus or broadcom_bus,
+	 * so fall back to the defaults historically used by pci_create_bus().
+	 */
+	printk(KERN_DEBUG "PCI: root bus %02x: using default resources\n", bus);
+	pci_add_resource(resources, &ioport_resource);
+	pci_add_resource(resources, &iomem_resource);
 }
 
 void __devinit update_res(struct pci_root_info *info, resource_size_t start,
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index b389a2d..6cdd4cd 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -164,9 +164,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus *b)
 {
 	struct pci_dev *dev;
 
-	/* root bus? */
-	if (!b->parent)
-		x86_pci_root_bus_res_quirks(b);
 	pci_read_bridge_bases(b);
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
@@ -433,6 +430,7 @@ void __init dmi_check_pciprobe(void)
 
 struct pci_bus * __devinit pcibios_scan_root(int busnum)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *bus = NULL;
 	struct pci_sysdata *sd;
 
@@ -456,9 +454,12 @@ struct pci_bus * __devinit pcibios_scan_root(int busnum)
 	sd->node = get_mp_bus_to_node(busnum);
 
 	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
-	bus = pci_scan_bus(busnum, &pci_root_ops, sd);
-	if (!bus)
+	x86_pci_root_bus_resources(busnum, &resources);
+	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
+	if (!bus) {
+		pci_free_resource_list(&resources);
 		kfree(sd);
+	}
 
 	return bus;
 }
@@ -639,6 +640,7 @@ int pci_ext_cfg_avail(struct pci_dev *dev)
 
 struct pci_bus * __devinit pci_scan_bus_on_node(int busno, struct pci_ops *ops, int node)
 {
+	LIST_HEAD(resources);
 	struct pci_bus *bus = NULL;
 	struct pci_sysdata *sd;
 
@@ -653,9 +655,12 @@ struct pci_bus * __devinit pci_scan_bus_on_node(int busno, struct pci_ops *ops,
 		return NULL;
 	}
 	sd->node = node;
-	bus = pci_scan_bus(busno, ops, sd);
-	if (!bus)
+	x86_pci_root_bus_resources(busno, &resources);
+	bus = pci_scan_root_bus(NULL, busno, ops, sd, &resources);
+	if (!bus) {
+		pci_free_resource_list(&resources);
 		kfree(sd);
+	}
 
 	return bus;
 }

