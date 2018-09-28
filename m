From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V5 18/30] dt-bindings: csky CPU Bindings
Date: Fri, 28 Sep 2018 19:42:04 +0800
Message-ID: <20180928114204.GA335@guoren-Inspiron-7460>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1537789737.git.ren_guo@c-sky.com>
 <20180927164317.GA8427@bogus>
 <20180928010312.GA4179@guoren-Inspiron-7460>
 <CAL_JsqJNPzTy_vE3HjdKhsXq+jtsCMS8RyWvppSB8sJaV1WZ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJNPzTy_vE3HjdKhsXq+jtsCMS8RyWvppSB8sJaV1WZ9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 06:32:34AM -0500, Rob Herring wrote:
> On Thu, Sep 27, 2018 at 8:03 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Thu, Sep 27, 2018 at 11:43:17AM -0500, Rob Herring wrote:
> > > On Tue, Sep 25, 2018 at 07:39:21AM +0800, Guo Ren wrote:
> > > > This patch adds the documentation to describe that how to add cpu nodes in
> > > > dts for SMP.
> > > >
> > > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
> > > >  1 file changed, 70 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> > > > new file mode 100644
> > > > index 0000000..ee3901d
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> > > > @@ -0,0 +1,70 @@
> > > > +==================
> > > > +C-SKY CPU Bindings
> > > > +==================
> > > > +
> > > > +The device tree allows to describe the layout of CPUs in a system through
> > > > +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> > > > +defining properties for every cpu.
> > > > +
> > > > +Only SMP system need to care about the cpus node and single processor
> > > > +needn't define cpus node at all.
> > >
> > > We've generally found this is not true. Even for single core, you can
> > > have power domains, clocks for DVFS, etc.
> > Ok, I'll remove it.
> >
> > >
> > > > +
> > > > +=====================================
> > > > +cpus and cpu node bindings definition
> > > > +=====================================
> > > > +
> > > > +- cpus node
> > > > +
> > > > +        Description: Container of cpu nodes
> > > > +
> > > > +        The node name must be "cpus".
> > > > +
> > > > +        A cpus node must define the following properties:
> > > > +
> > > > +        - #address-cells
> > > > +                Usage: required
> > > > +                Value type: <u32>
> > > > +                Definition: must be set to 1
> > > > +        - #size-cells
> > > > +                Usage: required
> > > > +                Value type: <u32>
> > > > +                Definition: must be set to 0
> > > > +
> > > > +- cpu node
> > > > +
> > > > +        Description: Describes one of SMP cores
> > > > +
> > > > +        PROPERTIES
> > > > +
> > >
> > > You need a compatible property for cpu nodes.
> > Our cpu is defined in defconfig, not in dts. I could put a comatible
> > property in here, but it's no use in code.
> 
> It doesn't matter as that could change. Most arches do run-time
> selection of cpus within a range of compatible cores.
> 
> And read the DT spec (devicetree.org) which says compatible is
> required for cpu nodes.
Ok, follow the rules. Here is my design..

		- compatible:
			Usage: required
			Value type: <string>
			Definition: csky,<cpu-type>:
			"csky,610"
			"csky,807"
			"csky,810"
			"csky,860"

Best Regards
 Guo Ren
