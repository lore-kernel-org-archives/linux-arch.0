Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbdB0PPc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Feb 2017 10:15:32 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 02/20] PCI: fix pci_remap_iospace() remap attribute
Date: Mon, 27 Feb 2017 15:14:13 +0000
Message-ID: <20170227151436.18698-3-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170227151413.GykHVMK_TtF6qXeaCDKhVe3mrPm3_ikgqxtg7Xup4Xs@z>

According to the PCI local bus specifications (Revision 3.0, 3.2.5),
I/O Address space transactions are non-posted. On architectures where
I/O space is implemented through a chunk of memory mapped space mapped
to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
region backing I/O Address Space transactions determines the I/O
transactions attributes (before the transactions actually reaches the
PCI bus where it is handled according to the PCI specifications).

Current pci_remap_iospace() interface, that is used to map the PCI I/O
Address Space into virtual address space, use pgprot_device() as memory
attribute for the virtual address mapping, that in some architectures
(ie ARM64) provides non-cacheable but write bufferable mappings (ie
posted writes), which clash with the non-posted write behaviour for I/O
Address Space mandated by the PCI specifications.

Update the prot ioremap_page_range() parameter in pci_remap_iospace()
to pgprot_noncached to ensure that the virtual mapping backing
I/O Address Space guarantee non-posted write transactions issued
when addressing I/O Address Space through the MMIO mapping.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd98674..bfb3c6e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3375,7 +3375,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 		return -EINVAL;
 
 	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
-				  pgprot_device(PAGE_KERNEL));
+				  pgprot_noncached(PAGE_KERNEL));
 #else
 	/* this architecture does not have memory mapped I/O space,
 	   so this function should never be called */
-- 
2.10.0
