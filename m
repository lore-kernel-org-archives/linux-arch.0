Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932212AbeENNhr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 09:37:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180511162028.20616-11-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-11-brgl@bgdev.pl>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 14 May 2018 08:37:24 -0500
Message-ID: <CAL_JsqJw8UXktcLK8ADUfo1P+1un+omJ31sGcq7GFbNwJMsHKg@mail.gmail.com>
Subject: Re: [PATCH 10/12] platform/early: implement support for early
 platform drivers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Message-ID: <20180514133724.24mYa_GHi4AYYvTckL0k3Be2Al3CNPU6gJdN8WzAMuo@z>

On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This introduces the core part of support for early platform drivers
> and devices.
>

It looks like most of your prep patches are to separate the alloc and
init of platform devices because you are essentially making early
devices/drivers a sub-class. Maybe you could avoid doing that and
simplify things a bit. Comments below based on doing that...

> +/**
> + * struct early_platform_driver
> + *
> + * @pdrv: real platform driver associated with this early platform driver
> + * @list: list head for the list of early platform drivers
> + * @early_probe: early probe callback
> + */
> +struct early_platform_driver {
> +       struct platform_driver pdrv;
> +       struct list_head list;

Couldn't you use an existing list in driver_private until you move
over to the normal bus infra.

> +       int (*early_probe)(struct platform_device *);

Just add this to platform_driver.

> +};
> +
> +/**
> + * struct early_platform_device
> + *
> + * @pdev: real platform device associated with this early platform device
> + * @list: list head for the list of early platform devices
> + * @deferred: true if this device's early probe was deferred
> + * @deferred_drv: early platform driver with which this device was matched
> + */
> +struct early_platform_device {
> +       struct platform_device pdev;
> +       struct list_head list;

Use a list in device_private?

> +       bool deferred;
> +       struct early_platform_driver *deferred_drv;

Can't you use the existing deferred probe list?

Rob
