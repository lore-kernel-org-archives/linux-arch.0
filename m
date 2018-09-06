Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38007 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeIFGqJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 02:46:09 -0400
Date: Thu, 6 Sep 2018 10:12:54 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB
 intc
Message-ID: <20180906021254.GC29405@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
 <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180906021254.oSQbIv2mvsiuQVNRsCVLCDPm3f9uSoFeobJlt1XpHI0@z>

On Wed, Sep 05, 2018 at 07:43:10PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../interrupt-controller/csky,apb-intc.txt         | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > new file mode 100644
> > index 0000000..faa482c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> > @@ -0,0 +1,45 @@
> > +==============================
> > +C-SKY APB Interrupt Controller
> > +==============================
> > +
> > +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> > +on the apb bus and we only use it as root irq controller.
> > +
> > + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> > + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.
> 
> Can't this be described in DT as 2 csky,apb-intc nodes?
In detail, dual-apb-intc is not the same as two apb-intc, so I still want to name them
separately, so I will keep this and it is clearer.

> > +        - compatible
> > +                Usage: required
> > +                Value type: <string>
> > +                Definition: must be "csky,apb-intc"
> > +                                   "csky,dual-apb-intc"
> > +                                   "csky,gx6605s-intc"
> > +        - interrupt-cells
> 
> #interrupt-cells
Yes, I forgot #.
             - #interrupt-cells

> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: must be <1>
> 
> No edge or level configuration?
No, also no support in hardware.

> > +
> > +       intc: interrupt-controller {
> 
> Needs a unit-address.
Ok, change it to:
            intc: interrupt-controller@0x00500000 {

 Guo Ren
