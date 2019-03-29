Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52229 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728704AbfC2LiZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Mar 2019 07:38:25 -0400
Date: Fri, 29 Mar 2019 13:38:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v14 00/11] Introduce the for_each_set_clump8 macro
Message-ID: <20190329113819.GR9224@smile.fi.intel.com>
References: <cover.1553828158.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553828158.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de
Message-ID: <20190329113819.9rUIqChBOfa-yJ2oxPS5IwvQ0mqSOVTfOMo6pL92boc@z>

On Fri, Mar 29, 2019 at 12:03:30PM +0900, William Breathitt Gray wrote:
> Changes in v14:
>   - Redefine bitmap_get_value8, bitmap_set_value8, and find_next_clump8
>     as static inline functions
>   - Rename 'idx' variable to 'index' in the bitmap_get_value8 and
>     bitmap_set_value8 functions
>   - Remove superfluous parens in gen_74x164_set_multiple
> 

Thank you!

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> While adding GPIO get_multiple/set_multiple callback support for various
> drivers, I noticed a pattern of looping manifesting that would be useful
> standardized as a macro.
> 
> This patchset introduces the for_each_set_clump8 macro and utilizes it
> in several GPIO drivers. The for_each_set_clump macro8 facilitates a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
> 
> For example, suppose you would like to iterate over a 32-bit integer 8
> bits at a time, skipping over 8-bit groups with no set bit, where
> XXXXXXXX represents the current 8-bit group:
> 
>     Example:        10111110 00000000 11111111 00110011
>     First loop:     10111110 00000000 11111111 XXXXXXXX
>     Second loop:    10111110 00000000 XXXXXXXX 00110011
>     Third loop:     XXXXXXXX 00000000 11111111 00110011
> 
> Each iteration of the loop returns the next 8-bit group that has at
> least one set bit.
> 
> The for_each_set_clump8 macro has four parameters:
> 
>     * start: set to the bit offset of the current clump
>     * clump: set to the current clump value
>     * bits: bitmap to search within
>     * size: bitmap size in number of bits
> 
> In this version of the patchset, the for_each_set_clump macro has been
> reimplemented and simplified based on the suggestions provided by Rasmus
> Villemoes and Andy Shevchenko in the version 4 submission.
> 
> In particular, the function of the for_each_set_clump macro has been
> restricted to handle only 8-bit clumps; the drivers that use the
> for_each_set_clump macro only handle 8-bit ports so a generic
> for_each_set_clump implementation is not necessary. Thus, a solution for
> large clumps (i.e. those larger than the width of a bitmap word) can be
> postponed until a driver appears that actually requires such a generic
> for_each_set_clump implementation.
> 
> For what it's worth, a semi-generic for_each_set_clump (i.e. for clumps
> smaller than the width of a bitmap word) can be implemented by simply
> replacing the hardcoded '8' and '0xFF' instances with respective
> variables. I have not yet had a need for such an implementation, and
> since it falls short of a true generic for_each_set_clump function, I
> have decided to forgo such an implementation for now.
> 
> In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
> introduced to get and set 8-bit values respectively. Their use is based
> on the behavior suggested in the patchset version 4 review.
> 
> William Breathitt Gray (11):
>   bitops: Introduce the for_each_set_clump8 macro
>   lib/test_bitmap.c: Add for_each_set_clump8 test cases
>   gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
>   gpio: 104-idi-48: Utilize for_each_set_clump8 macro
>   gpio: gpio-mm: Utilize for_each_set_clump8 macro
>   gpio: ws16c48: Utilize for_each_set_clump8 macro
>   gpio: pci-idio-16: Utilize for_each_set_clump8 macro
>   gpio: pcie-idio-24: Utilize for_each_set_clump8 macro
>   gpio: uniphier: Utilize for_each_set_clump8 macro
>   gpio: 74x164: Utilize the for_each_set_clump8 macro
>   thermal: intel: intel_soc_dts_iosf: Utilize for_each_set_clump8 macro
> 
>  drivers/gpio/gpio-104-dio-48e.c            |  73 ++++----------
>  drivers/gpio/gpio-104-idi-48.c             |  36 ++-----
>  drivers/gpio/gpio-74x164.c                 |  19 ++--
>  drivers/gpio/gpio-gpio-mm.c                |  73 ++++----------
>  drivers/gpio/gpio-pci-idio-16.c            |  75 +++++---------
>  drivers/gpio/gpio-pcie-idio-24.c           | 109 ++++++++-------------
>  drivers/gpio/gpio-uniphier.c               |  16 ++-
>  drivers/gpio/gpio-ws16c48.c                |  73 ++++----------
>  drivers/thermal/intel/intel_soc_dts_iosf.c |  29 +++---
>  drivers/thermal/intel/intel_soc_dts_iosf.h |   2 -
>  include/asm-generic/bitops/find.h          |  61 ++++++++++++
>  include/linux/bitops.h                     |   5 +
>  lib/test_bitmap.c                          |  65 ++++++++++++
>  13 files changed, 299 insertions(+), 337 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko
