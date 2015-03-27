Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36745 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbbC0Md5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2015 08:33:57 -0400
MIME-Version: 1.0
In-Reply-To: <55151695.5050203@linaro.org>
References: <1426197361-19290-1-git-send-email-maxime.coquelin@st.com>
	<1426197361-19290-5-git-send-email-maxime.coquelin@st.com>
	<5513D64A.7060702@linaro.org>
	<CALszF6CtEf0w8AoaMwFzn34ACMjkW6obT5_MrduBdUOm7T=zNw@mail.gmail.com>
	<55151695.5050203@linaro.org>
Date: Fri, 27 Mar 2015 13:33:55 +0100
Message-ID: <CALszF6AyjsYGFE+nqCHzHA3M5W3dQNSHEbt34EnVNOZLer-f7A@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] clocksource: Add ARM System timer driver
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>, Peter Meerwald <pmeerw@pmeerw.net>, Paul Bolle <pebolle@tiscali.nl>, Jonathan Corbet <corbet@lwn.net>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150327123355.Zr4e6jLCgxlKSNyRx-l4rhdFbtmfZ0yqFr1w6l5eBbA@z>

2015-03-27 9:36 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 03/26/2015 09:19 PM, Maxime Coquelin wrote:
>>
>> Hi Daniel,
>>
>>    Thanks for the review. Please find my answers below.
>>
>> 2015-03-26 10:50 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>>
>>> On 03/12/2015 10:55 PM, Maxime Coquelin wrote:
>>>>
>>>>
>>>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>>
>>>> This patch adds clocksource support for ARMv7-M's System timer,
>>>> also known as SysTick.
>>>>
>>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>
>>>
>>>
>>> Hi Maxime,
>>>
>>> the driver looks good. Three comments below.
>>>
>>>    -- Daniel
>>>
>>>
>
> [ ... ]
>
>
>>>> +static void __init system_timer_of_register(struct device_node *np)
>>>> +{
>>>> +       struct clk *clk;
>>>> +       void __iomem *base;
>>>> +       u32 rate = 0;
>>>> +       int ret;
>>>> +
>>>> +       base = of_iomap(np, 0);
>>>> +       if (!base) {
>>>> +               pr_warn("system-timer: invalid base address\n");
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       clk = of_clk_get(np, 0);
>>>> +       if (!IS_ERR(clk)) {
>>>> +               ret = clk_prepare_enable(clk);
>>>> +               if (ret) {
>>>> +                       clk_put(clk);
>>>> +                       goto out_unmap;
>>>> +               }
>>>> +
>>>> +               rate = clk_get_rate(clk);
>>>> +       }
>>>> +
>>>> +       /* If no clock found, try to get clock-frequency property */
>>>> +       if (!rate) {
>>>> +               ret = of_property_read_u32(np, "clock-frequency",
>>>> &rate);
>>>> +               if (ret)
>>>> +                       goto out_unmap;
>>>
>>>
>>>
>>> Shouldn't be 'goto out_clk_disable' ?
>>
>>
>> No, because I assumed !rate means we failed to get the clock.
>> Actually, clk_get_rate could return 0, so relying on rate value is not
>> safe.
>>
>> I propose to get clock-frequency property if IS_ERR(clk).
>>
>> Is it fine for you?
>
>
> Why not invert the conditions ? If the 'clock-frequency' is specified in the
> DT then it overrides the clk_get_rate(). So the resulting code will be:
>
> ret = of_property_read_u32(np, "clock-frequency", &rate);
> if (ret) {
>         clk = of_clk_get(np, 0);
>         if (IS_ERR(clk))
>                 goto out_unmap;
>
>         ret = clk_prepare_enable(clk);
>         if (ret)
>                 goto out_clk_put;
>
>         rate = clk_get_rate(clk);
>         if (!rate)
>                 goto out_clk_unprepare;
>
> }

Ok, it looks sensible.
I will do this in next version.

>
>
>
>>>> +       }
>>>> +
>>>> +       writel_relaxed(SYSTICK_LOAD_RELOAD_MASK, base + SYST_RVR);
>>>> +       writel_relaxed(SYST_CSR_ENABLE, base + SYST_CSR);
>>>> +
>>>> +       ret = clocksource_mmio_init(base + SYST_CVR, "arm_system_timer",
>>>> rate,
>>>> +                       200, 24, clocksource_mmio_readl_down);
>>>> +       if (ret) {
>>>> +               pr_err("failed to init clocksource (%d)\n", ret);
>>>> +               goto out_clk_disable;
>>>> +       }
>>>> +
>>>> +       pr_info("ARM System timer initialized as clocksource\n");
>>>> +
>>>> +       return;
>>>> +
>>>> +out_clk_disable:
>>>> +       if (!IS_ERR(clk))
>>>
>>>
>>>
>>> Why do you need this check ?
>>
>>
>> To handle the case were no clock was found, but a clk-frequency value
>> was provided.
>>
>>>
>>> It isn't missing a clk_put ?
>>
>>
>> Right, thanks for spotting this.
>>
>> I wonder if it makes sense to implement the error path.
>> If we fail to initialize the clocksource, the system will be unusable.
>>
>> Maybe I should just perform a BUG_ON() in the error cases, as most of
>> the other clocksource drivers do.
>> What is your view?
>
>
> I prefer to not BUG_ON in the init functions because it already happen that
> drivers were bugging at init time and when a driver was reused on another
> platform with several timers available, the board was not able to boot
> because one timer was not used, hence not defined in the DT. I don't know if
> that could be the case for this platform but I prefer to keep thing going
> smoothly and return from init even if that lead to a kernel hang. Of course,
> the errors must be displayed (pr_warn, pr_err, pr_notice, etc ...).

Ok, let's keep the error path, that's much cleaner indeed.

>
>>>
>>>> +               clk_disable_unprepare(clk);
>>>> +out_unmap:
>>>> +       iounmap(base);
>>>> +       WARN(ret, "ARM System timer register failed (%d)\n", ret);
>
>
> pr_warn

Sure, will fix.

Thanks,
Maxime

>
> Thanks
>
>   -- Daniel
>
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
