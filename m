Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35805 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbbESPED (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 11:04:03 -0400
Received: by wgfl8 with SMTP id l8so21487912wgf.2
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2015 08:04:01 -0700 (PDT)
Message-ID: <555B50D5.4010100@linaro.org>
Date: Tue, 19 May 2015 17:03:49 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<555B098A.8030202@linaro.org>	<CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>	<6177628.0ZDPLeVyah@wuerfel>	<CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>	<555B3F80.8070605@linaro.org> <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
In-Reply-To: <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150519150349.fziNSR800z0IaJCS25QpcblRm3MeGU61zXAYZf75YPI@z>

On 05/19/2015 04:41 PM, Maxime Coquelin wrote:
> 2015-05-19 15:49 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>
>>
>> It is not exactly as the initial patch.
>>
>> I think Arnd is proposing:
>>
>> config CLKSRC_STM32
>>          bool "Clocksource for STM32 SoCs" if COMPILE_TEST
>>          select CLKSRC_MMIO
>>
>
> Isn't "depends on OF" missing for COMPILE_TEST case?

Hmm, yes. Probably.

> Other than that, I'm fine with the proposal.
> Daniel, is it the case for you too?

Yep.


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

