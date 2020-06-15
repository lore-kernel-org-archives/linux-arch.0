From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH v3 1/2] linux/bits.h: fix unsigned less than zero warnings
Date: Mon, 15 Jun 2020 20:52:36 +0100
Message-ID: <CACvgo51nGOeCtsCRaUuRGuFvV_EpHqWSph9AeA66Su2-_Fyy-A@mail.gmail.com>
References: <20200608184222.GA899@rikard> <20200608221823.35799-1-rikard.falkeborn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgFOT4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 15:56:17 -0400
In-Reply-To: <20200608221823.35799-1-rikard.falkeborn@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arch@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, lkp@intel.com, syednwaris@gmail.com, vilhelm.gray@gmail.com, Masahiro Yamada <yamada.masahiro@socionext.com>

Hi Rikard,

On Mon, 8 Jun 2020 at 23:18, Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> When calling the GENMASK and GENMASK_ULL macros with zero lower bit and
> an unsigned unknown high bit, some gcc versions warn due to the
> comparisons of the high and low bit in GENMASK_INPUT_CHECK.
>
> To silence the warnings, only perform the check if both inputs are
> known. This does not trigger any warnings, from the Wtype-limits help:
>
>         Warn if a comparison is always true or always false due to the
>         limited range of the data type, but do not warn for constant
>         expressions.
>
> As an example of the warning, kindly reported by the kbuild test robot:
>
> from drivers/mfd/atmel-smc.c:11:
> drivers/mfd/atmel-smc.c: In function 'atmel_smc_cs_encode_ncycles':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> |                            ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
> >> drivers/mfd/atmel-smc.c:49:25: note: in expansion of macro 'GENMASK'
> 49 |  unsigned int lsbmask = GENMASK(msbpos - 1, 0);
> |                         ^~~~~~~
>
> Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Emil Velikov <emil.l.velikov@gmail.com>
> Reported-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

This version is far better than my approach. Fwiw:

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Thanks
Emil
