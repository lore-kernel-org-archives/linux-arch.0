From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fls: Change parameter to unsigned int
Date: Tue, 6 Nov 2018 09:14:44 +0100
Message-ID: <CAMuHMdU90im=GH+TrboxjH0K-cqfYmeDXromvC=ag5MjcE5-bg@mail.gmail.com>
References: <20181105221117.31828-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105221117.31828-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 5, 2018 at 11:11 PM Matthew Wilcox <willy@infradead.org> wrote:
> When testing in userspace, UBSAN pointed out that shifting into the sign
> bit is undefined behaviour.  It doesn't really make sense to ask for the
> highest set bit of a negative value, so just turn the argument type into
> an unsigned int.
>
> Some architectures (eg ppc) already had it declared as an unsigned int,
> so I don't expect too many problems.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
