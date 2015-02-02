From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Add ARCH_MIGHT_HAVE_VGA_CONSOLE
Date: Mon, 2 Feb 2015 09:10:06 +0100
Message-ID: <CAMuHMdV8hyDWwz8V5rvrthcV8NyNk4J+9Opmxt3opqi5rtQoJw@mail.gmail.com>
References: <877fw093oa.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32938 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932677AbbBBIKH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 03:10:07 -0500
In-Reply-To: <877fw093oa.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Sato-san,


On Mon, Feb 2, 2015 at 8:24 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> The dependence of VGA_CONSOLE is complicated.
> We need clean up.

Thanks!

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>
> ---
>  arch/alpha/Kconfig            | 1 +
>  arch/arc/Kconfig              | 1 +
>  arch/arm/Kconfig              | 1 +
>  arch/c6x/Kconfig              | 1 +
>  arch/hexagon/Kconfig          | 1 +
>  arch/ia64/Kconfig             | 1 +
>  arch/m32r/Kconfig             | 1 +
>  arch/metag/Kconfig            | 1 +
>  arch/microblaze/Kconfig       | 1 +
>  arch/mips/Kconfig             | 1 +
>  arch/nios2/Kconfig            | 1 +
>  arch/openrisc/Kconfig         | 1 +
>  arch/powerpc/Kconfig          | 1 +
>  arch/s390/Kconfig             | 1 +
>  arch/score/Kconfig            | 1 +
>  arch/tile/Kconfig             | 1 +
>  arch/um/Kconfig.common        | 1 +
>  arch/unicore32/Kconfig        | 1 +
>  arch/x86/Kconfig              | 1 +
>  arch/xtensa/Kconfig           | 1 +

While I know you just kept the existing logic from
drivers/video/console/kconfig,
I doubt all of the architectures listed above do support VGA.
I guest most of them were just too lazy to update the dependency list.

I think only alpha, arm, ia64, mips, powerpc, and x86 can have VGA.

> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/rconfig
> @@ -2,14 +2,14 @@
>  # Video configuration
>  #
>
> +config ARCH_MIGHT_HAVE_VGA_CONSOLE
> +        bool
> +
>  menu "Console display driver support"
>
>  config VGA_CONSOLE
>         bool "VGA text console" if EXPERT || !X86
> -       depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
> -               !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
> -               (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -               !ARM64
> +       depends on ARCH_MIGHT_HAVE_VGA_CONSOLE
>         default y
>         help
>           Saying Y here will allow you to use Linux in text mode through a

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
