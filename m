From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/21] PCI: use busn_res to replace bus secondary/subordinate
Date: Thu, 17 May 2012 16:19:53 -0600
Message-ID: <CAErSpo6OZYXz-M=C9r154MY7kwC7LRR3ZnQe3pnmVJY2uoWeRw@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35658 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967208Ab2EQWUQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:20:16 -0400
Received: by lahd3 with SMTP id d3so1663979lah.19
        for <linux-arch@vger.kernel.org>; Thu, 17 May 2012 15:20:13 -0700 (PDT)
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, May 7, 2012 at 2:29 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> struct pci_bus will take busn_res instead. and those busn_res will be=
 in
> domain busn_res tree.
>
> This could be base of busn_res allocation patchset.
>
> The patches need to apply to pci-next and
> =A0 =A0 =A0 =A0for-pci-hotplug cleanup

Sigh.  You previously said we should do this order:

        for-pci-hostbridge-cleanup
        for-pci-busn-alloc
        for-pci-res-alloc
        for-pci-root-bus-hotplug
        for-pci-for-each-res-addon

I merged for-pci-hostbridge-cleanup already.  I was about to start
merging for-pci-busn-alloc.

But now you added for-pci-hotplug-cleanup and made for-pci-busn-alloc
depend on it.  I have some comments on for-pci-hotplug-cleanup, so I'm
not ready to merge it quite yet.  Can you please just go back to the
original order and put the new hotplug cleanup stuff at the *end*?

> could be found at:
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/=
linux-yinghai.git for-pci-busn_res
>
> Bjorn Helgaas (1):
> =A0PCI: print conflicting entry in busn_res inserting
>
> Yinghai Lu (20):
> =A0PCI: add busn_res into struct pci_bus.
> =A0PCI: replace secondary/subordinate with busn_res
> =A0PCI: Remove secondary/subordinate in struct ci_bus
> =A0PCI: Add busn_res for pci domain.
> =A0resource: adjust_resource handle resource without parent
> =A0PCI: Add busn_res operation functions
> =A0PCI: release busn_res when removing bus
> =A0PCI: Insert busn_res in pci_create_root_bus()
> =A0PCI: checking busn_res in pci_scan_root_bus()
> =A0PCI: Add default busn_resource
> =A0PCI: Add default busn_res for pci_scan_bus()
> =A0x86/PCI: add busn_res into resources list for ACPI path
> =A0x86/PCI: put busn resource in pci_root_info for native host bridge
> =A0 =A0drivers
> =A0ia64/PCI: register busn_res for root buses
> =A0sparc/PCI: register busn_res for root buses
> =A0powerpc/PCI: register busn_res for root buses
> =A0parisc/PCI: register busn_res for root buses
> =A0tile/PCI: Use pci_scan_root_bus instead pci_scan_bus
> =A0PCI: Register busn_res for iov bus
> =A0PCI: insert busn_res for child bus
>
> =A0arch/alpha/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
> =A0arch/arm/kernel/bios32.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0arch/ia64/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
> =A0arch/microblaze/pci/pci-common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-
> =A0arch/mips/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0 =A0 =A0 | =A0 17 ++-
> =A0arch/powerpc/kernel/pci_64.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0arch/powerpc/kernel/pci_of_scan.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/powernv/pci-ioda.c =A0| =A0 =A08 +-
> =A0arch/powerpc/platforms/pseries/pci_dlpar.c | =A0 =A02 +-
> =A0arch/sh/drivers/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A02 +-
> =A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A08 +-
> =A0arch/sparc/kernel/pci_impl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 +
> =A0arch/tile/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A09 +-
> =A0arch/x86/pci/acpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A09 +-
> =A0arch/x86/pci/amd_bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +-
> =A0arch/x86/pci/bus_numa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 22 +++-
> =A0arch/x86/pci/bus_numa.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A03 +-
> =A0arch/xtensa/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0drivers/iommu/intel-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
2 +-
> =A0drivers/net/ethernet/broadcom/tg3.c =A0 =A0 =A0 =A0| =A0 =A04 +-
> =A0drivers/parisc/dino.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 16 ++-
> =A0drivers/parisc/iosapic.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0drivers/parisc/lba_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 26 ++--
> =A0drivers/pci/hotplug-pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A04 +-
> =A0drivers/pci/hotplug/acpiphp_glue.c =A0 =A0 =A0 =A0 | =A0 =A08 +-
> =A0drivers/pci/hotplug/shpchp_sysfs.c =A0 =A0 =A0 =A0 | =A0 =A06 +-
> =A0drivers/pci/iov.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A04 +-
> =A0drivers/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A02 +-
> =A0drivers/pci/probe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0191 +++++++++++++++++++++++-----
> =A0drivers/pci/remove.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A01 +
> =A0drivers/pci/setup-bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 24 ++--
> =A0drivers/pcmcia/cardbus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0drivers/pcmcia/yenta_socket.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 26 =
++--
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A08 +-
> =A0kernel/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 13 +-
> =A037 files changed, 313 insertions(+), 135 deletions(-)
>
> --
> 1.7.7
>
