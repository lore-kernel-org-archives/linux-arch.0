From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 02/13] PCI: Add busn_res operation functions
Date: Mon, 30 Jan 2012 07:28:56 -0800
Message-ID: <CAErSpo7ji9R3azc7Xiu8K-=QXm26w=0oSWmcBh=j8dy=MttEvg@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org> <1327718971-9598-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1327718971-9598-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> will use them insert/update busn res in pci_bus
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 44 +++++++++++++++++++++++++++++++++++++=
+++++++
> =A0include/linux/pci.h | =A0 =A03 +++
> =A02 files changed, 47 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a114173..71261da 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1622,6 +1622,50 @@ err_out:
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
> + =A0 =A0 =A0 res->start =3D (pci_domain_nr(b) << 8) | bus;
> + =A0 =A0 =A0 res->end =3D (pci_domain_nr(b) << 8) | bus_max;
> + =A0 =A0 =A0 res->flags =3D IORESOURCE_BUS;
> +
> + =A0 =A0 =A0 if (!pci_is_root_bus(b))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D &b->parent->busn_res;
> +
> + =A0 =A0 =A0 ret =3D insert_resource(parent_res, res);
> +
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0"busn_res: %06llx-%06llx %s inserted under %06llx-%0=
6llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res=
->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res=
->end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret ? "can not be" :=
 "is",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)par=
ent_res->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)par=
ent_res->end);

Please update the %pR implementation so you can use it instead of
having to fiddle around with start/end separately and casts.

> +}
> +
> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 unsigned long long old_end =3D res->end;
> +
> + =A0 =A0 =A0 res->end &=3D ~0xff;
> + =A0 =A0 =A0 res->end |=3D bus_max;

This updates a resource in place, without removing it from the
resource tree and re-inserting it.  Doesn't this make it possible to
corrupt the resource tree?  For example, let's say you have this tree:

    00-3f : host bridge A
      00-1f : P2P bridge B
    40-7f : host bridge C

Now you use pci_bus_update_busn_res_end() to update the resource for
P2P bridge B,  setting its end to 5f.  I think the resource tree is
now corrupted.

> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"busn_res: %06llx-%06llx end updated=
 to %06llx-%06llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res=
->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res=
->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)res=
->end);
> +}
> +
> +void pci_bus_release_busn_res(struct pci_bus *b)
> +{
> + =A0 =A0 =A0 release_resource(&b->busn_res);
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
