Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34189 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeENVYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 17:24:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180511162028.20616-3-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-3-brgl@bgdev.pl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 23:24:39 +0200
Message-ID: <CAMuHMdWpJeJSzQKy2JqJ_g4oQb9HsqV-xEcsPqhgM5y3Ytin7Q@mail.gmail.com>
Subject: Re: [PATCH 02/12] platform/early: don't WARN() on non-empty devres
 list for early devices
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Message-ID: <20180514212439.onvf1qO0CH0ncAP5BsS4qVH_qZ5OCngEut2680L2ZVo@z>

On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Early platform devices can have devres objects allocated in
> early_probe(). This is not a bug so don't dump stack in this case.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
