From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v13 02/12] of/pci: Add pci_register_io_range() and
 pci_pio_to_address()
Date: Tue, 30 Sep 2014 09:59:33 +0100
Message-ID: <20140930085933.GM841@e106497-lin.cambridge.arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <1412000971-9242-3-git-send-email-Liviu.Dudau@arm.com>
 <5429B0FE.4070904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37317 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbaI3I7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Sep 2014 04:59:40 -0400
In-Reply-To: <5429B0FE.4070904@redhat.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Stone <ahs3@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Device Tree ML <devicetree@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Tanmay Inamdar <tinamdar@apm.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.in>

On Mon, Sep 29, 2014 at 08:20:30PM +0100, Al Stone wrote:
> On 09/29/2014 08:29 AM, Liviu Dudau wrote:
> > Some architectures do not have a simple view of the PCI I/O space a=
nd
> > instead use a range of CPU addresses that map to bus addresses.  Fo=
r some
> > architectures these ranges will be expressed by OF bindings in a de=
vice
> > tree file.
> >=20
> > This patch introduces a pci_register_io_range() helper function wit=
h a
> > generic implementation that can be used by such architectures to ke=
ep track
> > of the I/O ranges described by the PCI bindings.  If the PCI_IOBASE=
 macro
> > is not defined, that signals lack of support for PCI and we return =
an
> > error.
> >=20
> > In order to retrieve the CPU address associated with an I/O port, a=
 new
> > helper function pci_pio_to_address() is introduced.  This will sear=
ch in
> > the list of ranges registered with pci_register_io_range() and retu=
rn the
> > CPU address that corresponds to the given port.
> >=20
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > CC: Grant Likely <grant.likely@linaro.org>
> > CC: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/of/address.c       | 109 +++++++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/of_address.h |   2 +
> >  2 files changed, 111 insertions(+)
> >=20
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index e371825..758d4f0 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -5,6 +5,8 @@
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pci_regs.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> >  #include <linux/string.h>
> > =20
> >  /* Max address size we deal with */
> > @@ -601,12 +603,119 @@ const __be32 *of_get_address(struct device_n=
ode *dev, int index, u64 *size,
> >  }
> >  EXPORT_SYMBOL(of_get_address);
> > =20
> > +#ifdef PCI_IOBASE
> > +struct io_range {
> > +	struct list_head list;
> > +	phys_addr_t start;
> > +	resource_size_t size;
> > +};
> > +
> > +static LIST_HEAD(io_range_list);
> > +static DEFINE_SPINLOCK(io_range_lock);
> > +#endif
> > +
> > +/*
> > + * Record the PCI IO range (expressed as CPU physical address + si=
ze).
> > + * Return a negative value if an error has occured, zero otherwise
> > + */
> > +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t=
 size)
> > +{
> > +	int err =3D 0;
> > +
> > +#ifdef PCI_IOBASE
> > +	struct io_range *range;
> > +	resource_size_t allocated_size =3D 0;
> > +
> > +	/* check if the range hasn't been previously recorded */
> > +	spin_lock(&io_range_lock);
> > +	list_for_each_entry(range, &io_range_list, list) {
> > +		if (addr >=3D range->start && addr + size <=3D range->start + si=
ze) {
> > +			/* range already registered, bail out */
> > +			goto end_register;
> > +		}
> > +		allocated_size +=3D range->size;
> > +	}
> > +
> > +	/* range not registed yet, check for available space */
> > +	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
> > +		/* if it's too big check if 64K space can be reserved */
> > +		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
> > +			err =3D -E2BIG;
> > +			goto end_register;
> > +		}
> > +
> > +		size =3D SZ_64K;
> > +		pr_warn("Requested IO range too big, new size set to 64K\n");
> > +	}
> > +
> > +	/* add the range to the list */
> > +	range =3D kzalloc(sizeof(*range), GFP_KERNEL);
> > +	if (!range) {
> > +		err =3D -ENOMEM;
> > +		goto end_register;
> > +	}
> > +
> > +	range->start =3D addr;
> > +	range->size =3D size;
> > +
> > +	list_add_tail(&range->list, &io_range_list);
> > +
> > +end_register:
> > +	spin_unlock(&io_range_lock);
> > +#endif
> > +
> > +	return err;
> > +}
> > +
> > +phys_addr_t pci_pio_to_address(unsigned long pio)
> > +{
> > +	phys_addr_t address =3D (phys_addr_t)OF_BAD_ADDR;

Hi Al,

>=20
> This reference to OF_BAD_ADDR is the only thing I'm seeing in this
> patch that is DT specific.
>=20
> Couldn't these helper functions be more useful if provided outside
> of DT, perhaps in the PCI code instead?  I was giving some thought
> to re-using them for ACPI support of PCI but don't want to have to
> build DT if I'm not really going to use it.

The reason why I've put it (now) in drivers/of is that the code is only
used by DT specific code. At some moment one of the older series put
it into drivers/pci but I was trying to make it more clear that this
is DT specific.

If you find this useful for ACPI (and this series lands in v3.18) then
I suggest you send a patch to move it into drivers/pci?

Best regards,
Liviu

>=20
> > +#ifdef PCI_IOBASE
> > +	struct io_range *range;
> > +	resource_size_t allocated_size =3D 0;
> > +
> > +	if (pio > IO_SPACE_LIMIT)
> > +		return address;
> > +
> > +	spin_lock(&io_range_lock);
> > +	list_for_each_entry(range, &io_range_list, list) {
> > +		if (pio >=3D allocated_size && pio < allocated_size + range->siz=
e) {
> > +			address =3D range->start + pio - allocated_size;
> > +			break;
> > +		}
> > +		allocated_size +=3D range->size;
> > +	}
> > +	spin_unlock(&io_range_lock);
> > +#endif
> > +
> > +	return address;
> > +}
> > +
> >  unsigned long __weak pci_address_to_pio(phys_addr_t address)
> >  {
> > +#ifdef PCI_IOBASE
> > +	struct io_range *res;
> > +	resource_size_t offset =3D 0;
> > +	unsigned long addr =3D -1;
> > +
> > +	spin_lock(&io_range_lock);
> > +	list_for_each_entry(res, &io_range_list, list) {
> > +		if (address >=3D res->start && address < res->start + res->size)=
 {
> > +			addr =3D res->start - address + offset;
> > +			break;
> > +		}
> > +		offset +=3D res->size;
> > +	}
> > +	spin_unlock(&io_range_lock);
> > +
> > +	return addr;
> > +#else
> >  	if (address > IO_SPACE_LIMIT)
> >  		return (unsigned long)-1;
> > =20
> >  	return (unsigned long) address;
> > +#endif
> >  }
> > =20
> >  static int __of_address_to_resource(struct device_node *dev,
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.=
h
> > index fb7b722..f8cc7da 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -55,7 +55,9 @@ extern void __iomem *of_iomap(struct device_node =
*device, int index);
> >  extern const __be32 *of_get_address(struct device_node *dev, int i=
ndex,
> >  			   u64 *size, unsigned int *flags);
> > =20
> > +extern int pci_register_io_range(phys_addr_t addr, resource_size_t=
 size);
> >  extern unsigned long pci_address_to_pio(phys_addr_t addr);
> > +extern phys_addr_t pci_pio_to_address(unsigned long pio);
> > =20
> >  extern int of_pci_range_parser_init(struct of_pci_range_parser *pa=
rser,
> >  			struct device_node *node);
> >=20
>=20
>=20
> --=20
> ciao,
> al
> -----------------------------------
> Al Stone
> Software Engineer
> Red Hat, Inc.
> ahs3@redhat.com
> -----------------------------------
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
