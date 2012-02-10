From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
Date: Fri, 10 Feb 2012 09:24:15 -0800
Message-ID: <CAErSpo6MWS0=3gin7P6HQ7CNZwxD9cPfB6QNr1GDF7DVMhx2tw@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
 <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com>
 <CAE9FiQVx7=cSVkApbh_8dnoBqdrRYDOVtMqdC=mDCwq0fuVZpA@mail.gmail.com>
 <CAErSpo6zHhpz+N6y3ybDVp-oabVWAYeTt9pPJS3nz+nD2C8xkg@mail.gmail.com> <CAE9FiQVqKZGacZYqXETVVaqzobiw01OyCmASUfxwZ075rdX7XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51880 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253Ab2BJRYh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 12:24:37 -0500
Received: by wgbgn7 with SMTP id gn7so659554wgb.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2012 09:24:35 -0800 (PST)
In-Reply-To: <CAE9FiQVqKZGacZYqXETVVaqzobiw01OyCmASUfxwZ075rdX7XA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 10, 2012 at 9:20 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Feb 10, 2012 at 8:55 AM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
> ...
>>>
>>> I mean, we can unify sysdata usuage, make them all most the same.
>>>
>>> and for some sysdata, already acting like host_bridge struct with
>>> domain, numa_node, and resources.
>>>
>>>> If you can show an example of what you mean, maybe it will help me=
 understand.
>>>
>>> just looked the sys_data of different arch,
>>>
>>> looks like pci_sys_data for arm already include the io offset
>>>
>>> arch/arm/include/asm/mach/pci.h::
>>>
>>> struct pci_sys_data {
>>> #ifdef CONFIG_PCI_DOMAINS
>>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 domain;
>>> #endif
>>> =A0 =A0 =A0 =A0struct list_head node;
>>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 busnr; =A0 =A0 =A0 =A0 =A0=
/* primary bus number
>>> =A0 =A0 =A0 =A0 */
>>> =A0 =A0 =A0 =A0u64 =A0 =A0 =A0 =A0 =A0 =A0 mem_offset; =A0 =A0 /* b=
us->cpu memory mapping
>>> offset =A0 =A0 =A0 */
>>> =A0 =A0 =A0 =A0unsigned long =A0 io_offset; =A0 =A0 =A0/* bus->cpu =
IO mapping offset
>>> =A0 =A0 =A0 =A0 */
>>> =A0 =A0 =A0 =A0struct pci_bus =A0*bus; =A0 =A0 =A0 =A0 =A0 /* PCI b=
us
>>> =A0 =A0 =A0 =A0 */
>>> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* root bus reso=
urces (apertures)
>>
>> Let me try again. =A0Maybe your idea is that we should create someth=
ing
>> like "struct pcibios_sysdata" and require every arch to define a
>> struct with that name. =A0Every arch's struct would contain some mem=
bers
>> such as "domain," "mem_offset," "io_offset," and "resources." =A0The=
se
>> would have standard names & types across all arches and would be
>> referenced by the PCI core. =A0In addition, the struct could include
>> arch-specific data such as "acpi_handle," "iommu," etc.
>>
>> That way, the core could implement things like pci_domain_nr() and
>> pci_bus_to_resource() by using the data in struct pcibios_sysdata.
>> The current "void *sysdata" parameters to pci_scan_bus() and friends
>> would become "struct pcibios_sysdata *sysdata".
>>
>> I like the idea of unifying the sysdata struct name and changing fro=
m
>> a "void *" to something like "struct pcibios_sysdata *". =A0That mig=
ht
>> be worth doing.
>
> what i am mean:
> 1. make every arch to use same name for the struct, but could have
> different contents.
> =A0 struct pci_sys_data.
> 2. unify member field name, by changing name
> =A0 =A0pci_first_busno =3D=3D> first_busno
> =A0 =A0pci_last_busno =3D=3D> last_busno
> =A0 =A0or adding
> =A0 =A0first_busno
> =A0 =A0last_busno
> 3. changing more filed like domain, node
> =A0 =A0and io_offset, mem_offset
> ...

That's exactly what I said above, isn't it?  (In the paragraph
starting "Let me try again.")

As I said, the reason I don't like that approach is that I don't want
a dozen copies of first_busno, last_busno, domain, node, io_offset,
mem_offset, etc.  That information is not architecture-specific, so we
shouldn't keep it in an architecture-specific struct.

Bjorn
