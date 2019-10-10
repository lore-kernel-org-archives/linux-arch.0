From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v18 01/14] bitops: Introduce the for_each_set_clump8 macro
Date: Thu, 10 Oct 2019 16:18:42 +0300
Message-ID: <20191010131842.GT32742@smile.fi.intel.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
 <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570641097.git.vilhelm.gray@gmail.com>
 <20191009141855.310f1fa8bde58df0df27b8f0@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191009141855.310f1fa8bde58df0df27b8f0@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 09, 2019 at 02:18:55PM -0700, Andrew Morton wrote:
> On Wed,  9 Oct 2019 13:14:37 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> > 
> > ...
> >  
> > +#define for_each_set_clump8(start, clump, bits, size) \
> > +	for ((start) = find_first_clump8(&(clump), (bits), (size)); \
> > +	     (start) < (size); \
> > +	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
> > +
> 
> It wouldn't hurt to give this some documentation.  In kerneldoc form, I
> guess.

Good idea!

William, I have just tested your series with a complex hardware setup,
everything works to me.

I think I may give

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for this patch as well.

-- 
With Best Regards,
Andy Shevchenko
