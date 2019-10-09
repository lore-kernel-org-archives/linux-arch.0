From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v15 01/14] bitops: Introduce the for_each_set_clump8 macro
Date: Wed, 9 Oct 2019 11:25:59 +0200
Message-ID: <CACRpkdbEszHr3zzVBTinVFQXU+sjOu9YbWC-554+7PYgupYJBA@mail.gmail.com>
References: <cover.1570299719.git.vilhelm.gray@gmail.com> <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be63fa49f036b9168f223152648307a63056f4ee.1570299719.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Phil Reid <preid@electromag.com.au>, Lukas Wunner <lukas@wunner.de>, Sean Nyekjaer <sean.nyekjaer@prevas.dk>, morten.tiljeset@prevas.dk, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Sat, Oct 5, 2019 at 8:37 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

As usual I am happy to merge all this but I would need
Andrew Morton's ACK, as I don't feel like a maintainer for
the bitops.

Yours,
Linus Walleij
