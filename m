From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 02/15] PCI: Add iobusn_resource
Date: Fri, 3 Feb 2012 08:36:02 -0800
Message-ID: <CAErSpo44bef-Vj4LPB0QJ8HRjWxqRFK_=kpMq8hYEe=4t58zGQ@mail.gmail.com>
References: <1328136242-17725-1-git-send-email-yinghai@kernel.org> <1328136242-17725-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33443 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab2BCQgX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2012 11:36:23 -0500
Received: by wics10 with SMTP id s10so2747695wic.19
        for <linux-arch@vger.kernel.org>; Fri, 03 Feb 2012 08:36:22 -0800 (PST)
In-Reply-To: <1328136242-17725-3-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 1, 2012 at 2:43 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> also add busn_res into struct pci_bus.
>
> will use them to have bus number resource tree.

Will you make this tree visible in /proc?  Seems like that would be
useful for debugging and for symmetry with /proc/iomem and
/proc/ioports.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
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

Is this different from bus.secondary and bus.subordinate?  Do we need
both busn_res and secondary/subordinate?  If we need both, in what
circumstance with they contain different information?

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
> +EXPORT_SYMBOL(iobusn_resource);
> +
> =A0/* constraints to be met while allocating resources */
> =A0struct resource_constraint {
> =A0 =A0 =A0 =A0resource_size_t min, max, align;
> --
> 1.7.7
>
