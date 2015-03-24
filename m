Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34688 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760AbbCXRpG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2015 13:45:06 -0400
Received: by qgep97 with SMTP id p97so423988qge.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Mar 2015 10:45:05 -0700 (PDT)
Message-ID: <5511A295.1060103@hurleysoftware.com>
Date: Tue, 24 Mar 2015 13:44:53 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 10/15] serial: stm32-usart: Add STM32 USART Driver
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>	<1426197361-19290-11-git-send-email-maxime.coquelin@st.com>	<CAHp75Vd7+oLiLLuyocYh95TebtocWrRho6xNjuSUt8fYGp8npg@mail.gmail.com>	<CALszF6BWuUYRh+3rWnSQLApkAHA5dQXw=6x6D_evRtb+5B_ukA@mail.gmail.com>	<CAHp75Vdf6=z1d5+eYJ+QGTko9kkZf-oPfoWaf8FRoTdqcdWxjw@mail.gmail.com>	<CALszF6A5Zu7i0hxSLTS-nfOAXmd0__jLjB=fHxK93Ex5Vbi9LA@mail.gmail.com>	<550AE41C.8070803@hurleysoftware.com>	<CALszF6DX2pz_US6uqQwBjmZhfgjw5PP1UAy9H+c-_Kgkk_Z72w@mail.gmail.com> <CALszF6Dg7t9+F9NG+xREPQeaAj7T6D1GuGabkr8EvOAAdtg7yA@mail.gmail.com>
In-Reply-To: <CALszF6Dg7t9+F9NG+xREPQeaAj7T6D1GuGabkr8EvOAAdtg7yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?B?VXdlIEtsZWluZS0=?= =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QW5kcmVh?= =?UTF-8?B?cyBGw6RyYmVy?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, Linux Documentation List <linux-doc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150324174453.0wIPhD8U_KGfXodWO0LO4MUBZgYs3CUZVSa4SZJCMls@z>

Hi Maxime,

On 03/24/2015 01:21 PM, Maxime Coquelin wrote:
> Hi Peter,
> 
> 2015-03-19 18:35 GMT+01:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
>> 2015-03-19 15:58 GMT+01:00 Peter Hurley <peter@hurleysoftware.com>:
>>> On 03/19/2015 09:55 AM, Maxime Coquelin wrote:
>>>>>>>> +static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>>>>>>>> +                           struct ktermios *old)
>>> [...]
>>>>>>>> +       usardiv = (port->uartclk * 25) / (baud * 4);
>>>>>>>> +       mantissa = (usardiv / 100) << USART_BRR_DIV_M_SHIFT;
>>>>>>>> +       fraction = DIV_ROUND_CLOSEST((usardiv % 100) * 16, 100);
>>>>>>>> +       if (fraction & ~USART_BRR_DIV_F_MASK) {
>>>>>>>> +               fraction = 0;
>>>>>>>> +               mantissa += (1 << USART_BRR_DIV_M_SHIFT);
>>>>>>>> +       }
>>> [...]
>>>> Really, I would prefer keeping this fractional divider as it is
>>>> implemented today.
>>>
>>> You have to admit that's basically an unintelligible mess;
>>> how would anyone ever be able to refactor and replace that with a
>>> common divider implementation?
>>>
>>> At the very least, please comment on the formula and format.
>>
>> Ok, I will refactor the implementation, and comment it.
> 
> The implementation was indeed a mess.
> I found some time to refactor the code, and also added support for 8
> times oversampling (16 by default).
> It will allow to achieve higher speeds, with the side effect of being
> less tolerant to clock deviations.
> 
> What do you think about the code below?
> 
> 
>     usartdiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
> 
>     /*
>      * The USART supports 16 or 8 times oversampling.
>      * By default we prefer 16 times oversampling, so that the receiver
>      * has a better tolerance to clock deviations.
>      * 8 times oversampling is only used to achieve higher speeds.
>      */
>     if (usartdiv < 16) {
>         oversampling = 8;
>         stm32_set_bits(port, USART_CR1, USART_CR1_OVER8);
>     } else {
>         oversampling = 16;
>         stm32_clr_bits(port, USART_CR1, USART_CR1_OVER8);
>     }
> 
>     mantissa = (usartdiv / oversampling) << USART_BRR_DIV_M_SHIFT;
>     fraction = usartdiv % oversampling;
>     writel_relaxed(mantissa | fraction, port->membase + USART_BRR)

Thanks! Way better :)
Much more obvious this is a fixed-point divisor.

Regards,
Peter Hurley



