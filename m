From: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v10 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Date: Wed, 10 Sep 2014 17:53:47 +0100
Message-ID: <20140910165347.GJ27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-9-git-send-email-Liviu.Dudau@arm.com>
 <20140909133546.GB2636@e102568-lin.cambridge.arm.com>
 <20140910142241.GD27864@e106497-lin.cambridge.arm.com>
 <20140910151026.GB11640@e102568-lin.cambridge.arm.com>
 <20140910153233.GG27864@e106497-lin.cambridge.arm.com>
 <20140910163746.GB19662@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140910163746.GB19662-7AyDDHkRsp3ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 10, 2014 at 05:37:47PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 10, 2014 at 04:32:33PM +0100, Liviu Dudau wrote:
>=20
> [...]
>=20
> > > > > > +		/*
> > > > > > +		 * If we failed translation or got a zero-sized region
> > > > > > +		 * then skip this range
> > > > > > +		 */
> > > > > > +		if (range.cpu_addr =3D=3D OF_BAD_ADDR || range.size =3D=3D=
 0)
> > > > > > +			continue;
> > > > > > +
> > > > > > +		res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> > > > > > +		if (!res) {
> > > > > > +			err =3D -ENOMEM;
> > > > > > +			goto parse_failed;
> > > > > > +		}
> > > > > > +
> > > > > > +		err =3D of_pci_range_to_resource(&range, dev, res);
> > > > > > +		if (err) {
> > > > > > +			kfree(res);
> > > > >=20
> > > > > You might want to add a label to free res to make things more=
 uniform.
> >=20
> > Sorry, not following you. How would a label help here?
>=20
> It was just a suggestion so ignore it if you do not think it is clean=
er.
> It is to make code more uniform and undo operations in one place inst=
ead of
> doing it piecemeal (you kfree the res here and jump to complete the c=
lean-up,
> whereas you might want to add a different label and a different goto
> destination and carry out the kfree there).

But that kfree is the only done once, while the pci_free_resource_list(=
) is
done twice.

>=20
> I do not mind either, it is just what I noticed.
>=20
> > > > > > +			goto parse_failed;
> > > > > > +		}
> > > > > > +
> > > > > > +		if (resource_type(res) =3D=3D IORESOURCE_IO) {
> > > > > > +			if (*io_base)
> > > > >=20
> > > > > You do not zero io_base in the first place so you should ask =
the API
> > > > > user to do that. Is 0 a valid value BTW ? If it is you've got=
 to resort
> > > > > to something else to detect multiple IO resources.
> >=20
> > No, zero is not a valid value. It is the cpu_addr value from the IO=
 range, I'm
> > hopying that no one is crazy enough to map PCI address space at CPU=
 address zero.
> > Thanks for spotting the lack of initialisation though, I need to fi=
x it.
>=20
> Mmm...wasn't a trick question sorry :D
>=20
> PCI host bridge /pci ranges:
>    IO 0x00000000..0x0000ffff -> 0x00000000
>    More than one I/O resource converted. CPU offset for old range los=
t!
>      MEM 0x41000000..0x7fffffff -> 0x41000000
>      pci-host-generic 40000000.pci: PCI host bridge to bus 0000:00
>      pci_bus 0000:00: root bus resource [bu-01]
>      pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>      pci_bus 0000:00: root bus resource [mem 0x41000000-0x7fffffff]
>=20

Your DT puts the IO space at CPU address zero? Could you copy the relev=
ant
host bridge node from DT here?

Best regards,
Liviu

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
