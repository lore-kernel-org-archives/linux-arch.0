Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36944 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756047AbdCTQub (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2017 12:50:31 -0400
Date: Mon, 20 Mar 2017 16:43:55 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
Message-ID: <20170320164354.GQ21222@n2100.armlinux.org.uk>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170320164355.RcfAvE1dzsdRw81so1WU-DfMLltpiBgCQCTyqrfpYFk@z>

On Mon, Feb 27, 2017 at 03:14:16PM +0000, Lorenzo Pieralisi wrote:
> The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
> and Posting") define rules for PCI configuration space transactions
> ordering and posting, that state that configuration writes have to
> be non-posted transactions.
> 
> Current ioremap interface on ARM provides mapping functions that
> provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
> memory type) aka posted writes, so PCI host controller drivers have
> no arch interface to remap PCI configuration space with memory
> attributes that comply with the PCI specifications for configuration
> space.
> 
> Implement an ARM specific pci_remap_cfgspace() interface that allows to
> map PCI config memory regions with MT_UNCACHED memory type (ie strongly
> ordered - non-posted writes), providing a remap function that complies
> with PCI specifications for config space transactions.

Doesn't this have the side effect that configuration writes can bypass
writes to device memory if there isn't an intervening dsb?  (They
probably can do on some CPUs today anyway.)

So, in any case, this looks like an improvement:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
