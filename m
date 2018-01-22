Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44272 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeAVJxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jan 2018 04:53:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAEbi=3dF-ekx8oz0vjd3WfM7qO755rW46Q=+i-MnQC=4N1=EMA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <5930d2df872116555cc553284b6c111dce29e298.1515766253.git.green.hu@gmail.com>
 <CAK8P3a143yQ72+QGZSxpiFc7p8Hb7PXuCybJBFoLRSBaZ2uw4g@mail.gmail.com>
 <CAEbi=3dJm=M-1UjUftb5qb0YOOsq92zzF86xeaVOhzULjvT3eA@mail.gmail.com>
 <CAK8P3a3UCrMbTn1JMOGKCSV4WRw9T9tU+pey1t6Fzitf2V0Bvw@mail.gmail.com> <CAEbi=3dF-ekx8oz0vjd3WfM7qO755rW46Q=+i-MnQC=4N1=EMA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jan 2018 10:53:07 +0100
Message-ID: <CAK8P3a0Sz=O1j2t4ZnTY8X8C0Br68sTjNMTKrYQ--8s1OC5DBg@mail.gmail.com>
Subject: Re: [PATCH v6 06/36] nds32: Kernel booting and initialization
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180122095307.ffe2BU1SCv89EToHOhcELqwEII4R5ZeWqK_bGbMiFVE@z>

On Mon, Jan 22, 2018 at 10:49 AM, Greentime Hu <green.hu@gmail.com> wrote:
> 2018-01-20 0:41 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:

>>> This implementation is referenced from openrisc.
>>> https://lkml.org/lkml/2017/11/17/228
>>
>> It's correct on openrisc, because that has a reliable cycle counter,
>> and that gets used in its delay function:
>>
>> void __delay(unsigned long cycles)
>> {
>>         cycles_t start = get_cycles();
>>         while ((get_cycles() - start) < cycles)
>>                 cpu_relax();
>> }
>>
>> In my review comment that you cited, I assumed that nds32 had similar
>> hardware.
>>
>> However, as you explained earlier, the nds32 architecture does not provide
>> a cycle counter and the clocksource resolution is not high enough to
>> be a good replacement, so you have to use the traditional delay
>> calibration.
>>
>
> Hi, Arnd:
>
> Thank you for your explanation.
> Will it be ok if I code it like this?
>
> config GENERIC_CALIBRATE_DELAY
>        def_bool y

Yes, I think that should be sufficient.

       Arnd
