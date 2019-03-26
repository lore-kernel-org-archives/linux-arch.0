Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:55096 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZK15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Mar 2019 06:27:57 -0400
Date: Tue, 26 Mar 2019 19:28:43 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326102843.GA10264@icarus>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
 <20190326031422.GB3356@icarus>
 <20190326094345.v7l7xjvfs2scbvbv@wunner.de>
 <20190326100743.GA10005@icarus>
 <20190326101933.GW9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326101933.GW9224@smile.fi.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326102843.XkOTEVVAeMF0jhW5GCffglj3H_YT7SiLMBUZicWiYyo@z>

On Tue, Mar 26, 2019 at 12:19:33PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 07:08:18PM +0900, William Breathitt Gray wrote:
> > On Tue, Mar 26, 2019 at 10:43:45AM +0100, Lukas Wunner wrote:
> > > On Tue, Mar 26, 2019 at 12:14:22PM +0900, William Breathitt Gray wrote:
> 
> > > Why is it so complicated, does it allow passing in a start value
> > > that's not a multiple of 8?  Do you really need that?  I imagine
> > > a simplification is possible if that assumption can be made (and
> > > is spelled out in the kerneldoc).
> > 
> > That's a good point. Originally, I had envisioned the possibility of
> > calling bitmap_get_value8/bitmap_set_value8 at odd start offsets; this
> > would open up the possibility of a clump landing as a split between 2
> > words, thus requiring this complicated case handling code. However, I'm
> > not sure how often users would need this case; none of the drivers right
> > now require clumps at odd offsets.
> > 
> > Andy, would you have any objection to restricting the start offset
> > values for bitmap_get_value8/bitmap_set_value8 to multiples of 8? That
> > would prevent the split word case, and thus allow the implementation for
> > those functions to be a lot simpler.
> 
> No, I have no objection.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

In this case, bitmap_get_value8 could be simplified to something like
this:

        index = BIT_WORD(start);
        offset = start % BITS_PER_LONG;
        return (bitmap[index] >> offset) & 0xFF;

Or if you prefer a single line:

        (bitmap[BIT_WORD(start)] >> (start % BITS_PER_LONG)) & 0xFF;

Would it be better to define bitmap_get_value8 as a macro then?

William Breathitt Gray
