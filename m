From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
Date: Thu, 9 Jul 2020 11:13:31 -0700
Message-ID: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
References: <20200621054210.14804-1-rikard.falkeborn@gmail.com> <20200709123011.GA18734@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgGISNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 14:13:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304F8C08C5CE
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 11:13:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so3455373ljn.8
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 11:13:51 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b16sm1032215ljp.124.2020.07.09.11.13.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:13:48 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id m26so1691983lfo.13
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 11:13:47 -0700 (PDT)
In-Reply-To: <20200709123011.GA18734@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Emil Velikov <emil.l.velikov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, Syed Nayyar Waris <syednwaris@gmail.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Thu, Jul 9, 2020 at 5:30 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I'm still getting the same warning even with the patch, for example:

Are you building with W=1?

There's a patch to move that broken -Wtype-limits thing to W=2.

    https://lore.kernel.org/lkml/20200708190756.16810-1-rikard.falkeborn@gmail.com/

does that work for you?

              Linus
