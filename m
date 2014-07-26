From: Yijing Wang <wangyijing@huawei.com>
Subject: [RFC PATCH 05/11] PCI/MSI: Move populate_msi_sysfs() out of
 msi_capability_init()
Date: Sat, 26 Jul 2014 11:08:42 +0800
Message-ID: <1406344128-27055-6-git-send-email-wangyijing@huawei.com>
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406344128-27055-1-git-send-email-wangyijing@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Paul.Mundt@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, virtualization@lists.linux-foundation.org, Xinwei Hu <huxinwei@huawei.com>, Yijing Wang <wangyijing@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, Wuyun <wuyun.wu@huawei.com>, arnab.basu@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Because some Non-PCI devices don't need to create sysfs object,
so move populate_msi_sysfs() out of generic MSI function
msi/x_capability_init().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 116383c..21b16e0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -646,13 +646,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 		return ret;
 	}
 
-	ret = populate_msi_sysfs(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, ~mask);
-		free_msi_irqs(dev);
-		return ret;
-	}
-
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
 	msi_set_enable(dev, 1);
@@ -760,10 +753,6 @@ static int msix_capability_init(struct pci_dev *dev, void __iomem *base,
 
 	msix_program_entries(dev, entries);
 
-	ret = populate_msi_sysfs(dev);
-	if (ret)
-		goto out_free;
-
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
@@ -789,7 +778,6 @@ out_avail:
 			ret = avail;
 	}
 
-out_free:
 	free_msi_irqs(dev);
 
 	return ret;
@@ -939,7 +927,7 @@ EXPORT_SYMBOL(pci_msix_vec_count);
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 {
 	int status, nr_entries;
-	int i, j;
+	int i, j, ret;
 	void __iomem *base;
 	u16 control;
 
@@ -980,6 +968,14 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 		return -ENOMEM;
 
 	status = msix_capability_init(dev, base, entries, nvec);
+	if (!status) {
+		ret = populate_msi_sysfs(dev);
+		if (ret) {
+			dev->msix_enabled = 0;
+			pci_intx_for_msi(dev, 1);
+			free_msi_irqs(dev);
+		}
+	}
 	return status;
 }
 EXPORT_SYMBOL(pci_enable_msix);
@@ -1109,6 +1105,15 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 		}
 	} while (rc);
 
+	rc = populate_msi_sysfs(dev);
+	if (rc) {
+		msi_set_enable(dev, 0);
+		pci_intx_for_msi(dev, 1);
+		dev->msi_enabled = 0;
+		free_msi_irqs(dev);
+		return rc;
+	}
+
 	return nvec;
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
-- 
1.7.1
