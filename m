From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH v6 2/3] clocksource/drivers/atcpit100: VDSO support
Date: Sat, 20 Jan 2018 19:23:51 +0800
Message-ID: <CAJsyPhyrFFvXUpf67ev4Apf-vstH33iwMt1ifr8LTiBB3bf+hA@mail.gmail.com>
References: <cover.1515766198.git.green.hu@gmail.com> <de648d211061a16c85ae0321625c51343ce5e5ce.1515766198.git.green.hu@gmail.com>
 <CAK8P3a1RQxBNGiVD11BuL5kUx+fn0QcA02j0HVPnMQ2j3WmMQQ@mail.gmail.com> <CAJsyPhxrKKN43usZ+mxAzci4G1qXnEXQ6ydT18MCiT7qQcMz3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36794 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeATLXw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Jan 2018 06:23:52 -0500
In-Reply-To: <CAJsyPhxrKKN43usZ+mxAzci4G1qXnEXQ6ydT18MCiT7qQcMz3g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>

Correct the composition

Dear Arnd:

1. Setup an additional memory mapping for clock hardware in user space
when establishing vdso-needed memory mapping
     In arch_setup_additional_pages(), kernel establishes memory
mapping for vdso's text and vdata page in user space. In order to make
clock hardware be accessible in user space, we try to establish an
additional memory mapping for clock hardware here based on clock
information from driver. This page is located between vdata page and
vdso text page. For safety, this region for clock accessing is
read-only.

2. Accessing clock hardware in vdso
    After step 1, clock hardware is accessible in user space through
memory-mapped IO. However, it is not enough to access a specific
register. Therefore, we store register offset information in vdata
page to make it visible in user space.  Now, vdso can derive the
address of counter register by summation of __get_timerpage() and
counter register offset where __get_timerpage() is used to derive the
virtual address of memory-mapped clock.

2018-01-20 19:11 GMT+08:00 Vincent Chen <deanbo422@gmail.com>:
> 2018-01-18 19:08 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:57 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>> From: Rick Chen <rickchen36@gmail.com>
>>>
>>> VDSO needs real-time cycle count to ensure the time accuracy.
>>> Unlike others, nds32 architecture does not define clock source,
>>> hence VDSO needs atcpit100 offering real-time cycle count
>>> to derive the correct time.
>>>
>>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>>> Signed-off-by: Rick Chen <rickchen36@gmail.com>
>>> Signed-off-by: Greentime Hu <green.hu@gmail.com>
>>
>> I'm a bit puzzled by this patch, can you explain how the vdso actually
>> manages to access the clock hardware? It looks like you make the
>> physical address and the register offset available to user space, but
>> how does it end up accessing it?
>>
>>       Arnd
>
> Dear Arnd:
>
> Accessing clock hardware in vdso can be divided to 2 step.
>
> 1. Setup an additional memory mapping for clock hardware in user space
> when establishing
>     vdso-needed memory mapping
>
>         In arch_setup_additional_pages(), kernel establishes memory
> mapping for vdso's text and vdata page
>     in user space. In order to make clock hardware be accessible in
> user space, we try to establish an
>     additional memory mapping for clock hardware here based on clock
> information from driver. This page is
>     located between vdata page and vdso text page. For safety, this
> region for clock accessing is read-only.
>
> 2. Accessing clock hardware in vdso
>
>         After step 1, clock hardware is accessible in user space
> through memory-mapped IO. However, it is not
>    enough to access a specific register. Therefore, we store register
> offset information in vdata page to make it
>    visible in user space.  Now, vdso can derive the address of counter
> register by summation of __get_timerpage()
>    and counter register offset where __get_timerpage() is used to
> derive the virtual address of memory-mapped
>    clock.
>
>
> Vincent
