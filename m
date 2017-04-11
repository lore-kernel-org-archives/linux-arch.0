Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbdDKM3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 08:29:50 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 11/32] ia64: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:28:51 +0100
Message-ID: <20170411122923.6285-12-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Message-ID: <20170411122851.pI20pT8sRS5ODB2-sH6a_yCNNSPxn6scltC2l6_c87k@z>

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
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 5de673a..130956b 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -434,6 +434,7 @@ static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned lo
 }
 #define ioremap_cache ioremap_cache
 #define ioremap_uc ioremap_nocache
+#include <asm-generic/ioremap-nopost.h>
 
 
 /*
-- 
2.10.0
