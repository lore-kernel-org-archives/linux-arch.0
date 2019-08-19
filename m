Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34290 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHSJNX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 05:13:23 -0400
MIME-Version: 1.0
References: <20190819055421.13482-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190819055421.13482-1-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 11:13:11 +0200
Message-ID: <CAMuHMdVpn01Tcjm1Z3Jp--kiNYf4R5=AyH-huc26RwP19w9OZQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add CONFIG_ASM_MODVERSIONS
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190819091311.Wvng2V4RXGQSpTrI7Zbtaw6ZkVe_tB_Hd4Kd_WSx-yE@z>

On Mon, Aug 19, 2019 at 7:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Add CONFIG_ASM_MODVERSIONS to remove one if-conditional nesting
> from Makefile.build
>
> This also avoid $(wildcard ...) evaluation for every descending,
> but I did not see measurable performance improvement.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  arch/m68k/Kconfig      | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
