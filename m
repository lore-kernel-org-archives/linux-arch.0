From: MaJun <majun258@linux.alibaba.com>
Subject: [PATCH] arch/cksy: Support the pci in csky serial core
Date: Mon, 27 Jan 2020 10:56:21 +0800
Message-ID: <1580093781-927-1-git-send-email-majun258@linux.alibaba.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50120 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbgBFDsH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:48:07 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: majun258@linux.alibaba.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org

Add the pci related code for csky serial core.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig           |  4 ++++
 arch/csky/include/asm/pci.h | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/csky/include/asm/pci.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index cc5dc37..6ceafa3 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -62,6 +62,10 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_KPROBES if !CPU_CK610
 	select HAVE_KRETPROBES if !CPU_CK610
+	select GENERIC_PCI_IOMAP
+	select HAVE_PCI
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_SYSCALL if PCI
 
 config CPU_HAS_CACHEV2
 	bool
diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
new file mode 100644
index 0000000..ccd844e
--- /dev/null
+++ b/arch/csky/include/asm/pci.h
@@ -0,0 +1,17 @@
+#ifndef __ASM_CSKY_PCI_H
+#define __ASM_CSKY_PCI_H
+
+extern int isa_dma_bridge_buggy;
+
+#define PCIBIOS_MIN_IO      0x1000
+#define PCIBIOS_MIN_MEM     0x10000000
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc/bus/pci */
+	return 1;
+}
+
+#define pcibios_assign_all_busses()	1
+
+#endif /* __ASM_CSKY_PCI_H */
-- 
1.8.3.1
