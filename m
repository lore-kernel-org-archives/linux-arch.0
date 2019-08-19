From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] kbuild: add CONFIG_ASM_MODVERSIONS
Date: Mon, 19 Aug 2019 11:13:11 +0200
Message-ID: <CAMuHMdVpn01Tcjm1Z3Jp--kiNYf4R5=AyH-huc26RwP19w9OZQ@mail.gmail.com>
References: <20190819055421.13482-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819055421.13482-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
