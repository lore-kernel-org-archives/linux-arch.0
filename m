From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add ARCH_MIGHT_HAVE_VGA_CONSOLE
Date: Mon, 2 Feb 2015 22:07:50 +0100
Message-ID: <CAMuHMdWLJ=D1=Tw6CtXU6ke5+2NGZ+BchfZXTaDOzwrca-S9Hw@mail.gmail.com>
References: <877fw093oa.wl-ysato@users.sourceforge.jp>
	<CAMuHMdV8hyDWwz8V5rvrthcV8NyNk4J+9Opmxt3opqi5rtQoJw@mail.gmail.com>
	<87pp9s48mz.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87pp9s48mz.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Sato-san,

Your second version looks fine to me, except for this part:

On Mon, Feb 2, 2015 at 4:48 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- a/arch/um/Kconfig.common
> +++ b/arch/um/Kconfig.common
> @@ -9,6 +9,7 @@ config UML
>         select GENERIC_IO
>         select GENERIC_CLOCKEVENTS
>         select TTY # Needed for line.c
> +       select ARCH_MIGHT_HAVE_VGA_CONSOLE
>
>  config MMU
>         bool

UML definitely doesn't have VGA support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
