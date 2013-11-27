From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
Date: Wed, 27 Nov 2013 15:35:35 +0000
Message-ID: <20131127153535.EEA87C404EC@trevor.secretlab.ca>
References: <5283A000.8090007@gmail.com> < 1384859554-27268-1-git-send-email-geert@linux-m68k.org> <20131121122148. 1B43DC40A2C@trevor.secretlab.ca> < CAMuHMdXfsB_Ewz9sUPZaAjFaQGTGeqMiD8mJ0tCoH1uFLYGoxw@mail.gmail.com> < CAL_JsqJVteJuaD0PRMHSR9cVcMJTSNj4wXtYiftG=-pYSR9vsQ@mail.gmail.com> < CAMuHMdWYkaLD2h=oet1w+wB+2wePmnpWWMawrBh7o=KAJym5pg@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWYkaLD2h=oet1w+wB+2wePmnpWWMawrBh7o=KAJym5pg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 21 Nov 2013 18:42:58 +0100, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Nov 21, 2013 at 6:38 PM, Rob Herring <robherring2@gmail.com> wrote:
> > I really don't like saying one arch can have built-in dtb and another
> > one can't. Either we allow it or we don't. If this is a bad feature,
> > then why did we let multiple arches implement it.
> 
> ... and did we put it in asm-generic, so now _every_ arch has __dtb_start.
> 
> Gr{oetje,eeting}s,

Some platforms need it because they either don't have bootloader
support, they couldn't change the boot interface, or they don't have a
bootwrapper they can put it in. I'd rather have it in common code than a
different implementation on each architecture.

For the copy flag, it would be fine to put an "if (IS_CONFIGURED())"
test around the copy block so that it never happens on some
architectures.

g.

> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
