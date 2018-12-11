From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 21/27] treewide: surround file paths in Kconfig files with
 double quotes
Date: Tue, 11 Dec 2018 12:25:59 +0100
Message-ID: <CAMuHMdUcyzoMkiu-XaD5hM3uxhh+G3wMWWkVrFRNBkv5GbDGmA@mail.gmail.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com> <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544526070-16690-22-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Ulf Magnusson <ulfalizer@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 11, 2018 at 12:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The Kconfig lexer supports special characters such as '.' and '/' in
> the parameter context. In my understanding, the reason is just to
> support bare file paths in the source statement.
>
> I do not see a good reason to complicate Kconfig for the room of
> ambiguity.
>
> The majority of code already surround file paths with double quotes,
> and it makes sense since the included file paths are constant string
> literals.
>
> Make it treewide consistent now.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

>  arch/m68k/Kconfig            |  6 +++---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
