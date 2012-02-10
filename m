From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
Date: Fri, 10 Feb 2012 08:55:17 -0800
Message-ID: <CAErSpo6zHhpz+N6y3ybDVp-oabVWAYeTt9pPJS3nz+nD2C8xkg@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
 <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com> <CAE9FiQVx7=cSVkApbh_8dnoBqdrRYDOVtMqdC=mDCwq0fuVZpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51793 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab2BJQzj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 11:55:39 -0500
Received: by wgbdt10 with SMTP id dt10so2989383wgb.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 08:55:38 -0800 (PST)
In-Reply-To: <CAE9FiQVx7=cSVkApbh_8dnoBqdrRYDOVtMqdC=mDCwq0fuVZpA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Feb 9, 2012 at 8:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 8:34 PM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
>> On Thu, Feb 9, 2012 at 8:03 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>>> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>>>> There's a lot of PCI-related code under arch/, but much of it is n=
ot actually
>>>> architecture-specific. =A0This series removes some of that code by=
 moving most
>>>> of the bus-to-resource conversions into the core.
>>>>
>>>> We currently read PCI bus addresses from BARs in the core (pci_set=
up_device()).
>>>> Then every arch is responsible for converting those bus addresses =
to CPU
>>>> resources, usually in pcibios_fixup_bus().
>>>>
>>>> We already have a way for architectures to tell the core what the =
windows
>>>> through a host bridge are:
>>>>
>>>> =A0 =A0LIST_HEAD(resources);
>>>> =A0 =A0pci_add_resource(&resources, io_space);
>>>> =A0 =A0pci_add_resource(&resources, mem_space);
>>>> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>>>
>>>> This series extends that so the arch can also tell the core about =
address
>>>> translation performed by the host bridge:
>>>>
>>>> =A0 =A0LIST_HEAD(resources);
>>>> =A0 =A0pci_add_resource_offset(&resources, io_space, io_offset);
>>>> =A0 =A0pci_add_resource_offset(&resources, mem_space, mem_offset);
>>>> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>>>
>>>> Given that offset (the difference between bus address and CPU addr=
ess for
>>>> each aperture), the core can do the bus-to-resource conversion imm=
ediately
>>>> when it reads the BARs.
>>>>
>>>> This removes an opportunity for bugs (some PCI fixups currently se=
e bus
>>>> addresses in struct pci_dev resources when they're expecting CPU a=
ddresses),
>>>> but the main reason to do this is to make our PCI resource handlin=
g simpler
>>>> and more uniform.
>>>>
>>>> These patches are also available in this git repo:
>>>> =A0 =A0git://github.com/bjorn-helgaas/linux.git pci-offset-v2-d15a=
f52258dd
>>>>
>>>> Or you can browse them here:
>>>> =A0 =A0https://github.com/bjorn-helgaas/linux/compare/master...pci=
-offset-v2-d15af52258dd
>>>>
>>>> I'd like to get these into linux-next soon to be ready for the 3.4=
 merge
>>>> window, so please let me know if you see any issues.
>>>>
>>>> Changes since v1:
>>>> =A0- mips: remove Cobalt legacy IDE fixup
>>>> =A0- show bus address range, not offset, e.g., this:
>>>> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf00000000=
00-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
>>>> =A0 =A0instead of this:
>>>> =A0 =A0 =A0 =A0pci_bus 0000:00: root bus resource [mem 0xf00000000=
00-0xf007edfffff] (bus offset 0xeff80000000)
>>>>
>>>
>>> still think make pci_sysdata to generic and add one offset field to
>>> that would be more simple.
>>
>> Maybe I'm misunderstanding you, because this doesn't make sense to m=
e at all.
>>
>> *One* offset field is insufficient. =A0A host bridge can have an
>> arbitrary number of apertures, and each aperture can have a differen=
t
>> offset. =A0So we must have a list or other variable-size structure.
>>
>> pci_scan_bus() takes a "void *sysdata". =A0Every arch defines its ow=
n
>> structure (struct pci_sysdata for x86, struct pci_controller for mos=
t
>> others) to supply here. =A0Are you suggesting that we make a common
>> structure like this:
>>
>> =A0 =A0struct pci_sysdata {
>> =A0 =A0 =A0 =A0struct list_head windows;
>> =A0 =A0 =A0 =A0void *sysdata; =A0/* arch-specific stuff */
>> =A0 =A0};
>>
>> That's possible, but I don't see the advantage over what I've done.
>> It doesn't seem simpler, because all the arch code that looks at
>> bus->sysdata would have to change to use
>> bus->generic_sysdata->sysdata.
>
> I mean, we can unify sysdata usuage, make them all most the same.
>
> and for some sysdata, already acting like host_bridge struct with
> domain, numa_node, and resources.
>
>> If you can show an example of what you mean, maybe it will help me u=
nderstand.
>
> just looked the sys_data of different arch,
>
> looks like pci_sys_data for arm already include the io offset
>
> arch/arm/include/asm/mach/pci.h::
>
> struct pci_sys_data {
> #ifdef CONFIG_PCI_DOMAINS
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 domain;
> #endif
> =A0 =A0 =A0 =A0struct list_head node;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 busnr; =A0 =A0 =A0 =A0 =A0=
/* primary bus number
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0u64 =A0 =A0 =A0 =A0 =A0 =A0 mem_offset; =A0 =A0 /* bus=
->cpu memory mapping
> offset =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0unsigned long =A0 io_offset; =A0 =A0 =A0/* bus->cpu IO=
 mapping offset
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0struct pci_bus =A0*bus; =A0 =A0 =A0 =A0 =A0 /* PCI bus
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* root bus resour=
ces (apertures)

Let me try again.  Maybe your idea is that we should create something
like "struct pcibios_sysdata" and require every arch to define a
struct with that name.  Every arch's struct would contain some members
such as "domain," "mem_offset," "io_offset," and "resources."  These
would have standard names & types across all arches and would be
referenced by the PCI core.  In addition, the struct could include
arch-specific data such as "acpi_handle," "iommu," etc.

That way, the core could implement things like pci_domain_nr() and
pci_bus_to_resource() by using the data in struct pcibios_sysdata.
The current "void *sysdata" parameters to pci_scan_bus() and friends
would become "struct pcibios_sysdata *sysdata".

I like the idea of unifying the sysdata struct name and changing from
a "void *" to something like "struct pcibios_sysdata *".  That might
be worth doing.

But the whole point of this patch series is to move things that are
not architecture-specific out of the arch code.  I don't want to end
up with a dozen pcibios_sysdata structs that all contain exactly the
same generic members plus a few arch-specific ones.  That would mean
trying to keep those dozen places consistent all the time, which is a
maintenance hassle.

This series does cause some duplication, e.g., struct pci_host_bridge
will contain a "struct pci_bus *" and some resource information that's
also in the arch-specific struct pci_controller.  That information is
not actually arch-specific at all, so I think it's a good thing if we
gradually remove it from the arch-specific sysdata structs.  In many
cases, that will also remove current arch restrictions such as "all
memory apertures must have the same CPU/bus address offset," and "at
most one I/O aperture and three memory apertures are supported."

Bjorn
