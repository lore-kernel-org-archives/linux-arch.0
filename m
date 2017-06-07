From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V
 interrupt controllers
Date: Wed, 7 Jun 2017 11:13:43 +0100
Message-ID: <20170607101343.GC29370@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com>
 <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdFGKO2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 06:14:28 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Jun 07, 2017 at 09:11:31AM +0200, Geert Uytterhoeven wrote:
> CC irqchip and devicetree folks

Thanks Geert.

Palmer, in future, you can ensure (most) relevant parties are Cc'd by
using scripts/get_maintainer.pl to find them, and adding Cc: lines to
the relevant patches.

You can either hand that a patch or a path, e.g.

[mark@leverpostej:~/src/linux]% ./scripts/get_maintainer.pl -f Documentation/devicetree/bindings/interrupt-controller/                  
Thomas Gleixner <tglx@linutronix.de> (maintainer:IRQCHIP DRIVERS)
Jason Cooper <jason@lakedaemon.net> (maintainer:IRQCHIP DRIVERS)
Marc Zyngier <marc.zyngier@arm.com> (maintainer:IRQCHIP DRIVERS)
Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS)
devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

Otherwise, I have a few comments inline below.

> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > From: "Wesley W. Terpstra" <wesley@sifive.com>
> >
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  .../interrupt-controller/riscv,cpu-intc.txt        | 46 ++++++++++++++++++++++
> >  .../bindings/interrupt-controller/riscv,plic0.txt  | 44 +++++++++++++++++++++
> >  2 files changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> > new file mode 100644
> > index 000000000000..62f02e834ff9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> > @@ -0,0 +1,46 @@
> > +RISC-V Hart-Level Interrupt Controller (HLIC)
> > +---------------------------------------------
> > +
> > +RISC-V cores include Control Status Registers (CSRs) which are local to each
> > +hart and can be read or written by software. Some of these CSRs are used to
> > +control local interrupts connected to the core.
> > +
> > +Typical examples of local interrupts on a RISC-V core include: software IPI
> > +interrupts, timer interrupts, and a link to the PLIC interrupt controller.

So IIUC those interrupts are routed directly to the HLIC, and are (only)
controlled thought the HLIC?

Is the HLIC architecturally mandated? i.e. is this guaranteed to be
present on any RISC-V implementation?

Does the presence of the HLIC imply the presence of a PLIC (or
vice/versa)? Typically, the per-cpu and platform-wide parts of the
top-level interrupt controller are fairly intimately coupled.

> > +
> > +Required properties:
> > +- compatible : "riscv,cpu-intc"

You'll need to allocate the "riscv" vendor prefix in 
Documentation/devicetree/bindings/vendor-prefixes.txt

... if that was done in some other patch, I didn't receive it.

> > +- #interrupt-cells : should be <1>

What about the flags?

Are all HLIC interrupts edge triggered (or level triggered)?

> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +
> > +Furthermore, this interrupt-controller MUST be embedded inside the cpu
> > +definition of the hart whose CSRs control these local interrupts.
> > +
> > +Example:
> > +
> > +       cpu1: cpu@1 {
> > +               clock-frequency = <1600000000>;
> > +               compatible = "riscv";
> > +               d-cache-block-size = <64>;
> > +               d-cache-sets = <64>;
> > +               d-cache-size = <16384>;
> > +               d-tlb-sets = <1>;
> > +               d-tlb-size = <32>;
> > +               device_type = "cpu";
> > +               i-cache-block-size = <64>;
> > +               i-cache-sets = <64>;
> > +               i-cache-size = <16384>;
> > +               i-tlb-sets = <1>;
> > +               i-tlb-size = <32>;
> > +               mmu-type = "riscv,sv39";
> > +               next-level-cache = <&L2>;
> > +               reg = <1>;
> > +               riscv,isa = "rv64imac";
> > +               status = "okay";
> > +               tlb-split;

We can probably replace most of these with a "...", as they're largely
irrelevany to this binding.

> > +               cpu1-intc: interrupt-controller {
> > +                       #interrupt-cells = <1>;
> > +                       compatible = "riscv,cpu-intc";
> > +                       interrupt-controller;
> > +               };
> > +       };
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> > new file mode 100644
> > index 000000000000..c05b5806f7d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> > @@ -0,0 +1,44 @@
> > +RISC-V Platform-Level Interrupt Controller (PLIC)
> > +-------------------------------------------------
> > +
> > +RISC-V cores typically include a PLIC, which route interrupts from multiple
> > +devices to multiple hart contexts.  The PLIC is connected to the interrupt
> > +controller embedded in a RISC-V core via the interrupt-related CSRs.

Do you mean that the PLIC is connected to the HLIC, or that the HLIC is
also managed in part through CSRs?

> > +
> > +A hart context is a priviledge mode in a hardware execution thread.  For
> > +example, in an 4 core system with 2-way SMT, you have 8 harts and probably
> > +at least two priviledge modes per hart; machine mode and supervisor mode.
> > +
> > +Each interrupt can be enabled on per-context basis. Any context can claim
> > +a pending enabled interrupt and then release it once it has been handled.
> > +
> > +Each interrupt has a configurable priority. Higher priority interrupts are
> > +serviced firs. Each context can specify a priority threshold. Interrupts
> > +with priority below this threshold will not cause the PLIC to raise its
> > +interrupt line leading to the context.
> > +
> > +Required properties:
> > +- compatible : "riscv,plic0"
> > +- #address-cells : should be <0>
> > +- #interrupt-cells : should be <1>

As with the HLIC, what about the flags?

> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- reg : Should contain 1 register range (address and length)
> > +- riscv,ndev : Specifies the number of interrupts attached to the PLIC

Why do we need to know this?

I suspect this ia actually the number of interrupts implemented in the
PLIC, rather than the number of interrupts attached. i.e. the PLIC can
be implemented with a subset of the potential registers/bits. Is that
correct?

If so, something like "riscv,num-interrupts" would be better, along with
a clearer description.

> > +- interrupts-extended : Specifies which contexts are connected to the PLIC

That description doesn't sound right.

I take it that these are the HLIC interrupts that the PLIC can raise?

You will need to be explicit about the order of interrupts in this
property. i.e. which interrupt is routed to which context?

Is the interrupt at the HLIC well known? From the example I see that
here local interrupts 11 adn 9 are used. Is that mandated, or just the
case for this particular implementation?

Also, please consider how you will handle the case when the Linux
logical CPU ID is not the same as the physical ID, and how you will
handle physical IDs being sparse.

We went though a lot of pain trying to do something similar for the ARM
PMU interrupts (see the interrupt-affinity property in
Documentation/devicetree/bindings/arm/pmu.txt), and it's still painful
to deal with.

> > +
> > +Example:
> > +
> > +       plic: interrupt-controller@c000000 {
> > +               #address-cells = <0>;

This can go, given you don't have sub-nodes, nor a #size-cells property.

Thanks,
Mark.

> > +               #interrupt-cells = <1>;
> > +               compatible = "riscv,plic0";
> > +               interrupt-controller;
> > +               interrupts-extended = <
> > +                       &cpu0-intc 11
> > +                       &cpu1-intc 11 &cpu1-intc 9
> > +                       &cpu2-intc 11 &cpu2-intc 9
> > +                       &cpu3-intc 11 &cpu3-intc 9
> > +                       &cpu4-intc 11 &cpu4-intc 9>;
> > +               reg = <0xc000000 0x4000000>;
> > +               riscv,ndev = <10>;
> > +       };
> > --
> > 2.13.0
