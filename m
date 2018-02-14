Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36428 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbeBNFzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Feb 2018 00:55:35 -0500
MIME-Version: 1.0
In-Reply-To: <1518537768.22190.42.camel@perches.com>
References: <cover.1518505384.git.greentime@andestech.com> <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
 <1518537768.22190.42.camel@perches.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 14 Feb 2018 13:54:53 +0800
Message-ID: <CAEbi=3cYCAoqrw0JTQkEdnBNSpZUxZA+ZUSmrQd70S+xSro6Yw@mail.gmail.com>
Subject: Re: [PATCH v7 31/37] MAINTAINERS: Add nds32
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>
Message-ID: <20180214055453.-6JViGJATDQKlYAVfy-yDs__rvk3lnymgovJM6eCpqQ@z>

2018-02-14 0:02 GMT+08:00 Joe Perches <joe@perches.com>:
> On Tue, 2018-02-13 at 17:09 +0800, Greentime Hu wrote:
>> Add a maintainer information for the nds32(Andes) architecture.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -868,6 +868,17 @@ X:       drivers/iio/*/adjd*
>>  F:   drivers/staging/iio/*/ad*
>>  F:   drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>>
>> +ANDES ARCHITECTURE
>> +M:   Greentime Hu <green.hu@gmail.com>
>> +M:   Vincent Chen <deanbo422@gmail.com>
>> +T:   git https://github.com/andestech/linux.git
>> +S:   Supported
>> +F:   arch/nds32
>
> This should have a trailing /
>
> F:      arch/nds32/

Thank you Joe.
I will add this trailing /
>
>> +F:   Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
>> +F:   Documentation/devicetree/bindings/nds32

And here

>> +K:   nds32
>
> Perhaps this should be
>
> K:      \bnds32
>
> as there are some existing uses of nds32 in the current tree.
>
> or maybe case insensitive like
>
> K:      (?i:\bnds32)
> or
> K:      (?:\bnds32|\bNDS32)
>

I think it might be better to keep it "nds32" becaue some intrinsic
functions are defined with __nds32__xxx.
