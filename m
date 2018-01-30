From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Tue, 30 Jan 2018 14:33:03 +0100
Message-ID: <CAK8P3a1iv=10_pfvtfvDwD9YH1HRAXwDy_m8SC=tV59HEDuSsg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
 <CAJsyPhx1B75GJCD2a_=m92ipq3oYsXxMGq9Bg9eCw_ALavWKMg@mail.gmail.com>
 <CAK8P3a1mwKLi2Cj43EQvwodPCQVwWfW5gjNtf+DLdyb8T49OWw@mail.gmail.com>
 <CAK8P3a3PxsmNXDqYbivfCTL8NmnR==M91yjv_VV0zXwjzLxHuA@mail.gmail.com> <CAJsyPhx090fPsdhkydoKDHDw+LwByT66JHJNT4Tb5N0s_O7MPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40851 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeA3NdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 08:33:05 -0500
In-Reply-To: <CAJsyPhx090fPsdhkydoKDHDw+LwByT66JHJNT4Tb5N0s_O7MPw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <deanbo422@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>

On Tue, Jan 30, 2018 at 11:01 AM, Vincent Chen <deanbo422@gmail.com> wrote:
> 2018-01-24 19:10 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Wed, Jan 24, 2018 at 12:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Jan 24, 2018 at 11:53 AM, Vincent Chen <deanbo422@gmail.com> wrote:
>>>> 2018-01-18 18:14 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>>
>>> Ok. I still wonder about the kernel part of this though: is it a good idea
>>> for user space to configure whether the kernel does unaligned
>>> accesses? I would think that the kernel should just be fixed in such
>>> a case.
>>
>> To clarify: I'm asking only about unaligned accesses from kernel code itself,
>> which is generally considered a bug when
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is disabled.
>>
>>       Arnd
>
> Thanks for your comments.
>
> For performance, we decide always disable
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS even if hardware supports
> unaligned accessing. Therefore, I will remove kernel unaligned accessing from
> nds32/mm/alignment.c. In other words, alignment.c only addresses unaligned
> accessing for user space.

I'm not really following that logic, let's go through that again so I understand
the situation better.

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS should be set if and
only if you have a CPU that does not need to trap on unaligned accesses.

What are the hardware capabilities on nds32? Do you have all three
categories:

a) some CPUs that always trap on unaligned access
b) some CPUs that never trap on unaligned access
c) some CPUs that can be configured to either trap or not trap by
    the kernel?

        Arnd
