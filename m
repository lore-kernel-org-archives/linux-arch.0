Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35508 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbbCRBIO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2015 21:08:14 -0400
Received: by obcjt1 with SMTP id jt1so985746obc.2
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2015 18:08:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2464742.YZIRrHto62@wuerfel>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
	<2464742.YZIRrHto62@wuerfel>
Date: Wed, 18 Mar 2015 02:08:13 +0100
Message-ID: <CACRpkdZA4OMB+gqh6XKfYWR8RSLZGpYjj-cgrC_KcSfcon4QVg@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150318010813.5sg1Ybe9CCQh2Yib4Ma6hyE1YGkiOqL3SvIE6N6c3V4@z>

On Tue, Mar 10, 2015 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 20 February 2015 19:01:10 Maxime Coquelin wrote:

>> +/* Pull-Up/Down */
>> +#define NO_PULL                0
>> +#define PULL_UP                1
>> +#define PULL_DOWN      2
>> +
>> +/* Type */
>> +#define PUSH_PULL      (0 << 2)
>> +#define OPEN_DRAIN     (1 << 2)
>> +
>
> These should probably not be stm32 specific at all, they sound
> rather generic, so maybe put the definitions into a common file.

It's part of what GENERIC_PINCONF does and it has bindings
in Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Yours,
Linus Walleij
