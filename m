From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
Date: Thu, 6 Sep 2018 15:03:16 +0200
Message-ID: <CAK8P3a0qRKEfdyQ5V0JcukTG+e0vSLycoBkC4YxRM_os9_jUcQ@mail.gmail.com>
References: <cover.1536138304.git.ren_guo@c-sky.com> <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com> <20180906022322.GA30251@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906022322.GA30251@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 6, 2018 at 4:23 AM Guo Ren <ren_guo@c-sky.com> wrote:
> On Wed, Sep 05, 2018 at 07:45:12PM -0500, Rob Herring wrote:
> > On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > +
> > > +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> > > +SMP soc, and it also could be used in non-SMP system.
> >
> > How is it accessed? No mmio registers?
> Mmio reg base is got from cpu-coprocessor register and I'll detail
> it here in next version patch.
>
> csky_mpintc_init(struct device_node *node, struct device_node *parent)
> {
>         ...
>         INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);

It that reliable? I remember a similar situation with some registers on ARM
that are usually identified through a special CPU register, but in some
cases the SoC integrator put the wrong address in there, so we need to
look up the address in DT anyway.

      Arnd
