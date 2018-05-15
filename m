Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:52345 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOIln (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2018 04:41:43 -0400
Received: by mail-it0-f65.google.com with SMTP id y189-v6so17178461itb.2
        for <linux-arch@vger.kernel.org>; Tue, 15 May 2018 01:41:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUnG0YLg=HXMrUVJ34sZEDuuZRYxnrPPC45-KpAkO3bcw@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <20180511162028.20616-10-brgl@bgdev.pl>
 <CAMuHMdUnG0YLg=HXMrUVJ34sZEDuuZRYxnrPPC45-KpAkO3bcw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 15 May 2018 10:41:42 +0200
Message-ID: <CAMRc=MfF=OxvC=pcVvu2BmEceHytPZUOMrALf=CHxngPdAXpUA@mail.gmail.com>
Subject: Re: [PATCH 09/12] platform/early: add an init section for early
 driver data
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Message-ID: <20180515084142.M073el2crTGR5JNFoWSIWyNdJ36_dR7XSG4J8qx4ZCw@z>

2018-05-14 23:29 GMT+02:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Bartosz,
>
> On Fri, May 11, 2018 at 6:20 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Provide a separate section in which pointers to early platform driver
>> structs will be stored.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Thanks for your patch!
>
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -214,6 +214,16 @@
>>  #define CPU_METHOD_OF_TABLES() OF_TABLE(CONFIG_SMP, cpu_method)
>>  #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
>>
>> +#ifdef CONFIG_EARLY_PLATFORM
>> +#define EARLY_PLATFORM_DRIVERS_TABLE()                                 \
>> +       . = ALIGN(8);                                                   \
>
> Should this use STRUCT_ALIGN() instead?
>

No, we're only using it to store pointers to structs, not the actual
struct early_platform_driver objects.

>> +       VMLINUX_SYMBOL(__early_platform_drivers_table) = .;             \
>> +       KEEP(*(__early_platform_drivers_table))                         \
>> +       VMLINUX_SYMBOL(__early_platform_drivers_table_end) = .;
>> +#else
>> +#define EARLY_PLATFORM_DRIVERS_TABLE()
>> +#endif
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
Bartosz
