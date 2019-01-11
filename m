Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44311 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfAKIm7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2019 03:42:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so12177191lji.11
        for <linux-arch@vger.kernel.org>; Fri, 11 Jan 2019 00:42:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545198260.git.vilhelm.gray@gmail.com> <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
In-Reply-To: <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jan 2019 09:42:46 +0100
Message-ID: <CACRpkdaL3LY6esgBfpJcox7AzQ8RoreqV0_gzM-AmQ_mYQHueQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] bitops: Introduce the for_each_set_clump8 macro
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <20190111084246.hrr59NBbEB-HXGq39Vh0Wvw_mk_o_KsbCUPudi-KheI@z>

On Wed, Dec 19, 2018 at 7:00 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

I am still waiting for feedback from the core lib maintainers on this patch.
If I just get an ACK I can apply it to the GPIO tree, if noone else cares
I might just go in and apply it, but it feels slightly outside of my
jurisdiction.

Maybe people were just a bit stressed out around christmas?

What about looking at it now?

Yours,
Linus Walleij
