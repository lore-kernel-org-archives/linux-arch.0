From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 00/20] PCI: fix config and I/O Address space memory
 mappings
Date: Thu, 2 Mar 2017 18:00:57 +0000
Message-ID: <20170302180057.GA8094@red-moon>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <CAK8P3a2ULkNH39UJAeZSuw2kS+7wNyySs1RaY74ELGm498NmnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ULkNH39UJAeZSuw2kS+7wNyySs1RaY74ELGm498NmnA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Pratyush Anand <pratyush.anand@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>, Tanmay Inamdar <tinamdar@apm.com>, Murali Karicheri <m-karicheri2@ti.com>, Russell King <linux@armlinux.org.uk>, Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, Ray Jui <rjui@broadcom.com>, Wenrui Li <wenrui.li@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>, Minghuan Lian <minghuan.Lian@freescale.com>, Catalin Marinas <catalin>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 01, 2017 at 05:18:27PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 27, 2017 at 4:14 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> > This patch series[1] addresses both issues in one go:
> >
> > - It updates the pci_remap_iospace() function to use a page mapping
> >   that guarantees non-posted write transactions for I/O space addresses
> > - It adds a kernel API to remap PCI config space resources, so that
> >   architecture can override it with a mapping implementation that
> >   guarantees PCI specifications compliancy wrt non-posted write
> >   configuration transactions
> > - It updates all PCI host controller implementations (and the generic
> >   ECAM layer) to use the newly introduced mapping interface
> >
> > Tested on Juno ECAM based interface (DT/ACPI).
> 
> This looks all good to me, nice work!

Thanks a lot Arnd. There is a pending issue to complete the series,
that is related to asm-generic/io.h, which is not included by all
arches, therefore, on top of adding a default inline for
pci_remap_cfg_space() in asm-generic/io.h I will have to patch
all arches that do not include asm-generic/io.h (eg x86) to
make the series completely functional - ie I will have to add a

#define pci_remap_cfgspace ioremap_nocache

in every given asm/io.h that does not include <asm-generic/io.h>

Another option would consist in adding the default inline for
pci_remap_cfg_space() in asm-generic/pci_iomap.h which seems to
be included by all arches.

I think the first option, even if it requires more extensive
patching is more complete but please all let me know how
you want me to fix this niggle, I am not sure I grasp the background
policy behind asm-generic files entirely so I'd better ask.

Thanks !
Lorenzo
