From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v11 05/30] PCI: Add busn_res operation functions
Date: Mon, 30 Apr 2012 17:29:01 -0600
Message-ID: <CAErSpo5AnsmfQs4oa3P7AQyPTJ+YqCVVh5p2L=bmDY=A+BO9PQ@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org> <1332135781-13695-6-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1332135781-13695-6-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> Will use them insert/update busn res in pci_bus struct.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 50 +++++++++++++++++++++++++++++++++++++=
+++++++++++++
> =A0include/linux/pci.h | =A0 =A03 +++
> =A02 files changed, 53 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d30948d..9235b16 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1679,6 +1679,56 @@ err_out:
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max=
)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 struct resource *parent_res;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 res->start =3D bus;
> + =A0 =A0 =A0 res->end =3D bus_max;
> + =A0 =A0 =A0 res->flags =3D IORESOURCE_BUS;
> +
> + =A0 =A0 =A0 /* no parent for root bus' busn_res */
> + =A0 =A0 =A0 if (!pci_is_root_bus(b)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D &b->parent->busn_res;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D insert_resource(parent_res, res=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR %s inser=
ted under %pR\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res, ret ? "can not be"=
 : "is", parent_res);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR for root=
 bus\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res);
> +}
> +
> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
> +{
> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
> + =A0 =A0 =A0 struct resource old_res =3D *res;
> +
> + =A0 =A0 =A0 res->end =3D bus_max;

I've mentioned before that I'm not comfortable with updating the
struct resource after it's been inserted into the tree.  If you want
to do an in-place update, I think you need to add a new interface in
kernel/resource.c so it can make sure the resource tree remains
consistent.
