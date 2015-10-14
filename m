From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 3/4] PCI: Build setup-irq.o for nios2
Date: Wed, 14 Oct 2015 14:31:43 +0800
Message-ID: <1444804304-5213-4-git-send-email-lftan@altera.com>
References: <1444804304-5213-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1444804304-5213-1-git-send-email-lftan@altera.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
List-Id: linux-arch.vger.kernel.org

nios2 requires setup-irq.o to provide pci_fixup_irqs() implementation.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index be3f631..282b1b4 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
 obj-$(CONFIG_TILE) += setup-irq.o
 obj-$(CONFIG_SPARC_LEON) += setup-irq.o
 obj-$(CONFIG_M68K) += setup-irq.o
+obj-$(CONFIG_NIOS2) += setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
1.8.2.1
