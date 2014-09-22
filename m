From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 04/10] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
Date: Mon, 22 Sep 2014 16:32:07 +0100
Message-ID: <20140922153207.GA1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
 <541DBA57.2000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <541DBA57.2000903@gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 20, 2014 at 06:33:11PM +0100, Rob Herring wrote:
> On 09/17/2014 08:30 PM, Liviu Dudau wrote:
> > The ranges property for a host bridge controller in DT describes
> > the mapping between the PCI bus address and the CPU physical addres=
s.
> > The resources framework however expects that the IO resources start
> > at a pseudo "port" address 0 (zero) and have a maximum size of IO_S=
PACE_LIMIT.
> > The conversion from pci ranges to resources failed to take that int=
o account.
> >
> > In the process move the function into drivers/of/address.c as it no=
w
> > depends on pci_address_to_pio() code and make it return an error co=
de.
> > Also fix all the drivers that depend on the old behaviour by fetchi=
ng
> > the CPU physical address based on the port number.
> >
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>=20
> A few minor things below.
>=20
> > ---
> >  arch/arm/mach-integrator/pci_v3.c | 23 ++++++++++----------
> >  drivers/of/address.c              | 46 +++++++++++++++++++++++++++=
++++++++++++
> >  drivers/pci/host/pci-tegra.c      | 10 ++++++---
> >  drivers/pci/host/pcie-rcar.c      | 21 +++++++++++++-----
> >  include/linux/of_address.h        | 13 ++---------
> >  5 files changed, 82 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-inte=
grator/pci_v3.c
> > index 05e1f73..3321e1b 100644
> > --- a/arch/arm/mach-integrator/pci_v3.c
> > +++ b/arch/arm/mach-integrator/pci_v3.c
> > @@ -660,6 +660,7 @@ static void __init pci_v3_preinit(void)
> >  {
> >       unsigned long flags;
> >       unsigned int temp;
> > +     phys_addr_t io_address =3D pci_pio_to_address(io_mem.start);
> >
> >       pcibios_min_mem =3D 0x00100000;
> >
> > @@ -701,7 +702,7 @@ static void __init pci_v3_preinit(void)
> >       /*
> >        * Setup window 2 - PCI IO
> >        */
> > -     v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(io_mem.start) |
> > +     v3_writel(V3_LB_BASE2, v3_addr_to_lb_base2(io_address) |
> >                       V3_LB_BASE_ENABLE);
> >       v3_writew(V3_LB_MAP2, v3_addr_to_lb_map2(0));
> >
> > @@ -742,6 +743,7 @@ static void __init pci_v3_preinit(void)
> >  static void __init pci_v3_postinit(void)
> >  {
> >       unsigned int pci_cmd;
> > +     phys_addr_t io_address =3D pci_pio_to_address(io_mem.start);
> >
> >       pci_cmd =3D PCI_COMMAND_MEMORY |
> >                 PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
> > @@ -758,7 +760,7 @@ static void __init pci_v3_postinit(void)
> >                      "interrupt: %d\n", ret);
> >  #endif
> >
> > -     register_isa_ports(non_mem.start, io_mem.start, 0);
> > +     register_isa_ports(non_mem.start, io_address, 0);
> >  }
> >
> >  /*
> > @@ -867,33 +869,32 @@ static int __init pci_v3_probe(struct platfor=
m_device *pdev)
> >
> >       for_each_of_pci_range(&parser, &range) {
> >               if (!range.flags) {
> > -                     of_pci_range_to_resource(&range, np, &conf_me=
m);
> > +                     ret =3D of_pci_range_to_resource(&range, np, =
&conf_mem);
> >                       conf_mem.name =3D "PCIv3 config";
> >               }
> >               if (range.flags & IORESOURCE_IO) {
> > -                     of_pci_range_to_resource(&range, np, &io_mem)=
;
> > +                     ret =3D of_pci_range_to_resource(&range, np, =
&io_mem);
> >                       io_mem.name =3D "PCIv3 I/O";
> >               }
> >               if ((range.flags & IORESOURCE_MEM) &&
> >                       !(range.flags & IORESOURCE_PREFETCH)) {
> >                       non_mem_pci =3D range.pci_addr;
> >                       non_mem_pci_sz =3D range.size;
> > -                     of_pci_range_to_resource(&range, np, &non_mem=
);
> > +                     ret =3D of_pci_range_to_resource(&range, np, =
&non_mem);
> >                       non_mem.name =3D "PCIv3 non-prefetched mem";
> >               }
> >               if ((range.flags & IORESOURCE_MEM) &&
> >                       (range.flags & IORESOURCE_PREFETCH)) {
> >                       pre_mem_pci =3D range.pci_addr;
> >                       pre_mem_pci_sz =3D range.size;
> > -                     of_pci_range_to_resource(&range, np, &pre_mem=
);
> > +                     ret =3D of_pci_range_to_resource(&range, np, =
&pre_mem);
> >                       pre_mem.name =3D "PCIv3 prefetched mem";
> >               }
> > -     }
> >
> > -     if (!conf_mem.start || !io_mem.start ||
> > -         !non_mem.start || !pre_mem.start) {
> > -             dev_err(&pdev->dev, "missing ranges in device node\n"=
);
> > -             return -EINVAL;
> > +             if (ret < 0) {
> > +                     dev_err(&pdev->dev, "missing ranges in device=
 node\n");
> > +                     return -EINVAL;
>=20
> You should return ret rather than potentially changing the return val=
ue.

I was trying to keep the existing behaviour, which was to return -EINVA=
L if the
parsing has failed. But I can return ret and propagate the original err=
or code.

>=20
> > +             }
> >       }
> >
> >       pci_v3.map_irq =3D of_irq_parse_and_map_pci;
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 2373a92..ff10b64 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -947,3 +947,49 @@ bool of_dma_is_coherent(struct device_node *np=
)
> >       return false;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> > +
> > +/*
> > + * of_pci_range_to_resource - Create a resource from an of_pci_ran=
ge
> > + * @range:   the PCI range that describes the resource
> > + * @np:              device node where the range belongs to
> > + * @res:     pointer to a valid resource that will be updated to
> > + *              reflect the values contained in the range.
> > + *
> > + * Returns EINVAL if the range cannot be converted to resource.
> > + *
> > + * Note that if the range is an IO range, the resource will be con=
verted
> > + * using pci_address_to_pio() which can fail if it is called too e=
arly or
> > + * if the range cannot be matched to any host bridge IO space (our=
 case here).
> > + * To guard against that we try to register the IO range first.
> > + * If that fails we know that pci_address_to_pio() will do too.
> > + */
> > +int of_pci_range_to_resource(struct of_pci_range *range,
> > +     struct device_node *np, struct resource *res)
> > +{
> > +     int err;
> > +     res->flags =3D range->flags;
> > +     res->parent =3D res->child =3D res->sibling =3D NULL;
> > +     res->name =3D np->full_name;
> > +
> > +     if (res->flags & IORESOURCE_IO) {
> > +             unsigned long port =3D -1;
>=20
> Assigning a signed value to unsigned...

Ooops, sorry about that. Removed the initialisation now.

>=20
> Does port need to be 64-bit on 64-bit hosts?

I'm following existing APIs. Basically my function is a variant of __of=
_address_to_resource()=20

>=20
> > +             err =3D pci_register_io_range(range->cpu_addr, range-=
>size);
> > +             if (err)
> > +                     goto invalid_range;
> > +             port =3D pci_address_to_pio(range->cpu_addr);
> > +             if (port =3D=3D (unsigned long)-1) {
> > +                     err =3D -EINVAL;
> > +                     goto invalid_range;
> > +             }
> > +             res->start =3D port;
> > +     } else {
> > +             res->start =3D range->cpu_addr;
> > +     }
> > +     res->end =3D res->start + range->size - 1;
> > +     return 0;
> > +
> > +invalid_range:
> > +     res->start =3D (resource_size_t)OF_BAD_ADDR;
> > +     res->end =3D (resource_size_t)OF_BAD_ADDR;
> > +     return err;
> > +}
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-te=
gra.c
> > index 0fb0fdb..946935d 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -626,13 +626,14 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_I=
D, tegra_pcie_relax_enable);
> >  static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
> >  {
> >       struct tegra_pcie *pcie =3D sys_to_pcie(sys);
> > +     phys_addr_t io_start =3D pci_pio_to_address(pcie->io.start);
> >
> >       pci_add_resource_offset(&sys->resources, &pcie->mem, sys->mem=
_offset);
> >       pci_add_resource_offset(&sys->resources, &pcie->prefetch,
> >                               sys->mem_offset);
> >       pci_add_resource(&sys->resources, &pcie->busn);
> >
> > -     pci_ioremap_io(nr * SZ_64K, pcie->io.start);
> > +     pci_ioremap_io(nr * SZ_64K, io_start);
> >
> >       return 1;
> >  }
> > @@ -737,6 +738,7 @@ static irqreturn_t tegra_pcie_isr(int irq, void=
 *arg)
> >  static void tegra_pcie_setup_translations(struct tegra_pcie *pcie)
> >  {
> >       u32 fpci_bar, size, axi_address;
> > +     phys_addr_t io_start =3D pci_pio_to_address(pcie->io.start);
> >
> >       /* Bar 0: type 1 extended configuration space */
> >       fpci_bar =3D 0xfe100000;
> > @@ -749,7 +751,7 @@ static void tegra_pcie_setup_translations(struc=
t tegra_pcie *pcie)
> >       /* Bar 1: downstream IO bar */
> >       fpci_bar =3D 0xfdfc0000;
> >       size =3D resource_size(&pcie->io);
> > -     axi_address =3D pcie->io.start;
> > +     axi_address =3D io_start;
> >       afi_writel(pcie, axi_address, AFI_AXI_BAR1_START);
> >       afi_writel(pcie, size >> 12, AFI_AXI_BAR1_SZ);
> >       afi_writel(pcie, fpci_bar, AFI_FPCI_BAR1);
> > @@ -1520,7 +1522,9 @@ static int tegra_pcie_parse_dt(struct tegra_p=
cie *pcie)
> >       }
> >
> >       for_each_of_pci_range(&parser, &range) {
> > -             of_pci_range_to_resource(&range, np, &res);
> > +             err =3D of_pci_range_to_resource(&range, np, &res);
> > +             if (err < 0)
> > +                     return err;
> >
> >               switch (res.flags & IORESOURCE_TYPE_BITS) {
> >               case IORESOURCE_IO:
> > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-r=
car.c
> > index 4884ee5..61158e0 100644
> > --- a/drivers/pci/host/pcie-rcar.c
> > +++ b/drivers/pci/host/pcie-rcar.c
> > @@ -323,6 +323,7 @@ static void rcar_pcie_setup_window(int win, str=
uct rcar_pcie *pcie)
> >
> >       /* Setup PCIe address space mappings for each resource */
> >       resource_size_t size;
> > +     resource_size_t res_start;
> >       u32 mask;
> >
> >       rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
> > @@ -335,8 +336,13 @@ static void rcar_pcie_setup_window(int win, st=
ruct rcar_pcie *pcie)
> >       mask =3D (roundup_pow_of_two(size) / SZ_128) - 1;
> >       rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
> >
> > -     rcar_pci_write_reg(pcie, upper_32_bits(res->start), PCIEPARH(=
win));
> > -     rcar_pci_write_reg(pcie, lower_32_bits(res->start), PCIEPARL(=
win));
> > +     if (res->flags & IORESOURCE_IO)
> > +             res_start =3D pci_pio_to_address(res->start);
> > +     else
> > +             res_start =3D res->start;
> > +
> > +     rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPARH(w=
in));
> > +     rcar_pci_write_reg(pcie, lower_32_bits(res_start), PCIEPARL(w=
in));
> >
> >       /* First resource is for IO */
> >       mask =3D PAR_ENABLE;
> > @@ -363,9 +369,10 @@ static int rcar_pcie_setup(int nr, struct pci_=
sys_data *sys)
> >
> >               rcar_pcie_setup_window(i, pcie);
> >
> > -             if (res->flags & IORESOURCE_IO)
> > -                     pci_ioremap_io(nr * SZ_64K, res->start);
> > -             else
> > +             if (res->flags & IORESOURCE_IO) {
> > +                     phys_addr_t io_start =3D pci_pio_to_address(r=
es->start);
> > +                     pci_ioremap_io(nr * SZ_64K, io_start);
> > +             } else
> >                       pci_add_resource(&sys->resources, res);
> >       }
> >       pci_add_resource(&sys->resources, &pcie->busn);
> > @@ -935,8 +942,10 @@ static int rcar_pcie_probe(struct platform_dev=
ice *pdev)
> >       }
> >
> >       for_each_of_pci_range(&parser, &range) {
> > -             of_pci_range_to_resource(&range, pdev->dev.of_node,
> > +             err =3D of_pci_range_to_resource(&range, pdev->dev.of=
_node,
> >                                               &pcie->res[win++]);
> > +             if (err < 0)
> > +                     return err;
> >
> >               if (win > RCAR_PCI_MAX_RESOURCES)
> >                       break;
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.=
h
> > index f8cc7da..c9d70deb 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -23,17 +23,8 @@ struct of_pci_range {
> >  #define for_each_of_pci_range(parser, range) \
> >       for (; of_pci_range_parser_one(parser, range);)
> >
> > -static inline void of_pci_range_to_resource(struct of_pci_range *r=
ange,
> > -                                         struct device_node *np,
> > -                                         struct resource *res)
> > -{
> > -     res->flags =3D range->flags;
> > -     res->start =3D range->cpu_addr;
> > -     res->end =3D range->cpu_addr + range->size - 1;
> > -     res->parent =3D res->child =3D res->sibling =3D NULL;
> > -     res->name =3D np->full_name;
> > -}
> > -
> > +extern int of_pci_range_to_resource(struct of_pci_range *range,
> > +             struct device_node *np, struct resource *res);
>=20
> We probably need an empty version of this now for !OF_ADDRESS.

Good catch! Will update my patch.

Thanks for finding time to review the series!

Best regards,
Liviu

>=20
> Rob
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
