From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V interrupt controllers
Date: Wed, 7 Jun 2017 09:11:31 +0200
Message-ID: <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35590 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdFGHLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 03:11:39 -0400
In-Reply-To: <20170606230007.19101-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

CC irqchip and devicetree folks

On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  .../interrupt-controller/riscv,cpu-intc.txt        | 46 ++++++++++++++++++++++
>  .../bindings/interrupt-controller/riscv,plic0.txt  | 44 +++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> new file mode 100644
> index 000000000000..62f02e834ff9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> @@ -0,0 +1,46 @@
> +RISC-V Hart-Level Interrupt Controller (HLIC)
> +---------------------------------------------
> +
> +RISC-V cores include Control Status Registers (CSRs) which are local to each
> +hart and can be read or written by software. Some of these CSRs are used to
> +control local interrupts connected to the core.
> +
> +Typical examples of local interrupts on a RISC-V core include: software IPI
> +interrupts, timer interrupts, and a link to the PLIC interrupt controller.
> +
> +Required properties:
> +- compatible : "riscv,cpu-intc"
> +- #interrupt-cells : should be <1>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +Furthermore, this interrupt-controller MUST be embedded inside the cpu
> +definition of the hart whose CSRs control these local interrupts.
> +
> +Example:
> +
> +       cpu1: cpu@1 {
> +               clock-frequency = <1600000000>;
> +               compatible = "riscv";
> +               d-cache-block-size = <64>;
> +               d-cache-sets = <64>;
> +               d-cache-size = <16384>;
> +               d-tlb-sets = <1>;
> +               d-tlb-size = <32>;
> +               device_type = "cpu";
> +               i-cache-block-size = <64>;
> +               i-cache-sets = <64>;
> +               i-cache-size = <16384>;
> +               i-tlb-sets = <1>;
> +               i-tlb-size = <32>;
> +               mmu-type = "riscv,sv39";
> +               next-level-cache = <&L2>;
> +               reg = <1>;
> +               riscv,isa = "rv64imac";
> +               status = "okay";
> +               tlb-split;
> +               cpu1-intc: interrupt-controller {
> +                       #interrupt-cells = <1>;
> +                       compatible = "riscv,cpu-intc";
> +                       interrupt-controller;
> +               };
> +       };
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> new file mode 100644
> index 000000000000..c05b5806f7d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> @@ -0,0 +1,44 @@
> +RISC-V Platform-Level Interrupt Controller (PLIC)
> +-------------------------------------------------
> +
> +RISC-V cores typically include a PLIC, which route interrupts from multiple
> +devices to multiple hart contexts.  The PLIC is connected to the interrupt
> +controller embedded in a RISC-V core via the interrupt-related CSRs.
> +
> +A hart context is a priviledge mode in a hardware execution thread.  For
> +example, in an 4 core system with 2-way SMT, you have 8 harts and probably
> +at least two priviledge modes per hart; machine mode and supervisor mode.
> +
> +Each interrupt can be enabled on per-context basis. Any context can claim
> +a pending enabled interrupt and then release it once it has been handled.
> +
> +Each interrupt has a configurable priority. Higher priority interrupts are
> +serviced firs. Each context can specify a priority threshold. Interrupts
> +with priority below this threshold will not cause the PLIC to raise its
> +interrupt line leading to the context.
> +
> +Required properties:
> +- compatible : "riscv,plic0"
> +- #address-cells : should be <0>
> +- #interrupt-cells : should be <1>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- reg : Should contain 1 register range (address and length)
> +- riscv,ndev : Specifies the number of interrupts attached to the PLIC
> +- interrupts-extended : Specifies which contexts are connected to the PLIC
> +
> +Example:
> +
> +       plic: interrupt-controller@c000000 {
> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +               compatible = "riscv,plic0";
> +               interrupt-controller;
> +               interrupts-extended = <
> +                       &cpu0-intc 11
> +                       &cpu1-intc 11 &cpu1-intc 9
> +                       &cpu2-intc 11 &cpu2-intc 9
> +                       &cpu3-intc 11 &cpu3-intc 9
> +                       &cpu4-intc 11 &cpu4-intc 9>;
> +               reg = <0xc000000 0x4000000>;
> +               riscv,ndev = <10>;
> +       };
> --
> 2.13.0
