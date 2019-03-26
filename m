Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:20074 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZNTB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 09:19:01 -0400
Date: Tue, 26 Mar 2019 15:18:54 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326131854.GA9224@smile.fi.intel.com>
References: <20190326102843.GA10264@icarus>
 <20190326100743.GA10005@icarus>
 <20190326130319.cwn5zl4e222zh6ak@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326130319.cwn5zl4e222zh6ak@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326131854.Ts4VEo6bQw384t37Q-OE7Fa8O6V4DLq35wO3N5dUinQ@z>

On Tue, Mar 26, 2019 at 02:03:19PM +0100, Lukas Wunner wrote:
> On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> > On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:

> > In this case, bitmap_get_value8 could be simplified to something like
> > this:
> > 
> >         index = BIT_WORD(start);
> >         offset = start % BITS_PER_LONG;
> >         return (bitmap[index] >> offset) & 0xFF;
> 

> Hm, shouldn't that be "offset = round_down(start, 8)" ?

No, the index points to the word, the offset points to the offset inside word.

> (I prefer the multi-line version FWIW.)

+1 here.

> > Would it be better to define bitmap_get_value8 as a macro then?
> 
> Or a static inline.

Please, no macro. It disadvantages in terms of type checking. 

-- 
With Best Regards,
Andy Shevchenko
