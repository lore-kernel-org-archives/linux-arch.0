Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33164 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeKFRi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 12:38:58 -0500
MIME-Version: 1.0
References: <20181105221117.31828-1-willy@infradead.org>
In-Reply-To: <20181105221117.31828-1-willy@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Nov 2018 09:14:44 +0100
Message-ID: <CAMuHMdU90im=GH+TrboxjH0K-cqfYmeDXromvC=ag5MjcE5-bg@mail.gmail.com>
Subject: Re: [PATCH] fls: Change parameter to unsigned int
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20181106081444.5zv1zKFQt_l6PMORMqhbhLxMHcl7m-Om6nEfIXFY4U8@z>

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
