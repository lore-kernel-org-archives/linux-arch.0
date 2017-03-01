Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33078 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbdCAQRU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 11:17:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com> <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 1 Mar 2017 17:15:14 +0100
Message-ID: <CAK8P3a36fX2gdgdYcVT1Zg=5dsN1o-Z=Xy4471zxRWwnr1aZvw@mail.gmail.com>
Subject: Re: [PATCH 01/20] PCI: remove __weak tag from pci_remap_iospace()
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170301161514.n5g-a8XEW6PKJqI4kk3h67Yy2LfGH_vIdqdDe2JiF0U@z>

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> pci_remap_iospace() is marked as a weak symbol even though
> no architecture is currently overriding it; given that its
> implementation internals have already code paths that are
> arch specific (ie PCI_IOBASE and ioremap_page_range() attributes)
> there is no need to leave the weak symbol in the kernel since the
> same functionality can be achieved by customizing per-arch the
> corresponding functionality.
>
> Remove the __weak symbol from pci_remap_iospace().

Good idea,

Acked-by: Arnd Bergmann <arnd@arndb.de>
