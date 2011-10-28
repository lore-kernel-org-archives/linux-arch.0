From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 11/34] ia64/PCI: use pci_create_bus() instead of
	pci_scan_bus_parented()
Date: Fri, 28 Oct 2011 16:26:26 -0600
Message-ID: <20111028222626.30729.74531.stgit@bhelgaas.mtv.corp.google.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

This doesn't change any functionality, but it makes a subsequent patch
slightly simpler.

CC: Tony Luck <tony.luck@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/pci/pci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index aa2533a..a952fce 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -386,8 +386,11 @@ pci_acpi_scan_root(struct acpi_pci_root *root)
 	 * should handle the case here, but it appears that IA64 hasn't
 	 * such quirk. So we just ignore the case now.
 	 */
-	pbus = pci_scan_bus_parented(NULL, bus, &pci_root_ops, controller);
+	pbus = pci_create_bus(NULL, bus, &pci_root_ops, controller);
+	if (!pbus)
+		return NULL;
 
+	pbus->subordinate = pci_scan_child_bus(pbus);
 	return pbus;
 
 out3:
