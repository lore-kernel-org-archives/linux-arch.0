From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 08/18] PCI, powerpc: Register busn_res for root buses
Date: Mon, 27 Feb 2012 22:36:48 -0700
Message-ID: <CAErSpo4bw-V=SM+h5iP4nfv3HaAnHjwvNwu+4Oz8iyQcY_3gOQ@mail.gmail.com>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org> <1330395009-29260-9-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44603 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2B1FhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2012 00:37:10 -0500
Received: by wgbdt10 with SMTP id dt10so1896122wgb.1
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2012 21:37:08 -0800 (PST)
In-Reply-To: <1330395009-29260-9-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Mon, Feb 27, 2012 at 7:09 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =A0arch/powerpc/kernel/pci-common.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/p=
ci-common.c
> index 910b9de..ae5ae5f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1660,6 +1660,8 @@ void __devinit pcibios_scan_phb(struct pci_cont=
roller *hose)
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->l=
ast_busno);
> +
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1670,8 +1672,11 @@ void __devinit pcibios_scan_phb(struct pci_con=
troller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =
=3D pci_scan_child_bus(bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->s=
ubordinate);
> + =A0 =A0 =A0 }

There's a lot of powerpc code that does this:

    bus_range =3D of_get_property(pcictrl, "bus-range", &len);
    hose->first_busno =3D bus_range[0];
    hose->last_busno =3D bus_range[1];

That *looks* like it is discovering the bus number aperture.  Is it?
If it is, why are we using the largest bus number found by
pci_scan_child_bus() rather than "last_busno"?

Bjorn
