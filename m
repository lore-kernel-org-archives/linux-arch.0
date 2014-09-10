Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48568 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbaIJNEk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Sep 2014 09:04:40 -0400
Date: Wed, 10 Sep 2014 14:04:32 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Message-ID: <20140910130432.GB27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-8-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJi8k1Goc3UmXhuxf9v7=4gJrYG_Di7v574PxS8TsJaXw@mail.gmail.com>
 <20140908145459.GO27864@e106497-lin.cambridge.arm.com>
 <CAL_JsqJdGKDVwJOpPp19OkVPGzR7Zqv3nh+ONHHaYnPLYTYoYg@mail.gmail.com>
 <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
Message-ID: <20140910130432.pN9lIBSIoDPl9U7rlO63kInm6LM_b47HVySbrbj19j4@z>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2014 at 04:59:31PM +0100, Liviu Dudau wrote:
> On Mon, Sep 08, 2014 at 04:27:36PM +0100, Rob Herring wrote:
> > On Mon, Sep 8, 2014 at 9:54 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote=
:
> > > On Mon, Sep 08, 2014 at 03:27:56PM +0100, Rob Herring wrote:
> > >> On Mon, Sep 8, 2014 at 8:54 AM, Liviu Dudau <Liviu.Dudau@arm.com> wr=
ote:
> > >> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> > >> > of a given device from DT. If the information is not present,
> > >> > the function can be requested to allocate a new domain number.
> > >> >
> > >> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >> > Cc: Arnd Bergmann <arnd@arndb.de>
> > >> > Cc: Grant Likely <grant.likely@linaro.org>
> > >> > Cc: Rob Herring <robh+dt@kernel.org>
> > >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > >> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > >> > ---
> > >> >  drivers/of/of_pci.c    | 34 ++++++++++++++++++++++++++++++++++
> > >> >  include/linux/of_pci.h |  7 +++++++
> > >> >  2 files changed, 41 insertions(+)
> > >> >
> > >> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > >> > index 8481996..a107edb 100644
> > >> > --- a/drivers/of/of_pci.c
> > >> > +++ b/drivers/of/of_pci.c
> > >> > @@ -89,6 +89,40 @@ int of_pci_parse_bus_range(struct device_node *=
node, struct resource *res)
> > >> >  }
> > >> >  EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
> > >> >
> > >> > +static atomic_t of_domain_nr =3D ATOMIC_INIT(-1);
> > >> > +
> > >> > +/**
> > >> > + * This function will try to obtain the host bridge domain number=
 by
> > >> > + * using of_alias_get_id() call with "pci-domain" as a stem. If t=
hat
> > >> > + * fails, a local allocator will be used. The local allocator can
> > >> > + * be requested to return a new domain_nr if the information is m=
issing
> > >> > + * from the device tree.
> > >> > + *
> > >> > + * @node: device tree node with the domain information
> > >> > + * @allocate_if_missing: if DT lacks information about the domain=
 nr,
> > >> > + * allocate a new number.
> > >> > + *
> > >> > + * Returns the associated domain number from DT, or a new domain =
number
> > >> > + * if DT information is missing and @allocate_if_missing is true.=
 If
> > >> > + * @allocate_if_missing is false then the last allocated domain n=
umber
> > >> > + * will be returned.
> > >> > + */
> > >> > +int of_pci_get_domain_nr(struct device_node *node, bool allocate_=
if_missing)
> > >> > +{
> > >> > +       int domain;
> > >> > +
> > >> > +       domain =3D of_alias_get_id(node, "pci-domain");
> > >> > +       if (domain =3D=3D -ENODEV) {
> > >> > +               if (allocate_if_missing)
> > >> > +                       domain =3D atomic_inc_return(&of_domain_nr=
);
> > >> > +               else
> > >> > +                       domain =3D atomic_read(&of_domain_nr);
> > >>
> > >> This function seems a bit broken to me. It is overloaded with too ma=
ny
> > >> different outcomes. Think about how this would work if you have
> > >> multiple PCI buses and a mixture of having pci-domain aliases or not=
.
> > >> Aren't domain numbers global? Allocation should then start outside o=
f
> > >> the range of alias ids.
> > >>
> > >> Rob
> > >>
> > >
> > > Rob,
> > >
> > > Would this version make more sense?
> >=20
> > No.
> >=20

Hi Rob,

Here is an updated version of the patch. I have implemented a separate func=
tion
for getting the max domain number from the device tree and use the result a=
s
the start value + 1 for the allocator.

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
--d6Gm4EdcadzBjdND
Content-Type: text/x-diff; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0001-OF-Introduce-helper-function-for-getting-PCI-domain_.patch"


--d6Gm4EdcadzBjdND--
