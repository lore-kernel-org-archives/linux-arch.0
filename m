From: Robert Richter <rric-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Date: Mon, 22 Sep 2014 14:15:47 +0200
Message-ID: <20140922121547.GD20170@rric.localhost>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
 <20140922093228.GA20256@rric.localhost>
 <20140922114317.GN1994@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140922114317.GN1994-2JSQmVVBSi7ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>Sunil Goutham <s>
List-Id: linux-arch.vger.kernel.org

On 22.09.14 12:43:17, Liviu Dudau wrote:
> On Mon, Sep 22, 2014 at 10:32:28AM +0100, Robert Richter wrote:
> > On 18.09.14 02:30:23, Liviu Dudau wrote:
> > > +int of_pci_get_host_bridge_resources(struct device_node *dev,
> > > +			unsigned char busno, unsigned char bus_max,
> > > +			struct list_head *resources, resource_size_t *io_base)
> > > +{
> > > +	struct resource *res;
> > > +	struct resource *bus_range;
> > > +	struct of_pci_range range;
> > > +	struct of_pci_range_parser parser;
> > > +	char range_type[4];
> > > +	int err;
> > > +
> > > +	if (!io_base)
> > > +		return -EINVAL;
> > > +	*io_base =3D OF_BAD_ADDR;
> >=20
>=20
> Hi Robert,
>=20
> > This breaks for mem-mapped pci host controllers. The patch below fi=
xes
> > this.
>=20
> I think you mean PCI host controller that have only memory mapped ran=
ges,
> am I right? Initially I've read your reply as to mean that the host
> controller is accessed through some memory mapped area, which I belie=
ve is
> the case for all host controllers.

Right, that's meant here. Sorry for the misleading comment.

>=20
> >=20
> > This series was tested with the fix on top for Cavium Thunder.
> >=20
> > Tested-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>=20
> Thanks for that!
>=20
> >=20
> > -Robert
> >=20
> >=20
> >=20
> > From e798af4fc2f664d1aff7e863489b8298f90e716e Mon Sep 17 00:00:00 2=
001
> > From: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > Date: Mon, 22 Sep 2014 10:46:01 +0200
> > Subject: [PATCH] OF: PCI: Fix creation of mem-mapped pci host bridg=
es
> >=20
> > The pci host bridge was not created if io_base was not set when
> > calling of_pci_get_host_bridge_resources(). This is esp. the case f=
or
> > mem-mapped io (IORESOURCE_MEM). This patch fixes this. Function
> > parameter io_base is optional now.
>=20
> I think the message is misleading. What you want to do is make io_bas=
e
> optional for the case where the PCI host bridge only expects to have =
only
> IORESOURCE_MEM ranges and doesn't care about IORESOURCE_IO ones.
>=20
> As I'm going to touch this area again to address a comment from Bjorn=
,
> do you mind if I roll this patch into mine with your Signed-off-by an=
d
> the mention that you have made io_base optional?

Sure, fine with me.

Thanks,

-Robert


>=20
> Best regards,
> Liviu
>=20
> >=20
> > Signed-off-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/of/of_pci.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > index ffdb45ed8682..1f0e7c2505ee 100644
> > --- a/drivers/of/of_pci.c
> > +++ b/drivers/of/of_pci.c
> > @@ -182,9 +182,8 @@ int of_pci_get_host_bridge_resources(struct dev=
ice_node *dev,
> >  	char range_type[4];
> >  	int err;
> > =20
> > -	if (!io_base)
> > -		return -EINVAL;
> > -	*io_base =3D OF_BAD_ADDR;
> > +	if (io_base)
> > +		*io_base =3D OF_BAD_ADDR;
> > =20
> >  	bus_range =3D kzalloc(sizeof(*bus_range), GFP_KERNEL);
> >  	if (!bus_range)
> > @@ -242,7 +241,7 @@ int of_pci_get_host_bridge_resources(struct dev=
ice_node *dev,
> >  			goto parse_failed;
> >  		}
> > =20
> > -		if (resource_type(res) =3D=3D IORESOURCE_IO) {
> > +		if (io_base && resource_type(res) =3D=3D IORESOURCE_IO) {
> >  			if (*io_base !=3D OF_BAD_ADDR)
> >  				pr_warn("More than one I/O resource converted. CPU offset for =
old range lost!\n");
> >  			*io_base =3D range.cpu_addr;
> > --=20
> > 2.1.0
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci=
" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
>=20
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
