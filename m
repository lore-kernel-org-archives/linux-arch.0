From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] include/asm-generic/gpio.h: remove the call for
 __gpio_get_value() and __gpio_set_value() when GPIOLIB disabled
Date: Thu, 29 Aug 2013 14:08:12 +0200
Message-ID: <CACRpkdazBtZfWdGA71WV20oZn2NYXDGExDmDkrv_TrRnhOmxQg@mail.gmail.com>
References: <521B2917.6040908@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <521B2917.6040908@asianux.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>, Grant Likely <grant.likely@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 26, 2013 at 12:08 PM, Chen Gang <gang.chen@asianux.com> wrote:

> When GPIOLIB disabled, __gpio_get_value() and __gpio_set_value() will
> not implement, so need remove them, or compiling fails.
>
> e.g. (allmodconfig for h8300)
>
>     CC      arch/h8300/kernel/h8300_ksyms.o
>   In file included from arch/h8300/include/generated/asm/gpio.h:1:0,
>                    from arch/h8300/kernel/h8300_ksyms.c:17:
>   include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
>   include/asm-generic/gpio.h:270:2: error: implicit declaration of function '__gpio_get_value' [-Werror=implicit-function-declaration]
>     return __gpio_get_value(gpio);
>     ^
>
> For __gpio_get_value(), according to its implementation, it is enough
> to use "return 0" instead of, and for __gpio_set_value(), just remove
> directly.
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

NAK, this is not how you do it. This fallback path is for GENERIC_GPIO
without GPIOLIB. Including it from a file indicates that you *are*
using GENERIC_GPIO when GPIOLIB is not activated. It can not be
used to stub out gpiolib.

This is a better alternative: let h8300 select
ARCH_HAVE_CUSTOM_GPIO_H

This is quite common:
$ git grep ARCH_HAVE_CUSTOM_GPIO_H
arch/arm/Kconfig:       select ARCH_HAVE_CUSTOM_GPIO_H
arch/avr32/Kconfig:     select ARCH_HAVE_CUSTOM_GPIO_H
arch/blackfin/Kconfig:  select ARCH_HAVE_CUSTOM_GPIO_H
arch/m68k/Kconfig.cpu:  select ARCH_HAVE_CUSTOM_GPIO_H
arch/mips/Kconfig:      select ARCH_HAVE_CUSTOM_GPIO_H
arch/sh/Kconfig:        select ARCH_HAVE_CUSTOM_GPIO_H
arch/unicore32/Kconfig: select ARCH_HAVE_CUSTOM_GPIO_H

Then put your stubs for __gpio_get_value() etc in
arch/h8300/include/asm/gpio.h

This way the h8300 will have a stub implementation if GPIOLIB
is not selected.

Be sure to put a comment about this in that file.

Note: I'm still a bit rookie as GPIO maintainer so if Grant or
Russell tells me I'm telling you wrong things: listen to them.

Yours,
Linus Walleij
