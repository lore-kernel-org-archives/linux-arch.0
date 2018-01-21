From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v11 3/9] PCI: Add fwnode handler as input param of pci_register_io_range()
Date: Sun, 21 Jan 2018 20:27:21 +0800
Message-ID: <1516537647-50553-4-git-send-email-john.garry@huawei.com>
References: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516537647-50553-1-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
Cc: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

In preparation for having the PCI MMIO helpers to use the new generic
I/O space management(LOGIC_PIO) we need to add the fwnode handler as
extra input parameter.
This patch changes the signature of pci_register_io_range() and of
its callers as needed.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/acpi/pci_root.c | 8 +++++---
 drivers/of/address.c    | 4 +++-
 drivers/pci/pci.c       | 3 ++-
 include/linux/pci.h     | 3 ++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6fc204a..1213479 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -729,7 +729,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
+static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
 	struct resource *res = entry->res;
@@ -738,7 +739,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
 	resource_size_t length = resource_size(res);
 	unsigned long port;
 
-	if (pci_register_io_range(cpu_addr, length))
+	if (pci_register_io_range(fwnode, cpu_addr, length))
 		goto err;
 
 	port = pci_address_to_pio(cpu_addr);
@@ -780,7 +781,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
 	else {
 		resource_list_for_each_entry_safe(entry, tmp, list) {
 			if (entry->res->flags & IORESOURCE_IO)
-				acpi_pci_root_remap_iospace(entry);
+				acpi_pci_root_remap_iospace(&device->fwnode,
+						entry);
 
 			if (entry->res->flags & IORESOURCE_DISABLED)
 				resource_list_destroy_entry(entry);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index c6c410b..85975fe 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt)	"OF: " fmt
 
 #include <linux/device.h>
+#include <linux/fwnode.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
@@ -335,7 +336,8 @@ int of_pci_range_to_resource(struct of_pci_range *range,
 
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long port;
-		err = pci_register_io_range(range->cpu_addr, range->size);
+		err = pci_register_io_range(&np->fwnode, range->cpu_addr,
+				range->size);
 		if (err)
 			goto invalid_range;
 		port = pci_address_to_pio(range->cpu_addr);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8357ff..d60f0a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3383,7 +3383,8 @@ struct io_range {
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t	size)
 {
 	int err = 0;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8329983..1b70732 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1225,7 +1225,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(phys_addr_t addr, resource_size_t size);
+int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+			resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
