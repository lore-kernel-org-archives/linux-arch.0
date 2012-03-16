From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 28/36] PCI: Add pci_bus_extend/shrink_top()
Date: Fri, 16 Mar 2012 13:36:23 -0600
Message-ID: <CAErSpo7JS6N3XzVm=_A-oFF_VpmuQaAG_KagxAOEzpEPnhRP_g@mail.gmail.com>
References: <1330570837-26638-1-git-send-email-yinghai@kernel.org> <1330570837-26638-29-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63518 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab2CPTgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2012 15:36:45 -0400
Received: by lbbgm6 with SMTP id gm6so2265095lbb.19
        for <linux-arch@vger.kernel.org>; Fri, 16 Mar 2012 12:36:43 -0700 (PDT)
In-Reply-To: <1330570837-26638-29-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 29, 2012 at 8:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> extend or shrink bus and parent buses top (subordinate)
>
> extended range is verified safe range, and stop at recorded parent_re=
s.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 36 ++++++++++++++++++++++++++++++++++++
> =A01 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 1c07aba..96259f8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -655,6 +655,42 @@ static void pci_fixup_parent_subordinate_busnr(s=
truct pci_bus *child, int max)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void __devinit pci_bus_update_top(struct pci_bus *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 struct resource *res;
> +
> + =A0 =A0 =A0 if (!size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 while (parent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D &parent->busn_res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res =3D=3D parent_res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end +=3D size;

I've objected to this before on the grounds that it's not safe to
update res->end because res is already linked into the resource tree,
but I just noticed another problem.

Tree updates are protected by resource_lock, but we don't hold that
here.  I'm sure you "know" that this update can't race with any other
conflicting resource operations, but its safety certainly is not
obvious from the patch.

I think a better implementation would be to add something like
"resource_extend()" that could live in kernel/resource.c so it could
do the appropriate locking and checking.  Such an interface could also
be independent of the resource type, which may be useful when doing
mem/io resource reassignment.

This patch is already in Jesse's linux-next branch (commit
c901d4c0407), so I'm leaving it up to you and Jesse to figure out
what, if anything, to do about this.

Bjorn

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent->subordinate +=3D size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(parent->self, PCI=
_SUBORDINATE_BUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0parent->subordinate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &parent->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_r=
es: %s %02lx to %pR\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (size >=
 0) ? "extended" : "shrunk",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abs(siz=
e), res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D parent->parent;
> + =A0 =A0 =A0 }
> +}
> +
> +static void __devinit pci_bus_extend_top(struct pci_bus *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 pci_bus_update_top(parent, size, parent_res);
> +}
> +
> +static void __devinit pci_bus_shrink_top(struct pci_bus *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long size, struct resource *parent_r=
es)
> +{
> + =A0 =A0 =A0 pci_bus_update_top(parent, -size, parent_res);
> +}
> +
> =A0/*
> =A0* If it's a bridge, configure it and scan the bus behind it.
> =A0* For CardBus bridges, we don't scan behind as the devices will
> --
> 1.7.7
>
