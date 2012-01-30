From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 12/13] PCI: kill pci_fixup_parent_subordinate_busnr()
Date: Mon, 30 Jan 2012 08:09:19 -0800
Message-ID: <CAErSpo6JuJ-2u4KptUyx0N623f5X29CiqkzWEFTKnSFKQ6sP_w@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org> <1327718971-9598-13-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64735 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab2A3QJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 11:09:40 -0500
Received: by wgbed3 with SMTP id ed3so4814212wgb.1
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2012 08:09:39 -0800 (PST)
In-Reply-To: <1327718971-9598-13-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Now we can safely extend parent top and shrink them according iobusn_=
resource tree.
>
> Don't need that any more.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0 45 +++++++++----------------------------=
--------
> =A01 files changed, 9 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 23c2f0d..54615a9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -608,22 +608,6 @@ struct pci_bus *__ref pci_add_new_bus(struct pci=
_bus *parent, struct pci_dev *de
> =A0 =A0 =A0 =A0return child;
> =A0}
>
> -static void pci_fixup_parent_subordinate_busnr(struct pci_bus *child=
, int max)
> -{
> - =A0 =A0 =A0 struct pci_bus *parent =3D child->parent;
> -
> - =A0 =A0 =A0 /* Attempts to fix that up are really dangerous unless
> - =A0 =A0 =A0 =A0 =A0we're going to re-assign all bus numbers. */
> - =A0 =A0 =A0 if (!pcibios_assign_all_busses())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 while (parent->parent && parent->subordinate < max) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent->subordinate =3D max;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_write_config_byte(parent->self, PCI=
_SUBORDINATE_BUS, max);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D parent->parent;
> - =A0 =A0 =A0 }
> -}
> -
> =A0static void __devinit pci_bus_extend_top(struct pci_bus *parent,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t size, struct resource=
 *parent_res)
> =A0{
> @@ -925,6 +909,13 @@ int __devinit pci_scan_bridge(struct pci_bus *bu=
s, struct pci_dev *dev, int max,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear errors */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_write_config_word(dev, PCI_STATUS,=
 0xffff);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For CardBus bridges, we leave 4 bu=
s numbers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* as cards with a PCI-to-PCI bridge =
can be
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* inserted later.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* other just allocate 8 bus to avoid=
 we fall into
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0small hole in the middle.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/

This comment addition is in the wrong patch; it should go in the one
that added the code.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D pci_bridge_probe_busn_res(bus,=
 dev, &busn_res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_car=
dbus ? (CARDBUS_RESERVE_BUSNR + 1) : 8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&paren=
t_res);
> @@ -963,29 +954,11 @@ int __devinit pci_scan_bridge(struct pci_bus *b=
us, struct pci_dev *dev, int max,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_cardbus) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0child->bridge_ctl =3D =
bctl;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Adjust subordinate=
 busnr in parent buses.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We do this before =
scanning for children because
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* some devices may n=
ot be detected if the bios
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* was lazy.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_fixup_parent_subord=
inate_busnr(child, max);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Now we can scan all=
 subordinate buses... */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max =3D pci_scan_child=
_bus(child);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* now fix it up agai=
n since we have found
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the real value of =
max.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_fixup_parent_subord=
inate_busnr(child, max);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For CardBus bridge=
s, we leave 4 bus numbers
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* as cards with a PC=
I-to-PCI bridge can be
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* inserted later.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_fixup_parent_subord=
inate_busnr(child, max);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Set the subordinate bus number to i=
ts real value.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> --
> 1.7.7
>
