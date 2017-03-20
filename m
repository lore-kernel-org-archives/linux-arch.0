Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754839AbdCTQ1W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 12:27:22 -0400
Date: Mon, 20 Mar 2017 11:27:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 03/20] asm-generic/io.h: add PCI config space remap
 interface
Message-ID: <20170320162716.GC24572@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-4-lorenzo.pieralisi@arm.com>
 <20170316211243.GE9739@bhelgaas-glaptop.roam.corp.google.com>
 <20170317000803.GA28800@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317000803.GA28800@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Pratyush Anand <pratyush.anand@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Mingkai Hu <mingkai.hu@freescale.com>, John Garry <john.garry@huawei.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Jon Mason <jonmason@broadcom.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Thierry Reding <thierry.reding@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170320162716.7fGBoFWDUvu6-1aa5rgDMqFlFosPZY1EtSdG6mZmgFo@z>

On Fri, Mar 17, 2017 at 01:08:03AM +0100, Luis R. Rodriguez wrote:
> On Thu, Mar 16, 2017 at 04:12:43PM -0500, Bjorn Helgaas wrote:
> > [+cc Luis]
> > 
> > On Mon, Feb 27, 2017 at 03:14:14PM +0000, Lorenzo Pieralisi wrote:
> > > The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> > > Posting") mandate non-posted configuration transactions. As further
> > > highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
> > > Considerations for the Enhanced Configuration Access Mechanism"),
> > > through ECAM and ECAM-derivative configuration mechanism, the memory
> > > mapped transactions from the host CPU into Configuration Requests on the
> > > PCI express fabric may create ordering problems for software because
> > > writes to memory address are typically posted transactions (unless the
> > > architecture can enforce through virtual address mapping non-posted
> > > write transactions behaviour) but writes to Configuration Space are not
> > > posted on the PCI express fabric.
> > > 
> > > Current DT and ACPI host bridge controllers map PCI configuration space
> > > (ECAM and ECAM-derivative) into the virtual address space through
> > > ioremap() calls, that are non-cacheable device accesses on most
> > > architectures, but may provide "bufferable" or "posted" write semantics
> > > in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
> > > to be buffered in the bus connecting the host CPU to the PCI fabric;
> > > this behaviour, as underlined in the PCIe specifications, may trigger
> > > transactions ordering rules and must be prevented.
> > > 
> > > Introduce a new generic and explicit API to create a memory
> > > mapping for ECAM and ECAM-derivative config space area that
> > > defaults to ioremap_nocache() (which should provide a sane default
> > > behaviour) but still allowing architectures on which ioremap_nocache()
> > > results in posted write transactions to override the function
> > > call with an arch specific implementation that complies with
> > > the PCI specifications for configuration transactions.
> > ...

> > > +#ifndef pci_remap_cfgspace
> > > +#define pci_remap_cfgspace pci_remap_cfgspace
> > > +static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
> > > +					       size_t size)
> > > +{
> > > +	return ioremap_nocache(offset, size);
> > > +}
> > 
> > I'm fine with this conceptually, but I think it would make more sense
> > if the name weren't specific to PCI or config space, e.g.,
> > ioremap_nopost() or something.
> 
> Seems reasonable to me -- but are there other buses that could use
> this already as well ? Wouldn't these other buses also run into
> similar issues ? Can someone also bounce me a copy of the patches
> that use this ?

I forwarded a copy of the initial posting of all 20 patches to you.

> While at it, please add some documentation too, the above commit log
> is huge, and yet for the person eyeballing the code they won't have
> any clue why this was added exactly. Since this is about helping
> with picking the right ioremap due to certain semantics /
> requirements on the PCI config space, we should clarify then what
> exactly are the expectations here. The clearer you are the less in
> trouble we can get later.

I think the documentation above does contain the critical facts that:

  - Accesses to PCI config space and PCI I/O port space should be
    non-posted

  - ARM64 currently maps them as posted, which may cause ordering
    problems

It's possible the changelog could be made clearer by *removing* text,
but I'm not sure what Lorenzo could *add* to make it better.

This particular patch is generic (not ARM64-specific), so maybe all we
need to say here is that PCI requires non-posted mappings in some
cases, and we currently don't have a generic ioremap() to make them,
so we're adding a way for an arch to provide such an interface.

Bjorn
