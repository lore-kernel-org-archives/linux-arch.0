Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6500 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfCZJxS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 05:53:18 -0400
Date: Tue, 26 Mar 2019 11:53:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326095312.GR9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326095312.1nUHn_5KLwWf4heUUG2M94K-5t9OOFRyh9XGQA3EdOY@z>

On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:
> > On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:

> > Is this the sort of implementation you had in mind:
> > 
> >         offset = find_next_bit(addr, size, offset);
> >         if (offset == size)
> >                 return size;
> > 
> >         offset -= offset % 8;
> >         *clump = bitmap_get_value8(addr, size, offset);
> > 
> >         return offset;
> 
> Almost.  I'd use round_down() instead of "offset -= offset % 8".
> Then it's just a single cheap logical and operation at runtime.

> I'd try to avoid copying around the clump value and use a pointer
> to u8 instead.

u8 might be inconvenient in environment where everything else is type of
unsigned long.

-- 
With Best Regards,
Andy Shevchenko
