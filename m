Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:43336
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932621AbbIVHep (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Sep 2015 03:34:45 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 2/2] PCI: Build setup-irq.o for nios2
Date: Tue, 22 Sep 2015 15:19:27 +0800
Message-ID: <1442906367-10935-3-git-send-email-lftan@altera.com>
In-Reply-To: <1442906367-10935-1-git-send-email-lftan@altera.com>
References: <1442906367-10935-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
Message-ID: <20150922071927.q_1I58hplEyZZDP0I3EQw1NMuHbINyUPl5v18egE5yM@z>

nios2 requires setup-irq.o to provide pci_fixup_irqs() implementation.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..db8efcd 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
 obj-$(CONFIG_TILE) += setup-irq.o
 obj-$(CONFIG_SPARC_LEON) += setup-irq.o
 obj-$(CONFIG_M68K) += setup-irq.o
+obj-$(CONFIG_NIOS2) += setup-irq.o
 
 #
 # ACPI Related PCI FW Functions
-- 
1.8.2.1

