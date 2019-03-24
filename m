From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v10 00/10] Introduce the for_each_set_clump8 macro
Date: Sun, 24 Mar 2019 09:53:59 +0100
Message-ID: <CAMuHMdUbXFRZZeE0gT-qhpps4SmHz4N5i_6329cz_vfCPBLtTw@mail.gmail.com>
References: <cover.1552566113.git.vilhelm.gray@gmail.com> <20190322191202.GC9224@smile.fi.intel.com>
 <20190324040704.GA8285@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324040704.GA8285@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Phil Reid <preid@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Mar 24, 2019 at 5:07 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Fri, Mar 22, 2019 at 09:12:02PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 14, 2019 at 09:29:32PM +0900, William Breathitt Gray wrote:
> > > Changes in v10:
> > >   - Fix off-by-one error in bitmap initialization in the
> > >     test_for_each_set_clump8 function
> > >   - Fix typos in clump_exp array definition in test_bitmap.c ("0x28"
> > >     should have been "0x38")
> > >   - Utilize for_each_set_clump8 macro in intel_soc_dts_iosf.c
> >
> > One more, can you look at gen_74x164_set_multiple() ? It seems a candidate as
> > well, if I'm not mistaken.
>
> We can utilize the for_each_set_clump8 macro in the
> gen_74x164_set_multiple function, but I skipped over it earlier since I
> noticed it used the BITS_PER_BYTE define rather than a hardcoded 8. If
> it always loops 8 bits at a time, then we can use the
> for_each_set_clump8 macro; otherwise we would need the more generic
> for_each_set_clump macro to handle the non-8-bit looping cases.
>
> Will BITS_PER_BYTE always be defined as 8 bits?

Yes, Linux cannot run on platforms where BITS_PER_BYTE != 8
(no 9-bit bytes ;)

include/linux/bits.h:#define BITS_PER_BYTE              8

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
