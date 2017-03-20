Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753238AbdCTQH1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 12:07:27 -0400
Date: Mon, 20 Mar 2017 11:06:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 02/20] PCI: fix pci_remap_iospace() remap attribute
Message-ID: <20170320160636.GB24572@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-3-lorenzo.pieralisi@arm.com>
 <20170316214844.GA17769@bhelgaas-glaptop.roam.corp.google.com>
 <20170317003321.GB28800@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317003321.GB28800@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andy Lutomirski <luto@amacapital.net>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wenrui Li <wenrui.li@rock-chips.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>, Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>, linux-arch@vger.kernel.org, Pratyush Anand <pratyush.anand@gmail.com>, Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>, Murali Karicheri <m-karicheri2@ti.com>, Arnd Bergmann <arnd@arndb.de>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, Stanimir Varbanov <svarbanov@mm-sol.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Message-ID: <20170320160636.z1FmkCAeB0Shu4ZF5zFGAPvXpY2wA8eGcPurrLy6qcs@z>

On Fri, Mar 17, 2017 at 01:33:21AM +0100, Luis R. Rodriguez wrote:
> On Thu, Mar 16, 2017 at 04:48:44PM -0500, Bjorn Helgaas wrote:
> > [+cc Luis]
> > 
> > On Mon, Feb 27, 2017 at 03:14:13PM +0000, Lorenzo Pieralisi wrote:
> > > According to the PCI local bus specifications (Revision 3.0, 3.2.5),
> > > I/O Address space transactions are non-posted. On architectures where
> > > I/O space is implemented through a chunk of memory mapped space mapped
> > > to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
> > > region backing I/O Address Space transactions determines the I/O
> > > transactions attributes (before the transactions actually reaches the
> > > PCI bus where it is handled according to the PCI specifications).
> > > 
> > > Current pci_remap_iospace() interface, that is used to map the PCI I/O
> > > Address Space into virtual address space, use pgprot_device() as memory
> > > attribute for the virtual address mapping, that in some architectures
> > > (ie ARM64) provides non-cacheable but write bufferable mappings (ie
> > > posted writes), 
> 
> <sarcasm>
> Gee wiz, I am glad this is so well documented.
> </sarcasm>

I'm not sure this is actionable feedback.  The two paragraphs above
seem clear and useful to me.  How would you like to see them improved?

> > > ...
> > > @@ -3375,7 +3375,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> > >  		return -EINVAL;
> > >  
> > >  	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
> > > -				  pgprot_device(PAGE_KERNEL));
> > > +				  pgprot_noncached(PAGE_KERNEL));
> > 
> > ...
> > I do find this puzzling because I naively expected pgprot_noncached()
> > to match up with ioremap_nocache(), and apparently it doesn't.
> > 
> > For example, ARM64 ioremap_nocache() uses PROT_DEVICE_nGnRE, which
> > doesn't match the MT_DEVICE_nGnRnE in pgprot_noncached().
> > 
> > The point of these patches is to use non-posted mappings.  Apparently
> > you can do that with pgprot_noncached() here, but ioremap_nocache()
> > isn't enough for the config space mappings?
> 
> This is for iospace it seems, so the other patch I think was for
> config space.

I understand that 02/20 is for PCI I/O port space and 03/20 is for PCI
config space.  I'm confused because I thought we wanted the same
non-posted mapping for both, but looks like they're different.

Patch 02/20 uses ioremap_page_range(..., pgprot_noncached(PAGE_KERNEL))
to map PCI I/O port space:

  #define pgprot_noncached(prot) \
          __pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRnE) | PTE_PXN | PTE_UXN)

Patch 03/20 uses ioremap_nocache() to map PCI config space:

  #define ioremap_nocache(addr, size)     __ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))

So the I/O port mapping uses MT_DEVICE_nGnRnE, while the config space
mapping uses PROT_DEVICE_nGnRE, which looks different.

Bjorn
