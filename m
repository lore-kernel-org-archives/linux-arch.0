From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 04/20] ARM64: implement pci_remap_cfgspace() interface
Date: Mon, 27 Feb 2017 15:14:15 +0000
Message-ID: <20170227151436.18698-5-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.co>
List-Id: linux-arch.vger.kernel.org

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") defines rules for PCI configuration space transactions
ordering and posting, that state that configuration writes
are non-posted transactions.

This rule is reinforced by the ARM v8 architecture reference manual
(issue A.k, Early Write Acknowledgment) that explicitly recommends
that No Early Write Acknowledgment attribute should be used to map
PCI configuration (write) transactions.

Current ioremap interface on ARM64 implements mapping functions
where the Early Write Acknowledgment hint is enabled, so they
cannot be used to map PCI configuration space in a PCI specs
compliant way.

Implement an ARM64 specific pci_remap_cfgspace() interface
that allows to map PCI config region with nGnRnE attributes, providing
a remap function that complies with PCI specifications and the ARMv8
architecture reference manual recommendations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/io.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 0c00c87..7a03250 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -173,6 +173,16 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iounmap				__iounmap
 
 /*
+ * PCI configuration space mapping function.
+ *
+ * PCI specifications disallows posted write configuration transactions.
+ * Add an arch specific pci_remap_cfgspace definition that is implemented
+ * through nGnRnE device memory attribute as recommended by the ARM v8
+ * Architecture reference manual Issue A.k B2.8.2 "Device memory".
+ */
+#define pci_remap_cfgspace(addr, size) __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
+
+/*
  * io{read,write}{16,32,64}be() macros
  */
 #define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-- 
2.10.0
