From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Date: Wed, 27 Mar 2019 07:42:54 +0100
Message-ID: <20190327064254.lwj7ew37mxphieco@wunner.de>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

I would have preferred static inlines for bitmap_get_value8(),
bitmap_set_value8() and find_next_clump8() to make this as fast
as possible in the callers because I've personally worked with
an industrial application where the GPIO pins of a 74x164 are
written every 250 usec.

But apart from that I like this series a lot, thanks for working on it.

Lukas
