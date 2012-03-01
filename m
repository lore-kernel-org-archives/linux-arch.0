From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 00/39] PCI: pci_host_bridge related cleanup and busn_alloc
Date: Thu, 1 Mar 2012 11:51:19 -0700
Message-ID: <CAL-B5D0Phxhx-2ipYwoKfZCTvCfuh6bX-iqQkQS0cLmRqQHGbg@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 29, 2012 at 4:06 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> The first 14 patches are hostbridge clean up.
> will add struct device dev into host_bridge struct.
> also will add release support to make sure allocated resource get
> freed during root bus removal including hostbridge and pci_sysdata.
>
> others 25 patches are busn_alloc related.
> Set up iobusn_resource tree, and register bus number range to it.
> Later when need to find bus range, will try to allocate from the tree
> Need to test on arches other than x86. esp for ia64 and powerpc that =
support
> =A0more than on peer root buses.

Why did you collapse these two series into one at this point?

Last I was keeping up with - there was a -v9 00/23 series related to
bus_num and a -v2 00/11 series for pci_host_bridge related cleanup.

As a distro maintainer I need to try and keep up with what is occurring
here and actions like this - coalescing multiple series - unnecessarily
complicates things.  It also masks the fact that the bus_num series is
now on -v10 within a very short time frame (which implies a lot).

Myron
>
> The patches need to apply to pci/for-linus and pci/linux-next
> because one patch that is needed only is only in pci/for-linus
>
> could get from
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/=
linux-yinghai.git for-pci-next
>
> please put them into pci/linux-next branch for more testing.
>
> Thanks
>
> Yinghai
>
> Yinghai Lu (39):
> =A0PCI: Separate host_bridge code out from probe.c
> =A0x86, PCI: have own version for pcibios_bus_to_resource
> =A0x86, PCI: Fix memleak with get_current_resources
> =A0PCI: rename pci_host_bridge() to find_pci_root_bridge()
> =A0PCI: add generic device into pci_host_bridge struct
> =A0PCI: add host bridge release support
> =A0x86, PCI: break down get_current_resource()
> =A0x86, PCI: add host bridge resource release for using _CRS
> =A0x86, PCI: embed name acpi version pci_root_info struct
> =A0x86, PCI: embed pci_sysdata into pci_root_info on acpi path
> =A0x86, PCI: Allocating pci_root_info for not using _CRS path
> =A0x86, PCI: Merge root info printing for nocrs path
> =A0x86, PCI: add print all root info for nocrs path
> =A0x86, PCI: allocate temp range array in amd_bus pci_root_info probi=
ng
> =A0x86, PCI: Merge pcibios_scan_root and pci_scan_bus_on_node
> =A0PCI: skip busn resource at first.
> =A0x86, PCI: put busn resource in pci_root_info for acpi path
> =A0PCI: default busn_resource
> =A0x86, PCI: put busn resource in pci_root_info for no_crs path
> =A0PCI: Add busn_res into struct pci_bus.
> =A0PCI: Add busn_res operation functions
> =A0PCI: release busn when removing bus
> =A0PCI: insert busn_res in pci_create_root_bus
> =A0PCI: checking busn_res in pci_scan_root_bus
> =A0PCI: add default res for pci_scan_bus
> =A0PCI, ia64: Register busn_res for root buses
> =A0PCI, sparc: Register busn_res for root buses
> =A0PCI, powerpc: Register busn_res for root buses
> =A0PCI, parisc: Register busn_res for root buses
> =A0PCI: Add pci_bus_extend/shrink_top()
> =A0PCI: Probe safe range that we can use for unassigned bridge.
> =A0PCI: Strict checking of valid range for bridge
> =A0PCI: Allocate bus range instead of use max blindly
> =A0PCI: kill pci_fixup_parent_subordinate_busnr()
> =A0PCI: Seperate child bus scanning to two passes overall
> =A0pcmcia: remove workaround for fixing pci parent bus subordinate
> =A0PCI: Double checking setting for bus register and bus struct.
> =A0PCI, pciehp: Remove not needed bus number range checking
> =A0x86, PCI: kill busn in acpi pci_root_info
>
> =A0arch/ia64/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +
> =A0arch/powerpc/include/asm/pci-bridge.h | =A0 =A01 +
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0| =A0 10 +-
> =A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +
> =A0arch/sparc/kernel/pci_impl.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/x86/pci/acpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0121 +=
+++---
> =A0arch/x86/pci/amd_bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 88 ++-=
---
> =A0arch/x86/pci/broadcom_bus.c =A0 =A0 =A0 =A0 =A0 | =A0 17 +-
> =A0arch/x86/pci/bus_numa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0100 +++++=
--
> =A0arch/x86/pci/bus_numa.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 23 +-
> =A0arch/x86/pci/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 27 +--
> =A0arch/x86/pci/i386.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 +
> =A0drivers/parisc/dino.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0drivers/parisc/lba_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0drivers/pci/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02=
 +-
> =A0drivers/pci/host-bridge.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 97 ++++++
> =A0drivers/pci/hotplug/pciehp_pci.c =A0 =A0 =A0| =A0 12 +-
> =A0drivers/pci/probe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0601 +=
+++++++++++++++++++++-----------
> =A0drivers/pci/remove.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
> =A0drivers/pcmcia/yenta_socket.c =A0 =A0 =A0 =A0 | =A0 75 ----
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15 +=
-
> =A021 files changed, 767 insertions(+), 452 deletions(-)
> =A0create mode 100644 drivers/pci/host-bridge.c
>
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
