Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLBBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2019 21:01:16 -0400
Date: Mon, 11 Mar 2019 18:01:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190311180113.c283fdbcba3df10db2c815aa@linux-foundation.org>
In-Reply-To: <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
        <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
        <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190312010113.dnfVJpTb1cwzcJDv0_wUntNOqcBzuM_HRe4M6HbBSmc@z>

On Fri, 8 Mar 2019 09:31:00 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Mar 3, 2019 at 8:47 AM William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> 
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> Andrew: would you be OK with this being merged in v5.1?

Yup.  We have quite a few users there.  I assume this will go via the
gpio tree?

Feel free to add Acked-by: Andrew Morton <akpm@linux-foundation.org>,
although it probably isn't worth churning the git tree to do so at this
late stage - your cvall.
