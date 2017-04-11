Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754348AbdDKM3s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 08:29:48 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 10/32] hexagon: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:28:50 +0100
Message-ID: <20170411122923.6285-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Richard Kuo <rkuo@codeaurora.org>
Message-ID: <20170411122850.15w2fgHiyTUBPiCNcVB75KhGwOIWiFU-Vdc4CUihTdQ@z>

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
Cc: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 66f5e9a..be630bf 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -197,6 +197,8 @@ static inline void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 	return ioremap_nocache(phys_addr, size);
 }
 
+#include <asm-generic/ioremap-nopost.h>
+
 static inline void iounmap(volatile void __iomem *addr)
 {
 	__iounmap(addr);
-- 
2.10.0
