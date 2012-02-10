From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 02/18] PCI: add struct pci_host_bridge and a list of
 all bridges found
Date: Thu, 9 Feb 2012 19:47:00 -0800
Message-ID: <CAE9FiQXtYfcqjSKLxiYqgtMfqZts2kvM8G1M5Kw0VemmtvTBPA@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
	<20120210023631.10311.37307.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120210023631.10311.37307.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> This adds a list of all PCI host bridges we find and a way to look up
> the host bridge from a pci_dev.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
> =A0drivers/pci/probe.c | =A0 39 ++++++++++++++++++++++++++++++++++---=
--
> =A0include/linux/pci.h | =A0 =A05 +++++
> =A02 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index da0d655..2ffe8a3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -15,6 +15,8 @@
> =A0#define CARDBUS_LATENCY_TIMER =A0176 =A0 =A0 /* secondary latency =
timer */
> =A0#define CARDBUS_RESERVE_BUSNR =A03
>
> +static LIST_HEAD(pci_host_bridges);
> +
> =A0/* Ugh. =A0Need to stop exporting this to modules. */
> =A0LIST_HEAD(pci_root_buses);
> =A0EXPORT_SYMBOL(pci_root_buses);
> @@ -42,6 +44,23 @@ int no_pci_devices(void)
> =A0}
> =A0EXPORT_SYMBOL(no_pci_devices);
>
> +static struct pci_host_bridge *pci_host_bridge(struct pci_dev *dev)
> +{
> + =A0 =A0 =A0 struct pci_bus *bus;
> + =A0 =A0 =A0 struct pci_host_bridge *bridge;
> +
> + =A0 =A0 =A0 bus =3D dev->bus;
> + =A0 =A0 =A0 while (bus->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D bus->parent;
> +
> + =A0 =A0 =A0 list_for_each_entry(bridge, &pci_host_bridges, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bridge->bus =3D=3D bus)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return bridge;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return NULL;
> +}
> +

so pci_host_bridge(dev) still is expensive.



> =A0/*
> =A0* PCI Bus Class
> =A0*/
> @@ -1526,20 +1545,23 @@ struct pci_bus *pci_create_root_bus(struct de=
vice *parent, int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_ops *ops, void *sysdata, st=
ruct list_head *resources)
> =A0{
> =A0 =A0 =A0 =A0int error, i;
> + =A0 =A0 =A0 struct pci_host_bridge *bridge;
> =A0 =A0 =A0 =A0struct pci_bus *b, *b2;
> =A0 =A0 =A0 =A0struct device *dev;
> =A0 =A0 =A0 =A0struct pci_bus_resource *bus_res, *n;
> =A0 =A0 =A0 =A0struct resource *res;
>
> + =A0 =A0 =A0 bridge =3D kzalloc(sizeof(*bridge), GFP_KERNEL);
> + =A0 =A0 =A0 if (!bridge)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> =A0 =A0 =A0 =A0b =3D pci_alloc_bus();
> =A0 =A0 =A0 =A0if (!b)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_bus;
>
> =A0 =A0 =A0 =A0dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> - =A0 =A0 =A0 if (!dev) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(b);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_dev;
>
> =A0 =A0 =A0 =A0b->sysdata =3D sysdata;
> =A0 =A0 =A0 =A0b->ops =3D ops;
> @@ -1576,6 +1598,8 @@ struct pci_bus *pci_create_root_bus(struct devi=
ce *parent, int bus,
>
> =A0 =A0 =A0 =A0b->number =3D b->secondary =3D bus;
>
> + =A0 =A0 =A0 bridge->bus =3D b;
> +
> =A0 =A0 =A0 =A0/* Add initial resources to the bus */
> =A0 =A0 =A0 =A0list_for_each_entry_safe(bus_res, n, resources, list)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_move_tail(&bus_res->list, &b->res=
ources);
> @@ -1591,6 +1615,7 @@ struct pci_bus *pci_create_root_bus(struct devi=
ce *parent, int bus,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0down_write(&pci_bus_sem);
> + =A0 =A0 =A0 list_add_tail(&bridge->list, &pci_host_bridges);
> =A0 =A0 =A0 =A0list_add_tail(&b->node, &pci_root_buses);
> =A0 =A0 =A0 =A0up_write(&pci_bus_sem);
>
> @@ -1600,11 +1625,15 @@ class_dev_reg_err:
> =A0 =A0 =A0 =A0device_unregister(dev);
> =A0dev_reg_err:
> =A0 =A0 =A0 =A0down_write(&pci_bus_sem);
> + =A0 =A0 =A0 list_del(&bridge->list);
> =A0 =A0 =A0 =A0list_del(&b->node);
> =A0 =A0 =A0 =A0up_write(&pci_bus_sem);
> =A0err_out:
> =A0 =A0 =A0 =A0kfree(dev);
> +err_dev:
> =A0 =A0 =A0 =A0kfree(b);
> +err_bus:
> + =A0 =A0 =A0 kfree(bridge);
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a16b1df..dfb2b64 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -388,6 +388,11 @@ static inline void pci_add_saved_cap(struct pci_=
dev *pci_dev,
> =A0 =A0 =A0 =A0hlist_add_head(&new_cap->next, &pci_dev->saved_cap_spa=
ce);
> =A0}
>
> +struct pci_host_bridge {
> + =A0 =A0 =A0 struct list_head list;
> + =A0 =A0 =A0 struct pci_bus *bus; =A0 =A0 =A0 =A0 =A0 =A0/* root bus=
 */
> +};
> +

also still have two list: one for host bridges and one for root buses.

Yinghai
