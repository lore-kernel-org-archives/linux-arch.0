Return-Path: <SRS0=DwsV=37=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60918 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgBKDlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Feb 2020 22:41:12 -0500
From: Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Add PCI support
Date: Tue, 11 Feb 2020 11:41:07 +0800
Message-ID: <20200211034107.11192-1-guoren@linux.alibaba.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org, majun258@linux.alibaba.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200211034107.7DI1H3xChQ5pzmVhQx4tbuoTXUpVpBXLlRW50xl5Ugc@z>

From: MaJun <majun258@linux.alibaba.com>

Add the pci related code for csky arch to support basic pci virtual
function, such as qemu virt-pci-9pfs.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig           |  5 +++++
 arch/csky/include/asm/pci.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/csky/include/asm/pci.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bf246b036dee..72b2999a889a 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -58,6 +58,11 @@ config CSKY
 	select TIMER_OF
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select GENERIC_PCI_IOMAP
+	select HAVE_PCI
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_SYSCALL if PCI
+	select PCI_MSI if PCI
 
 config CPU_HAS_CACHEV2
 	bool
diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
new file mode 100644
index 000000000000..ebc765b1f78b
--- /dev/null
+++ b/arch/csky/include/asm/pci.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_CSKY_PCI_H
+#define __ASM_CSKY_PCI_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0
+
+/* C-SKY shim does not initialize PCI bus */
+#define pcibios_assign_all_busses() 1
+
+extern int isa_dma_bridge_buggy;
+
+#ifdef CONFIG_PCI
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on csky */
+	return -ENODEV;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif  /* CONFIG_PCI */
+
+#endif  /* __ASM_CSKY_PCI_H */
-- 
2.17.0
