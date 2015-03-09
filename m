Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:40912 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbbCIRBy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 13:01:54 -0400
MIME-Version: 1.0
In-Reply-To: <CACRpkdaYVyH-y19yHYp2noq6VhDVJYQfqkevDtLr-7y8gVwdXw@mail.gmail.com>
References: <1423763164-5606-1-git-send-email-mcoquelin.stm32@gmail.com>
	<1423763164-5606-15-git-send-email-mcoquelin.stm32@gmail.com>
	<CACRpkdaM0BwMcq77MO=0-dVaqwobD5Pt+11j7ZZ4c3yKM=AkeA@mail.gmail.com>
	<CALszF6Bz978KA1DAxcKtmA55X=vJWEcVDa9fLOF=uNatYS+b+Q@mail.gmail.com>
	<CACRpkdaYVyH-y19yHYp2noq6VhDVJYQfqkevDtLr-7y8gVwdXw@mail.gmail.com>
Date: Mon, 9 Mar 2015 18:01:51 +0100
Message-ID: <CALszF6B1k9tAhhhwMJ9y3J9JdPabdeK4600FBw0o21YL4kSoAg@mail.gmail.com>
Subject: Re: [PATCH 14/14] MAINTAINERS: Add entry for STM32 MCUs
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <20150309170151.tIEBOAIeN2f_uQT77qikmpwH-IZlYJoNaA5d87kX-a0@z>

2015-03-09 17:47 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Mar 6, 2015 at 10:55 AM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>> 2015-03-06 10:03 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>>> On Thu, Feb 12, 2015 at 6:46 PM, Maxime Coquelin
>>> <mcoquelin.stm32@gmail.com> wrote:
>>>
>>>> Add a MAINTAINER entry covering all STM32 machine and drivers files.
>>>>
>>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>
>>> (...)
>>>> +F:     drivers/clocksource/arm_system_timer.c
>>>
>>> Is that all? And that is not even a STM32 specific driver.
>>
>> For the ARM System Timer, I'm fine to add a new entry.
>> Or remove the line, and let the maintain-ship to clocksource maintainers.
>>
>> All the STM32 files are covered by this line:
>> +N:     stm32
>
> Aha you're right, news2me, I'm old and stupid :/

This is new to me too. :)

Maxime

>
> Thanks,
> Linus Walleij
