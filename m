From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Date: Tue, 15 Nov 2016 10:03:39 +0100
Message-ID: <CACRpkdacDcy_Y_5g8739DF+f3fRzzMQ_bkM1TQ+uTtPq1=VmFg@mail.gmail.com>
References: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com> <5825B6D4.1000600@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33921 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941141AbcKOJDl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2016 04:03:41 -0500
Received: by mail-qt0-f182.google.com with SMTP id n6so64342541qtd.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Nov 2016 01:03:41 -0800 (PST)
In-Reply-To: <5825B6D4.1000600@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, Nov 11, 2016 at 1:17 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

>> Yeah but since pinctrl and pinmux has its own debugfs files why is this
>> necessary? I understand it is convenient but only for debugging
>> right? They the inconvenience of using pinctrls debugfs files should
>> be bearable.
>
> Yes, it is debugging and capturing all the info at single place. Currently,
> gpio debugFs shows the gpio related stuff and the pinctrl on pinconfig but
> there is not any dump which shows the complete pin mapping.
> The effort is to compile all the data in single place with proper message to
> avoid any manual work for decoding multiple outputs.

I don't know if this is a good idea. I don't want to clutter the
gpiolib ABI for no good reason.

For certain this should only be available for drivers using pin
control as a back-end for their GPIOs.

For that purpose we have (in <linux/pinctrl/consumer.h>:

/* External interface to pin control */
extern int pinctrl_request_gpio(unsigned gpio);
extern void pinctrl_free_gpio(unsigned gpio);
extern int pinctrl_gpio_direction_input(unsigned gpio);
extern int pinctrl_gpio_direction_output(unsigned gpio);

It would be more natural to add a function pinctrl_is_gpio(unsigned gpio)
to call back to the pin controller, then that can be called from
the generic or driver-specific debug print callback.

Yours,
Linus Walleij
