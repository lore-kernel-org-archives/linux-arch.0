Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37306 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757677AbdLRLNk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 06:13:40 -0500
MIME-Version: 1.0
In-Reply-To: <a5dc2090640500d88aa3af2f6fe9e4c73f0634f2.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <a5dc2090640500d88aa3af2f6fe9e4c73f0634f2.1513577007.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Dec 2017 12:13:39 +0100
Message-ID: <CAK8P3a1EOD3WB=c4JybBD5bazhVJ5reuegyA1Hyoj-nPHpsW6g@mail.gmail.com>
Subject: Re: [PATCH v4 25/36] nds32: Miscellaneous header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Philippe Ombredanne <pombredanne@nexb.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171218111339.bpr2fk27NRa0vZPf4ZuoaVZ4T1ejJkCRXMs2EWjdsBM@z>

On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch introduces some miscellaneous header files.

> +static inline void __delay(unsigned long loops)
> +{
> +       __asm__ __volatile__(".align 2\n"
> +                            "1:\n"
> +                            "\taddi\t%0, %0, -1\n"
> +                            "\tbgtz\t%0, 1b\n"
> +                            :"=r"(loops)
> +                            :"0"(loops));
> +}
> +
> +static inline void __udelay(unsigned long usecs, unsigned long lpj)
> +{
> +       usecs *= (unsigned long)(((0x8000000000000000ULL / (500000 / HZ)) +
> +                                 0x80000000ULL) >> 32);
> +       usecs = (unsigned long)(((unsigned long long)usecs * lpj) >> 32);
> +       __delay(usecs);
> +}

Do you have a reliable clocksource that you can read here instead of doing the
loop? It's generally preferred to have an accurate delay if at all possible, the
delay loop calibration is only for those architectures that don't have any
way to observe how much time has passed accurately.

       Arnd
