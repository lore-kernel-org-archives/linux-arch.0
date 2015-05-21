Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33356 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbEUHme convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2015 03:42:34 -0400
MIME-Version: 1.0
In-Reply-To: <555D6FBD.3020202@suse.cz>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
	<CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
	<555D12F8.4000403@suse.de>
	<555D6FBD.3020202@suse.cz>
Date: Thu, 21 May 2015 09:42:32 +0200
Message-ID: <CALszF6AdNfYRhcLdc252peOcPOnzAXOKQydNcvgVdT26btAA6Q@mail.gmail.com>
Subject: Re: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset to
 kallsyms if XIP Kernel
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Peter Meerwald <pmeerw@pmeerw.net>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, Linux-Arch <linux-arch@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Antti Palosaari <crope@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kamil Lulko <rev13@wp.pl>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Nicolae Rosia <nicolae.rosia@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <20150521074232.8oNmVw4qeGo6rnMZKTUpCsAyxH3gg5o7b-6sMvEgGck@z>

2015-05-21 7:40 GMT+02:00 Michal Marek <mmarek@suse.cz>:
> Dne 21.5.2015 v 07:04 Andreas Färber napsal(a):
>> Am 18.05.2015 um 13:47 schrieb Maxime Coquelin:
>> But this is definitely an improvement for ARMv7-M debugging,
>>
>> Tested-by: Andreas Färber <afaerber@suse.de>
>>
>>> [Hi Michal, ...] could you consider
>>> taking it for v4.2?
>
> I applied it to kbuild.git#kbuild now.

Thanks!
Maxime
