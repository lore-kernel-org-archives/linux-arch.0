From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/16] drivers: Add h8300
Date: Wed, 21 Jan 2015 12:03:46 +0100
Message-ID: <CAMuHMdWc7QfLKx4GvQw1tQkcmHyu1ryUtwPuumpGQcQKncEqCA@mail.gmail.com>
References: <cover.1421813622.git.ysato@users.sourceforge.jp>
	<87r3uovjv0.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:46697 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbbAULDr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 06:03:47 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so39434512lab.11
        for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2015 03:03:46 -0800 (PST)
In-Reply-To: <87r3uovjv0.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Jan 21, 2015 at 5:27 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -9,7 +9,7 @@ config VGA_CONSOLE
>         depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && \
>                 !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
>                 (!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
> -               !ARM64
> +               !ARM64 && !H8300

We desperately need ARCH_MIGHT_HAVE_VGA_CONSOLE, to be
selected by architectures that need it.

Yes, the onus is on the submitter who (re)introduces a new anti-dependency ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
