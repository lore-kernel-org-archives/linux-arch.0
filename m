Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46313 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeITWdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:33:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so4686700pga.13
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:49:00 -0700 (PDT)
Subject: Re: [RESEND PATCH v3 0/3] sh: make early_platform code
 SuperH-specific
References: <20180827090651.25062-1-brgl@bgdev.pl>
 <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
 <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org>
 <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0622b4da-20d3-5f05-5774-85c1dbabe00e@linaro.org>
Date: Thu, 20 Sep 2018 18:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <20180920164857.Pe-nx-3ykQxOkA-3jG7aoRHjuSzWAuFHiOG6tA1mldI@z>

On 20/09/2018 18:19, Bartosz Golaszewski wrote:
> 2018-09-20 18:09 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 20/09/2018 15:00, Bartosz Golaszewski wrote:
>>
>> [ ... ]
>>
>>> Ping for 4.20. This is the third release cycle I'm trying to get this
>>> merged and there never were any objections.
>>
>> Thanks for the heads up, it is in the pipe.
>>
> 
> I guess you mean only the clocksource patch?


I meant it is in the pipe of things to review :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
