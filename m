From: Wesley Terpstra <wesley@sifive.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V interrupt controllers
Date: Fri, 9 Jun 2017 14:58:14 -0700
Message-ID: <CAMgXwTi+H5n9f_kcbvTJE1yA-yeNSuwuR+QO4kYXtyZbQ2ga2w@mail.gmail.com>
References: <20170523004107.536-1-palmer@dabbelt.com> <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com> <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
 <20170607101343.GC29370@leverpostej> <CAMgXwTiz0jXgSw=veJ3O7xzVgm==YisZZLWpZFH7aJMXV4j7qA@mail.gmail.com>
 <20170608105230.GC5765@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35017 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdFIV6P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 17:58:15 -0400
Received: by mail-yw0-f179.google.com with SMTP id v7so7637969ywc.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Jun 2017 14:58:15 -0700 (PDT)
In-Reply-To: <20170608105230.GC5765@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Ugh. Clicked reply without being done writing the reply!

On Thu, Jun 8, 2017 at 3:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Edge vs level, active high vs active low. Typically some of these are
> programmable, and are described as flags in the interrupt-specifier.
>
> See the examples in:
>
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Ok. Those are not really relevant to the PLIC. It has a flat interrupt
namespace and the way you handle all four kinds of interrupts in the
driver is uniform. I don't think we want to architecturally expose
this to the operating system.

> So do any CSRs affect the state of the PLIC? If it's just MMIO, the
> mention of CSRs above is just a little confusing.

HLIC = CSR only. PLIC = MMIO only.

> It might be best to just say "The PLIC is connect to the HLIC embedded
> in each RISC-V core".

Fair enough.

> It sounds like we'd need these to distinguish edge/level interrupts,
> unless that's fixed at integration time and you can determine it from
> the PLIC itself?

They are fixed at integration time and the PLIC driver does not need to care.

> It's not too much of a problem, but if we end up having to change
> anything else from the proposed bindings, those trees are going to
> require updates anyway.

I'll talk to the other stakeholders.

> Please update the binding to explicitly define the ordering requirement.

The ordering requirement is that the first interrupts-extended entry
corresponds to the first context, second to second, etc. If a context
is unused for some reason, that's when you need a -1. The contexts are
linear and contiguous in the MMIO address map.

> Does this mean that you expect Linux logical CPU IDs to be equal to
> physical CPU IDs in all cases?

No. There is no 'physical CPU ID' anyway, except the mhartid CSR which
is unavailable to linux. The SBI conveys your CPU ID by passing it as
the first argument to the linux kernel.

The interrupts-extended in the PLIC uses a phandle to reference the
matching CPU in DTS. The num in cpu@<num> only need correspond to the
first register argument to the kernel.

If for some reason there end up too many -1 holes in the PLIC (b/c you
virtualized a 128-core machine down to say 2), you can always
virtualize the PLIC device and provide a matching simplified DTB.
