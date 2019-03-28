Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34150 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1E32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2019 00:29:28 -0400
Date: Thu, 28 Mar 2019 13:30:13 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190328043013.GA3251@icarus>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
 <20190327064254.lwj7ew37mxphieco@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327064254.lwj7ew37mxphieco@wunner.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190328043013.KBfxDGGPBb2k26ps6UU6i8mFFbhDVTeo3vSX0hU4EKU@z>

On Wed, Mar 27, 2019 at 07:42:54AM +0100, Lukas Wunner wrote:
> On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> 
> I would have preferred static inlines for bitmap_get_value8(),
> bitmap_set_value8() and find_next_clump8() to make this as fast
> as possible in the callers because I've personally worked with
> an industrial application where the GPIO pins of a 74x164 are
> written every 250 usec.
> 
> But apart from that I like this series a lot, thanks for working on it.
> 
> Lukas

I'm not sure these can be static inline since the symbols are exported
for use outside this file. However, in theory I have no objection from a
performance standpoint. Since my devices don't have such strict realtime
requirements as your 74x164 application, I'll defer this decision to
someone more knowledgeable in this area; perhaps someone else can
comment in this thread with their advice and suggestions.

William Breathitt Gray
