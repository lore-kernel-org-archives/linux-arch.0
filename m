From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v12 09/12] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Date: Wed, 24 Sep 2014 18:53:31 +0100
Message-ID: <20140924175330.GI1994@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-10-git-send-email-Liviu.Dudau@arm.com>
 <20140924164304.GF1994@e106497-lin.cambridge.arm.com>
 <20140924173109.GA20416@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140924173109.GA20416@google.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Robert Richter <rrichter@cavium.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 24, 2014 at 06:31:09PM +0100, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2014 at 05:43:04PM +0100, Liviu Dudau wrote:
> > Provide a function to parse the PCI DT ranges that can be used to
> > create a pci_host_bridge structure together with its associated
> > bus.
> >=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > [make io_base parameter optional]
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> > ---
> > Hi Bjorn,
> >=20
> > I have fixed the compilation error that this patch was triggering. =
I
> > have validated that the patch applies to your pci/host-generic bran=
ch
> > as well as to my series.
>=20
> I applied this to pci/host-generic along with the following patches a=
nd
> pushed the branch, thanks!

Thanks again and sorry for lack of thorough testing. I still haven't ma=
naged
to get a cross compiler for sparc and as I don't run Ubuntu or debian t=
he
make.cross script doesn't work for me.

Best regards,
Liviu

>=20
> Bjorn
>=20
> >  drivers/of/of_pci.c    | 117 +++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/of_pci.h |   6 +++
> >  2 files changed, 123 insertions(+)
> >=20
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > index 82d172f..3cad1af 100644
> > --- a/drivers/of/of_pci.c
> > +++ b/drivers/of/of_pci.c
> > @@ -1,7 +1,9 @@
> >  #include <linux/kernel.h>
> >  #include <linux/export.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> > +#include <linux/slab.h>
> > =20
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int data)
> > @@ -114,6 +116,121 @@ int of_get_pci_domain_nr(struct device_node *=
node)
> >  }
> >  EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
> > =20
> > +#if defined(CONFIG_OF_ADDRESS)
> > +/**
> > + * of_pci_get_host_bridge_resources - Parse PCI host bridge resour=
ces from DT
> > + * @dev: device node of the host bridge having the range property
> > + * @busno: bus number associated with the bridge root bus
> > + * @bus_max: maximum number of busses for this bridge
> > + * @resources: list where the range of resources will be added aft=
er DT parsing
> > + * @io_base: pointer to a variable that will contain on return the=
 physical
> > + * address for the start of the I/O range. Can be NULL if the call=
er doesn't
> > + * expect IO ranges to be present in the device tree.
> > + *
> > + * It is the callers job to free the @resources list.
> > + *
> > + * This function will parse the "ranges" property of a PCI host br=
idge device
> > + * node and setup the resource mapping based on its content. It is=
 expected
> > + * that the property conforms with the Power ePAPR document.
> > + *
> > + * It returns zero if the range parsing has been successful or a s=
tandard error
> > + * value if it failed.
> > + */
> > +int of_pci_get_host_bridge_resources(struct device_node *dev,
> > +			unsigned char busno, unsigned char bus_max,
> > +			struct list_head *resources, resource_size_t *io_base)
> > +{
> > +	struct resource *res;
> > +	struct resource *bus_range;
> > +	struct of_pci_range range;
> > +	struct of_pci_range_parser parser;
> > +	char range_type[4];
> > +	int err;
> > +
> > +	if (io_base)
> > +		*io_base =3D (resource_size_t)OF_BAD_ADDR;
> > +
> > +	bus_range =3D kzalloc(sizeof(*bus_range), GFP_KERNEL);
> > +	if (!bus_range)
> > +		return -ENOMEM;
> > +
> > +	pr_info("PCI host bridge %s ranges:\n", dev->full_name);
> > +
> > +	err =3D of_pci_parse_bus_range(dev, bus_range);
> > +	if (err) {
> > +		bus_range->start =3D busno;
> > +		bus_range->end =3D bus_max;
> > +		bus_range->flags =3D IORESOURCE_BUS;
> > +		pr_info("  No bus range found for %s, using %pR\n",
> > +			dev->full_name, bus_range);
> > +	} else {
> > +		if (bus_range->end > bus_range->start + bus_max)
> > +			bus_range->end =3D bus_range->start + bus_max;
> > +	}
> > +	pci_add_resource(resources, bus_range);
> > +
> > +	/* Check for ranges property */
> > +	err =3D of_pci_range_parser_init(&parser, dev);
> > +	if (err)
> > +		goto parse_failed;
> > +
> > +	pr_debug("Parsing ranges property...\n");
> > +	for_each_of_pci_range(&parser, &range) {
> > +		/* Read next ranges element */
> > +		if ((range.flags & IORESOURCE_TYPE_BITS) =3D=3D IORESOURCE_IO)
> > +			snprintf(range_type, 4, " IO");
> > +		else if ((range.flags & IORESOURCE_TYPE_BITS) =3D=3D IORESOURCE_=
MEM)
> > +			snprintf(range_type, 4, "MEM");
> > +		else
> > +			snprintf(range_type, 4, "err");
> > +		pr_info("  %s %#010llx..%#010llx -> %#010llx\n", range_type,
> > +			range.cpu_addr, range.cpu_addr + range.size - 1,
> > +			range.pci_addr);
> > +
> > +		/*
> > +		 * If we failed translation or got a zero-sized region
> > +		 * then skip this range
> > +		 */
> > +		if (range.cpu_addr =3D=3D OF_BAD_ADDR || range.size =3D=3D 0)
> > +			continue;
> > +
> > +		res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> > +		if (!res) {
> > +			err =3D -ENOMEM;
> > +			goto parse_failed;
> > +		}
> > +
> > +		err =3D of_pci_range_to_resource(&range, dev, res);
> > +		if (err)
> > +			goto conversion_failed;
> > +
> > +		if (resource_type(res) =3D=3D IORESOURCE_IO) {
> > +			if (!io_base) {
> > +				pr_err("I/O range found for %s. Please provide an io_base poin=
ter to save CPU base address\n",
> > +					dev->full_name);
> > +				err =3D -EINVAL;
> > +				goto conversion_failed;
> > +			}
> > +			if (*io_base !=3D (resource_size_t)OF_BAD_ADDR)
> > +				pr_warn("More than one I/O resource converted for %s. CPU base=
 address for old range lost!\n",
> > +					dev->full_name);
> > +			*io_base =3D range.cpu_addr;
> > +		}
> > +
> > +		pci_add_resource_offset(resources, res,	res->start - range.pci_a=
ddr);
> > +	}
> > +
> > +	return 0;
> > +
> > +conversion_failed:
> > +	kfree(res);
> > +parse_failed:
> > +	pci_free_resource_list(resources);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> > +#endif /* CONFIG_OF_ADDRESS */
> > +
> >  #ifdef CONFIG_PCI_MSI
> > =20
> >  static LIST_HEAD(of_pci_msi_chip_list);
> > diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> > index 71062e9..1fd207e 100644
> > --- a/include/linux/of_pci.h
> > +++ b/include/linux/of_pci.h
> > @@ -52,6 +52,12 @@ of_get_pci_domain_nr(struct device_node *node)
> >  }
> >  #endif
> > =20
> > +#if defined(CONFIG_OF_ADDRESS)
> > +int of_pci_get_host_bridge_resources(struct device_node *dev,
> > +			unsigned char busno, unsigned char bus_max,
> > +			struct list_head *resources, resource_size_t *io_base);
> > +#endif
> > +
> >  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> >  int of_pci_msi_chip_add(struct msi_chip *chip);
> >  void of_pci_msi_chip_remove(struct msi_chip *chip);
> > --=20
> > 2.1.0
> >=20
> >=20
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
