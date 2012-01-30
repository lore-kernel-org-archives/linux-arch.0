From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 08/13] PCI: Add pci_bus_extend/shrink_top()
Date: Mon, 30 Jan 2012 07:50:17 -0800
Message-ID: <CAErSpo6dihCWme3bgVV0AjHXnKd78BskLVj2LZqHocoAp83h+Q@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org> <1327718971-9598-9-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46185 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2A3Pui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 10:50:38 -0500
Received: by wics10 with SMTP id s10so3549676wic.19
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2012 07:50:37 -0800 (PST)
In-Reply-To: <1327718971-9598-9-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> extend or shrink bus and parent buses top (subordinate)
>
> extended range is verified safe range, and stop at recorded parent_re=
s.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 50 +++++++++++++++++++++++++++++++++++++=
+++++++++++++
> =A01 files changed, 50 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 55404c3..3e62f45 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -624,6 +624,56 @@ static void pci_fixup_parent_subordinate_busnr(s=
truct pci_bus *child, int max)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void __devinit pci_bus_extend_top(struct pci_bus *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t size, struct resourc=
e *parent_res)
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent->subordinate +=3D size;

This makes me nervous for the same reason as
pci_bus_update_busn_res_end() -- we're changing res->end for resources
already in a tree.  How do we know the tree remains consistent?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(parent->self, PCI=
_SUBORDINATE_BUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0parent->subordinate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &parent->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_r=
es: extended %02llx to %06llx-%06llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)res->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)res->end);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D parent->parent;
> + =A0 =A0 =A0 }
> +}
> +
> +static void __devinit pci_bus_shrink_top(struct pci_bus *parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t size, struct resourc=
e *parent_res)
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end -=3D size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent->subordinate -=3D size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(parent->self, PCI=
_SUBORDINATE_BUS,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0parent->subordinate);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &parent->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_r=
es: shrunk %02llx to %06llx-%06llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)res->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)res->end);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D parent->parent;
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* If it's a bridge, configure it and scan the bus behind it.
> =A0* For CardBus bridges, we don't scan behind as the devices will
> --
> 1.7.7
>
