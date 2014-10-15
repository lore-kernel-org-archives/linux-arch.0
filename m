From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 03/27] s390/MSI: Use __msi_mask_irq() instead of default_msi_mask_irq()
Date: Wed, 15 Oct 2014 11:06:51 +0800
Message-ID: <1413342435-7876-4-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Now only s390/MSI use default_msi_mask_irq() and
default_msix_mask_irq(), replace them with the common
msi mask irq functions __msi_mask_irq() and __msix_mask_irq().
Remove default_msi_mask_irq() and default_msix_mask_irq().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/s390/pci/pci.c |    4 ++--
 include/linux/msi.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2fa7b14..552b990 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -448,9 +448,9 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	/* Release MSI interrupts */
 	list_for_each_entry(msi, &pdev->msi_list, list) {
 		if (msi->msi_attrib.is_msix)
-			default_msix_mask_irq(msi, 1);
+			__msix_mask_irq(msi, 1);
 		else
-			default_msi_mask_irq(msi, 1, 1);
+			__msi_mask_irq(msi, 1, 1);
 		irq_set_msi_desc(msi->irq, NULL);
 		irq_free_desc(msi->irq);
 		msi->msg.address_lo = 0;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 9ac1e3b..175aa21 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -65,8 +65,6 @@ void arch_restore_msi_irqs(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
-#define default_msi_mask_irq	__msi_mask_irq
-#define default_msix_mask_irq	__msix_mask_irq
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.1
