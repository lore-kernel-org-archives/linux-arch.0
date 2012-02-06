From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/24] PCI: Add iobusn_resource
Date: Mon, 6 Feb 2012 10:48:56 -0800
Message-ID: <CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org> <1328425088-6562-2-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1328425088-6562-2-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> also add busn_res into struct pci_bus.
>
> will use them to have bus number resource tree.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> =A0include/linux/ioport.h | =A0 =A01 +
> =A0include/linux/pci.h =A0 =A0| =A0 =A01 +
> =A0kernel/resource.c =A0 =A0 =A0| =A0 =A08 ++++++++
> =A03 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e885ba2..6fe9e19 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -136,6 +136,7 @@ struct resource {
> =A0/* PC/ISA/whatever - the normal PC address spaces: IO and memory *=
/
> =A0extern struct resource ioport_resource;
> =A0extern struct resource iomem_resource;
> +extern struct resource iobusn_resource;
>
> =A0extern struct resource *request_resource_conflict(struct resource =
*root, struct resource *new);
> =A0extern int request_resource(struct resource *root, struct resource=
 *new);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f8caaab..94ad468 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -419,6 +419,7 @@ struct pci_bus {
> =A0 =A0 =A0 =A0struct list_head slots; =A0 =A0 =A0 =A0 /* list of slo=
ts on this bus */
> =A0 =A0 =A0 =A0struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* address space r=
outed to this bus */
> + =A0 =A0 =A0 struct resource busn_res; =A0 =A0 =A0 /* track register=
ed bus num range */
>
> =A0 =A0 =A0 =A0struct pci_ops =A0*ops; =A0 =A0 =A0 =A0 =A0 /* configu=
ration access functions */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*sysdata; =A0 =A0 =A0 /* h=
ook for sys-specific extension */
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 7640b3a..53b42f0 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -38,6 +38,14 @@ struct resource iomem_resource =3D {
> =A0};
> =A0EXPORT_SYMBOL(iomem_resource);
>
> +struct resource iobusn_resource =3D {
> + =A0 =A0 =A0 .name =A0 =3D "PCI busn",
> + =A0 =A0 =A0 .start =A0=3D 0,
> + =A0 =A0 =A0 .end =A0 =A0=3D 0xffffff,
> + =A0 =A0 =A0 .flags =A0=3D IORESOURCE_BUS,
> +};

I'm not sure this should be global.  iomem_resource and
ioport_resource *are* really global, because they refer to processor
address space that is the same for everybody.  But PCI bus numbers are
specific to PCI.  Some machines don't have PCI at all, and there are
different bus architectures to which this doesn't apply.

The 0-0xffffff range is misleading because it includes both the domain
and the bus number, and it's meaningless to allocate ranges that cross
domain boundaries.  For example, [bus 0x0000f0-0x000120] includes bus
numbers from domain 0000 and domain 0001, which doesn't make any sense
because a bus can only be in one domain.

I think it would make more sense to keep this bus number resource in a
per-host bridge structure.  Then we wouldn't need to include the
domain number at all because the host bridge determines the domain.

> +EXPORT_SYMBOL(iobusn_resource);
> +
> =A0/* constraints to be met while allocating resources */
> =A0struct resource_constraint {
> =A0 =A0 =A0 =A0resource_size_t min, max, align;
> --
> 1.7.7
>
