From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Thu, 18 Sep 2014 02:30:22 +0100
Message-ID: <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Device Tree ML <devicetree@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Tanmay Inamdar <tinamdar@apm.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, Grant Likely <grant.likely@linaro.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Add of_pci_get_domain_nr() to retrieve the PCI domain number
of a given device from DT. If the information is not present,
the function can be requested to allocate a new domain number.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/of/of_pci.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pci.h |  7 ++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 8481996..7eaeac2 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -3,6 +3,8 @@
 #include <linux/of.h>
 #include <linux/of_pci.h>
 
+#include "of_private.h"
+
 static inline int __of_pci_pci_compare(struct device_node *node,
 				       unsigned int data)
 {
@@ -89,6 +91,66 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
 
+static atomic_t of_domain_nr = ATOMIC_INIT(-1);
+
+/*
+ * Get the maximum value for a domain number from the device tree
+ */
+static int of_get_max_pci_domain_nr(void)
+{
+	struct alias_prop *app;
+	int max_domain = -1;
+
+	mutex_lock(&of_mutex);
+	list_for_each_entry(app, &aliases_lookup, link) {
+		if (strncmp(app->stem, "pci-domain", 10) != 0)
+			continue;
+
+		max_domain = max(max_domain, app->id);
+	}
+	mutex_unlock(&of_mutex);
+
+	return max_domain;
+}
+
+/**
+ * This function will try to obtain the host bridge domain number by
+ * using of_alias_get_id() call with "pci-domain" as a stem. If that
+ * fails, a local allocator will be used. The local allocator can
+ * be requested to return a new domain_nr if the information is missing
+ * from the device tree.
+ *
+ * @node: device tree node with the domain information
+ * @allocate_if_missing: if DT lacks information about the domain nr,
+ * allocate a new number.
+ *
+ * Returns the associated domain number from DT, or a new domain number
+ * if DT information is missing and @allocate_if_missing is true. If
+ * @allocate_if_missing is false then the last allocated domain number
+ * will be returned.
+ */
+int of_pci_get_domain_nr(struct device_node *node, bool allocate_if_missing)
+{
+	int domain;
+
+	domain = atomic_read(&of_domain_nr);
+	if (domain == -1) {
+		/* first run, get max defined domain nr in device tree */
+		domain = of_get_max_pci_domain_nr();
+		/* then set the start value for allocator to be max + 1 */
+		atomic_set(&of_domain_nr, domain + 1);
+	}
+	domain = of_alias_get_id(node, "pci-domain");
+	if (domain == -ENODEV) {
+		domain = atomic_read(&of_domain_nr);
+		if (allocate_if_missing)
+			atomic_inc(&of_domain_nr);
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_domain_nr);
+
 #ifdef CONFIG_PCI_MSI
 
 static LIST_HEAD(of_pci_msi_chip_list);
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index dde3a4a..3a3824c 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -15,6 +15,7 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
 int of_pci_get_devfn(struct device_node *np);
 int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
+int of_pci_get_domain_nr(struct device_node *node, bool allocate_if_missing);
 #else
 static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
 {
@@ -43,6 +44,12 @@ of_pci_parse_bus_range(struct device_node *node, struct resource *res)
 {
 	return -EINVAL;
 }
+
+static inline int
+of_pci_get_domain_nr(struct device_node *node, bool allocate_if_missing)
+{
+	return -1;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
-- 
2.1.0
