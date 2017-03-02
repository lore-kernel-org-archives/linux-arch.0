Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36831 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbdCBT02 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2017 14:26:28 -0500
Date: Thu, 2 Mar 2017 14:24:06 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
Message-ID: <20170302192406.GA8519@wtj.duckdns.org>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
 <20170302120546.GB17277@red-moon>
 <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170302192406.8FVa6275Ch6WGTktBwfORu0u8fhX3-5brVjHIloGOv0@z>

Hello,

On Thu, Mar 02, 2017 at 02:50:00PM +0200, Andy Shevchenko wrote:
> > I thought about that and did not do it because here we are remapping
> > resources that are _not_ PCI bus resources (ie it is not PCI BARs we
> > are remapping), keeping the devm_* prefix would be more consistent
> > to the typical device drivers remapping functions pattern (ie a
> > typical PCI host controller driver would mix devm_ and pcim_ calls
> > which is a bit hard to parse), that was my rationale.
> >
> > I am not too fussed about that either way, I am happy to update it to
> > pcim_* though, it is Bjorn/Arnd's decision.
> 
> I would vote for pcim_*() variant.

Me too, for brevity.

> >> 2. If you may notice there is no separate pcim_*map*() stuff, they are
> >> dynamically adapting to the case.
> >
> > I do not understand what you mean here I would ask you to elaborate
> > a bit more please so that I can do something about it.
> 
> Oh, sorry, there are two examples currently, i.e.
> pci_enable_msi()/pci_enable_msix() and pci_request_region*() which has
> no "m" in the name, but are managed on release by pcim_release().
> Some developers consider this as a bad idea, but so far no patch has
> been sent to introduce pcim_*() variants of those.
>
> So, regarding to your stuff, I would stick with "pcim" prefix.

Sounds good to me.

Thanks.

-- 
tejun
