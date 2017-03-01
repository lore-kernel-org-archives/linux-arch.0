Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36478 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdCAQ04 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 11:26:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 1 Mar 2017 17:18:27 +0100
Message-ID: <CAK8P3a2ULkNH39UJAeZSuw2kS+7wNyySs1RaY74ELGm498NmnA@mail.gmail.com>
Subject: Re: [PATCH 00/20] PCI: fix config and I/O Address space memory mappings
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Pratyush Anand <pratyush.anand@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Russell King <linux@armlinux.org.uk>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Catalin Marinas <catalin.marinas@arm.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>, John Garry <john.garry@huawei.com>
Message-ID: <20170301161827.QooO624mrFDQWh5BiLMEo-JqiJNKtlPPL5FAb3z_2VY@z>

On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> This patch series[1] addresses both issues in one go:
>
> - It updates the pci_remap_iospace() function to use a page mapping
>   that guarantees non-posted write transactions for I/O space addresses
> - It adds a kernel API to remap PCI config space resources, so that
>   architecture can override it with a mapping implementation that
>   guarantees PCI specifications compliancy wrt non-posted write
>   configuration transactions
> - It updates all PCI host controller implementations (and the generic
>   ECAM layer) to use the newly introduced mapping interface
>
> Tested on Juno ECAM based interface (DT/ACPI).

This looks all good to me, nice work!

    Arnd
