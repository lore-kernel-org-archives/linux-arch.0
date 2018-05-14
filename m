Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40326 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeENV3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 17:29:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180511162028.20616-10-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-10-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 23:29:53 +0200
Message-ID: <CAMuHMdUnG0YLg=HXMrUVJ34sZEDuuZRYxnrPPC45-KpAkO3bcw@mail.gmail.com>
Subject: Re: [PATCH 09/12] platform/early: add an init section for early
 driver data
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Message-ID: <20180514212953.o98CFivY7XNy4rQLs_BJC5RuO8L3sSVdahx3eLl_FKI@z>

Hi Bartosz,

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Provide a separate section in which pointers to early platform driver
> structs will be stored.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for your patch!

> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -214,6 +214,16 @@
>  #define CPU_METHOD_OF_TABLES() OF_TABLE(CONFIG_SMP, cpu_method)
>  #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
>
> +#ifdef CONFIG_EARLY_PLATFORM
> +#define EARLY_PLATFORM_DRIVERS_TABLE()                                 \
> +       . = ALIGN(8);                                                   \

Should this use STRUCT_ALIGN() instead?

> +       VMLINUX_SYMBOL(__early_platform_drivers_table) = .;             \
> +       KEEP(*(__early_platform_drivers_table))                         \
> +       VMLINUX_SYMBOL(__early_platform_drivers_table_end) = .;
> +#else
> +#define EARLY_PLATFORM_DRIVERS_TABLE()
> +#endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
