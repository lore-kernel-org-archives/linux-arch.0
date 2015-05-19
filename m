Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36151 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbESNRe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 09:17:34 -0400
MIME-Version: 1.0
In-Reply-To: <20150519130028.GF2067@n2100.arm.linux.org.uk>
References: <1431158038-3813-10-git-send-email-mcoquelin.stm32@gmail.com>
	<5559E4B0.70506@linaro.org>
	<CALszF6CK7axU0qrWNf38aqrt2R2126ZACn7wx5jNY_1KE+4H+g@mail.gmail.com>
	<555AF143.2060807@linaro.org>
	<CALszF6CwGuKqgbX6gVrya1-_YOgvtrgC7pVqKTNjCRif_o532A@mail.gmail.com>
	<555AFD18.2070009@linaro.org>
	<CALszF6Asfke0-cMQJcEQ8ya+rbPPPhUc6aXTZXQvQ8QF66cwYQ@mail.gmail.com>
	<555B098A.8030202@linaro.org>
	<CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
	<alpine.DEB.2.11.1505191455540.4225@nanos>
	<20150519130028.GF2067@n2100.arm.linux.org.uk>
Date: Tue, 19 May 2015 15:17:32 +0200
Message-ID: <CALszF6CLE3NY=pcsKeL2HGbr0HvJJZnHprpkOHgjRquC4pWNxw@mail.gmail.com>
Subject: Re: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Joe Perches <joe@perches.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nicolae Rosia <nicolae.rosia@gmail.com>, Kamil Lulko <rev13@wp.pl>
Message-ID: <20150519131732.GH0qH-6h9mYAa7u-iMhXcZQkCG1KiewTcZqnMlPzcas@z>

2015-05-19 15:00 GMT+02:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, May 19, 2015 at 02:56:43PM +0200, Thomas Gleixner wrote:
>> Folks, can you please trim your replies. It's a PITA to scroll down
>> through several pages to find a single line of content.
>
> Absolutely right.  Too many people do not do this, and it's a waste of
> readers time.  Maybe we should start ignoring emails which contain only
> quoted mail in the first 50 lines.
>
> Also, cutting the rest of the email below the point which you've finished
> replying is good etiquette as well.  I've seen a number of posts where
> people have added their signature mid-mail and left a huge chunk of quoted
> mail below.  That's just not on either.
>

Ok, I will take care of that.
Sorry for the inconvenience,

Maxime
