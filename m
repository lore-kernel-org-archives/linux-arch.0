From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v9 06/12] ARM: integrator: Correct usage of
 of_pci_range_to_resource()
Date: Mon, 8 Sep 2014 13:25:49 +0100
Message-ID: <20140908122549.GI27864@e106497-lin.cambridge.arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-7-git-send-email-Liviu.Dudau@arm.com>
 <20140905220820.GI8080@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33775 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaIHMZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Sep 2014 08:25:54 -0400
In-Reply-To: <20140905220820.GI8080@google.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Sep 05, 2014 at 11:08:20PM +0100, Bjorn Helgaas wrote:
> [+cc Linus]
>=20
> On Tue, Aug 12, 2014 at 05:25:19PM +0100, Liviu Dudau wrote:
> > Previously, of_pci_range_to_resource() would return a resource
> > that contained physical addresses of the IO space even if the
> > IORESOURCE_IO flags mandate a logical port set of values. Now
> > that the function has been fixed we need to update the drivers
> > that were taking advantage of the old behaviour.
> >=20
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>=20
> Something's wrong with the CC: list.  You list Linus here in the chan=
gelog,
> but I don't see him in the CC: headers.

Yes, turns out one of my .git/config directories had supresscc=3Dall.

Best regards,
Liviu

>=20
> > ---
> >  arch/arm/mach-integrator/pci_v3.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-inte=
grator/pci_v3.c
> > index 05e1f73..193b7f8 100644
> > --- a/arch/arm/mach-integrator/pci_v3.c
> > +++ b/arch/arm/mach-integrator/pci_v3.c
> > @@ -660,6 +660,7 @@ static void __init pci_v3_preinit(void)
> >  {
> >  	unsigned long flags;
> >  	unsigned int temp;
> > +	phys_addr_t io_address =3D pci_pio_to_address(io_mem.start);
> > =20
> >  	pcibios_min_mem =3D 0x00100000;
> > =20
> > @@ -701,7 +702,7 @@ static void __init pci_v3_preinit(void)
> >  	/*
> >  	 * Setup window 2 - PCI IO
> >  	 */
> > -	v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(io_mem.start) |
> > +	v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(io_address) |
> >  			V3_LB_BASE_ENABLE);
> >  	v3_writew(V3_LB_MAP2, v3_addr_to_lb_map2(0));
> > =20
> > @@ -742,6 +743,7 @@ static void __init pci_v3_preinit(void)
> >  static void __init pci_v3_postinit(void)
> >  {
> >  	unsigned int pci_cmd;
> > +	phys_addr_t io_address =3D pci_pio_to_address(io_mem.start);
> > =20
> >  	pci_cmd =3D PCI_COMMAND_MEMORY |
> >  		  PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
> > @@ -758,7 +760,7 @@ static void __init pci_v3_postinit(void)
> >  		       "interrupt: %d\n", ret);
> >  #endif
> > =20
> > -	register_isa_ports(non_mem.start, io_mem.start, 0);
> > +	register_isa_ports(non_mem.start, io_address, 0);
> >  }
> > =20
> >  /*
> > @@ -867,33 +869,33 @@ static int __init pci_v3_probe(struct platfor=
m_device *pdev)
> > =20
> >  	for_each_of_pci_range(&parser, &range) {
> >  		if (!range.flags) {
> > -			of_pci_range_to_resource(&range, np, &conf_mem);
> > +			ret =3D of_pci_range_to_resource(&range, np, &conf_mem);
> >  			conf_mem.name =3D "PCIv3 config";
> >  		}
> >  		if (range.flags & IORESOURCE_IO) {
> > -			of_pci_range_to_resource(&range, np, &io_mem);
> > +			ret =3D of_pci_range_to_resource(&range, np, &io_mem);
> > +			dev_info(&pdev->dev, "IO PCI range converted\n");
> >  			io_mem.name =3D "PCIv3 I/O";
> >  		}
> >  		if ((range.flags & IORESOURCE_MEM) &&
> >  			!(range.flags & IORESOURCE_PREFETCH)) {
> >  			non_mem_pci =3D range.pci_addr;
> >  			non_mem_pci_sz =3D range.size;
> > -			of_pci_range_to_resource(&range, np, &non_mem);
> > +			ret =3D of_pci_range_to_resource(&range, np, &non_mem);
> >  			non_mem.name =3D "PCIv3 non-prefetched mem";
> >  		}
> >  		if ((range.flags & IORESOURCE_MEM) &&
> >  			(range.flags & IORESOURCE_PREFETCH)) {
> >  			pre_mem_pci =3D range.pci_addr;
> >  			pre_mem_pci_sz =3D range.size;
> > -			of_pci_range_to_resource(&range, np, &pre_mem);
> > +			ret =3D of_pci_range_to_resource(&range, np, &pre_mem);
> >  			pre_mem.name =3D "PCIv3 prefetched mem";
> >  		}
> > -	}
> > =20
> > -	if (!conf_mem.start || !io_mem.start ||
> > -	    !non_mem.start || !pre_mem.start) {
> > -		dev_err(&pdev->dev, "missing ranges in device node\n");
> > -		return -EINVAL;
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "missing ranges in device node\n");
> > +			return -EINVAL;
> > +		}
> >  	}
> > =20
> >  	pci_v3.map_irq =3D of_irq_parse_and_map_pci;
> > --=20
> > 2.0.4
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
