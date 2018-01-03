Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37141 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeACIni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 03:43:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180103013516.18844-4-sboyd@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org> <20180103013516.18844-4-sboyd@codeaurora.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Jan 2018 09:43:37 +0100
Message-ID: <CAMuHMdX7m8Wx994pfJpsg-CR_O+uORLMfU0PuvQsSDt=L+3yQQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] arch: Remove clkdev.h asm-generic from Kbuild
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20180103084337.ixAdedeNa7IfZkpfUxsCbbKQJWQzFvds2sWUKIeJazo@z>

On Wed, Jan 3, 2018 at 2:35 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Now that every architecture is using the generic clkdev.h file
> and we no longer include asm/clkdev.h anywhere in the tree, we
> can remove it.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

For m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
