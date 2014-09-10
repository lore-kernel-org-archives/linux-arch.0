From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v10 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Date: Wed, 10 Sep 2014 16:32:33 +0100
Message-ID: <20140910153233.GG27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-9-git-send-email-Liviu.Dudau@arm.com>
 <20140909133546.GB2636@e102568-lin.cambridge.arm.com>
 <20140910142241.GD27864@e106497-lin.cambridge.arm.com>
 <20140910151026.GB11640@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140910151026.GB11640@e102568-lin.cambridge.arm.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 10, 2014 at 04:10:26PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Sep 10, 2014 at 03:22:41PM +0100, Liviu Dudau wrote:
> > On Tue, Sep 09, 2014 at 02:35:46PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Sep 08, 2014 at 02:54:30PM +0100, Liviu Dudau wrote:
> > > > Provide a function to parse the PCI DT ranges that can be used =
to
> > > > create a pci_host_bridge structure together with its associated
> > > > bus.
> > > >=20
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Grant Likely <grant.likely@linaro.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > > ---
> > > >  drivers/of/of_pci.c    | 102 +++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > >  include/linux/of_pci.h |  11 ++++++
> > > >  2 files changed, 113 insertions(+)
> > > >=20
> > > > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > > > index a107edb..36701da 100644
> > > > --- a/drivers/of/of_pci.c
> > > > +++ b/drivers/of/of_pci.c
> > > > @@ -1,7 +1,9 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/of.h>
> > > > +#include <linux/of_address.h>
> > > >  #include <linux/of_pci.h>
> > > > +#include <linux/slab.h>
> > > > =20
> > > >  static inline int __of_pci_pci_compare(struct device_node *nod=
e,
> > > >  				       unsigned int data)
> > > > @@ -123,6 +125,106 @@ int of_pci_get_domain_nr(struct device_no=
de *node, bool allocate_if_missing)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(of_pci_get_domain_nr);
> > > > =20
> > > > +/**
> > > > + * of_pci_get_host_bridge_resources - Parse PCI host bridge re=
sources from DT
> > > > + * @dev: device node of the host bridge having the range prope=
rty
> > > > + * @busno: bus number associated with the bridge root bus
> > > > + * @bus_max: maximum number of busses for this bridge
> > > > + * @resources: list where the range of resources will be added=
 after DT parsing
> > > > + * @io_base: pointer to a variable that will contain on return=
 the physical
> > > > + * address for the start of the I/O range.
> > > > + *
> > > > + * It is the callers job to free the @resources list.
> > > > + *
> > > > + * This function will parse the "ranges" property of a PCI hos=
t bridge device
> > > > + * node and setup the resource mapping based on its content. I=
t is expected
> > > > + * that the property conforms with the Power ePAPR document.
> > >=20
> > > You should also define what it returns and when.
> >=20
> > Thanks, will do.
> >=20
> > >=20
> > > > + *
> > > > + */
> > > > +int of_pci_get_host_bridge_resources(struct device_node *dev,
> > > > +			unsigned char busno, unsigned char bus_max,
> > > > +			struct list_head *resources, resource_size_t *io_base)
> > > > +{
> > > > +	struct resource *res;
> > > > +	struct resource *bus_range;
> > > > +	struct of_pci_range range;
> > > > +	struct of_pci_range_parser parser;
> > > > +	char range_type[4];
> > > > +	int err;
> > > > +
> > > > +	bus_range =3D kzalloc(sizeof(*bus_range), GFP_KERNEL);
> > > > +	if (!bus_range)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pr_info("PCI host bridge %s ranges:\n", dev->full_name);
> > > > +
> > > > +	err =3D of_pci_parse_bus_range(dev, bus_range);
> > > > +	if (err) {
> > > > +		bus_range->start =3D busno;
> > > > +		bus_range->end =3D bus_max;
> > > > +		bus_range->flags =3D IORESOURCE_BUS;
> > > > +		pr_info("  No bus range found for %s, using %pR\n",
> > > > +			dev->full_name, &bus_range);
> > > > +	} else {
> > > > +		if (bus_range->end > bus_range->start + bus_max)
> > > > +			bus_range->end =3D bus_range->start + bus_max;
> > > > +	}
> > > > +	pci_add_resource(resources, bus_range);
> > >=20
> > > This means that eg in the PCI generic host controller I cannot "f=
ilter"
> > > the bus resource, unless I remove it, "filter" it, and add it aga=
in.
> >=20
> > I'm not sure what you mean. Why do you have to remove the bus resou=
rce and
> > add it again? What you get back from of_pci_get_host_bridge_resourc=
es() is
> > a list of resources as they have been parsed from DT. You now have =
the option
> > of doing any filtering that you might have done pre-v10 in the
> > pcibios_fixup_bridge_ranges() but that is only on the list that was=
 returned
> > from of_pci_get_host_bridge_resources(). At this moment no root bus=
 or
> > host bridge structure has been created so no resource was added to =
those.
> > With the filtered list you can use it to call pci_scan_root_bus() a=
nd *then*
> > it gets added to the pci_host_bridge structure.
>=20
> You are right sorry. As discussed, I just have to remove the resource=
s
> assignment in the respective host controller drivers (because you do
> that in the API) and grab the resource pointers to "filter" them.
>=20
> > > I certainly can't filter a resource that has been already added w=
ithout
> > > removing it first.
> > >=20
> > > Thoughts ?
> >=20
> > Hope I have explained what happens. Please let me know if you have =
any other
> > comments.
>=20
> There were other comments below ;)

My PgDn key is broken ;)

>=20
> Thanks,
> Lorenzo
>=20
> >=20
> > Best regards,
> > Liviu
> >=20
> > >=20
> > > > +
> > > > +	/* Check for ranges property */
> > > > +	err =3D of_pci_range_parser_init(&parser, dev);
> > > > +	if (err)
> > > > +		goto parse_failed;
> > > > +
> > > > +	pr_debug("Parsing ranges property...\n");
> > > > +	for_each_of_pci_range(&parser, &range) {
> > > > +		/* Read next ranges element */
> > > > +		if ((range.flags & IORESOURCE_TYPE_BITS) =3D=3D IORESOURCE_I=
O)
> > > > +			snprintf(range_type, 4, " IO");
> > > > +		else if ((range.flags & IORESOURCE_TYPE_BITS) =3D=3D IORESOU=
RCE_MEM)
> > > > +			snprintf(range_type, 4, "MEM");
> > > > +		else
> > > > +			snprintf(range_type, 4, "err");
> > > > +		pr_info("  %s %#010llx..%#010llx -> %#010llx\n", range_type,
> > > > +			range.cpu_addr, range.cpu_addr + range.size - 1,
> > > > +			range.pci_addr);
> > > > +
> > > > +		/*
> > > > +		 * If we failed translation or got a zero-sized region
> > > > +		 * then skip this range
> > > > +		 */
> > > > +		if (range.cpu_addr =3D=3D OF_BAD_ADDR || range.size =3D=3D 0=
)
> > > > +			continue;
> > > > +
> > > > +		res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> > > > +		if (!res) {
> > > > +			err =3D -ENOMEM;
> > > > +			goto parse_failed;
> > > > +		}
> > > > +
> > > > +		err =3D of_pci_range_to_resource(&range, dev, res);
> > > > +		if (err) {
> > > > +			kfree(res);
> > >=20
> > > You might want to add a label to free res to make things more uni=
form.

Sorry, not following you. How would a label help here?

> > >=20
> > > > +			goto parse_failed;
> > > > +		}
> > > > +
> > > > +		if (resource_type(res) =3D=3D IORESOURCE_IO) {
> > > > +			if (*io_base)
> > >=20
> > > You do not zero io_base in the first place so you should ask the =
API
> > > user to do that. Is 0 a valid value BTW ? If it is you've got to =
resort
> > > to something else to detect multiple IO resources.

No, zero is not a valid value. It is the cpu_addr value from the IO ran=
ge, I'm
hopying that no one is crazy enough to map PCI address space at CPU add=
ress zero.
Thanks for spotting the lack of initialisation though, I need to fix it=
=2E

Best regards,
Liviu

> > >=20
> > > Lorenzo

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
