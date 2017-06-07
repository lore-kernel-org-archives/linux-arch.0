From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 03/17] base: fix order of OF initialization
Date: Wed, 7 Jun 2017 10:35:23 +0100
Message-ID: <20170607093523.GB29370@leverpostej>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-4-palmer@dabbelt.com>
 <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXWH5fU8YKfR37D5SMi1GpSk75Bq-OcYmm5ZuHe+XK0PQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, albert-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org, patches-q3qR2WxjNRFS9aJRtSZj7A@public.gmane.org, "Wesley W. Terpstra" <wesley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 07, 2017 at 09:07:20AM +0200, Geert Uytterhoeven wrote:
> CC devicetree folks
> 
> On Wed, Jun 7, 2017 at 12:59 AM, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org> wrote:
> > From: "Wesley W. Terpstra" <wesley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
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
> > Signed-off-by: Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>
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
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
