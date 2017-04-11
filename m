From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 20/32] parisc: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:29:00 +0100
Message-ID: <20170411122923.6285-21-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754838AbdDKMaG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 08:30:06 -0400
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
mandate non-posted configuration transactions. As further highlighted in
the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
Enhanced Configuration Access Mechanism"), through ECAM and
ECAM-derivative configuration mechanism, the memory mapped transactions
from the host CPU into Configuration Requests on the PCI express fabric
may create ordering problems for software because writes to memory
address are typically posted transactions (unless the architecture can
enforce through virtual address mapping non-posted write transactions
behaviour) but writes to Configuration Space are not posted on the PCI
express fabric.

Include the asm-generic ioremap_nopost() implementation (currently
falling back to ioremap_nocache()) to provide a non-posted writes
ioremap interface to kernel subsystems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 1a16f1d..373ba75 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -139,6 +139,7 @@ static inline void __iomem * ioremap(unsigned long offset, unsigned long size)
 #define ioremap_nocache(off, sz)	ioremap((off), (sz))
 #define ioremap_wc			ioremap_nocache
 #define ioremap_uc			ioremap_nocache
+#include <asm-generic/ioremap-nopost.h>
 
 extern void iounmap(const volatile void __iomem *addr);
 
-- 
2.10.0
