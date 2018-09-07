Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46659 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbeIGMlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 08:41:05 -0400
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <66335e5f59c186b291f8c3c98c9dadbd61d0cd3e.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a2pOYNB6LtFB6hJ3WMXzJsj5wwNKvBK4_dP-4uPKas-Pw@mail.gmail.com> <20180907051747.GC13356@guoren-Inspiron-7460>
In-Reply-To: <20180907051747.GC13356@guoren-Inspiron-7460>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 7 Sep 2018 10:01:03 +0200
Message-ID: <CAK8P3a3HTySouXpwd3qbxzKodJgmTF+N_NxPzt5u7erNbkELig@mail.gmail.com>
Subject: Re: [PATCH V3 17/26] csky: Misc headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907080103.ROolSn2w0WJBmUdTl-_mtJL1hMmuXXYJkmkxY0FAg-s@z>

On Fri, Sep 7, 2018 at 7:17 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Thu, Sep 06, 2018 at 04:16:30PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > > diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> > > new file mode 100644
> > > index 0000000..d36e4cd
> > > --- /dev/null
> > > +++ b/arch/csky/boot/dts/qemu.dts
> > > @@ -0,0 +1,77 @@
> > > +/dts-v1/;
> > > +/ {
> > > +       compatible = "csky,qemu";
> > > +       #address-cells = <1>;
> > > +       #size-cells = <1>;
> > > +       interrupt-parent = <&intc>;
> >
> > Ideally, qemu would supply a dtb file that matches the current configuration,
> > as we do for instance on the ARM 'virt' machine. This allows you
> > much more flexibility in running all kinds of options, as well as extending
> > qemu later with new features.
> So, I should remove qemu.dts in next version patch?

It's up to you really. If you won't have a version of qemu that can do this
by itself, it may make sense to keep it around for a while. You might
want to include the version of your current qemu port is based on
qemu-2.x but not upstream, you could include a qemu-2.x.dts file
here, and have the future 3.x port provide its own.

      Arnd
