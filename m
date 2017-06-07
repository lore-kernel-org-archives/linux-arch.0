Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdFGJgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 05:36:08 -0400
Date: Wed, 7 Jun 2017 10:35:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 03/17] base: fix order of OF initialization
Message-ID: <20170607093523.GB29370@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-4-palmer@dabbelt.com>
 <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <20170607093523.jyjKgNaOp69M7W-ke0lo_jm2YrOOditIA-oihChT3Vs@z>

On Wed, Jun 07, 2017 at 09:07:20AM +0200, Geert Uytterhoeven wrote:
> CC devicetree folks
> 
> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > From: "Wesley W. Terpstra" <wesley@sifive.com>
> >
> > This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
> > ... which you get for every CPU on all architectures with a OF cpu/ node.

I take it this means a /cpus node? Or the /cpus/cpu@* nodes?

I'm not seeing this on arm64 when booting v4.12-rc4 with DT, so clearly
this doesn't affect all such architectures.

What path are these errors happening in?

Thanks,
Mark.

> >
> > This affects riscv, nios, etc.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  drivers/base/init.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/init.c b/drivers/base/init.c
> > index 48c0e220acc0..0dcd17e561d0 100644
> > --- a/drivers/base/init.c
> > +++ b/drivers/base/init.c
> > @@ -31,9 +31,9 @@ void __init driver_init(void)
> >         /* These are also core pieces, but must come after the
> >          * core core pieces.
> >          */
> > +       of_core_init();
> >         platform_bus_init();
> >         cpu_dev_init();
> >         memory_dev_init();
> >         container_dev_init();
> > -       of_core_init();
> >  }
> > --
> > 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
