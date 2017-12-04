From: =?UTF-8?B?6Zmz5bu65b+X?= <rickchen36@gmail.com>
Subject: Re: [PATCH v2 35/35] dt-bindings: timer: Add andestech atcpit100
 timer binding doc
Date: Mon, 4 Dec 2017 09:07:20 +0800
Message-ID: <CAN5B=e+-igkynapqoMhY6TMMNybnPudkL24aYiqJ7nESqxn9Yw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <60f23e7fcff11f16b0bca4753a39d098849eeac3.1511785528.git.green.hu@gmail.com>
 <CACRpkdYuo88qeEznKxVojYofV4YTGu6AOgan-2GPYS9qZCVxZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39296 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdLDBHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Dec 2017 20:07:21 -0500
In-Reply-To: <CACRpkdYuo88qeEznKxVojYofV4YTGu6AOgan-2GPYS9qZCVxZA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org, deanbo422@gmail.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org

2017-12-01 20:19 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> From: Rick Chen <rickchen36@gmail.com>
>>
>> Add a document to describe Andestech atcpit100 timer and
>> binding information.
>>
>> Signed-off-by: Rick Chen <rickchen36@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Greentime Hu <green.hu@gmail.com>
>
> Thanks for submitting this interesting architecture!
>
> (...)
>
>> +Required properties:
>> +- compatible   : Should be "andestech,atcpit100"
>> +- reg          : Address and length of the register set
>> +- interrupts   : Reference to the timer interrupt
>> +- clocks : a clock to provide the tick rate for "andestech,atcpit100"
>> +- clock-names : should be "PCLK" for the external tick timer.
>
> This text seem wrong. PCLK is the internal timer, right? "PCLK" is
> "peripheral clock" (I hope) and that comes from the bus.
>
> Consider also adding an optional "EXTCLK" already now, since it is
> evident from the driver that this is also supported.
>

Thank you for reviewing !
I will modify it in the next patch.

Rick

> Yours,
> Linus Walleij
