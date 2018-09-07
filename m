Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59103 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbeIGJyk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 05:54:40 -0400
Date: Fri, 7 Sep 2018 13:14:55 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 13/26] csky: Library functions
Message-ID: <20180907051454.GB13356@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <37f9bd824ede529fdab291a40eef3415f99ec8aa.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1xUhyQohifsvs_3th-iPCGL9WKDGj9qKoEaizuu19FeA@mail.gmail.com>
 <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3GhYGPnPf0ph=ZbVpNqiYhAsSMni7SKTC1ZC9zTUUxw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907051455.gX6g9twuQgym3Qr0TA9Gyt92jOp3ZMijhgspSJ0kC_w@z>

On Thu, Sep 06, 2018 at 05:50:02PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 6, 2018 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > > --- /dev/null
> > > +++ b/arch/csky/abiv1/memset.c
> > > @@ -0,0 +1,38 @@

> > > +       if ((long)d & 0x3)
> > > +               while (l--) *d++ = ch;
> 
> while ((uintptr_t)d & 0x3) && l--)
>         *d++ =ch;
> 
> and remove the else below?
Ok
 
> > > +                       *(((long *)d)+3) = tmp;
> 
> s/long/u32/
Ok

Thx
 Guo Ren
