Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36510 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbbCQRXn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2015 13:23:43 -0400
MIME-Version: 1.0
In-Reply-To: <1426236895.3083.20.camel@pengutronix.de>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
	<1426197361-19290-7-git-send-email-maxime.coquelin@st.com>
	<1426236895.3083.20.camel@pengutronix.de>
Date: Tue, 17 Mar 2015 18:23:41 +0100
Message-ID: <CALszF6AS551JCxcfaKtPyeisbNt6OkdacS7uWaSEAEm3pRP95Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] drivers: reset: Add STM32 reset driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150317172341.dK3dlj-LFVg-Pp8VLzE_YxSczeLRTpJeQxD6XuiD0GA@z>

2015-03-13 9:54 GMT+01:00 Philipp Zabel <p.zabel@pengutronix.de>:
> Am Donnerstag, den 12.03.2015, 22:55 +0100 schrieb Maxime Coquelin:
>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> The STM32 MCUs family IP can be reset by accessing some shared registers.
>>
>> The specificity is that some reset lines are used by the timers.
>> At timer initialization time, the timer has to be reset, that's why
>> we cannot use a regular driver.
>
> But this is a regular driver now, should this comment be updated?
>

Indeed, I changed in v4 to:
    The STM32 MCUs family IPs can be reset by accessing some registers
    from the RCC block.

    The list of available reset lines is documented in the DT bindings.

Thanks,
Maxime
>
> regards
> Philipp
>
