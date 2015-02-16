Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:43966 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbBPMVD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Feb 2015 07:21:03 -0500
MIME-Version: 1.0
In-Reply-To: <54E12F39.6030509@suse.de>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-4-git-send-email-mcoquelin.stm32@gmail.com>
	<54E12F39.6030509@suse.de>
Date: Mon, 16 Feb 2015 13:21:01 +0100
Message-ID: <CALszF6DySx-j8hrXoSRC7uo7BcFQXgOu0SJD1q3NHKoD-NxhKQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] clocksource: Add ARM System timer driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150216122101.XolkRuGwDmt6gklaH7cWjOuZ-wkulGZ6ZFIWw_1lgpc@z>

2015-02-16 0:43 GMT+01:00 Andreas Färber <afaerber@suse.de>:
> Am 12.02.2015 um 18:45 schrieb Maxime Coquelin:
>> This patch adds clocksource support for ARMv7-M's System timer,
>> also known as SysTick.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../devicetree/bindings/arm/system_timer.txt       | 15 +++++
>>  drivers/clocksource/Kconfig                        |  7 ++
>>  drivers/clocksource/Makefile                       |  1 +
>>  drivers/clocksource/arm_system_timer.c             | 74 ++++++++++++++++++++++
>>  4 files changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/system_timer.txt
>>  create mode 100644 drivers/clocksource/arm_system_timer.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/system_timer.txt b/Documentation/devicetree/bindings/arm/system_timer.txt
>> new file mode 100644
>> index 0000000..35268b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/system_timer.txt
>> @@ -0,0 +1,15 @@
>> +* ARM System Timer
>> +
>> +ARMv7-M includes a system timer, known as SysTick. Current driver only
>> +implements the clocksource feature.
>> +
>> +Required properties:
>> +- compatible : Should be "arm,armv7m-systick"
>> +- reg             : The address range of the timer
>> +- clocks     : The input clock of the timer
>> +
>> +systick: system-timer {
>> +     compatible = "arm,armv7m-systick";
>> +     reg = <0xe000e010 0x10>;
>> +     clocks = <&clk_systick>;
>> +};
>
> Binding documentation is supposed to go into its own patch:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/submitting-patches.txt
Ok, will change this in the v2.

>
...
>
> I've used a SysTick based implementation on my stm32 branch myself, but
> looking at efm32 I got the impression that it would be better to use one
> of the 32-bit TIM2/TIM5 as clocksource and the other as clockevents?
>
> Still this implementation will be handy to have, also for other targets.

My view is that we should use as much generic parts of the Cortex-M as possible.
Moreover, doing, that, we can keep one more IP instance under reset
with associated clock gated,
and so maybe reduce the power consumption a little (I haven't done any
measurements)

Do you see a case where it could be better to use the STM32 timers?


Thanks,
Maxime
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
> Graham Norton; HRB 21284 (AG Nürnberg)
