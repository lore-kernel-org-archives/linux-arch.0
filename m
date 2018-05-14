From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/12] of/platform: make the OF code aware of early
 platform drivers
Date: Mon, 14 May 2018 23:32:02 +0200
Message-ID: <CAMuHMdWrOL7gN4Uxx5KipD6ZZ971LmP2yZe3XERz8jQ4TGwDCw@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-13-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-13-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank
List-Id: linux-arch.vger.kernel.org

Hi Bartosz,

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Check the relevant flag in the device node and skip the allocation
> part for devices that were populated early.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for your patch!

> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c

> @@ -196,9 +197,17 @@ static struct platform_device *of_platform_device_create_pdata(
>             of_node_test_and_set_flag(np, OF_POPULATED))
>                 return NULL;
>
> -       dev = of_device_alloc(np, bus_id, parent);
> -       if (!dev)
> -               goto err_clear_flag;
> +       if (of_node_check_flag(np, OF_POPULATED_EARLY)) {
> +               dev = of_early_to_platform_device(np);
> +               if (IS_ERR(dev))
> +                       goto err_clear_flag;
> +
> +               of_device_init(dev, np, bus_id, parent);
> +       } else {
> +               dev = of_device_alloc(np, bus_id, parent);
> +               if (!dev)
> +                       goto err_clear_flag;
> +       }

The above may become cleaner if:
  1. of_early_to_platform_device() would return NULL instead -ENOENT,
  2. of_device_alloc() would be split in alloc and init phases, too.

Then you can do:

        dev = of_node_check_flag(np, OF_POPULATED_EARLY)
                ? of_early_to_platform_device(np)
                 : __of_device_alloc(np, bus_id, parent);
        if (!dev)
                goto err_clear_flag;

        of_device_init(dev, np, bus_id, parent);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
