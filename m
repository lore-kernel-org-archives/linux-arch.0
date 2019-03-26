Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35371 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZNDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Mar 2019 09:03:22 -0400
Date: Tue, 26 Mar 2019 14:03:19 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326130319.cwn5zl4e222zh6ak@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326102843.GA10264@icarus>
 <20190326100743.GA10005@icarus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326130319.2iHLlGylaBxyGk1MZQuv9tcW6scY7n7fd6efCGPxVMA@z>

On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> > I'd try to avoid copying around the clump value and use a pointer
> > to u8 instead.
> 
> Although in this case we are handling 8-bit clumps, I anticipate device
> drivers in the future which may benefit from larger size clumps (e.g.
> GPIO devices with 24-bit ports). It'll be better to define clumps
> similar to how we're defining bitmaps now (unsigned long *) so that we
> can support these sizes if need be in the future without requiring data
> type changes.

It's just that copying around data in memory may be more expensive
than, say, returning from a function, in which case it's usually
stored in a register.


> In this case, bitmap_get_value8 could be simplified to something like
> this:
> 
>         index = BIT_WORD(start);
>         offset = start % BITS_PER_LONG;
>         return (bitmap[index] >> offset) & 0xFF;

Hm, shouldn't that be "offset = round_down(start, 8)" ?

(I prefer the multi-line version FWIW.)


> Would it be better to define bitmap_get_value8 as a macro then?

Or a static inline.

Thanks,

Lukas
