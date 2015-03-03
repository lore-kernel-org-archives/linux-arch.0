Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:33437 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932174AbbCCR7M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Mar 2015 12:59:12 -0500
MIME-Version: 1.0
In-Reply-To: <54F4A0F7.80606@suse.de>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
	<54F4A0F7.80606@suse.de>
Date: Tue, 3 Mar 2015 18:59:10 +0100
Message-ID: <CALszF6Bn7z+COs84BV622BXnpRSruLn-9y+vo51mQxrHkDdQyQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150303175910.ut96UYO4RVzEDwAikaRxBZF0ZeR0jvVLls7MQIdp8zA@z>

Hi Andreas,

Thanks for this detailed review.

2015-03-02 18:42 GMT+01:00 Andreas Färber <afaerber@suse.de>:
> Hi Maxime,
>
> Please don't put the whole world in To, that makes replying to you much
> harder. You can put maintainers in CC instead.
Ok.
>
> Am 20.02.2015 um 19:01 schrieb Maxime Coquelin:
>> The STMicrolectornics's STM32F419 MCU has the following main features:
>>  - Cortex-M4 core running up to @180MHz
>>  - 2MB internal flash, 256KBytes internal RAM
>>  - FMC controller to connect SDRAM, NOR and NAND memories
>>  - SD/MMC/SDIO support
>>  - Ethernet controller
>>  - USB OTFG FS & HS controllers
>>  - I2C, SPI, CAN busses support
>>  - Several 16 & 32 bits general purpose timers
>>  - Serial Audio interface
>>  - LCD controller
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile            |   1 +
>>  arch/arm/boot/dts/stm32f429-disco.dts |  41 ++++
>>  arch/arm/boot/dts/stm32f429.dtsi      | 396 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 438 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/stm32f429-disco.dts
>>  create mode 100644 arch/arm/boot/dts/stm32f429.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 91bd5bd..d7da0ef 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -442,6 +442,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
>>       stih416-b2000.dtb \
>>       stih416-b2020.dtb \
>>       stih416-b2020e.dtb
>> +dtb-$(CONFIG_ARCH_STM32)+= stm32f429-disco.dtb
>>  dtb-$(CONFIG_MACH_SUN4I) += \
>>       sun4i-a10-a1000.dtb \
>>       sun4i-a10-ba10-tvbox.dtb \
>> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
>> new file mode 100644
>> index 0000000..0e79cc1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
>> @@ -0,0 +1,41 @@
>
> Add a suitable license header here? There had been attempts to
> dual-license as GPL and MIT/X11.

I agree to add the dual GPL and MIT/X11 licence.

>
>> +/dts-v1/;
>> +#include "stm32f429.dtsi"
>> +
>> +/ {
>> +     model = "STMicroelectronics's STM32F429i-DISCO board";
>
> "'s" seems uncommon here and "s's" looks wrong. Just use
> "STMicroelectronics STM32F429I-DISCO board"?

Ok, it will be fixed in v3.

>
>> +     compatible = "st,stm32f429i-disco", "st,stm32f429";
>> +
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
>> +             linux,stdout-path = &usart1;
>
> I have actually been using USART3, following a guide I found on GitHub.
> Which pins do you use for USART1, and is one better than the other?

I used U-boot from Emcraft, which uses USART1, that is the only reason
I used this one.
Regarding USART3, I had a look at your boot-wrapper, and you configure
the USART3 to PC10/PC11 pins.
