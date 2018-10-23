From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
Date: Tue, 23 Oct 2018 13:32:16 +0200
Message-ID: <CAMuHMdWPPr56j3z4-eamtavt7cZ2jkKyE3W5_XiK1HNim8qXBg@mail.gmail.com>
References: <20180827090651.25062-1-brgl@bgdev.pl> <20180827090651.25062-4-brgl@bgdev.pl>
 <8636swude1.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8636swude1.wl-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frow>
List-Id: linux-arch.vger.kernel.org

Hi Marc,

On Tue, Oct 23, 2018 at 1:11 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 27 Aug 2018 10:06:51 +0100,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> As for the whole "early device" debate, my take is that we'd be much
> better off making the device model available early, rather than trying
> to architect something that is simply papering over the issue.

The device model itself can be made available earlier, but the big blocker
is mainly the use of everything related to the scheduler (threads, msleep()),
which depends on the "early" timer.

I think it can be made to work if msleep() and all thread-related functions
would return -EPROBE_DEFER, but that should be handled in every
single driver, which may be already the case for thread-related functions,
but not for e.g. msleep(), which currently returns void.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
