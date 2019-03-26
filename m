Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:41688 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZLm6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 07:42:58 -0400
Date: Tue, 26 Mar 2019 13:42:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190326114252.GX9224@smile.fi.intel.com>
References: <cover.1553494625.git.vilhelm.gray@gmail.com>
 <9afc30a574ce3e6a86b51dd522146a1d2156dedd.1553494625.git.vilhelm.gray@gmail.com>
 <20190325131236.GW9224@smile.fi.intel.com>
 <20190326025459.GA3356@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326025459.GA3356@icarus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190326114252.OK3ALIhXA5ew66p476Yr-KmZ5xtkgNu6Hn5flZTsLxE@z>

On Tue, Mar 26, 2019 at 11:54:59AM +0900, William Breathitt Gray wrote:
> On Mon, Mar 25, 2019 at 03:12:36PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2019 at 03:22:23PM +0900, William Breathitt Gray wrote:
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
> > 
> > 
> > This seems to miss Randy's (IIRC) comment about too many const specifiers.
> 
> I disagree with removing the const qualifiers; I believe they are useful
> and do not significantly impact the clarity of the code (in fact, I'd
> argue the opposite). 

Had you checked the assembly? I'm talking about const for values on the stack.

I think if you put less const there compiler can keep something in the
registers instead of using direct constants or accessing stack.

I might be mistaken, so, I can't argue without evidence of either.

> The const qualifiers make it clear these values are
> constant, allowing readers at a glace to know these values never change
> within this function. Although I believe GCC is smart enough in this
> case to deduce implicitly that these are constant values, generally
> speaking const qualifiers do make it easier for compilers to optimize
> sections of code (OoO execution, algorithm simplification, etc.), so I
> believe it's useful in a technical sense as well.

Again, what the difference do you see in assembly if any?

> I added the const qualifier to these variables because they really are
> constant, and I believe there is merit in making it explicit in the
> code. If the primary reason for removing the const qualifiers is for
> aesthetics, then I must dissent with that decision.

The point is, if there is no difference, I would prefer one which will be
better to read, otherwise check the assembly.

> However, it is difficult to read the definitions that wrap around to a
> second line. These definitions are long enough that even removing the
> const qualifiers would not help prevent the wrapping, so perhaps it
> would make to let these stay on a single line. Do you think it would
> help to ignore the 80-character maximum line width coding style rule for
> these cases here?

80-characters rule can be slightly bended depending on the context. Here, I
think, we might continue discussing the matter after having an evidence how
const qualifiers affect the code.

-- 
With Best Regards,
Andy Shevchenko
