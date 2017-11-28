Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38153 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbdK1CyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 21:54:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2ovDuwWCq2HABZaCVGO04TX0VdgnQbK65RvHhsMEzsiw@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 28 Nov 2017 10:53:37 +0800
Message-ID: <CAEbi=3f6YZJySA5A2+y1hiPHwfkq+05cisnRwyhKYDXQdnFzWA@mail.gmail.com>
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Rick Chen <rickchen36@gmail.com>
Message-ID: <20171128025337.aQp7JJHgS4LJbi2zMsd9ryfSBjNwS26OD27yxX-p830@z>

2017-11-27 22:11 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Rick Chen <rickchen36@gmail.com>
>>
>> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
>> It often be used in Andestech AE3XX platform.
>>
>> Signed-off-by: Rick Chen <rickchen36@gmail.com>
>> Signed-off-by: Greentime Hu <green.hu@gmail.com>
>
> No need to split out the Makefile patch from the actual driver, they
> clearly belong together.
> The binding change should be a separate patch, as you did.
>
> It's probably best to separate the driver patches from the
> architecture submission
> in the future, they can simply get merged by the respective subsystem
> maintainers,
> with a smaller Cc list.
>

Hi, Arnd:

Thanks.
We will merge these 2 patches together in the next version patch.
We will sent to clocksource subsystem with a seperate patchset.
