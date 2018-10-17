Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44685 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:21:04 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:24:36 +0200
Message-ID: <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
Subject: Re: [PATCH V9 13/21] csky: Library functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com, linfei_chen@c-sky.com, Mao Han <han_mao@c-sky.com>
Message-ID: <20181017152436.8LL0y0jNorUKEawUMZMcUyb1OrETmIEBbRwe5b-0SC0@z>

On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:

> +++ b/arch/csky/lib/delay.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +
> +void __delay(unsigned long loops)
> +{
> +       asm volatile (
> +               "mov r0, r0\n"
> +               "1:declt %0\n"
> +               "bf     1b"
> +               : "=r"(loops)
> +               : "0"(loops));
> +}
> +EXPORT_SYMBOL(__delay);
> +
> +void __const_udelay(unsigned long xloops)
> +{
> +       unsigned long long loops;
> +
> +       loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
> +
> +       __delay(loops >> 32);
> +}
> +EXPORT_SYMBOL(__const_udelay);

I can't find any indication we discussed this part before. Can you
explain (in the
changelog and in a reply) if there is a reliable high-resolution clocksource
available in the architecture? If you can read the elapsed time here instead of
using the loops_per_jiffy estimate, that would make this more robust, as
well as speed up the boot.

If you can't do that in general, that's fine, and you can add my
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
