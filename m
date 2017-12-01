Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35987 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdLAMaO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Dec 2017 07:30:14 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so2255635itj.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2017 04:30:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <672e0b3843953d1ab69bc19baf1a0f217ec1b1fa.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <672e0b3843953d1ab69bc19baf1a0f217ec1b1fa.1511785528.git.green.hu@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Dec 2017 13:30:13 +0100
Message-ID: <CACRpkdaRq1ZH7EN3RTeLGfUW+xK06fxDDhY6kTQeacdW9MOQYA@mail.gmail.com>
Subject: Re: [PATCH v2 33/35] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, deanbo422@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Rick Chen <rickchen36@gmail.com>
Message-ID: <20171201123013.eqWjoN50gAP0pMCWUFEqVdh8EqJeQp-VC28CUNEhZj8@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> From: Rick Chen <rickchen36@gmail.com>
>
> ATCPIT100 is often used on the Andes architecture,
> This timer provide 4 PIT channels. Each PIT channel is a
> multi-function timer, can be configured as 32,16,8 bit timers
> or PWM as well.
>
> For system timer it will set channel 1 32-bit timer0 as clock
> source and count downwards until underflow and restart again.
>
> It also set channel 0 32-bit timer0 as clock event and count
> downwards until condition match. It will generate an interrupt
> for handling periodically.
>
> Signed-off-by: Rick Chen <rickchen36@gmail.com>
> Signed-off-by: Greentime Hu <green.hu@gmail.com>

The driver looks nice overall.

> +static struct timer_of to = {
> +       .flags = TIMER_OF_IRQ | TIMER_OF_CLOCK | TIMER_OF_BASE,
> +
> +       .clkevt = {
> +               .name = "atcpit100_tick",
> +               .rating = 300,
> +               .features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +               .set_state_shutdown = atcpit100_clkevt_shutdown,
> +               .set_state_periodic = atcpit100_clkevt_set_periodic,
> +               .set_state_oneshot = atcpit100_clkevt_set_oneshot,
> +               .tick_resume = atcpit100_clkevt_shutdown,
> +               .set_next_event = atcpit100_clkevt_next_event,
> +               .cpumask = cpu_all_mask,
> +       },
> +
> +       .of_irq = {
> +               .handler = atcpit100_timer_interrupt,
> +               .flags = IRQF_TIMER | IRQF_IRQPOLL,
> +       },

I would add:

.of_clk = {
    .name = "PCLK",
};

To be explicit on what we use.

(I hope I understand this OF timer right.)

Otherwise it looks good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
