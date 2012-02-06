From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 04/24] PCI: Add busn_res operation functions
Date: Mon, 6 Feb 2012 10:59:12 -0800
Message-ID: <CAErSpo6=t1XtdUMBAn7Ag5XNLS3wKueybfrsUzmht6GL9XSGLQ@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org> <1328425088-6562-5-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1328425088-6562-5-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> will use them insert/update busn res in pci_bus
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 42 +++++++++++++++++++++++++++++++++++++=
+++++
> =A0include/linux/pci.h | =A0 =A03 +++
> =A02 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a114173..8d4de5e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1622,6 +1622,48 @@ err_out:
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max=
)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 struct resource *parent_res =3D &iobusn_resource;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 res->start =3D busn(pci_domain_nr(b), bus);
> + =A0 =A0 =A0 res->end =3D busn(pci_domain_nr(b), bus_max);
> + =A0 =A0 =A0 res->flags =3D IORESOURCE_BUS;
> +
> + =A0 =A0 =A0 if (!pci_is_root_bus(b))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D &b->parent->busn_res;
> +
> + =A0 =A0 =A0 ret =3D insert_resource(parent_res, res);
> +
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR %s inser=
ted under %pR\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res, ret ? "can not be"=
 : "is", parent_res);
> +}
> +
> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 struct resource old_res =3D *res;
> +
> + =A0 =A0 =A0 res->end =3D busn_update_bus_nr(res->end, bus_max);

I think this design is a mistake.  Here's what you're doing:

  - initialize struct resource (keys are "start" and "end")
  - insert into tree (placed in tree by kernel/resource.c based on
"start" and "end")
  - update "end"

You "know" in this case that the update is safe because the caller has
validated "bus_max."  But that still breaks the kernel/resource.c
encapsulation.  If we change the kernel/resource.c implementation,
this code might break.

I think it would be better to remove the bus resource from the tree,
change its "end," then re-insert it.

> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR end upda=
ted to %pR\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &old_res, res);
> +}
> +
> +void pci_bus_release_busn_res(struct pci_bus *b)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D release_resource(res);
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR %s relea=
sed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res, ret ? "can not be"=
 : "is");
> +}
> +
> =A0struct pci_bus * __devinit pci_scan_root_bus(struct device *parent=
, int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_ops *ops, void *sysdata, st=
ruct list_head *resources)
> =A0{
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 94ad468..3da935c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -665,6 +665,9 @@ struct pci_bus *pci_scan_bus(int bus, struct pci_=
ops *ops, void *sysdata);
> =A0struct pci_bus *pci_create_root_bus(struct device *parent, int bus=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct pci_ops *ops, void *sysdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct list_head *resources);
> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax)=
;
> +void pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
> +void pci_bus_release_busn_res(struct pci_bus *b);
> =A0struct pci_bus * __devinit pci_scan_root_bus(struct device *parent=
, int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct list_head *resources);
> --
> 1.7.7
>
