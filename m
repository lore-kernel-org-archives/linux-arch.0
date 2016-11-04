Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34448 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbcKDWU0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2016 18:20:26 -0400
Received: by mail-qt0-f176.google.com with SMTP id n6so57061431qtd.1
        for <linux-arch@vger.kernel.org>; Fri, 04 Nov 2016 15:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com>
References: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Nov 2016 23:20:24 +0100
Message-ID: <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20161104222024.dCMpT9RpDRB6WHoaai2GDqbQu2hfmkqt9oWaq1vlwFU@z>

On Wed, Nov 2, 2016 at 1:17 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Many of devices/SoCs supports the GPIO and special IO function
> from their pins. On such cases, there is always configuration
> bits to select the mode of pin as GPIO or as the special IO mode.
> The functional modes are selected by pinmux option.
>
> When device booted and reach to kernel, it is not possible to get
> the current configuration of pin whether it is in GPIO mode or
> in special IO mode without configurations.
>
> Add APIs to return the current mode of pins without requesting it
> as GPIO to find out the current mode.
> This helps on dumping the pin configuration from debug/test utility
> to get the current mode GPIO or functional mode.
>
> The typical utility looks as:
> pin_dump(pin)
> {
>         if(gpio_is_enabled(pin)) {
>                 dump direction using get_direction()
>         } else {
>                 dump pinmux option and its configurations.
>         }
> }

Yeah but since pinctrl and pinmux has its own debugfs files why is this
necessary? I understand it is convenient but only for debugging
right? They the inconvenience of using pinctrls debugfs files should
be bearable.

Also it is possible for any GPIO chip to implement its own
debug print if they like, check what we do in
->dbg_show in drivers/pinctrl/nomadik/pinctrl-nomadik.c
for example.

If the use is for debug prints, keep it driver-local.

(...)
> +static inline int gpio_is_enabled(unsigned gpio)
> +{
> +       return gpiod_is_enabled(gpio_to_desc(gpio));
> +}

NAK why would be encourage the non-descriptor interface by
adding to it? Better only offer this to the descriptor users.

Yours,
Linus Walleij
