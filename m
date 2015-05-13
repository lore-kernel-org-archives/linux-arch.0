Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37343 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934208AbbEMM6K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 08:58:10 -0400
Received: by widdi4 with SMTP id di4so54653064wid.0
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2015 05:58:08 -0700 (PDT)
Message-ID: <55534A5D.6050904@linaro.org>
Date: Wed, 13 May 2015 13:58:05 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<1431158038-3813-15-git-send-email-mcoquelin.stm32@gmail.com>	<2789447.8FUTAOJOHR@wuerfel> <CALszF6CS8Q9DWX+ERtu=k=Bzr1-25N3oZQyWyxDZBF3an4nFKQ@mail.gmail.com>
In-Reply-To: <CALszF6CS8Q9DWX+ERtu=k=Bzr1-25N3oZQyWyxDZBF3an4nFKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150513125805.BmbifLJx2m8yzYmv81tcvJQ_F13rIIWKROWs08xuPM0@z>

On 13/05/15 12:45, Maxime Coquelin wrote:
> 2015-05-12 23:21 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
>> On Saturday 09 May 2015 09:53:56 Maxime Coquelin wrote:
>>> +#include  <dt-bindings/mfd/stm32f4-rcc.h>
>>> +
>>>
>>
>> Can you find a way to avoid this dependency?
>>
>> Maybe you can change the bindings so that the numbers you pass as
>> arguments to the reset and clock specifiers reflect the numbers that
>> the hardware use?
>
> If I understand correctly, you prefer the way I did in v7 [0]?
>
> I don't have a strong opinion on this. Either way is fine to me.
>
> I changed the bindings in the v8 after discussions with Daniel
> Thompson, who is implementing the clock driver part of the RCC IP.
>
> He proposed we used common defines, because each peripheral has a
> reset line and a clock gate.
> Both reset and clock are represented as a single bit, with only the
> base offset differing between clock and reset.
> You can have a look at chapter 6 of the reference manual [1] if you
> find some time.
>
> Having common defines between clocks and reset make sense to me, but I
> also understand your point of avoiding dependencies.
>
> Maybe I can revert back to v7 bindings for now, and then we can
> reconsider using common defines when Daniel will send the clock
> patches.
> Note that doing that won't break the DT binary compatibility, as the
> raw reset values, or the ones from defines are the same.
>
> Daniel, could you share an example of the bindings you would use for the clocks?

For the most cases, where there is a clock gate just before the 
peripheral it looks pretty much like the reset driver and I use the bit 
offset of the clock gating bit as the index.

However there are a couple of clocks without gating just before the 
clock reaches the peripheral:

1. A hard coded /8. I think this will have to be given a synthetic
    number.

2. Ungated dividers. For these I am using the bit offset of the LSB of
    the mux field.

So I think there is only one value that is completely unrelated to the 
hardware and will use a magic constant instead.

I had planned to macros similar to the STM32F4_AxB_RESET() family of 
macros in both clk driver and DT in order to reuse the bit layouts from 
dt-bindings/mfd/stm32f4-rcc.h .

Normal case would have looked like this:

		timer3: timer@40000000 {
			compatible = "st,stm32-timer";
			reg = <0x40000000 0x400>;
			interrupts = <28>;
			resets = <&rcc STM32F4_APB1_RESET(TIM3)>;
			clocks = <&rcc STM32F4_APB1_CLK(TIM3)>;
			status = "disabled";
		};

Without the macros it looks like this:

		timer3: timer@40000000 {
			compatible = "st,stm32-timer";
			reg = <0x40000000 0x400>;
			interrupts = <28>;
			resets = <&rcc 257>;
			clocks = <&rcc 513>;
			status = "disabled";
		};

However we could perhaps be more literate even if we don't use the macros?

		timer3: timer@40000000 {
			compatible = "st,stm32-timer";
			reg = <0x40000000 0x400>;
			interrupts = <28>;
			resets = <&rcc ((0x20*8) + 1)>;
			clocks = <&rcc ((0x40*8) + 1)>;
			status = "disabled";
		};


Daniel.


> Kind regards,
> Maxime
>
>>
>>          Arnd
>
> [0]: http://lkml.iu.edu/hypermail/linux/kernel/1504.3/04523.html
> [1]: http://www.st.com/web/en/resource/technical/document/reference_manual/DM00031020.pdf
>

