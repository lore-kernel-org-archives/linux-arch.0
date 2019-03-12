From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Date: Tue, 12 Mar 2019 09:14:14 +0200
Message-ID: <CAHp75Veic69S5uG2VQxYT4L0WHp2H+SwiyJgHhQN_Lk8Atr55g@mail.gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com> <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CAK7LNATW7uKB2-wMytLSpb8dPLkWbirptCgU=LAq3PYRtgOuXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATW7uKB2-wMytLSpb8dPLkWbirptCgU=LAq3PYRtgOuXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 12, 2019 at 7:04 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Mar 3, 2019 at 4:48 PM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> >
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.

> > +/**
> > + * bitmap_get_value8 - get an 8-bit value within a memory region
> > + * @bitmap: address to the bitmap memory region
> > + * @size: bitmap size in number of bits
> > + * @start: bit offset of the 8-bit value
> > + *
> > + * Returns the 8-bit value located at the @start bit offset within the @bitmap
> > + * memory region.
> > + */
> > +unsigned long bitmap_get_value8(const unsigned long *const bitmap,
> > +                               const unsigned int size,
> > +                               const unsigned int start)
>
>
> The comment says this function returns '8-bit value'.
>
> The return type should be 'u8' instead of 'unsigned long', then.
>
> Same for other helpers.

This is done in a way to be consistent with the rest of bitmap API.
None of them returns boolean, for example, for single bit.

-- 
With Best Regards,
Andy Shevchenko
