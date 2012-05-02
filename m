From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v11 00/30] PCI: allocate pci bus num range for unassigned
 bridge busn
Date: Wed, 2 May 2012 15:22:00 -0600
Message-ID: <CAErSpo7RNLdP4sRfg_3NE78rbvKM5HyRrApmLSLJOA8ggX=VvQ@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> Set up iobusn_resource tree, and register bus number range to it.
> Later when need to find bus range, will try to allocate from the tree
>
> Need to test on arches other than x86. esp for ia64 and powerpc that =
support
> =A0more than on peer root buses.
>
> The patches need to apply to linux v3.3 + pci-next and
> =A0 =A0 =A0 =A0[PATCH -v3] PCI: pci_host_bridge related cleanup
>
> could be found at:
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/=
linux-yinghai.git for-pci-busn-alloc

I started merging this series, but I didn't get very far.  I stopped
at the "resources: Add probe_resource()" patch because I don't think
that interface makes sense yet.  My work-in-progress is at
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git on the
topic/yinghai-busn-alloc branch.

I *could* merge that branch, but I don't think they fix anything (that
would come in the later patches), and there are still some issues in
my mind.

  - I think we really want a [bus 00-ff] resource for each *domain*,
with each host bridge in the domain requesting part of that range.  I
think these patches only track bus number usage within each host
bridge, and I'm not sure there's any place we would detect conflicts
between host bridges.

  - I think I made a mistake in the pci_create_root_bus() and
pci_scan_root_bus() interfaces.  They currently take a bus number and
a list of resources, and we expect the arch to include the bus number
aperture in the list.  The bus number argument should have been
replaced with a bus number aperture resource.  The bus number aperture
is essential, while the MMIO/IO aperture list may be empty.  And it's
stupid to pass both the starting bus number and a bus resource that
contains the starting bus number.  Fixing this would make some of
these patches quite a bit simpler.

  - In some of the arches (sparc, powerpc), you added a bus number
resource right next to existing first_busno, last_busno fields.  So
now that data lives two places, which will bite us later.

Bjorn


> Yinghai Lu (30):
> =A0x86, PCI: Add print all root info for not using _CRS path
> =A0x86, PCI: Allocate temp range array in amd_bus pci_root_info probi=
ng
> =A0x86, PCI: Merge pcibios_scan_root and pci_scan_bus_on_node
> =A0PCI: Add busn_res into struct pci_bus.
> =A0PCI: Add busn_res operation functions
> =A0PCI: Release busn_res when removing bus
> =A0PCI: Insert busn_res in pci_create_root_bus()
> =A0PCI: Checking busn_res in pci_scan_root_bus()
> =A0PCI: Add default busn_resource
> =A0PCI: Add default busn_res for pci_scan_bus()
> =A0x86, PCI: Add busn_res into resources list for acpi path
> =A0x86, PCI: Put busn resource in pci_root_info for not using _CRS pa=
th
> =A0PCI, ia64: Register busn_res for root buses
> =A0PCI, sparc: Register busn_res for root buses
> =A0PCI, powerpc: Register busn_res for root buses
> =A0PCI, parisc: Register busn_res for root buses
> =A0resources: Add probe_resource()
> =A0resources: Replace registered resource in tree.
> =A0PCI: Add pci_bus_extend/shrink_top()
> =A0PCI: Probe safe range that we can use for unassigned bridge.
> =A0PCI: Add pci_bus_replace_busn_res()
> =A0PCI: Allocate bus range instead of use max blindly
> =A0PCI: Strict checking of valid range for bridge
> =A0PCI: Kill pci_fixup_parent_subordinate_busnr()
> =A0PCI: Seperate child bus scanning to two passes overall
> =A0pcmcia: Remove workaround for fixing pci parent bus subordinate
> =A0PCI: Double checking setting for bus register and bus struct.
> =A0PCI, pciehp: Remove not needed bus number range checking
> =A0PCI: More strict checking of valid range for bridge
> =A0PCI: Don't shrink too much for hotplug bridge
>
> =A0arch/ia64/pci/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 +
> =A0arch/powerpc/include/asm/pci-bridge.h | =A0 =A01 +
> =A0arch/powerpc/kernel/pci-common.c =A0 =A0 =A0| =A0 10 +-
> =A0arch/sparc/kernel/pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +
> =A0arch/sparc/kernel/pci_impl.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/x86/pci/acpi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +=
-
> =A0arch/x86/pci/amd_bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +-
> =A0arch/x86/pci/bus_numa.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 30 ++-
> =A0arch/x86/pci/bus_numa.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-
> =A0arch/x86/pci/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 27 +--
> =A0drivers/parisc/dino.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0drivers/parisc/lba_pci.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A0drivers/pci/hotplug/pciehp_pci.c =A0 =A0 =A0| =A0 12 +-
> =A0drivers/pci/probe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0439 +=
++++++++++++++++++++++++++------
> =A0drivers/pci/remove.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
> =A0drivers/pcmcia/yenta_socket.c =A0 =A0 =A0 =A0 | =A0 75 ------
> =A0include/linux/ioport.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 +
> =A0kernel/resource.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0175=
 +++++++++++++-
> =A019 files changed, 613 insertions(+), 215 deletions(-)
>
> --
> 1.7.7
>
