From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Wed, 4 Jul 2012 10:00:50 +0200
Message-ID: <CAMuHMdXzE48MCpQWjaxdrYMEwi-Cn5GR6NYrDAOAKwqiJ3m7Yg@mail.gmail.com>
References: <1341329015-28207-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1341329015-28207-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@arm.linux.org.uk>, mturquette@ti.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 3, 2012 at 5:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> --- a/include/asm-generic/Kbuild.asm
> +++ b/include/asm-generic/Kbuild.asm
> @@ -13,6 +13,10 @@ ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
>  header-y += a.out.h
>  endif
>
> +ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/clkdev.h),)
> +generic-y += clkdev.h
> +endif

Quoting Sam:
"Any use of wildcards in include/asm-generic/Kbuild.asm is bogus."

http://lkml.indiana.edu/hypermail/linux/kernel/1206.2/01507.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
