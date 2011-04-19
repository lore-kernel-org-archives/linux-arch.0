From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/6] pci/of: Match PCI devices to OF nodes dynamically
Date: Mon, 18 Apr 2011 23:19:42 -0600
Message-ID: <BANLkTik1TVuvpbPCX41pcnGazOPPeBTjjg@mail.gmail.com>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org> <1302495170-973-2-git-send-email-benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44525 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab1DSFUC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 01:20:02 -0400
In-Reply-To: <1302495170-973-2-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de, bigeasy@linutronix.de, Jesse Barnes <jbarnes@virtuousgeek.org>

On Sun, Apr 10, 2011 at 10:12 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> powerpc has two different ways of matching PCI devices to their
> corresponding OF node (if any) for historical reasons. The ppc64 one
> does a scan looking for matching bus/dev/fn, while the ppc32 one does=
 a
> scan looking only for matching dev/fn on each level in order to be
> agnostic to busses being renumbered (which Linux does on some
> platforms).
>
> This removes both and instead moves the matching code to the PCI core
> itself. It's the most logical place to do it: when a pci_dev is creat=
ed,
> we know the parent and thus can do a single level scan for the matchi=
ng
> device_node (if any).
>
> The benefit is that all archs now get the matching for free. There's =
one
> hook the arch might want to provide to match a PHB bus to its device
> node. A default weak implementation is provided that looks for the
> parent device device node, but it's not entirely reliable on powerpc =
for
> various reasons so powerpc provides its own.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good to me.  I've not tested this, but I think it is the right
approach.  It makes me a little nervous because the patch is quite
large and seems to fix up several things at once (like the movement of
of_irq_map_pci(), and bug fixes like adding of_node_get() calls).  I'm
not going to make a stink about it, but it is hard to review in this
form.  Since this touches several architectures and also core pci
code, I think it is probably best (as you suggested on IRC) to put it
into a separate branch and get sfr to add it to linux-next.  If
anything goes wrong, then sfr can punt it independently.  :-)

You'll need to check with Jesse also.

Inadequately-reviewed-by:: Grant Likely <grant.likely@secretlab.ca>

g.

> ---
> =A0arch/microblaze/include/asm/pci-bridge.h | =A0 14 ++--
> =A0arch/microblaze/include/asm/prom.h =A0 =A0 =A0 | =A0 15 ---
> =A0arch/microblaze/pci/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 40 ++--=
-----
> =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0| =A0 35 ++-----
> =A0arch/powerpc/include/asm/pci.h =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> =A0arch/powerpc/include/asm/prom.h =A0 =A0 =A0 =A0 =A0| =A0 14 ---
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 | =A0 11 ++-
> =A0arch/powerpc/kernel/pci_32.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0150 +++-=
--------------------------
> =A0arch/powerpc/kernel/pci_dn.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 47 ----=
-----
> =A0arch/powerpc/kernel/pci_of_scan.c =A0 =A0 =A0 =A0| =A0 =A09 +-
> =A0arch/powerpc/platforms/powermac/pci.c =A0 =A0| =A0 =A03 +-
> =A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A0drivers/of/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A08 ++-
> =A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 +
> =A0drivers/of/of_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
112 ++++++----------------
> =A0drivers/of/of_pci_irq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 9=
2 ++++++++++++++++++
> =A0drivers/pci/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
> =A0drivers/pci/hotplug/rpadlpar_core.c =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/pci/of.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 61 ++++++++++++
> =A0drivers/pci/probe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A07 +-
> =A0include/linux/of_pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
5 +
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 18 ++++
> =A022 files changed, 275 insertions(+), 376 deletions(-)
> =A0create mode 100644 drivers/of/of_pci_irq.c
> =A0create mode 100644 drivers/pci/of.c
>
> diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microbla=
ze/include/asm/pci-bridge.h
> index 746df91..728f8d6 100644
> --- a/arch/microblaze/include/asm/pci-bridge.h
> +++ b/arch/microblaze/include/asm/pci-bridge.h
> @@ -105,19 +105,19 @@ struct pci_controller {
> =A0};
>
> =A0#ifdef CONFIG_PCI
> -static inline struct pci_controller *pci_bus_to_host(const struct pc=
i_bus *bus)
> +static inline struct device_node *pci_device_to_OF_node(struct pci_d=
ev *dev)
> =A0{
> - =A0 =A0 =A0 return bus->sysdata;
> + =A0 =A0 =A0 return dev->dev.of_node;
> =A0}
>
> =A0static inline struct device_node *pci_bus_to_OF_node(struct pci_bu=
s *bus)
> =A0{
> - =A0 =A0 =A0 struct pci_controller *host;
> + =A0 =A0 =A0 return bus->dev.of_node;
> +}
>
> - =A0 =A0 =A0 if (bus->self)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self)=
;
> - =A0 =A0 =A0 host =3D pci_bus_to_host(bus);
> - =A0 =A0 =A0 return host ? host->dn : NULL;
> +static inline struct pci_controller *pci_bus_to_host(const struct pc=
i_bus *bus)
> +{
> + =A0 =A0 =A0 return bus->sysdata;
> =A0}
>
> =A0static inline int isa_vaddr_is_ioport(void __iomem *address)
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/inc=
lude/asm/prom.h
> index d0890d3..9bd01ec 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -29,21 +29,6 @@
> =A0extern int early_uartlite_console(void);
> =A0extern int early_uart16550_console(void);
>
> -#ifdef CONFIG_PCI
> -/*
> - * PCI <-> OF matching functions
> - * (XXX should these be here?)
> - */
> -struct pci_bus;
> -struct pci_dev;
> -extern int pci_device_from_OF_node(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u8 *bus, u8 *devfn);
> -extern struct device_node *pci_busdev_to_OF_node(struct pci_bus *bus=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int devfn);
> -extern struct device_node *pci_device_to_OF_node(struct pci_dev *dev=
);
> -extern void pci_create_OF_bus_map(void);
> -#endif
> -
> =A0/*
> =A0* OF address retreival & translation
> =A0*/
> diff --git a/arch/microblaze/pci/pci_32.c b/arch/microblaze/pci/pci_3=
2.c
> index 92728a6..2fa9506 100644
> --- a/arch/microblaze/pci/pci_32.c
> +++ b/arch/microblaze/pci/pci_32.c
> @@ -210,38 +210,6 @@ static struct device_node *scan_OF_for_pci_bus(s=
truct pci_bus *bus)
> =A0 =A0 =A0 =A0return np;
> =A0}
>
> -/*
> - * Scans the OF tree for a device node matching a PCI device
> - */
> -struct device_node *
> -pci_busdev_to_OF_node(struct pci_bus *bus, int devfn)
> -{
> - =A0 =A0 =A0 struct device_node *parent, *np;
> -
> - =A0 =A0 =A0 pr_debug("pci_busdev_to_OF_node(%d,0x%x)\n", bus->numbe=
r, devfn);
> - =A0 =A0 =A0 parent =3D scan_OF_for_pci_bus(bus);
> - =A0 =A0 =A0 if (parent =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> - =A0 =A0 =A0 pr_debug(" parent is %s\n", parent ? parent->full_name =
: "<NULL>");
> - =A0 =A0 =A0 np =3D scan_OF_for_pci_dev(parent, devfn);
> - =A0 =A0 =A0 of_node_put(parent);
> - =A0 =A0 =A0 pr_debug(" result is %s\n", np ? np->full_name : "<NULL=
>");
> -
> - =A0 =A0 =A0 /* XXX most callers don't release the returned node
> - =A0 =A0 =A0 =A0* mostly because ppc64 doesn't increase the refcount=
,
> - =A0 =A0 =A0 =A0* we need to fix that.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 return np;
> -}
> -EXPORT_SYMBOL(pci_busdev_to_OF_node);
> -
> -struct device_node*
> -pci_device_to_OF_node(struct pci_dev *dev)
> -{
> - =A0 =A0 =A0 return pci_busdev_to_OF_node(dev->bus, dev->devfn);
> -}
> -EXPORT_SYMBOL(pci_device_to_OF_node);
> -
> =A0static int
> =A0find_OF_pci_device_filter(struct device_node *node, void *data)
> =A0{
> @@ -315,6 +283,13 @@ pci_create_OF_bus_map(void)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 struct pci_controller *hose =3D bus->sysdata;
> +
> + =A0 =A0 =A0 return of_node_get(hose->dn);
> +}
> +
> =A0static void __devinit pcibios_scan_phb(struct pci_controller *hose=
)
> =A0{
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> @@ -332,7 +307,6 @@ static void __devinit pcibios_scan_phb(struct pci=
_controller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hose->global_number);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 bus.dev->of_node =3D of_node_get(node);
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/inc=
lude/asm/pci-bridge.h
> index b90dbf8..3e68694 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -169,18 +169,22 @@ static inline struct pci_controller *pci_bus_to=
_host(const struct pci_bus *bus)
> =A0 =A0 =A0 =A0return bus->sysdata;
> =A0}
>
> -#ifndef CONFIG_PPC64
> +static inline struct device_node *pci_device_to_OF_node(struct pci_d=
ev *dev)
> +{
> + =A0 =A0 =A0 return dev->dev.of_node;
> +}
>
> =A0static inline struct device_node *pci_bus_to_OF_node(struct pci_bu=
s *bus)
> =A0{
> - =A0 =A0 =A0 struct pci_controller *host;
> -
> - =A0 =A0 =A0 if (bus->self)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self)=
;
> - =A0 =A0 =A0 host =3D pci_bus_to_host(bus);
> - =A0 =A0 =A0 return host ? host->dn : NULL;
> + =A0 =A0 =A0 return bus->dev.of_node;
> =A0}
>
> +#ifndef CONFIG_PPC64
> +
> +extern int pci_device_from_OF_node(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u8 *bus, u8 *devfn);
> +extern void pci_create_OF_bus_map(void);
> +
> =A0static inline int isa_vaddr_is_ioport(void __iomem *address)
> =A0{
> =A0 =A0 =A0 =A0/* No specific ISA handling on ppc32 at this stage, it
> @@ -223,17 +227,8 @@ struct pci_dn {
> =A0/* Get the pointer to a device_node's pci_dn */
> =A0#define PCI_DN(dn) =A0 =A0 ((struct pci_dn *) (dn)->data)
>
> -extern struct device_node *fetch_dev_dn(struct pci_dev *dev);
> =A0extern void * update_dn_pci_info(struct device_node *dn, void *dat=
a);
>
> -/* Get a device_node from a pci_dev. =A0This code must be fast excep=
t
> - * in the case where the sysdata is incorrect and needs to be fixed
> - * up (this will only happen once). */
> -static inline struct device_node *pci_device_to_OF_node(struct pci_d=
ev *dev)
> -{
> - =A0 =A0 =A0 return dev->dev.of_node ? dev->dev.of_node : fetch_dev_=
dn(dev);
> -}
> -
> =A0static inline int pci_device_from_OF_node(struct device_node *np,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0u8 *bus, u8 *devfn)
> =A0{
> @@ -244,14 +239,6 @@ static inline int pci_device_from_OF_node(struct=
 device_node *np,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> -{
> - =A0 =A0 =A0 if (bus->self)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pci_device_to_OF_node(bus->self)=
;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return bus->dev.of_node; /* Must be roo=
t bus (PHB) */
> -}
> -
> =A0/** Find the bus corresponding to the indicated device node */
> =A0extern struct pci_bus *pcibios_find_pci_bus(struct device_node *dn=
);
>
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/as=
m/pci.h
> index 7d77909..1f52268 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -179,8 +179,7 @@ extern int remove_phb_dynamic(struct pci_controll=
er *phb);
> =A0extern struct pci_dev *of_create_pci_dev(struct device_node *node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct pci_bus *bus, int devfn);
>
> -extern void of_scan_pci_bridge(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
pci_dev *dev);
> +extern void of_scan_pci_bridge(struct pci_dev *dev);
>
> =A0extern void of_scan_bus(struct device_node *node, struct pci_bus *=
bus);
> =A0extern void of_rescan_bus(struct device_node *node, struct pci_bus=
 *bus);
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/a=
sm/prom.h
> index c189aa5..b823536 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -22,20 +22,6 @@
>
> =A0#define HAVE_ARCH_DEVTREE_FIXUPS
>
> -#ifdef CONFIG_PPC32
> -/*
> - * PCI <-> OF matching functions
> - * (XXX should these be here?)
> - */
> -struct pci_bus;
> -struct pci_dev;
> -extern int pci_device_from_OF_node(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
u8* bus, u8* devfn);
> -extern struct device_node* pci_busdev_to_OF_node(struct pci_bus *, i=
nt);
> -extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
> -extern void pci_create_OF_bus_map(void);
> -#endif
> -
> =A0/*
> =A0* OF address retreival & translation
> =A0*/
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/p=
ci-common.c
> index 893af2a..a3c9277 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1097,9 +1097,6 @@ void __devinit pcibios_setup_bus_devices(struct=
 pci_bus *bus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dev->is_added)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Setup OF node pointer in the device =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.of_node =3D pci_device_to_OF_n=
ode(dev);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fixup NUMA node as it may not be se=
tup yet by the generic
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * code and is needed by the DMA init
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> @@ -1685,6 +1682,13 @@ int early_find_capability(struct pci_controlle=
r *hose, int bus, int devfn,
> =A0 =A0 =A0 =A0return pci_bus_find_capability(fake_pci_bus(hose, bus)=
, devfn, cap);
> =A0}
>
> +struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 struct pci_controller *hose =3D bus->sysdata;
> +
> + =A0 =A0 =A0 return of_node_get(hose->dn);
> +}
> +
> =A0/**
> =A0* pci_scan_phb - Given a pci_controller, setup and scan the PCI bu=
s
> =A0* @hose: Pointer to the PCI host controller instance structure
> @@ -1705,7 +1709,6 @@ void __devinit pcibios_scan_phb(struct pci_cont=
roller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->global_number);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 bus->dev.of_node =3D of_node_get(node);
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_3=
2.c
> index bedb370..8658550 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -167,150 +167,26 @@ pcibios_make_OF_bus_map(void)
> =A0#endif
> =A0}
>
> -typedef int (*pci_OF_scan_iterator)(struct device_node* node, void* =
data);
> -
> -static struct device_node*
> -scan_OF_pci_childs(struct device_node *parent, pci_OF_scan_iterator =
filter, void* data)
> -{
> - =A0 =A0 =A0 struct device_node *node;
> - =A0 =A0 =A0 struct device_node* sub_node;
> -
> - =A0 =A0 =A0 for_each_child_of_node(parent, node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 const unsigned int *class_code;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (filter(node, data)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return node;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* For PCI<->PCI bridges or CardBus bri=
dges, we go down
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Note: some OFs create a parent nod=
e "multifunc-device" as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fake root for all functions of a=
 multi-function device,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we go down them as well.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 class_code =3D of_get_property(node, "c=
lass-code", NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((!class_code || ((*class_code >> 8)=
 !=3D PCI_CLASS_BRIDGE_PCI &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*class_code >> 8) !=3D=
 PCI_CLASS_BRIDGE_CARDBUS)) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strcmp(node->name, "mul=
tifunc-device"))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub_node =3D scan_OF_pci_childs(node, f=
ilter, data);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sub_node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(node);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sub_node;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return NULL;
> -}
> -
> -static struct device_node *scan_OF_for_pci_dev(struct device_node *p=
arent,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0unsigned int devfn)
> -{
> - =A0 =A0 =A0 struct device_node *np, *cnp;
> - =A0 =A0 =A0 const u32 *reg;
> - =A0 =A0 =A0 unsigned int psize;
> -
> - =A0 =A0 =A0 for_each_child_of_node(parent, np) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(np, "reg", &psi=
ze);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (reg && psize >=3D 4 && ((reg[0] =
>> 8) & 0xff) =3D=3D devfn)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return np;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Note: some OFs create a parent node =
"multifunc-device" as
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fake root for all functions of a=
 multi-function device,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* we go down them as well. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strcmp(np->name, "multifunc-dev=
ice")) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cnp =3D scan_OF_for_=
pci_dev(np, devfn);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cnp)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retu=
rn cnp;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 return NULL;
> -}
> -
> -
> -static struct device_node *scan_OF_for_pci_bus(struct pci_bus *bus)
> -{
> - =A0 =A0 =A0 struct device_node *parent, *np;
> -
> - =A0 =A0 =A0 /* Are we a root bus ? */
> - =A0 =A0 =A0 if (bus->self =3D=3D NULL || bus->parent =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_controller *hose =3D pci_bus=
_to_host(bus);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hose =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return of_node_get(hose->dn);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* not a root bus, we need to get our parent */
> - =A0 =A0 =A0 parent =3D scan_OF_for_pci_bus(bus->parent);
> - =A0 =A0 =A0 if (parent =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> -
> - =A0 =A0 =A0 /* now iterate for children for a match */
> - =A0 =A0 =A0 np =3D scan_OF_for_pci_dev(parent, bus->self->devfn);
> - =A0 =A0 =A0 of_node_put(parent);
> -
> - =A0 =A0 =A0 return np;
> -}
> -
> -/*
> - * Scans the OF tree for a device node matching a PCI device
> - */
> -struct device_node *
> -pci_busdev_to_OF_node(struct pci_bus *bus, int devfn)
> -{
> - =A0 =A0 =A0 struct device_node *parent, *np;
> -
> - =A0 =A0 =A0 pr_debug("pci_busdev_to_OF_node(%d,0x%x)\n", bus->numbe=
r, devfn);
> - =A0 =A0 =A0 parent =3D scan_OF_for_pci_bus(bus);
> - =A0 =A0 =A0 if (parent =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> - =A0 =A0 =A0 pr_debug(" parent is %s\n", parent ? parent->full_name =
: "<NULL>");
> - =A0 =A0 =A0 np =3D scan_OF_for_pci_dev(parent, devfn);
> - =A0 =A0 =A0 of_node_put(parent);
> - =A0 =A0 =A0 pr_debug(" result is %s\n", np ? np->full_name : "<NULL=
>");
> -
> - =A0 =A0 =A0 /* XXX most callers don't release the returned node
> - =A0 =A0 =A0 =A0* mostly because ppc64 doesn't increase the refcount=
,
> - =A0 =A0 =A0 =A0* we need to fix that.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 return np;
> -}
> -EXPORT_SYMBOL(pci_busdev_to_OF_node);
> -
> -struct device_node*
> -pci_device_to_OF_node(struct pci_dev *dev)
> -{
> - =A0 =A0 =A0 return pci_busdev_to_OF_node(dev->bus, dev->devfn);
> -}
> -EXPORT_SYMBOL(pci_device_to_OF_node);
> -
> -static int
> -find_OF_pci_device_filter(struct device_node* node, void* data)
> -{
> - =A0 =A0 =A0 return ((void *)node =3D=3D data);
> -}
>
> =A0/*
> =A0* Returns the PCI device matching a given OF node
> =A0*/
> -int
> -pci_device_from_OF_node(struct device_node* node, u8* bus, u8* devfn=
)
> +int pci_device_from_OF_node(struct device_node *node, u8 *bus, u8 *d=
evfn)
> =A0{
> - =A0 =A0 =A0 const unsigned int *reg;
> - =A0 =A0 =A0 struct pci_controller* hose;
> - =A0 =A0 =A0 struct pci_dev* dev =3D NULL;
> -
> - =A0 =A0 =A0 /* Make sure it's really a PCI device */
> - =A0 =A0 =A0 hose =3D pci_find_hose_for_OF_device(node);
> - =A0 =A0 =A0 if (!hose || !hose->dn)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> - =A0 =A0 =A0 if (!scan_OF_pci_childs(hose->dn,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 find_OF_pci_device_filt=
er, (void *)node))
> + =A0 =A0 =A0 struct pci_dev *dev =3D NULL;
> + =A0 =A0 =A0 const __be32 *reg;
> + =A0 =A0 =A0 int size;
> +
> + =A0 =A0 =A0 /* Check if it might have a chance to be a PCI device *=
/
> + =A0 =A0 =A0 if (!pci_find_hose_for_OF_device(node))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> - =A0 =A0 =A0 reg =3D of_get_property(node, "reg", NULL);
> - =A0 =A0 =A0 if (!reg)
> +
> + =A0 =A0 =A0 reg =3D of_get_property(node, "reg", &size);
> + =A0 =A0 =A0 if (!reg || size < 5 * sizeof(u32))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> - =A0 =A0 =A0 *bus =3D (reg[0] >> 16) & 0xff;
> - =A0 =A0 =A0 *devfn =3D ((reg[0] >> 8) & 0xff);
> +
> + =A0 =A0 =A0 *bus =3D (be32_to_cpup(&reg[0]) >> 16) & 0xff;
> + =A0 =A0 =A0 *devfn =3D (be32_to_cpup(&reg[0]) >> 8) & 0xff;
>
> =A0 =A0 =A0 =A0/* Ok, here we need some tweak. If we have already ren=
umbered
> =A0 =A0 =A0 =A0 * all busses, we can't rely on the OF bus number any =
more.
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_d=
n.c
> index d225d99..8cb66a2 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -143,53 +143,6 @@ void __devinit pci_devs_phb_init_dynamic(struct =
pci_controller *phb)
> =A0 =A0 =A0 =A0traverse_pci_devices(dn, update_dn_pci_info, phb);
> =A0}
>
> -/*
> - * Traversal func that looks for a <busno,devfcn> value.
> - * If found, the pci_dn is returned (thus terminating the traversal)=
=2E
> - */
> -static void *is_devfn_node(struct device_node *dn, void *data)
> -{
> - =A0 =A0 =A0 int busno =3D ((unsigned long)data >> 8) & 0xff;
> - =A0 =A0 =A0 int devfn =3D ((unsigned long)data) & 0xff;
> - =A0 =A0 =A0 struct pci_dn *pci =3D dn->data;
> -
> - =A0 =A0 =A0 if (pci && (devfn =3D=3D pci->devfn) && (busno =3D=3D p=
ci->busno))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return dn;
> - =A0 =A0 =A0 return NULL;
> -}
> -
> -/*
> - * This is the "slow" path for looking up a device_node from a
> - * pci_dev. =A0It will hunt for the device under its parent's
> - * phb and then update of_node pointer.
> - *
> - * It may also do fixups on the actual device since this happens
> - * on the first read/write.
> - *
> - * Note that it also must deal with devices that don't exist.
> - * In this case it may probe for real hardware ("just in case")
> - * and add a device_node to the device tree if necessary.
> - *
> - * Is this function necessary anymore now that dev->dev.of_node is
> - * used to store the node pointer?
> - *
> - */
> -struct device_node *fetch_dev_dn(struct pci_dev *dev)
> -{
> - =A0 =A0 =A0 struct pci_controller *phb =3D dev->sysdata;
> - =A0 =A0 =A0 struct device_node *dn;
> - =A0 =A0 =A0 unsigned long searchval =3D (dev->bus->number << 8) | d=
ev->devfn;
> -
> - =A0 =A0 =A0 if (WARN_ON(!phb))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> -
> - =A0 =A0 =A0 dn =3D traverse_pci_devices(phb->dn, is_devfn_node, (vo=
id *)searchval);
> - =A0 =A0 =A0 if (dn)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dev.of_node =3D dn;
> - =A0 =A0 =A0 return dn;
> -}
> -EXPORT_SYMBOL(fetch_dev_dn);
> -
> =A0/**
> =A0* pci_devs_phb_init - Initialize phbs and pci devs under them.
> =A0*
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/=
pci_of_scan.c
> index 1e89a72..fe0a5ad 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -202,9 +202,9 @@ EXPORT_SYMBOL(of_create_pci_dev);
> =A0* this routine in turn call of_scan_bus() recusively to scan for m=
ore child
> =A0* devices.
> =A0*/
> -void __devinit of_scan_pci_bridge(struct device_node *node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct pci_dev *dev)
> +void __devinit of_scan_pci_bridge(struct pci_dev *dev)
> =A0{
> + =A0 =A0 =A0 struct device_node *node =3D dev->dev.of_node;
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0const u32 *busrange, *ranges;
> =A0 =A0 =A0 =A0int len, i, mode;
> @@ -238,7 +238,6 @@ void __devinit of_scan_pci_bridge(struct device_n=
ode *node,
> =A0 =A0 =A0 =A0bus->primary =3D dev->bus->number;
> =A0 =A0 =A0 =A0bus->subordinate =3D busrange[1];
> =A0 =A0 =A0 =A0bus->bridge_ctl =3D 0;
> - =A0 =A0 =A0 bus->dev.of_node =3D of_node_get(node);
>
> =A0 =A0 =A0 =A0/* parse ranges property */
> =A0 =A0 =A0 =A0/* PCI #address-cells =3D=3D 3 and #size-cells =3D=3D =
2 always */
> @@ -335,9 +334,7 @@ static void __devinit __of_scan_bus(struct device=
_node *node,
> =A0 =A0 =A0 =A0list_for_each_entry(dev, &bus->devices, bus_list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dev->hdr_type =3D=3D PCI_HEADER_TY=
PE_BRIDGE ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->hdr_type =3D=3D PCI_HEADE=
R_TYPE_CARDBUS) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *chi=
ld =3D pci_device_to_OF_node(dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (child)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan=
_pci_bridge(child, dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan_pci_bridge(dev)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0}
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/pla=
tforms/powermac/pci.c
> index f33e08d..abe8d7e 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/bootmem.h>
> =A0#include <linux/irq.h>
> +#include <linux/of_pci.h>
>
> =A0#include <asm/sections.h>
> =A0#include <asm/io.h>
> @@ -235,7 +236,7 @@ static int chaos_validate_dev(struct pci_bus *bus=
, int devfn, int offset)
>
> =A0 =A0 =A0 =A0if (offset >=3D 0x100)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return =A0PCIBIOS_BAD_REGISTER_NUMBER;
> - =A0 =A0 =A0 np =3D pci_busdev_to_OF_node(bus, devfn);
> + =A0 =A0 =A0 np =3D of_pci_find_child_device(bus->dev.of_node, devfn=
);
> =A0 =A0 =A0 =A0if (np =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PCIBIOS_DEVICE_NOT_FOUND;
>
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 713dc91..e539d23 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -284,7 +284,7 @@ static struct pci_dev *of_create_pci_dev(struct p=
ci_pbm_info *pbm,
> =A0 =A0 =A0 =A0dev->sysdata =3D node;
> =A0 =A0 =A0 =A0dev->dev.parent =3D bus->bridge;
> =A0 =A0 =A0 =A0dev->dev.bus =3D &pci_bus_type;
> - =A0 =A0 =A0 dev->dev.of_node =3D node;
> + =A0 =A0 =A0 dev->dev.of_node =3D of_node_get(node);
> =A0 =A0 =A0 =A0dev->devfn =3D devfn;
> =A0 =A0 =A0 =A0dev->multifunction =3D 0; =A0 =A0 =A0 =A0 /* maybe a l=
ie? */
> =A0 =A0 =A0 =A0set_pcie_port_type(dev);
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index d06a637..cac63c9 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -71,8 +71,14 @@ config OF_MDIO
>
> =A0config OF_PCI
> =A0 =A0 =A0 =A0def_tristate PCI
> - =A0 =A0 =A0 depends on PCI && (PPC || MICROBLAZE || X86)
> + =A0 =A0 =A0 depends on PCI
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0OpenFirmware PCI bus accessors
>
> +config OF_PCI_IRQ
> + =A0 =A0 =A0 def_tristate PCI
> + =A0 =A0 =A0 depends on OF_PCI && OF_IRQ
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 OpenFirmware PCI IRQ routing helpers
> +
> =A0endmenu # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index f7861ed..dccb117 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_OF_NET) =A0+=3D of_net.o
> =A0obj-$(CONFIG_OF_SPI) =A0 +=3D of_spi.o
> =A0obj-$(CONFIG_OF_MDIO) =A0+=3D of_mdio.o
> =A0obj-$(CONFIG_OF_PCI) =A0 +=3D of_pci.o
> +obj-$(CONFIG_OF_PCI_IRQ) =A0+=3D of_pci_irq.o
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index ac1ec54..ec7b060 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -1,92 +1,40 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/of_pci.h>
> -#include <linux/of_irq.h>
> =A0#include <asm/prom.h>
>
> -/**
> - * of_irq_map_pci - Resolve the interrupt for a PCI device
> - * @pdev: =A0 =A0 =A0 the device whose interrupt is to be resolved
> - * @out_irq: =A0 =A0structure of_irq filled by this function
> - *
> - * This function resolves the PCI interrupt for a given PCI device. =
If a
> - * device-node exists for a given pci_dev, it will use normal OF tre=
e
> - * walking. If not, it will implement standard swizzling and walk up=
 the
> - * PCI tree until an device-node is found, at which point it will fi=
nish
> - * resolving using the OF tree walking.
> - */
> -int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> +static inline int __of_pci_pci_compare(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned int devfn)
> =A0{
> - =A0 =A0 =A0 struct device_node *dn, *ppnode;
> - =A0 =A0 =A0 struct pci_dev *ppdev;
> - =A0 =A0 =A0 u32 lspec;
> - =A0 =A0 =A0 __be32 lspec_be;
> - =A0 =A0 =A0 __be32 laddr[3];
> - =A0 =A0 =A0 u8 pin;
> - =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 unsigned int size;
> + =A0 =A0 =A0 const __be32 *reg =3D of_get_property(node, "reg", &siz=
e);
>
> - =A0 =A0 =A0 /* Check if we have a device node, if yes, fallback to =
standard
> - =A0 =A0 =A0 =A0* device tree parsing
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 dn =3D pci_device_to_OF_node(pdev);
> - =A0 =A0 =A0 if (dn) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D of_irq_map_one(dn, 0, out_irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rc)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /* Ok, we don't, time to have fun. Let's start by build=
ing up an
> - =A0 =A0 =A0 =A0* interrupt spec. =A0we assume #interrupt-cells is 1=
, which is standard
> - =A0 =A0 =A0 =A0* for PCI. If you do different, then don't use that =
routine.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 rc =3D pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &p=
in);
> - =A0 =A0 =A0 if (rc !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> - =A0 =A0 =A0 /* No pin, exit */
> - =A0 =A0 =A0 if (pin =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> -
> - =A0 =A0 =A0 /* Now we walk up the PCI tree */
> - =A0 =A0 =A0 lspec =3D pin;
> - =A0 =A0 =A0 for (;;) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the pci_dev of our parent */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppdev =3D pdev->bus->self;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ouch, it's a host bridge... */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppdev =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_bus_to_O=
=46_node(pdev->bus);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No node for host bri=
dge ? give up */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We found a P2P bridg=
e, check if it has a node */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_device_t=
o_OF_node(ppdev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we have found a parent with a de=
vice-node, hand over to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the OF parsing code.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We build a unit address from the l=
inux device to be used for
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resolution. Note that we use the l=
inux bus number which may
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not match your firmware bus number=
ing.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fortunately, in most cases, interr=
upt-map-mask doesn't
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* include the bus number as part of =
the matching.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* You should still be careful about =
that though if you intend
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to rely on this function (you ship=
 =A0a firmware that doesn't
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* create device nodes for all PCI de=
vices).
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 if (!reg || size < 5 * sizeof(__be32))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return ((be32_to_cpup(&reg[0]) >> 8) & 0xff) =3D=3D dev=
fn;
> +}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can only get here if we hit a P2P=
 bridge with no node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* let's do standard swizzling and tr=
y again
> +struct device_node *of_pci_find_child_device(struct device_node *par=
ent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0unsigned int devfn)
> +{
> + =A0 =A0 =A0 struct device_node *node, *node2;
> +
> + =A0 =A0 =A0 for_each_child_of_node(parent, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__of_pci_pci_compare(node, devfn))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return node;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Some OFs create a parent node "mul=
tifunc-device" as
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fake root for all functions of a=
 multi-function
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* device we go down them as well.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lspec =3D pci_swizzle_interrupt_pin(pde=
v, lspec);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D ppdev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(node->name, "multifunc-devi=
ce")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_child_of_node(=
node, node2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (__o=
f_pci_pci_compare(node2, devfn)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 of_node_put(node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 return node2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 lspec_be =3D cpu_to_be32(lspec);
> - =A0 =A0 =A0 laddr[0] =3D cpu_to_be32((pdev->bus->number << 16) | (p=
dev->devfn << 8));
> - =A0 =A0 =A0 laddr[1] =A0=3D laddr[2] =3D cpu_to_be32(0);
> - =A0 =A0 =A0 return of_irq_map_raw(ppnode, &lspec_be, 1, laddr, out_=
irq);
> + =A0 =A0 =A0 return NULL;
> =A0}
> -EXPORT_SYMBOL_GPL(of_irq_map_pci);
> +EXPORT_SYMBOL_GPL(of_pci_find_child_device);
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> new file mode 100644
> index 0000000..ac1ec54
> --- /dev/null
> +++ b/drivers/of/of_pci_irq.c
> @@ -0,0 +1,92 @@
> +#include <linux/kernel.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_irq.h>
> +#include <asm/prom.h>
> +
> +/**
> + * of_irq_map_pci - Resolve the interrupt for a PCI device
> + * @pdev: =A0 =A0 =A0 the device whose interrupt is to be resolved
> + * @out_irq: =A0 =A0structure of_irq filled by this function
> + *
> + * This function resolves the PCI interrupt for a given PCI device. =
If a
> + * device-node exists for a given pci_dev, it will use normal OF tre=
e
> + * walking. If not, it will implement standard swizzling and walk up=
 the
> + * PCI tree until an device-node is found, at which point it will fi=
nish
> + * resolving using the OF tree walking.
> + */
> +int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> +{
> + =A0 =A0 =A0 struct device_node *dn, *ppnode;
> + =A0 =A0 =A0 struct pci_dev *ppdev;
> + =A0 =A0 =A0 u32 lspec;
> + =A0 =A0 =A0 __be32 lspec_be;
> + =A0 =A0 =A0 __be32 laddr[3];
> + =A0 =A0 =A0 u8 pin;
> + =A0 =A0 =A0 int rc;
> +
> + =A0 =A0 =A0 /* Check if we have a device node, if yes, fallback to =
standard
> + =A0 =A0 =A0 =A0* device tree parsing
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 dn =3D pci_device_to_OF_node(pdev);
> + =A0 =A0 =A0 if (dn) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D of_irq_map_one(dn, 0, out_irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Ok, we don't, time to have fun. Let's start by build=
ing up an
> + =A0 =A0 =A0 =A0* interrupt spec. =A0we assume #interrupt-cells is 1=
, which is standard
> + =A0 =A0 =A0 =A0* for PCI. If you do different, then don't use that =
routine.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 rc =3D pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &p=
in);
> + =A0 =A0 =A0 if (rc !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 /* No pin, exit */
> + =A0 =A0 =A0 if (pin =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* Now we walk up the PCI tree */
> + =A0 =A0 =A0 lspec =3D pin;
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the pci_dev of our parent */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppdev =3D pdev->bus->self;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ouch, it's a host bridge... */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppdev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_bus_to_O=
=46_node(pdev->bus);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No node for host bri=
dge ? give up */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We found a P2P bridg=
e, check if it has a node */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppnode =3D pci_device_t=
o_OF_node(ppdev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Ok, we have found a parent with a de=
vice-node, hand over to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the OF parsing code.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We build a unit address from the l=
inux device to be used for
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* resolution. Note that we use the l=
inux bus number which may
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* not match your firmware bus number=
ing.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Fortunately, in most cases, interr=
upt-map-mask doesn't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* include the bus number as part of =
the matching.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* You should still be careful about =
that though if you intend
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to rely on this function (you ship=
 =A0a firmware that doesn't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* create device nodes for all PCI de=
vices).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ppnode)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We can only get here if we hit a P2P=
 bridge with no node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* let's do standard swizzling and tr=
y again
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lspec =3D pci_swizzle_interrupt_pin(pde=
v, lspec);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev =3D ppdev;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 lspec_be =3D cpu_to_be32(lspec);
> + =A0 =A0 =A0 laddr[0] =3D cpu_to_be32((pdev->bus->number << 16) | (p=
dev->devfn << 8));
> + =A0 =A0 =A0 laddr[1] =A0=3D laddr[2] =3D cpu_to_be32(0);
> + =A0 =A0 =A0 return of_irq_map_raw(ppnode, &lspec_be, 1, laddr, out_=
irq);
> +}
> +EXPORT_SYMBOL_GPL(of_irq_map_pci);
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 98d61c8..d5c3cb9 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -70,4 +70,6 @@ obj-$(CONFIG_PCI_STUB) +=3D pci-stub.o
>
> =A0obj-$(CONFIG_XEN_PCIDEV_FRONTEND) +=3D xen-pcifront.o
>
> +obj-$(CONFIG_OF) +=3D of.o
> +
> =A0ccflags-$(CONFIG_PCI_DEBUG) :=3D -DDEBUG
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplu=
g/rpadlpar_core.c
> index 0830347..1d002b1 100644
> --- a/drivers/pci/hotplug/rpadlpar_core.c
> +++ b/drivers/pci/hotplug/rpadlpar_core.c
> @@ -158,7 +158,7 @@ static void dlpar_pci_add_bus(struct device_node =
*dn)
> =A0 =A0 =A0 =A0/* Scan below the new bridge */
> =A0 =A0 =A0 =A0if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE ||
> =A0 =A0 =A0 =A0 =A0 =A0dev->hdr_type =3D=3D PCI_HEADER_TYPE_CARDBUS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan_pci_bridge(dn, dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_scan_pci_bridge(dev);
>
> =A0 =A0 =A0 =A0/* Map IO space for child bus, which may or may not su=
cceed */
> =A0 =A0 =A0 =A0pcibios_map_io_space(dev->subordinate);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> new file mode 100644
> index 0000000..c94d37e
> --- /dev/null
> +++ b/drivers/pci/of.c
> @@ -0,0 +1,61 @@
> +/*
> + * PCI <-> OF mapping helpers
> + *
> + * Copyright 2011 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include "pci.h"
> +
> +void pci_set_of_node(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 if (!dev->bus->dev.of_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 dev->dev.of_node =3D of_pci_find_child_device(dev->bus-=
>dev.of_node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->devfn);
> +}
> +
> +void pci_release_of_node(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 of_node_put(dev->dev.of_node);
> + =A0 =A0 =A0 dev->dev.of_node =3D NULL;
> +}
> +
> +void pci_set_bus_of_node(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 if (bus->self =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->dev.of_node =3D pcibios_get_phb_of=
_node(bus);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->dev.of_node =3D of_node_get(bus->s=
elf->dev.of_node);
> +}
> +
> +void pci_release_bus_of_node(struct pci_bus *bus)
> +{
> + =A0 =A0 =A0 of_node_put(bus->dev.of_node);
> + =A0 =A0 =A0 bus->dev.of_node =3D NULL;
> +}
> +
> +struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *=
bus)
> +{
> + =A0 =A0 =A0 /* This should only be called for PHBs */
> + =A0 =A0 =A0 if (WARN_ON(bus->self || bus->parent))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 /* Look for a node pointer in either the intermediary d=
evice we
> + =A0 =A0 =A0 =A0* create above the root bus or it's own parent. Norm=
ally only
> + =A0 =A0 =A0 =A0* the later is populated.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (bus->bridge->of_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return of_node_get(bus->bridge->of_node=
);
> + =A0 =A0 =A0 if (bus->bridge->parent->of_node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return of_node_get(bus->bridge->parent-=
>of_node);
> + =A0 =A0 =A0 return NULL;
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 44cbbba..7964474 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -89,6 +89,7 @@ static void release_pcibus_dev(struct device *dev)
> =A0 =A0 =A0 =A0if (pci_bus->bridge)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0put_device(pci_bus->bridge);
> =A0 =A0 =A0 =A0pci_bus_remove_resources(pci_bus);
> + =A0 =A0 =A0 pci_release_bus_of_node(pci_bus);
> =A0 =A0 =A0 =A0kfree(pci_bus);
> =A0}
>
> @@ -624,7 +625,7 @@ static struct pci_bus *pci_alloc_child_bus(struct=
 pci_bus *parent,
>
> =A0 =A0 =A0 =A0child->self =3D bridge;
> =A0 =A0 =A0 =A0child->bridge =3D get_device(&bridge->dev);
> -
> + =A0 =A0 =A0 pci_set_bus_of_node(child);
> =A0 =A0 =A0 =A0pci_set_bus_speed(child);
>
> =A0 =A0 =A0 =A0/* Set up default resource pointers and names.. */
> @@ -1074,6 +1075,7 @@ static void pci_release_dev(struct device *dev)
>
> =A0 =A0 =A0 =A0pci_dev =3D to_pci_dev(dev);
> =A0 =A0 =A0 =A0pci_release_capabilities(pci_dev);
> + =A0 =A0 =A0 pci_release_of_node(pci_dev);
> =A0 =A0 =A0 =A0kfree(pci_dev);
> =A0}
>
> @@ -1193,6 +1195,8 @@ static struct pci_dev *pci_scan_device(struct p=
ci_bus *bus, int devfn)
> =A0 =A0 =A0 =A0dev->vendor =3D l & 0xffff;
> =A0 =A0 =A0 =A0dev->device =3D (l >> 16) & 0xffff;
>
> + =A0 =A0 =A0 pci_set_of_node(dev);
> +
> =A0 =A0 =A0 =A0if (pci_setup_device(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> @@ -1445,6 +1449,7 @@ struct pci_bus * pci_create_bus(struct device *=
parent,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto dev_reg_err;
> =A0 =A0 =A0 =A0b->bridge =3D get_device(dev);
> =A0 =A0 =A0 =A0device_enable_async_suspend(b->bridge);
> + =A0 =A0 =A0 pci_set_bus_of_node(b);
>
> =A0 =A0 =A0 =A0if (!parent)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_dev_node(b->bridge, pcibus_to_node=
(b));
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 85a27b6..f93e217 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -6,4 +6,9 @@
> =A0struct pci_dev;
> =A0struct of_irq;
> =A0int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
> +
> +struct device_node;
> +struct device_node *of_pci_find_child_device(struct device_node *par=
ent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0unsigned int devfn);
> +
> =A0#endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 96f70d7..f2a25f8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1543,5 +1543,23 @@ int pci_vpd_find_tag(const u8 *buf, unsigned i=
nt off, unsigned int len, u8 rdt);
> =A0int pci_vpd_find_info_keyword(const u8 *buf, unsigned int off,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned i=
nt len, const char *kw);
>
> +/* PCI <-> OF binding helpers */
> +#ifdef CONFIG_OF
> +struct device_node;
> +extern void pci_set_of_node(struct pci_dev *dev);
> +extern void pci_release_of_node(struct pci_dev *dev);
> +extern void pci_set_bus_of_node(struct pci_bus *bus);
> +extern void pci_release_bus_of_node(struct pci_bus *bus);
> +
> +/* Arch may override this (weak) */
> +extern struct device_node * __weak pcibios_get_phb_of_node(struct pc=
i_bus *bus);
> +
> +#else /* CONFIG_OF */
> +static inline void pci_set_of_node(struct pci_dev *dev) { }
> +static inline void pci_release_of_node(struct pci_dev *dev) { }
> +static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
> +static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> +#endif =A0/* CONFIG_OF */
> +
> =A0#endif /* __KERNEL__ */
> =A0#endif /* LINUX_PCI_H */
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
