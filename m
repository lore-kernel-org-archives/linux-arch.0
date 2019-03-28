Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:40361 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfC1Hax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2019 03:30:53 -0400
Date: Thu, 28 Mar 2019 08:30:49 +0100
From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190328073049.jpizz6uio7er2sjv@wunner.de>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
 <20190327064254.lwj7ew37mxphieco@wunner.de>
 <20190328043013.GA3251@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328043013.GA3251@icarus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190328073049.qQLF-HIKHzmjfXi0SxV3BVsSVVMwgqUm-4rz_hDkPA4@z>

On Thu, Mar 28, 2019 at 01:30:13PM +0900, William Breathitt Gray wrote:
> On Wed, Mar 27, 2019 at 07:42:54AM +0100, Lukas Wunner wrote:
> > On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > within a bitmap memory region. For each iteration, "start" is set to the
> > > bit offset of the found clump, while the respective clump value is
> > > stored to the location pointed by "clump". Additionally, the
> > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > respectively get and set an 8-bit value in a bitmap memory region.
> > 
> > I would have preferred static inlines for bitmap_get_value8(),
> > bitmap_set_value8() and find_next_clump8() to make this as fast
> > as possible in the callers because I've personally worked with
> > an industrial application where the GPIO pins of a 74x164 are
> > written every 250 usec.
> 
> I'm not sure these can be static inline since the symbols are exported
> for use outside this file.

By static inlines I meant that the functions are moved to the appropriate
header file in include/linux/.  You don't need to worry about exporting
in that case as the code is local to each module.  For smallish functions
like these, static inlines are usually fine.  See drivers/dma/virt-dma.h
for an extreme case of static inlines (as compared to the much smaller
virt-dma.c).

Thanks,

Lukas
