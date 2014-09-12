From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v10 00/10] Support for creating generic PCI host bridges
 from DT
Date: Fri, 12 Sep 2014 10:30:18 +0100
Message-ID: <20140912093018.GX27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <5412ADE9.2050708@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5412ADE9.2050708@amd.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 12, 2014 at 09:25:13AM +0100, Suravee Suthikulpanit wrote:
> On 9/8/2014 8:54 AM, Liviu Dudau wrote:
> > This is my version 10 of the attempt at adding support for generic =
PCI host
> > bridge controllers that make use of device tree information to
> > configure themselves. This version reverses v9's attempt to create =
one function
> > to drive the whole process of extracting the host bridge ranges, se=
tup the
> > host bridge driver and then scan the root bus behind the host bridg=
e. While it
> > would've been quite user friendly, I agree that it would've caused =
a lot of pain
> > in the future.
> >
> > I would like to get ACKs for the remaining patches as I would like =
to integrate
> > this into -next in the following week.
> >
> > This version marks an implementation break with the previous versio=
ns as
> > of_create_pci_host_bridge() is now gone. It gets replaced by
> > of_pci_get_host_bridge_resources() that only parses the DT and extr=
acts the
> > relevant ranges and converts them to resources. The updated host br=
idge drivers
> > will have to follow the guidelines in this example code:
> >
> > static int foohb_probe(struct platform_device *pdev)
> > {
> > 	struct device_node *dn =3D pdev->dev.of_node;
> > 	struct foohb_drv *drv;
> > 	resource_size_t io_base =3D 0;  /* phys address for start of IO */
> > 	struct pci_bus *bus;
> > 	int err =3D 0;
> > 	LIST_HEAD(res);
> >
> > 	.....
> > 	err =3D of_pci_get_host_bridge_resources(dn, 0, 255, &res, &io_bas=
e);
> > 	if (err)
> > 		goto err_handling;
> > 	err =3D foohb_setup(drv, ...., &res, &io_base);
> > 	if (err)
> > 		goto err_handling;

Hi Suravee,

>=20
> My understanding is that the "foohb_setup" above is supposed to be eq=
uivalent
> to the "int (*setup)(struct pci_host_bridge *, resource_size_t)" in V=
9 that was
> passed in as an argument of "of_create_pci_hot_bridge()".

Correct. Parameters are probably different, but it is internal to your =
driver so
you can do whatever you want there.

>=20
> The problem I have is I need an intermediate step between "pci_create=
_root_bus()"
> and "pci_scan_child_bus()" in order to update the information such as=
 the "pci_bus->msi"
> before this is propagate down to the child bus during the "pci_scan_c=
hild_bus"
> which is also called in the pci_scan_root_bus() function.

How did that work with my v9 patchset? How does it work for other MSI-a=
ware platforms?
Are they not using pci_scan_child_bus()?

>=20
> Does this mean that I should not be calling the pci_scan_root_bus(), =
and tries to
> re-implement the same logic in my driver?

Bjorn can comment here, but there seems to be a long standing desire to=
 make
pci_scan_root_bus() more useful. If your change is generic enough, how =
about proposing
a patch for pci_scan_root_bus() and see what feedback you get.

Judging by the complete silence I'm getting on my change (patch 9/10) o=
f the same function,
we might be lucky enough and no one will notice ;) (Bjorn, I'm kidding =
and I know you
are busy).

Best regards,
Liviu

>=20
> Thanks,
>=20
> Suravee
>=20
> > 	.....
> > 	pci_add_flags(....);
> > 	bus =3D pci_scan_root_bus(&pdev->dev, 0, &foohb_ops, drv, &res);
> > 	if (!bus)
> > 		goto err_handling;
> > 	....
> > 	return 0;
> >
> > err_handling:
> > 	......
> > 	return err;
> > }
> >
>=20
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
