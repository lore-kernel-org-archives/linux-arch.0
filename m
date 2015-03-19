Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36857 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbbCSO6n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 10:58:43 -0400
Received: by qgf3 with SMTP id 3so67097516qgf.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2015 07:58:41 -0700 (PDT)
Message-ID: <550AE41C.8070803@hurleysoftware.com>
Date: Thu, 19 Mar 2015 10:58:36 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 10/15] serial: stm32-usart: Add STM32 USART Driver
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>	<1426197361-19290-11-git-send-email-maxime.coquelin@st.com>	<CAHp75Vd7+oLiLLuyocYh95TebtocWrRho6xNjuSUt8fYGp8npg@mail.gmail.com>	<CALszF6BWuUYRh+3rWnSQLApkAHA5dQXw=6x6D_evRtb+5B_ukA@mail.gmail.com>	<CAHp75Vdf6=z1d5+eYJ+QGTko9kkZf-oPfoWaf8FRoTdqcdWxjw@mail.gmail.com> <CALszF6A5Zu7i0hxSLTS-nfOAXmd0__jLjB=fHxK93Ex5Vbi9LA@mail.gmail.com>
In-Reply-To: <CALszF6A5Zu7i0hxSLTS-nfOAXmd0__jLjB=fHxK93Ex5Vbi9LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, Linux Documentation List <linux-doc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150319145836.WCKhgucXRw1EjQoDtyhIESCHUmAdscjwH7SPBn1DM_s@z>

On 03/19/2015 09:55 AM, Maxime Coquelin wrote:
>>>>> +static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>>>>> +                           struct ktermios *old)
[...]
>>>>> +       usardiv = (port->uartclk * 25) / (baud * 4);
>>>>> +       mantissa = (usardiv / 100) << USART_BRR_DIV_M_SHIFT;
>>>>> +       fraction = DIV_ROUND_CLOSEST((usardiv % 100) * 16, 100);
>>>>> +       if (fraction & ~USART_BRR_DIV_F_MASK) {
>>>>> +               fraction = 0;
>>>>> +               mantissa += (1 << USART_BRR_DIV_M_SHIFT);
>>>>> +       }
[...]
> Really, I would prefer keeping this fractional divider as it is
> implemented today.

You have to admit that's basically an unintelligible mess;
how would anyone ever be able to refactor and replace that with a
common divider implementation?

At the very least, please comment on the formula and format.

Regards,
Peter Hurley
