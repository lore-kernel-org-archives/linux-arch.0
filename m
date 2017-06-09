Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35504 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdFIVqa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 17:46:30 -0400
Received: by mail-yw0-f177.google.com with SMTP id v7so7588095ywc.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Jun 2017 14:46:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608105230.GC5765@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com> <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
 <20170607101343.GC29370@leverpostej> <CAMgXwTiz0jXgSw=veJ3O7xzVgm==YisZZLWpZFH7aJMXV4j7qA@mail.gmail.com>
 <20170608105230.GC5765@leverpostej>
From: Wesley Terpstra <wesley@sifive.com>
Date: Fri, 9 Jun 2017 14:46:28 -0700
Message-ID: <CAMgXwTgk0yY2WzqKGnriy+KR0+YqZJYLEBz_HStYq03d5C3QKQ@mail.gmail.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V interrupt controllers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20170609214628.Pe5M94JPE1iHXTFer0-QZ7Tf7YiYa-eRVKeSt6Ud3EU@z>

On Thu, Jun 8, 2017 at 3:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> What flags?
>
> Edge vs level, active high vs active low. Typically some of these are
> programmable, and are described as flags in the interrupt-specifier.
>
> See the examples in:
>
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Ok. Those are not applicable to the PLIC.

>
>> > Are all HLIC interrupts edge triggered (or level triggered)?
>>
>> HLIC = level. PLIC = both.
>
> Ok. Given that, flags aren't necessary for the HLIC, and the
> interrupt-specifier is fine as-is.
>
>> >> > +RISC-V cores typically include a PLIC, which route interrupts from multiple
>> >> > +devices to multiple hart contexts.  The PLIC is connected to the interrupt
>> >> > +controller embedded in a RISC-V core via the interrupt-related CSRs.
>> >
>> > Do you mean that the PLIC is connected to the HLIC, or that the HLIC is
>> > also managed in part through CSRs?
>>
>> Both. The HLIC is entirely manager through CSRs. The PLIC is managed
>> through a memory mapped interface. The PLIC is attached to the HLIC.
>
> So do any CSRs affect the state of the PLIC? If it's just MMIO, the
> mention of CSRs above is just a little confusing.
>
> It might be best to just say "The PLIC is connect to the HLIC embedded
> in each RISC-V core".
>
>> >> > +Required properties:
>> >> > +- compatible : "riscv,plic0"
>> >> > +- #address-cells : should be <0>
>> >> > +- #interrupt-cells : should be <1>
>> >
>> > As with the HLIC, what about the flags?
>>
>> Still unsure what flags we're talking about.
>
> As covered above for the HLIC.
>
> It sounds like we'd need these to distinguish edge/level interrupts,
> unless that's fixed at integration time and you can determine it from
> the PLIC itself?
>
>> >> > +- riscv,ndev : Specifies the number of interrupts attached to the PLIC
>> >
>> > Why do we need to know this?
>> >
>> > I suspect this ia actually the number of interrupts implemented in the
>> > PLIC, rather than the number of interrupts attached. i.e. the PLIC can
>> > be implemented with a subset of the potential registers/bits. Is that
>> > correct?
>>
>> You're in principle correct, although these are probably always the same.
>
> For now, perhaps. Let's not embed an assumption we cannot guarantee.
>
>> > If so, something like "riscv,num-interrupts" would be better, along with
>> > a clearer description.
>>
>> Uhm. I suppose we can change this. However, it would requires changes
>> to quite a number of riscv repositories. I believe this is also
>> included in the riscv platform specification. A better description is
>> easy, do we really need to change the key?
>
> It's not too much of a problem, but if we end up having to change
> anything else from the proposed bindings, those trees are going to
> require updates anyway.
>
> If we can, I would like to change this to keep things as clear as
> possible from the outset.
>
> [...]
>
>> > You will need to be explicit about the order of interrupts in this
>> > property. i.e. which interrupt is routed to which context?
>>
>> Yes. Order and position matter.
>
> Ok.
>
> Please update the binding to explicitly define the ordering requirement.
>
> [...]
>
>> > Also, please consider how you will handle the case when the Linux
>> > logical CPU ID is not the same as the physical ID, and how you will
>> > handle physical IDs being sparse.
>>
>> We already deal with this. If the interrupt is '-1', we skip it.
>> That's done in plic.c:
>>                 if (parent.args[0] == -1) continue; // skip context holes
>
> If this is what we expect people to do, it needs to be documented in the
> binding.
>
> Does this mean that you expect Linux logical CPU IDs to be equal to
> physical CPU IDs in all cases?
>
> That's going to be painful for very sparse ID ranges, and won't work for
> cases like kexec/kdump where you cannot guarantee which physical CPU
> will end up being CPU0 in the new kernel.
>
> I would strongly advise that you explicitly describe the relationship
> using phandles to CPU nodes.
>
> I would also advise that you try to decouple the physical CPU IDs and
> Linux logical IDs. While assuming they're the same might simplify things
> today, it will create longer term maintenance problems and get in the
> way of a number of features.
>
> Thanks,
> Mark.
