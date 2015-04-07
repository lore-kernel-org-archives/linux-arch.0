Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35901 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbbDGPt5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2015 11:49:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKioFc65Gng0FbOOBCspwxr1-bdy1kShKRM24XyALPmOw@mail.gmail.com>
References: <1428080481-18591-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1428080481-18591-10-git-send-email-mcoquelin.stm32@gmail.com>
	<CAL_JsqKioFc65Gng0FbOOBCspwxr1-bdy1kShKRM24XyALPmOw@mail.gmail.com>
Date: Tue, 7 Apr 2015 17:49:54 +0200
Message-ID: <CALszF6BnFz3D=6AT0+o2umy6wtVJg1BGX4rLWmHjrbt=4-ZknQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] dt-bindings: Document the STM32 USART bindings
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robherring2@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150407154954.VFJiot7Dp5E4y1pXP-YaBLTmA39ZUE4ywMNtTDskwZw@z>

2015-04-03 19:14 GMT+02:00 Rob Herring <robherring2@gmail.com>:
> On Fri, Apr 3, 2015 at 12:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> This adds documentation of device tree bindings for the
>> STM32 USART
>>
>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>  .../devicetree/bindings/serial/st,stm32-usart.txt  | 32 ++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>> new file mode 100644
>> index 0000000..090a3a4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
>> @@ -0,0 +1,32 @@
>> +* STMicroelectronics STM32 USART
>> +
>> +Required properties:
>> +- compatible: Can be either "st,stm32-usart" or "st,stm32-uart" depending on
>> +whether the device supports synchronous mode.
>> +- reg: The address and length of the peripheral registers space
>> +- interrupts: The interrupt line of the USART instance
>> +- clocks: The input clock of the USART instance
>> +
>> +Optional properties:
>> +- pinctrl: The reference on the pins configuration
>> +- st,hw-flow-ctrl: bool flag to enable hardware flow control.
>
> We already have "auto-flow-control" for 8250. Does that work for you?

Yes it works, just that I didn't know about it.

I will change to "auto-flow-control" in next version.

Thanks,
Maxime
