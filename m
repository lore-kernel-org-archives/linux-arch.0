Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:46778 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbBMP7E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Feb 2015 10:59:04 -0500
MIME-Version: 1.0
In-Reply-To: <1423828078.4182.17.camel@pengutronix.de>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-13-git-send-email-mcoquelin.stm32@gmail.com>
	<1423828078.4182.17.camel@pengutronix.de>
Date: Fri, 13 Feb 2015 16:59:01 +0100
Message-ID: <CALszF6D+5mXajUWarwq8M4yL_Nc+x1Bmu4D7_HxDRy2kGRXNVQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] ARM: dts: Introduce STM32F429 MCU
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150213155901.ynShpKagNkRyoFYDpo299XemtkcRqjcaAjAWAi7pIIo@z>

Hi Philipp,

2015-02-13 12:47 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Hi Maxime,
>
> Am Donnerstag, den 12.02.2015, 18:46 +0100 schrieb Maxime Coquelin:
> [...]
>> +     soc {
>> +             reset_ahb1: reset@40023810 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023810 0x4>;
>> +             };
>> +
>> +             reset_ahb2: reset@40023814 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023814 0x4>;
>> +             };
>> +
>> +             reset_ahb3: reset@40023818 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023818 0x4>;
>> +             };
>> +
>> +             reset_apb1: reset@40023820 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023820 0x4>;
>> +             };
>> +
>> +             reset_apb2: reset@40023824 {
>> +                     #reset-cells = <1>;
>> +                     compatible = "st,stm32-reset";
>> +                     reg = <0x40023824 0x4>;
>> +             };
>
> These are mostly consecutive, single registers. I wonder if these are
> part of the same IP block and thus should be grouped together into the
> same reset controller node?

What I could to is to have two instances. One for AHB and one for APB domain.
Doing this, I will have one instance per domain, and only consecutive registers.
Is it fine for you?

Thanks,
Maxime

>
> regards
> Philipp
>
