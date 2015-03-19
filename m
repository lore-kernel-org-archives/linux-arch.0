Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:34836 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbbCSNzk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 09:55:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdf6=z1d5+eYJ+QGTko9kkZf-oPfoWaf8FRoTdqcdWxjw@mail.gmail.com>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
	<1426197361-19290-11-git-send-email-maxime.coquelin@st.com>
	<CAHp75Vd7+oLiLLuyocYh95TebtocWrRho6xNjuSUt8fYGp8npg@mail.gmail.com>
	<CALszF6BWuUYRh+3rWnSQLApkAHA5dQXw=6x6D_evRtb+5B_ukA@mail.gmail.com>
	<CAHp75Vdf6=z1d5+eYJ+QGTko9kkZf-oPfoWaf8FRoTdqcdWxjw@mail.gmail.com>
Date: Thu, 19 Mar 2015 14:55:38 +0100
Message-ID: <CALszF6A5Zu7i0hxSLTS-nfOAXmd0__jLjB=fHxK93Ex5Vbi9LA@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] serial: stm32-usart: Add STM32 USART Driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, Linux Documentation List <linux-doc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150319135538.qVag_-5mMHVbAeFeCiKstzlBWxh60cn6YISZE6bCIvo@z>

2015-03-17 18:56 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Tue, Mar 17, 2015 at 7:32 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> 2015-03-13 15:19 GMT+01:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>
>>>> +static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
>>>> +                           struct ktermios *old)
>>>> +{
>>>> +       unsigned int baud;
>>>> +       u32 usardiv, mantissa, fraction;
>>>> +       tcflag_t cflag;
>>>> +       u32 cr1, cr2, cr3;
>>>> +       unsigned long flags;
>>>> +
>>>> +       baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
>>>> +       cflag = termios->c_cflag;
>>>> +
>>>> +       spin_lock_irqsave(&port->lock, flags);
>>>> +
>>>> +       /* Stop serial port and reset value */
>>>> +       writel_relaxed(0, port->membase + USART_CR1);
>>>> +
>>>> +       cr1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_UE | USART_CR1_RXNEIE;
>>>> +
>>>> +       if (cflag & CSTOPB)
>>>> +               cr2 = USART_CR2_STOP_2B;
>>>> +
>>>> +       if (cflag & PARENB) {
>>>> +               cr1 |= USART_CR1_PCE;
>>>> +               if ((cflag & CSIZE) == CS8)
>>>> +                       cr1 |= USART_CR1_M;
>>>> +       }
>>>> +
>>>> +       if (cflag & PARODD)
>>>> +               cr1 |= USART_CR1_PS;
>>>> +
>>>> +       if (cflag & CRTSCTS)
>>>> +               cr3 = USART_CR3_RTSE | USART_CR3_CTSE;
>>>> +
>>>> +       usardiv = (port->uartclk * 25) / (baud * 4);
>>>> +       mantissa = (usardiv / 100) << USART_BRR_DIV_M_SHIFT;
>>>> +       fraction = DIV_ROUND_CLOSEST((usardiv % 100) * 16, 100);
>>>> +       if (fraction & ~USART_BRR_DIV_F_MASK) {
>>>> +               fraction = 0;
>>>> +               mantissa += (1 << USART_BRR_DIV_M_SHIFT);
>>>> +       }
>>>
>>> So, it's a fractional divider. right? Could it be then fractional
>>> divider clock in this first place (see
>>> drivers/clk/clk-fractional-divider.c)?
>>>
>>
>> I'm not sure it makes sense to represent this baudrate divider within
>> the UART IP as a clock.
>
> You have it already. I mean it should be fractional divider clock.
>
> stm32port->clk = devm_clk_get(&pdev->dev, NULL);
> +
> +       if (WARN_ON(IS_ERR(stm32port->clk)))
> +               return -EINVAL;
> +
> +       /* ensure that clk rate is correct by enabling the clk */
> +       clk_prepare_enable(stm32port->clk);
> +       stm32port->port.uartclk = clk_get_rate(stm32port->clk);

No I don't have it already.
The clock I get here is coming from outside the IP, so this driver is
a clock consumer.
If I follow your advice, this driver will become both the clock
provider and the only clock consumer of this clock.
I think this is something that should be avoided.

Also, it would require to add another clock in between (a by-16 fixed
divider), because the formula is:
baud = fck / (16 * usart_div)

Finally, representing this as a clock is not really matching the
reality, because we are generating a baud rate, not a frequency.

Really, I would prefer keeping this fractional divider as it is
implemented today.

Kind regards,
Maxime

>
>> What would be the gain?
>
> Remove custom implementation of the calculations. It will be just one
> line to refresh the baud rate. I think we have a lot of duplicates
> here and there in the kernel. It would be nice not to bring another
> one.
>
> --
> With Best Regards,
> Andy Shevchenko
