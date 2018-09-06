From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Date: Thu, 6 Sep 2018 10:02:29 +0800
Message-ID: <20180906020229.GB29405@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <rob.herring@linaro.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 05, 2018 at 07:47:29PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> >
> > diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> > new file mode 100644
> > index 0000000..1136d9e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> > @@ -0,0 +1,46 @@
> > +=================
> > +gx6605s SOC Timer
> > +=================
> > +
> > +The timer is used in gx6605s soc as system timer and the driver
> > +contain clk event and clk source.
> > +
> > +==============================
> > +timer node bindings definition
> > +==============================
> > +
> > +        Description: Describes gx6605s SOC timer
> > +
> > +        PROPERTIES
> > +
> > +        - compatible
> > +                Usage: required
> > +                Value type: <string>
> > +                Definition: must be "csky,gx6605s"
> 
> -timer?
Yes, thx. must be "csky,gx6605s-timer"
> 
> > +       - reg
> > +               Usage: required
> > +               Value type: <u32 u32>
> > +               Definition: <phyaddr size> in soc from cpu view
> > +       - clocks
> > +               Usage: required
> > +               Value type: <node>
> 
> phandle + clock specifier cells
Sorry, I don't got it. Do you mean:
                    Value type: <phandle + clock specifier cells>
?
> 
> > +               Definition: must be input clk node
> > +        - interrupt
> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: must be timer irq num defined by soc
> > +        - interrupt-parent:
> 
> This is implied. Don't need to document it here.
Ok, remove interrupt-parent
> 
> > +                Usage: required
> > +               Value type: <node>
> > +                Definition: must be interrupt controller node
> > +
> > +Examples:
> > +---------
> > +
> > +       timer:timer {
> 
> Needs a unit-address.
Ok, change to "timer0: timer@0x0020a000"
> 
> > +               compatible = "csky,gx6605s-timer";
> > +               reg = <0x0020a000 0x400>;
> > +               clocks = <&dummy_apb_clk>;
> > +               interrupts = <10>;
> > +               interrupt-parent = <&intc>;
> > +       };
> > --
> > 2.7.4
> >
