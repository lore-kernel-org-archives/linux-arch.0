From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V interrupt controllers
Date: Wed, 7 Jun 2017 11:57:17 -0700
Message-ID: <CAMgXwTiz0jXgSw=veJ3O7xzVgm==YisZZLWpZFH7aJMXV4j7qA@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com> <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
 <20170607101343.GC29370@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607101343.GC29370@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 7, 2017 at 3:13 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > +RISC-V Hart-Level Interrupt Controller (HLIC)
>> > +---------------------------------------------
>> > +
>> > +RISC-V cores include Control Status Registers (CSRs) which are local to each
>> > +hart and can be read or written by software. Some of these CSRs are used to
>> > +control local interrupts connected to the core.
>> > +
>> > +Typical examples of local interrupts on a RISC-V core include: software IPI
>> > +interrupts, timer interrupts, and a link to the PLIC interrupt controller.
>
> So IIUC those interrupts are routed directly to the HLIC, and are (only)
> controlled thought the HLIC?

Yes. You can have a local interrupt that goes directly to a specific
core, not via the PLIC.

> Is the HLIC architecturally mandated? i.e. is this guaranteed to be
> present on any RISC-V implementation?

It's in the RISC-V privileged specification. Therefore, if a riscv
core can run linux it will have these CSRs.

> Does the presence of the HLIC imply the presence of a PLIC (or
> vice/versa)?

No. SiFive implementations always have a PLIC, though.

> Typically, the per-cpu and platform-wide parts of the
> top-level interrupt controller are fairly intimately coupled.

They are coupled if they both exist. The privileged specification does
explicitly call out interrupts 9 and 11 in the HLIC for attaching the
PLIC.

> You'll need to allocate the "riscv" vendor prefix in
> Documentation/devicetree/bindings/vendor-prefixes.txt

@palmer: Can you add this?

> What about the flags?

What flags?

> Are all HLIC interrupts edge triggered (or level triggered)?

HLIC = level. PLIC = both.

> We can probably replace most of these with a "...", as they're largely
> irrelevany to this binding.

Sure. I thought it would be nice to include a complete cpu example
somewhere, though.

>> > +RISC-V cores typically include a PLIC, which route interrupts from multiple
>> > +devices to multiple hart contexts.  The PLIC is connected to the interrupt
>> > +controller embedded in a RISC-V core via the interrupt-related CSRs.
>
> Do you mean that the PLIC is connected to the HLIC, or that the HLIC is
> also managed in part through CSRs?

Both. The HLIC is entirely manager through CSRs. The PLIC is managed
through a memory mapped interface. The PLIC is attached to the HLIC.

>> > +Required properties:
>> > +- compatible : "riscv,plic0"
>> > +- #address-cells : should be <0>
>> > +- #interrupt-cells : should be <1>
>
> As with the HLIC, what about the flags?

Still unsure what flags we're talking about.

>> > +- riscv,ndev : Specifies the number of interrupts attached to the PLIC
>
> Why do we need to know this?
>
> I suspect this ia actually the number of interrupts implemented in the
> PLIC, rather than the number of interrupts attached. i.e. the PLIC can
> be implemented with a subset of the potential registers/bits. Is that
> correct?

You're in principle correct, although these are probably always the same.

> If so, something like "riscv,num-interrupts" would be better, along with
> a clearer description.

Uhm. I suppose we can change this. However, it would requires changes
to quite a number of riscv repositories. I believe this is also
included in the riscv platform specification. A better description is
easy, do we really need to change the key?


>> > +- interrupts-extended : Specifies which contexts are connected to the PLIC
>
> That description doesn't sound right.
>
> I take it that these are the HLIC interrupts that the PLIC can raise?

Yes.

> You will need to be explicit about the order of interrupts in this
> property. i.e. which interrupt is routed to which context?

Yes. Order and position matter.

> Is the interrupt at the HLIC well known? From the example I see that
> here local interrupts 11 adn 9 are used. Is that mandated, or just the
> case for this particular implementation?

9 and 11 are in the privileged specification.

> Also, please consider how you will handle the case when the Linux
> logical CPU ID is not the same as the physical ID, and how you will
> handle physical IDs being sparse.

We already deal with this. If the interrupt is '-1', we skip it.
That's done in plic.c:
                if (parent.args[0] == -1) continue; // skip context holes

>> > +       plic: interrupt-controller@c000000 {
>> > +               #address-cells = <0>;
>
> This can go, given you don't have sub-nodes, nor a #size-cells property.

The device-tree-specification seems to indicate that this is mandatory
for an interrupt-controller. Or have I understood this wrongly? When
you use interrupts-extended, doesn't it use the address-cells of the
interrupt controller? We should add that size-cells = 0, though.
