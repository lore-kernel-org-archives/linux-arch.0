From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 1/2] resource: align functions now return start of
	resource
Date: Fri, 1 Jan 2010 14:12:09 -0800
Message-ID: <86802c441001011412u1543c1afk6337cd6d3ea0f257@mail.gmail.com>
References: <20100101163811.GA8124@comet.dominikbrodowski.net>
	 <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:37891 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab0AAWMK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jan 2010 17:12:10 -0500
In-Reply-To: <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

On Fri, Jan 1, 2010 at 8:40 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> As suggested by Linus, align functions should return the start
> of a resource, not void. An update of "res->start" is no longer
> necessary.
>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Yinghai Lu <yhlu.kernel@gmail.com>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
> =A0arch/alpha/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04=
 ++--
> =A0arch/arm/kernel/bios32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08=
 +++++---
> =A0arch/cris/arch-v32/drivers/pci/bios.c =A0 | =A0 14 ++++++--------
> =A0arch/frv/mb93090-mb00/pci-frv.c =A0 =A0 =A0 =A0 | =A0 14 ++++++---=
-----
> =A0arch/ia64/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A03 ++-
> =A0arch/mips/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A04 ++--
> =A0arch/mips/pmc-sierra/yosemite/ht.c =A0 =A0 =A0| =A0 10 +++++-----
> =A0arch/mn10300/unit-asb2305/pci-asb2305.c | =A0 16 +++++++---------
> =A0arch/parisc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 10 +=
++++-----
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0| =A0 13 ++++++---=
----
> =A0arch/sh/drivers/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +=
++---
> =A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05=
 +++--
> =A0arch/sparc/kernel/pcic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 +++--
> =A0arch/x86/pci/i386.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
12 +++++-------
> =A0arch/xtensa/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +=
++++------
> =A0drivers/pci/bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A06 ++++--
> =A0drivers/pcmcia/rsrc_mgr.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +++=
+++------
> =A0drivers/pcmcia/rsrc_nonstatic.c =A0 =A0 =A0 =A0 | =A0 16 +++++++++=
-------
> =A0include/linux/ioport.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
6 ++++--
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A08 +++++---
> =A0kernel/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 14 +++++++++-----
> =A021 files changed, 102 insertions(+), 95 deletions(-)
>
> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index a91ba28..5cf111e 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -126,7 +126,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, p=
cibios_fixup_final);
> =A0#define MB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1024*KB)
> =A0#define GB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1024*MB)
>
> -void
> +resource_size_t
> =A0pcibios_align_resource(void *data, struct resource *res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t size, res=
ource_size_t align)
> =A0{
> @@ -184,7 +184,7 @@ pcibios_align_resource(void *data, struct resourc=
e *res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 res->start =3D start;
> + =A0 =A0 =A0 return start;
> =A0}
> =A0#undef KB
> =A0#undef MB
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 8096819..a7c85f8 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -616,15 +616,17 @@ char * __init pcibios_setup(char *str)
> =A0* but we want to try to avoid allocating at 0x2900-0x2bff
> =A0* which might be mirrored at 0x0100-0x03ff..
> =A0*/
> -void pcibios_align_resource(void *data, struct resource *res,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t=
 size, resource_size_t align)
> +resource_size_t pcibios_align_resource(void *data, struct resource *=
res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resourc=
e_size_t size, resource_size_t align)
> =A0{
> =A0 =A0 =A0 =A0resource_size_t start =3D res->start;
>
> =A0 =A0 =A0 =A0if (res->flags & IORESOURCE_IO && start & 0x300)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start =3D (start + 0x3ff) & ~0x3ff;
>
> - =A0 =A0 =A0 res->start =3D (start + align - 1) & ~(align - 1);
> + =A0 =A0 =A0 start =3D (start + align - 1) & ~(align - 1);
> +
> + =A0 =A0 =A0 return start;
> =A0}
>
> =A0/**
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v=
32/drivers/pci/bios.c
> index 77ee319..5811e2f 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -41,18 +41,16 @@ int pci_mmap_page_range(struct pci_dev *dev, stru=
ct vm_area_struct *vma,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -void
> +resource_size_t
> =A0pcibios_align_resource(void *data, struct resource *res,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t size, res=
ource_size_t align)
> =A0{
> - =A0 =A0 =A0 if (res->flags & IORESOURCE_IO) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size_t start =3D res->start;
> + =A0 =A0 =A0 resource_size_t start =3D res->start;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (start & 0x300) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D (start + 0x3f=
f) & ~0x3ff;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start =3D start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((res->flags & IORESOURCE_IO) && (start & 0x300))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D (start + 0x3ff) & ~0x3ff;
> +
> + =A0 =A0 =A0 return start

missed ; here?

YH
