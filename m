From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/28] nios2: Memory management
Date: Wed, 23 Apr 2014 09:24:49 +0200
Message-ID: <CAMuHMdU2qmCeFWLGt9G8U0Pm_bP3WwV2qY6aJa0VQ=+aFFKSBg@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-5-git-send-email-lftan@altera.com>
	<20140422142443.GB15745@arch.cereza>
	<20140422151458.GC1053@distanz.ch>
	<20140422153522.GF15745@arch.cereza>
	<20140422162432.GA17674@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140422162432.GA17674@ravnborg.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tobias Klauser <tklauser@distanz.ch>, Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, LeyFoon Tan <lftan.linux@gmail.com>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Hi Sam,

On Tue, Apr 22, 2014 at 6:24 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> #define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
> #define PAGE_MASK    (~(PAGE_SIZE-1))
>
> _AC(1, UL) expands to 1 for assembler and 1UL for C code.

Ideally, PAGE_SIZE should be size_t, not unsigned long, avoiding issues
like https://lkml.org/lkml/2014/4/13/78. But currently it's unsigned long
everywhere, so nios2 should be consistent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
