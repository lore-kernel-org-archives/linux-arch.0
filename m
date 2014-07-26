From: Yijing Wang <wangyijing@huawei.com>
Subject: [RFC PATCH 06/11] PCI/MSI: Save MSI irq in PCI MSI layer
Date: Sat, 26 Jul 2014 11:08:43 +0800
Message-ID: <1406344128-27055-7-git-send-email-wangyijing@huawei.com>
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

Save MSI irq in PCI MSI layer, this is preparation
for generic MSI.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 21b16e0..f96dd38 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -650,8 +650,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	pci_intx_for_msi(dev, 0);
 	msi_set_enable(dev, 1);
 	dev->msi_enabled = 1;
-
-	dev->irq = entry->irq;
 	return 0;
 }
 
@@ -1059,6 +1057,7 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 {
 	int nvec;
 	int rc;
+	struct msi_desc *entry;
 
 	if (dev->current_state != PCI_D0)
 		return -EINVAL;
@@ -1114,6 +1113,8 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 		return rc;
 	}
 
+	entry = list_entry(dev->msi_list.next, struct msi_desc, list);
+	dev->irq = entry->irq;
 	return nvec;
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
-- 
1.7.1
