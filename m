From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 33/35] clocksource/drivers/atcpit100: Add andestech
 atcpit100 timer
Date: Thu, 7 Dec 2017 09:44:55 +0100
Message-ID: <f6e29691-a9eb-2b11-9889-dfba9ff71576@linaro.org>
References: <cover.1511785528.git.green.hu@gmail.com>
 <672e0b3843953d1ab69bc19baf1a0f217ec1b1fa.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39322 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdLGIo7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2017 03:44:59 -0500
Received: by mail-wm0-f67.google.com with SMTP id i11so11383730wmf.4
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2017 00:44:58 -0800 (PST)
In-Reply-To: <672e0b3843953d1ab69bc19baf1a0f217ec1b1fa.1511785528.git.green.hu@gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Rick Chen <rickchen36@gmail.com>

On 27/11/2017 13:28, Greentime Hu wrote:
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
> ---

Looks good.

Please resend this patch folded with the Makefile change and the DT
binding (fixed) as suggested by Arnd. I will merge them.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
