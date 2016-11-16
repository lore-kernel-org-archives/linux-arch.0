From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] gpio: lib: Add gpio_is_enabled() to get pin mode
Date: Wed, 16 Nov 2016 20:41:01 +0100
Message-ID: <CACRpkdYAbkg34fUsBFTm9Ny5HVz=2HpR18cnORyFNH+4R3nJzg@mail.gmail.com>
References: <1478089037-26441-1-git-send-email-ldewangan@nvidia.com>
 <CACRpkdYjWiy-PyBhN8gRa5TM5ARXrCZ-KqBXYm-bVeXFY11MQw@mail.gmail.com>
 <5825B6D4.1000600@nvidia.com> <CACRpkdacDcy_Y_5g8739DF+f3fRzzMQ_bkM1TQ+uTtPq1=VmFg@mail.gmail.com>
 <582AF350.1000007@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36580 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbcKPTlC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Nov 2016 14:41:02 -0500
Received: by mail-qk0-f181.google.com with SMTP id n21so189612654qka.3
        for <linux-arch@vger.kernel.org>; Wed, 16 Nov 2016 11:41:02 -0800 (PST)
In-Reply-To: <582AF350.1000007@nvidia.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, Nov 15, 2016 at 12:36 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> [Me]
>> It would be more natural to add a function pinctrl_is_gpio(unsigned gpio)
>> to call back to the pin controller, then that can be called from
>> the generic or driver-specific debug print callback.
>
>
> We have two type of IPs, GPIO mode is configured in the register which is
> part of GPIO controller and in other IP, it is configured in register which
> is in pincontroller registers.
>
> Your suggested API pinctrl_is_gpio() will definitely help on second case and
> I will work on this once we will have the new IP driver in mainline. This
> will be in coming T186 patches.

I don't really understand this. In both cases we are dealing with pin muxing
and that belongs in the pin control subsystem. What register range the stuff
is in and whether it is called "GPIO block" in the datasheet does not concern
me, it is a pin controller from the point of the view of the kernel subsystems,
if it can multiplex pads/pins.

Yours,
Linus Walleij
