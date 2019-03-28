Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfC1EjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2019 00:39:07 -0400
Date: Thu, 28 Mar 2019 13:40:04 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v13 10/11] gpio: 74x164: Utilize the for_each_set_clump8
 macro
Message-ID: <20190328044004.GB3251@icarus>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <645f16f1d1ad3f215e34a82f457e06725fcf8f56.1553661964.git.vilhelm.gray@gmail.com>
 <20190327123314.GJ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327123314.GJ9224@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20190328044004.WW_5ueRW_Ks2tTdeFalIMMQefBTwLMextBgvqnCqRNc@z>

On Wed, Mar 27, 2019 at 02:33:14PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 27, 2019 at 02:02:39PM +0900, William Breathitt Gray wrote:
> > Replace verbose implementation in set_multiple callback with
> > for_each_set_clump8 macro to simplify code and improve clarity.
> 
> > +	for_each_set_clump8(offset, bankmask, mask, chip->registers * 8) {
> 
> > +		bank = (chip->registers - 1) - (offset / 8);
> 
> Excessive parens, but it's minor.

Fair point, this could do without parens around (chip->registers - 1).

Since this and renaming 'idx' to 'index' in find_bit.c are such a minor
changes, I'll wait first to see if something else comes up to be fixed
in this review. If so, I'll add these changes to the next version of
this patchset.

William Breathitt Gray

> 
> > +		bitmask = bitmap_get_value8(bits, offset) & bankmask;
> >  
> >  		chip->buffer[bank] &= ~bankmask;
> > +		chip->buffer[bank] |= bitmask;
> >  	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
