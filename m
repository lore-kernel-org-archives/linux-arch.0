From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 06/17] pci: Add generic pcibios_{fixup_bus,align_resource}
Date: Fri, 23 Jun 2017 19:01:51 -0700 (PDT)
Message-ID: <mhng-730176d6-cea5-4f58-99fa-63f6f32df543@palmer-si-x1c4>
References: <CAK8P3a1Q=LoAPU_6X_z1=4Yp-Q=TCYpVz3R2MOv_UikX-tPDQg@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34233 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdFXCBy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2017 22:01:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so9746982pfe.1
        for <linux-arch@vger.kernel.org>; Fri, 23 Jun 2017 19:01:53 -0700 (PDT)
In-Reply-To: <CAK8P3a1Q=LoAPU_6X_z1=4Yp-Q=TCYpVz3R2MOv_UikX-tPDQg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: hch@infradead.org, geert@linux-m68k.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, bhelgaas@google.com, linux-pci@vger.kernel.org

On Thu, 08 Jun 2017 01:35:29 PDT (-0700), Arnd Bergmann wrote:
> On Thu, Jun 8, 2017 at 10:12 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Wed, Jun 07, 2017 at 09:19:49AM +0200, Geert Uytterhoeven wrote:
>>> CC pci folks
>>
>> Ok, replying with pci folks in Cc then :)
>>
>> Weak symbols have (rightly) gotten a bad reputation, so maybe
>> we should approach this without them.
>
> Agreed, I would almost never recommend using a __weak symbol,
> but they are already widely used in the PCI subsystem, so I suggested
> using them here for consistency.
>
> We have a struct pci_host_bridge now, and we should eventually
> move most of the 38 pci specific weak  per-architecture symbols
> into per-host driver callbacks, but that I think that would be too much
> to ask for when adding an architecture port.

I agree :)

>> It seems we have a large number of emptry pcibios_fixup_bus calls
>> alreayd, so I think we should simply have the architectures
>> that do define it define a Kconfig or header symbol and not call
>> it at all otherwise.
>
> I would argue that most of them should not be per-architecture
> in the first place, the current state is mostly an artifact of the
> times when each architecture had just one PCI implementation.
>
> The ones that have multiple implementations (arm, powerpc, ...)
> tend to actually override the weak functions with their own
> per-host multiplexers again.
>
>> For the ones that exist as lot just seem to call pci_read_bridge_bases
>> and/or pcibios_fixup_device_resources in one form or another,
>> and I wonder why we even need the arch indirection for that.
>>
>> Similarly for pcibios_align_resource: a lot of architetures seem
>> to have a noop, and the once that don't mostly seem copy and
>> paste code, so we should again have a symbol for architectures
>> to opt into it, and we probably should have a generic helper
>> for the VGA window mirroring code instead of duplicating it multiple
>> times.
>
> I now remember that we already have a host_bridge->align_resource
> callback pointer, so the generic function should definitely try
> to use that.
>
> We could just use the version from arch/mips/pci/pci-generic.c
> and remove that in the process. I'm not sure about why mips calls
> pci_read_bridge_bases() in pcibios_fixup_bus() though, or whether
> this make sense to put in the generic version.

I'm splitting this off into another patch set and sending it to a bunch of PCI
people.
