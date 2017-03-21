Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54396 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbdCUQyX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2017 12:54:23 -0400
Date: Tue, 21 Mar 2017 16:53:50 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
Message-ID: <20170321165349.GB21222@n2100.armlinux.org.uk>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
 <20170320164354.GQ21222@n2100.armlinux.org.uk>
 <20170321152636.GA4799@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321152636.GA4799@red-moon>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170321165350.wPJIrMlKI9zX4JMwfxIOJ46xCBNAQUPpHSMWg-Xgm1o@z>

On Tue, Mar 21, 2017 at 03:26:36PM +0000, Lorenzo Pieralisi wrote:
> I assumed that in plain terms, the difference between MT_DEVICE and
> MT_UNCACHED is write posting (aka bufferable) behaviour (across CPU
> architecture versions) and that does not affect write ordering rules.

Having looked it up in the ARM ARM, I think we're fine.  Device and
strongly ordered accesses are both ordered as one group, so can be
thought of as the same.  The only difference is that Device can
complete from the CPU's perspective before it hits the peripheral,
whereas strongly ordered only completes once it's hit the peripheral.

So this looks like exactly the right thing to do here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
