From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 00/10] Support for creating generic PCI host bridges
 from DT
Date: Mon, 22 Sep 2014 12:35:23 +0100
Message-ID: <20140922113523.GM1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <20140919215905.GB30239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59029 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbaIVLf3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Sep 2014 07:35:29 -0400
In-Reply-To: <20140919215905.GB30239@google.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 19, 2014 at 10:59:05PM +0100, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2014 at 02:30:15AM +0100, Liviu Dudau wrote:
> > This is my version 11 of the attempt at adding support for generic =
PCI host
> > bridge controllers that make use of device tree information to
> > configure themselves. It contains minor cleanups compared with v10 =
to address
> > the existing comments.
> > ...
> > Catalin Marinas (1):
> >   PCI: Introduce generic domain handling for PCI busses.
> >=20
> > Liviu Dudau (9):
> >   Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
> >   PCI: Introduce helper functions to deal with PCI I/O ranges.
> >   ARM: Define PCI_IOBASE as the base of virtual PCI IO space.
> >   PCI: OF: Fix the conversion of IO ranges into IO resources.
> >   PCI: Create pci_host_bridge before its associated bus in
> >     pci_create_root_bus.
> >   OF: Introduce helper function for getting PCI domain_nr
> >   OF: PCI: Add support for parsing PCI host bridge resources from D=
T
> >   PCI: Assign unassigned bus resources in pci_scan_root_bus()
> >   PCI: Introduce pci_remap_iospace() for remapping PCI I/O bus reso=
urces
> >     into CPU space
> >=20
> >  arch/arm/include/asm/io.h         |   1 +
> >  arch/arm/mach-integrator/pci_v3.c |  23 +++---
> >  drivers/of/address.c              | 146 ++++++++++++++++++++++++++=
++++++
> >  drivers/of/of_pci.c               | 170 ++++++++++++++++++++++++++=
++++++++++++
> >  drivers/pci/host/pci-tegra.c      |  10 ++-
> >  drivers/pci/host/pcie-rcar.c      |  21 +++--
> >  drivers/pci/pci.c                 |  33 ++++++++
> >  drivers/pci/probe.c               |  46 +++++++----
> >  include/asm-generic/io.h          |   2 +-
> >  include/asm-generic/pgtable.h     |   4 +
> >  include/linux/of_address.h        |  15 +---
> >  include/linux/of_pci.h            |  18 ++++
> >  include/linux/pci.h               |  24 ++++++
> >  13 files changed, 463 insertions(+), 50 deletions(-)
>=20
> I put this on a pci/liviu-generic-v11 branch.  I mentioned a couple t=
hings
> in response to the individual patches, so I'm hoping you can send me
> incremental patches to address them.  Then I'll update this branch, r=
ename
> it, and get it into linux-next.

Thanks a lot for that!

As I've mentioned in the other email, I can send incremental patches fo=
r most
of the comments (and Acks?). Don't know how to handle the split of=20
"[PATH v11 4/10] PCI: OF: Fix the conversion of IO ranges into IO resou=
rces."
that you are asking for.

Best regards,
Liviu

>=20
> Bjorn
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
