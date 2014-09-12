From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v10 09/10] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
Date: Fri, 12 Sep 2014 11:34:29 +0100
Message-ID: <20140912103429.GA1994@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
 <5412C75F.30207@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55128 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbaILKef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Sep 2014 06:34:35 -0400
In-Reply-To: <5412C75F.30207@amd.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 12, 2014 at 11:13:51AM +0100, Suravee Suthikulpanit wrote:
> On 9/8/2014 8:54 AM, Liviu Dudau wrote:
> > If the firmware has not assigned all the bus resources and
> > we are not just probing the PCIe busses, it makes sense to
> > assign the unassigned resources in pci_scan_root_bus().
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > ---
> >   drivers/pci/probe.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index ef891d2..508cf61 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct devi=
ce *parent, int bus,
> >   	if (!found)
> >   		pci_bus_update_busn_res_end(b, max);
> >
> > +	if (!pci_has_flag(PCI_PROBE_ONLY))
> > +		pci_assign_unassigned_bus_resources(b);
> > +
> >   	pci_bus_add_devices(b);
> >   	return b;
> >   }
> >
>=20
> Liviu,
>=20
> Besides the check for PCI_PROBE_ONLY here, I think we also need to av=
oid calling
> "pci_enable_resources()" in the "driver/pci/pci.c: pcibios_enable_dev=
ice()" for
> PCI_PROBE_ONLY mode since the resource is not assigned by Linux. Othe=
rwise, the
> "drivers/pci/setup-res.c: pci_enable_resource()" would fail w/ error:
>=20
>      can't enable device: BAR ..... not assigned

Hmm, are you sure that is not because the host bridge resources have no=
t been
requested? pci-host-generic.c uses PCI_PROBE_ONLY and yet it works with=
 the series as
is. But it does request_resource() for the host bridge resources inside=
 the driver.

Best regards,
Liviu

>=20
> Actually, in "arch/arm/kernel/bios32.c:", the weak "pcibios_enable_de=
vice()" function
> also has the check for PCI_PROBE_ONLY mode before calling pci_enable_=
resources().
>=20
> Thanks,
>=20
> Suravee
>=20
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
