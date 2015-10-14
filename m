Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0062.outbound.protection.outlook.com ([207.46.100.62]:52304
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750845AbbJNGqi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Oct 2015 02:46:38 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v2 3/4] PCI: Build setup-irq.o for nios2
Date: Wed, 14 Oct 2015 14:31:43 +0800
Message-ID: <1444804304-5213-4-git-send-email-lftan@altera.com>
In-Reply-To: <1444804304-5213-1-git-send-email-lftan@altera.com>
References: <1444804304-5213-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com
Message-ID: <20151014063143.LytMvRysj6nyOtThhIqeoQuHKZwk9w_4hygztitcBv8@z>

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

