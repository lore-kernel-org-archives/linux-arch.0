From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Date: Thu, 31 May 2018 07:16:45 -0700
Message-ID: <20180531141645.GM5705@atomide.com>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
 <20180530194032.982.41562@harbor.lan>
 <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
 <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUY+-_72DHg9Tim2d4E24k5KskQxm52bHSyrSYLbZDr2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Frank Rowand <frowand.list@gmail.com>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jiri Slaby <jslaby@suse.com>, devicetree <devicetree@vger.kernel.org>, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Johan Hovold <johan@kerne>
List-Id: linux-arch.vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [180531 06:45]:
> Yes, they should all be drivers.
> 
> Assuming clocksources, clockevents, or primary interrupt controllers are
> special, and thus forcing everyone to use OF_DECLARE for the whole
> subsystem, doesn't fly everywhere.
> 
> Clockevents and interrupt controllers can have a module clock.
> All three can be part of a PM Domain, which requires a struct device to
> be handled properly.

I agree it sure would be nice to have all these as drivers. I believe
SoC specific clockevent using SoC specific clocks is the reason why some
clocks cannot currently be drivers.

Regards,

Tony
