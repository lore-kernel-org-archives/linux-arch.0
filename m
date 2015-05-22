Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33992 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbbEVOO5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2015 10:14:57 -0400
Received: by wghq2 with SMTP id q2so19203325wgh.1
        for <linux-arch@vger.kernel.org>; Fri, 22 May 2015 07:14:56 -0700 (PDT)
Message-ID: <555F39DD.9060209@linaro.org>
Date: Fri, 22 May 2015 15:14:53 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>	<2282066.NWoIT9ZyLc@wuerfel>	<CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>	<13641152.Yt4ZI3oT6L@wuerfel>	<CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>	<1432285588.3929.28.camel@pengutronix.de>	<20150522091822.GF8557@lukather>	<1432289231.3929.60.camel@pengutronix.de>	<CALszF6CQ1_HQXJ8=vgytvVo2t4_ue5_nsE06HPyHMzSLrntqKg@mail.gmail.com>	<555F2A8A.5020205@suse.de> <CALszF6A=TZ_EROrfuBOAGiY3mbydC5fepWLSWrZLLt4nV9sr4w@mail.gmail.com>
In-Reply-To: <CALszF6A=TZ_EROrfuBOAGiY3mbydC5fepWLSWrZLLt4nV9sr4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, =?UTF-8?B?QW5kcmVhcyBGw6Q=?= =?UTF-8?B?cmJlcg==?= <afaerber@suse.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150522141453.S-S7DP1dPNAJhWDH6a0TBA6J2To01Rz5-W2u0e6eNas@z>

On 22/05/15 14:57, Maxime Coquelin wrote:
> 2015-05-22 15:09 GMT+02:00 Andreas Färber <afaerber@suse.de>:
>> As you should know, I did have an RCC clk driver, and there is no such
>> issue. The two drivers use different mechanisms for initialization. And
>> I'm pretty sure that I've already remarked that on the list, too.
>
> Yes, you use of_iomap in your clock driver [0].
> Daniel, would you accept to do the same?
> That would remove one difference between stm32/sunxi/socfpga reset drivers.

In fact, that is exactly what I am currently doing, though I was 
planning for it to be temporary.

It seems a bit weird to me that one driver (which requests too much 
register space) only works because another driver chooses not to request 
any.

BTW in drivers/clk there are ~110 of_iomaps and only 10 
of_io_request_and_maps... so I don't think anyone will yell at me for 
using of_iomap().


Daniel.

