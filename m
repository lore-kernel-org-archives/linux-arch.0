From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 16/29] ia64/PCI: use pci_create_bus() instead of
	pci_scan_bus_parented()
Date: Thu, 13 Oct 2011 22:28:28 -0600
Message-ID: <20111014042828.23504.61212.stgit@bhelgaas.mtv.corp.google.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This doesn't change any functionality, but it makes a subsequent patch
slightly simpler.

CC: Tony Luck <tony.luck@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/pci/pci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index aa2533a..d7e47a9 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -386,8 +386,11 @@ pci_acpi_scan_root(struct acpi_pci_root *root)
 	 * should handle the case here, but it appears that IA64 hasn't
 	 * such quirk. So we just ignore the case now.
 	 */
-	pbus = pci_scan_bus_parented(NULL, bus, &pci_root_ops, controller);
+	pbus = pci_create_bus(NULL, bus, &pci_root_ops, controller, NULL);
+	if (!pbus)
+		return NULL;
 
+	pbus->subordinate = pci_scan_child_bus(pbus);
 	return pbus;
 
 out3:
