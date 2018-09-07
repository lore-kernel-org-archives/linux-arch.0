Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55689 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725986AbeIGJ5c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 05:57:32 -0400
Date: Fri, 7 Sep 2018 13:17:47 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 17/26] csky: Misc headers
Message-ID: <20180907051747.GC13356@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <66335e5f59c186b291f8c3c98c9dadbd61d0cd3e.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a2pOYNB6LtFB6hJ3WMXzJsj5wwNKvBK4_dP-4uPKas-Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2pOYNB6LtFB6hJ3WMXzJsj5wwNKvBK4_dP-4uPKas-Pw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907051747.iudy28HueUbg9u93sIkOm1OGVSbq_6-zfefW1zkpzzE@z>

On Thu, Sep 06, 2018 at 04:16:30PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> > new file mode 100644
> > index 0000000..d36e4cd
> > --- /dev/null
> > +++ b/arch/csky/boot/dts/qemu.dts
> > @@ -0,0 +1,77 @@
> > +/dts-v1/;
> > +/ {
> > +       compatible = "csky,qemu";
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       interrupt-parent = <&intc>;
> 
> Ideally, qemu would supply a dtb file that matches the current configuration,
> as we do for instance on the ARM 'virt' machine. This allows you
> much more flexibility in running all kinds of options, as well as extending
> qemu later with new features.
So, I should remove qemu.dts in next version patch?

> > +
> > +               timer0: timer@0xffffd000 {
> > +                       compatible = "snps,dw-apb-timer";
> > +                       reg = <0xffffd000 0x1000>;
> > +                       clocks = <&dummy_apb>;
> > +                       clock-names = "timer";
> > +                       interrupts = <1>;
> > +               };
> > +
> > +               timer1: timer@0xffffd014 {
> 
> Drop the leading '0x' in the unit-address here (in all devices)
Ok
