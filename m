Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36617 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdCAX63 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 18:58:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com> <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Mar 2017 01:54:42 +0200
Message-ID: <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
Subject: Re: [PATCH 07/20] PCI: implement Devres interface to map PCI config space
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170301235442.uIY1vI1sH5hrbrWq19KyM6Yg2Ej4Mqdkdcrq-tI3lT8@z>

On Mon, Feb 27, 2017 at 5:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The introduction of the pci_remap_cfgspace() interface allows
> PCI host controller drivers to map PCI config space through a
> dedicated kernel interface. Current PCI host controller drivers
> use the devm_ioremap_* Devres interfaces to map PCI configuration
> space regions so in order to update them to the new
> pci_remap_cfgspace() mapping interface a new set of Devres interfaces
> should be implemented so that PCI host controller drivers can make
> use of them.
>
> Introduce two new functions in the PCI kernel layer and Devres
> documentation:
>
> - devm_pci_remap_cfgspace()
> - devm_pci_remap_cfg_resource()
>
> so that PCI host controller drivers can make use of them to map
> PCI configuration space regions.

Wouldn't you like to be consistent with current PCI API, i.e.:
1. devm_*() functions called pcim_*() in PCI.
2. If you may notice there is no separate pcim_*map*() stuff, they are
dynamically adapting to the case.

?

-- 
With Best Regards,
Andy Shevchenko
