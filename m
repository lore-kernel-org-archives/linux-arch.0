From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 02/39] x86, PCI: have own version for pcibios_bus_to_resource
Date: Wed, 29 Feb 2012 16:20:02 -0700
Message-ID: <CAErSpo62VuJw+3caNUhmg5moh3h4cn5z4kCsqTWZW-XqSzpk4Q@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org> <1330556858-11768-3-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64870 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966006Ab2B2XUY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Feb 2012 18:20:24 -0500
Received: by lahj13 with SMTP id j13so4149909lah.19
        for <linux-arch@vger.kernel.org>; Wed, 29 Feb 2012 15:20:22 -0800 (PST)
In-Reply-To: <1330556858-11768-3-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> x86 does not need to offset the address. So we can skip that costing =
offset
> searching.

I tried to start a discussion about this patch (and others), but I
don't think you responded:
http://marc.info/?l=3Dlinux-pci&m=3D133036414506921&w=3D2

It's discouraging to spend time reviewing all your patches and trying
to give useful feedback, when all I get in response is a deluge of
fresh patches.

Bjorn

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0arch/x86/pci/i386.c =A0 =A0 =A0 | =A0 14 ++++++++++++++
> =A0drivers/pci/host-bridge.c | =A0 =A09 +++++----
> =A02 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index 33e6a0b..eeed28e 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -335,6 +335,20 @@ void __init pcibios_resource_survey(void)
> =A0*/
> =A0fs_initcall(pcibios_assign_resources);
>
> +void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_reg=
ion *region,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resou=
rce *res)
> +{
> + =A0 =A0 =A0 region->start =3D res->start;
> + =A0 =A0 =A0 region->end =3D res->end;
> +}
> +
> +void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *r=
es,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_b=
us_region *region)
> +{
> + =A0 =A0 =A0 res->start =3D region->start;
> + =A0 =A0 =A0 res->end =3D region->end;
> +}
> +
> =A0static const struct vm_operations_struct pci_mmap_ops =3D {
> =A0 =A0 =A0 =A0.access =3D generic_access_phys,
> =A0};
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 5ca4220..dfaff3f 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -38,8 +38,9 @@ static bool resource_contains(struct resource *res1=
, struct resource *res2)
> =A0 =A0 =A0 =A0return res1->start <=3D res2->start && res1->end >=3D =
res2->end;
> =A0}
>
> -void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_reg=
ion *region,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct resou=
rce *res)
> +void __weak pcibios_resource_to_bus(struct pci_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct pci_bus_region *region,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct resource *res)
> =A0{
> =A0 =A0 =A0 =A0struct pci_host_bridge *bridge =3D pci_host_bridge(dev=
);
> =A0 =A0 =A0 =A0struct pci_host_bridge_window *window;
> @@ -66,8 +67,8 @@ static bool region_contains(struct pci_bus_region *=
region1,
> =A0 =A0 =A0 =A0return region1->start <=3D region2->start && region1->=
end >=3D region2->end;
> =A0}
>
> -void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *r=
es,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_b=
us_region *region)
> +void __weak pcibios_bus_to_resource(struct pci_dev *dev, struct reso=
urce *res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct pci_bus_region *region)
> =A0{
> =A0 =A0 =A0 =A0struct pci_host_bridge *bridge =3D pci_host_bridge(dev=
);
> =A0 =A0 =A0 =A0struct pci_host_bridge_window *window;
> --
> 1.7.7
>
