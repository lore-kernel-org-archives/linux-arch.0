From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 08/17] dts: include documentation for the RISC-V
 interrupt controllers
Date: Mon, 19 Jun 2017 15:30:51 +0100
Message-ID: <20170619143027.GA4433@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-9-palmer@dabbelt.com>
 <CAMuHMdWYNVvh4hqDrqYNe2oyVHkCbH15VfWTWHaBCeRAaf6O4g@mail.gmail.com>
 <20170607101343.GC29370@leverpostej>
 <CAMgXwTiz0jXgSw=veJ3O7xzVgm==YisZZLWpZFH7aJMXV4j7qA@mail.gmail.com>
 <20170608105230.GC5765@leverpostej>
 <CAMgXwTi+H5n9f_kcbvTJE1yA-yeNSuwuR+QO4kYXtyZbQ2ga2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMgXwTi+H5n9f_kcbvTJE1yA-yeNSuwuR+QO4kYXtyZbQ2ga2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Albert Ou <albert@sifive.com>, patches@groups.riscv.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 09, 2017 at 02:58:14PM -0700, Wesley Terpstra wrote:
> Ugh. Clicked reply without being done writing the reply!
> 
> On Thu, Jun 8, 2017 at 3:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Edge vs level, active high vs active low. Typically some of these are
> > programmable, and are described as flags in the interrupt-specifier.
> >
> > See the examples in:
> >
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> 
> Ok. Those are not really relevant to the PLIC. It has a flat interrupt
> namespace and the way you handle all four kinds of interrupts in the
> driver is uniform. I don't think we want to architecturally expose
> this to the operating system.

Sure thing. I was just making sure I clarified my initial statement.

> > So do any CSRs affect the state of the PLIC? If it's just MMIO, the
> > mention of CSRs above is just a little confusing.
> 
> HLIC = CSR only. PLIC = MMIO only.
> 
> > It might be best to just say "The PLIC is connect to the HLIC embedded
> > in each RISC-V core".
> 
> Fair enough.
> 
> > It sounds like we'd need these to distinguish edge/level interrupts,
> > unless that's fixed at integration time and you can determine it from
> > the PLIC itself?
> 
> They are fixed at integration time and the PLIC driver does not need to care.

Ok.

> > Please update the binding to explicitly define the ordering requirement.
> 
> The ordering requirement is that the first interrupts-extended entry
> corresponds to the first context, second to second, etc. If a context
> is unused for some reason, that's when you need a -1. The contexts are
> linear and contiguous in the MMIO address map.

Ah. It wasn't at all clear to me that the order was in relation to the
MMIO space.

How is it possible to tell if an context is unused?

Are those mandated to be linear and contiguous in the address space?

How is the relationship between an MMIO context and hart determined?

I'm not sure that it makes sense to use -1 in this manner, since the
first cell of each interrupts-extended tuple entry is a phandle. IIRC
zero is currently de-facto invalid, and if we really need a NULL
phandle, we should get that clarified in the DT spec.

It might be better to describe each MMIO context separately, and then
associate IRQs with those in-order.

> 
> > Does this mean that you expect Linux logical CPU IDs to be equal to
> > physical CPU IDs in all cases?
> 
> No. There is no 'physical CPU ID' anyway, except the mhartid CSR which
> is unavailable to linux. The SBI conveys your CPU ID by passing it as
> the first argument to the linux kernel.
> 
> The interrupts-extended in the PLIC uses a phandle to reference the
> matching CPU in DTS. The num in cpu@<num> only need correspond to the
> first register argument to the kernel.

So you use the reference to the HLIC to implictly provide the CPU
affinity? Or do you assume that these align with the SBI-provided CPU
IDs?

Thanks,
Mark.
