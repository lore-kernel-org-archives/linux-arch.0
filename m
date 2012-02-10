From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
Date: Thu, 9 Feb 2012 20:34:30 -0800
Message-ID: <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57859 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab2BJEev convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2012 23:34:51 -0500
Received: by werb13 with SMTP id b13so1735456wer.19
        for <linux-arch@vger.kernel.org>; Thu, 09 Feb 2012 20:34:50 -0800 (PST)
In-Reply-To: <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Feb 9, 2012 at 8:03 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
>> There's a lot of PCI-related code under arch/, but much of it is not=
 actually
>> architecture-specific. =A0This series removes some of that code by m=
oving most
>> of the bus-to-resource conversions into the core.
>>
>> We currently read PCI bus addresses from BARs in the core (pci_setup=
_device()).
>> Then every arch is responsible for converting those bus addresses to=
 CPU
>> resources, usually in pcibios_fixup_bus().
>>
>> We already have a way for architectures to tell the core what the wi=
ndows
>> through a host bridge are:
>>
>> =A0 =A0LIST_HEAD(resources);
>> =A0 =A0pci_add_resource(&resources, io_space);
>> =A0 =A0pci_add_resource(&resources, mem_space);
>> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> This series extends that so the arch can also tell the core about ad=
dress
>> translation performed by the host bridge:
>>
>> =A0 =A0LIST_HEAD(resources);
>> =A0 =A0pci_add_resource_offset(&resources, io_space, io_offset);
>> =A0 =A0pci_add_resource_offset(&resources, mem_space, mem_offset);
>> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> Given that offset (the difference between bus address and CPU addres=
s for
>> each aperture), the core can do the bus-to-resource conversion immed=
iately
>> when it reads the BARs.
>>
>> This removes an opportunity for bugs (some PCI fixups currently see =
bus
>> addresses in struct pci_dev resources when they're expecting CPU add=
resses),
>> but the main reason to do this is to make our PCI resource handling =
simpler
>> and more uniform.
>>
>> These patches are also available in this git repo:
>> =A0 =A0git://github.com/bjorn-helgaas/linux.git pci-offset-v2-d15af5=
2258dd
>>
>> Or you can browse them here:
>> =A0 =A0https://github.com/bjorn-helgaas/linux/compare/master...pci-o=
ffset-v2-d15af52258dd
>>
>> I'd like to get these into linux-next soon to be ready for the 3.4 m=
erge
>> window, so please let me know if you see any issues.
>>
>> Changes since v1:
>> =A0- mips: remove Cobalt legacy IDE fixup
>> =A0- show bus address range, not offset, e.g., this:
>> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf0000000000=
-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
>> =A0 =A0instead of this:
>> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf0000000000=
-0xf007edfffff] (bus offset 0xeff80000000)
>>
>
> still think make pci_sysdata to generic and add one offset field to
> that would be more simple.

Maybe I'm misunderstanding you, because this doesn't make sense to me a=
t all.

*One* offset field is insufficient.  A host bridge can have an
arbitrary number of apertures, and each aperture can have a different
offset.  So we must have a list or other variable-size structure.

pci_scan_bus() takes a "void *sysdata".  Every arch defines its own
structure (struct pci_sysdata for x86, struct pci_controller for most
others) to supply here.  Are you suggesting that we make a common
structure like this:

    struct pci_sysdata {
        struct list_head windows;
        void *sysdata;  /* arch-specific stuff */
    };

That's possible, but I don't see the advantage over what I've done.
It doesn't seem simpler, because all the arch code that looks at
bus->sysdata would have to change to use
bus->generic_sysdata->sysdata.

If you can show an example of what you mean, maybe it will help me unde=
rstand.

Bjorn
