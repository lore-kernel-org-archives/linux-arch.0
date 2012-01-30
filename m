From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 03/13] PCI: Add busn_res tracking in core
Date: Mon, 30 Jan 2012 07:35:24 -0800
Message-ID: <CAErSpo4d=HW9Lk+O8Kz6BzQZY1DpF1OEuD37RwABgT3m03LB3Q@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org> <1327718971-9598-4-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1327718971-9598-4-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> update pci_scan_root_bus, and pci_scan_bus to insert root bus busn in=
to
> iobusn_resource tree.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c =A0| =A0 30 ++++++++++++++++++++++++++----
> =A0drivers/pci/remove.c | =A0 =A01 +
> =A0include/linux/pci.h =A0| =A0 =A04 ++++
> =A03 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 71261da..55404c3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1666,8 +1666,9 @@ void pci_bus_release_busn_res(struct pci_bus *b=
)
> =A0 =A0 =A0 =A0release_resource(&b->busn_res);
> =A0}
>
> -struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, =
int bus,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata, str=
uct list_head *resources)
> +struct pci_bus * __devinit pci_scan_root_bus_max(struct device *pare=
nt, int bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bus_max, struct pci_ops *ops, void =
*sysdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct list_head *resources)

We are adding "scan root bus" interfaces at an alarming rate (I'm
responsible for most of them, so I'm not blaming you :)).  Could we
get away without adding this one by just adding a bus number resource
to the "resources" list?  For example, then an arch could do:

    LIST_HEAD(resources);
    pci_add_resource(resources, bus_window);
    pci_add_resource(resources, mem_window);
    pci_add_resource(resources, io_window);
    pci_scan_root_bus(..., resources);

If pci_scan_root_bus() didn't find a bus number resource in the list,
it could fall back to a default max_bus of 255.

> =A0{
> =A0 =A0 =A0 =A0struct pci_bus *b;
>
> @@ -1675,10 +1676,26 @@ struct pci_bus * __devinit pci_scan_root_bus(=
struct device *parent, int bus,
> =A0 =A0 =A0 =A0if (!b)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, bus_max);
> =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus(b);
> =A0 =A0 =A0 =A0pci_bus_add_devices(b);
> =A0 =A0 =A0 =A0return b;
> =A0}
> +EXPORT_SYMBOL(pci_scan_root_bus_max);
> +
> +struct pci_bus * __devinit pci_scan_root_bus(struct device *parent, =
int bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct list_head *resources)
> +{
> + =A0 =A0 =A0 struct pci_bus *b;
> +
> + =A0 =A0 =A0 b =3D pci_scan_root_bus_max(parent, bus, 255, ops, sysd=
ata, resources);
> +
> + =A0 =A0 =A0 if (b)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subor=
dinate);
> +
> + =A0 =A0 =A0 return b;
> +}
> =A0EXPORT_SYMBOL(pci_scan_root_bus);
>
> =A0/* Deprecated; use pci_scan_root_bus() instead */
> @@ -1691,9 +1708,11 @@ struct pci_bus * __devinit pci_scan_bus_parent=
ed(struct device *parent,
> =A0 =A0 =A0 =A0pci_add_resource(&resources, &ioport_resource);
> =A0 =A0 =A0 =A0pci_add_resource(&resources, &iomem_resource);
> =A0 =A0 =A0 =A0b =3D pci_create_root_bus(parent, bus, ops, sysdata, &=
resources);
> - =A0 =A0 =A0 if (b)
> + =A0 =A0 =A0 if (b) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus(=
b);
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subor=
dinate);
> + =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_free_resource_list(&resources);
> =A0 =A0 =A0 =A0return b;
> =A0}
> @@ -1709,7 +1728,10 @@ struct pci_bus * __devinit pci_scan_bus(int bu=
s, struct pci_ops *ops,
> =A0 =A0 =A0 =A0pci_add_resource(&resources, &iomem_resource);
> =A0 =A0 =A0 =A0b =3D pci_create_root_bus(NULL, bus, ops, sysdata, &re=
sources);
> =A0 =A0 =A0 =A0if (b) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus(=
b);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subor=
dinate);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_bus_add_devices(b);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_free_resource_list(&resources);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index bd70f23..8056e6a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -68,6 +68,7 @@ void pci_remove_bus(struct pci_bus *pci_bus)
>
> =A0 =A0 =A0 =A0down_write(&pci_bus_sem);
> =A0 =A0 =A0 =A0list_del(&pci_bus->node);
> + =A0 =A0 =A0 pci_bus_release_busn_res(pci_bus);
> =A0 =A0 =A0 =A0up_write(&pci_bus_sem);
> =A0 =A0 =A0 =A0if (!pci_bus->is_added)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3da935c..d5b6786 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -668,6 +668,10 @@ struct pci_bus *pci_create_root_bus(struct devic=
e *parent, int bus,
> =A0void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busma=
x);
> =A0void pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
> =A0void pci_bus_release_busn_res(struct pci_bus *b);
> +struct pci_bus * __devinit pci_scan_root_bus_max(struct device *pare=
nt, int bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int busmax, struct pci_ops *ops,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *sysdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct list_head *resources);
> =A0struct pci_bus * __devinit pci_scan_root_bus(struct device *parent=
, int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct list_head *resources);
> --
> 1.7.7
>
