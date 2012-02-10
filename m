From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
Date: Thu, 9 Feb 2012 20:03:46 -0800
Message-ID: <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53147 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758171Ab2BJEDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2012 23:03:47 -0500
In-Reply-To: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> There's a lot of PCI-related code under arch/, but much of it is not =
actually
> architecture-specific. =A0This series removes some of that code by mo=
ving most
> of the bus-to-resource conversions into the core.
>
> We currently read PCI bus addresses from BARs in the core (pci_setup_=
device()).
> Then every arch is responsible for converting those bus addresses to =
CPU
> resources, usually in pcibios_fixup_bus().
>
> We already have a way for architectures to tell the core what the win=
dows
> through a host bridge are:
>
> =A0 =A0LIST_HEAD(resources);
> =A0 =A0pci_add_resource(&resources, io_space);
> =A0 =A0pci_add_resource(&resources, mem_space);
> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>
> This series extends that so the arch can also tell the core about add=
ress
> translation performed by the host bridge:
>
> =A0 =A0LIST_HEAD(resources);
> =A0 =A0pci_add_resource_offset(&resources, io_space, io_offset);
> =A0 =A0pci_add_resource_offset(&resources, mem_space, mem_offset);
> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>
> Given that offset (the difference between bus address and CPU address=
 for
> each aperture), the core can do the bus-to-resource conversion immedi=
ately
> when it reads the BARs.
>
> This removes an opportunity for bugs (some PCI fixups currently see b=
us
> addresses in struct pci_dev resources when they're expecting CPU addr=
esses),
> but the main reason to do this is to make our PCI resource handling s=
impler
> and more uniform.
>
> These patches are also available in this git repo:
> =A0 =A0git://github.com/bjorn-helgaas/linux.git pci-offset-v2-d15af52=
258dd
>
> Or you can browse them here:
> =A0 =A0https://github.com/bjorn-helgaas/linux/compare/master...pci-of=
fset-v2-d15af52258dd
>
> I'd like to get these into linux-next soon to be ready for the 3.4 me=
rge
> window, so please let me know if you see any issues.
>
> Changes since v1:
> =A0- mips: remove Cobalt legacy IDE fixup
> =A0- show bus address range, not offset, e.g., this:
> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf0000000000-=
0xf007edfffff] (bus address [0x80000000-0xfedfffff])
> =A0 =A0instead of this:
> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf0000000000-=
0xf007edfffff] (bus offset 0xeff80000000)
>

still think make pci_sysdata to generic and add one offset field to
that would be more simple.

Yinghai
