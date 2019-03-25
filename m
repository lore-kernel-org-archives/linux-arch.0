Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbfCYNJk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Mar 2019 09:09:40 -0400
Date: Mon, 25 Mar 2019 15:09:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190325130933.GU9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093854.jzkkwaksxi7zvtrg@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190325130933.GI-LgZtGqZbqMB81l0bWOWOHBDLoCf4DMpFSQRGUhSw@z>

On Mon, Mar 25, 2019 at 10:38:54AM +0100, Lukas Wunner wrote:
> On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > +/**
> > + * find_next_clump8 - find next 8-bit clump with set bits in a memory region
> > + * @clump: location to store copy of found clump
> > + * @addr: address to base the search on
> > + * @offset: bit offset at which to start searching
> > + * @size: bitmap size in number of bits
> > + *
> > + * Returns the bit offset for the next set clump; the found clump value is
> > + * copied to the location pointed by @clump. If no bits are set, returns @size.
> > + */
> > +unsigned int find_next_clump8(unsigned long *const clump,
> > +			      const unsigned long *const addr,
> > +			      unsigned int offset, const unsigned int size)
> > +{
> > +	for (; offset < size; offset += 8) {
> > +		*clump = bitmap_get_value8(addr, size, offset);
> > +		if (!*clump)
> > +			continue;
> > +
> > +		return offset;
> > +	}
> > +
> > +	return size;
> > +}
> > +EXPORT_SYMBOL(find_next_clump8);
> 
> Just use find_first_bit() / find_next_bit() to use optimized arch-specific
> bitops instead of open-coding the iteration over the bitmap.
> 
> See max3191x_get_multiple() for an example.

Actually a good point.

-- 
With Best Regards,
Andy Shevchenko
