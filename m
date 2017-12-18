Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:39253 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757935AbdLRLpb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 06:45:31 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0xQ4mYnkxjWTTEcvpJg6SfcA4WZKNkopa93_6Mz_YOGw@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <ec54d5ac8067e2ff542f69fc2967182922870b83.1513577007.git.green.hu@gmail.com>
 <CAK8P3a0xQ4mYnkxjWTTEcvpJg6SfcA4WZKNkopa93_6Mz_YOGw@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Mon, 18 Dec 2017 19:44:49 +0800
Message-ID: <CAEbi=3cAoP85hc-0rMwPoJ8=BjfG=4HaD89rqbEdiA7saUx7yQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/36] nds32: Device specific operations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Philippe Ombredanne <pombredanne@nexb.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171218114449.Jgu0yplETrTQk3JzuE6HEZRuasIOMkUk_eSWSlt9aC0@z>

2017-12-18 19:26 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>> +#define __ASM_NDS32_IO_H
>> +
>> +extern void iounmap(void __iomem *addr);
>
> The prototype here should probably include 'volatile' to avoid warnings in an
> allmodconfig build.
>

Thanks. I will update it like this.
extern void iounmap(volatile void __iomem *addr);
