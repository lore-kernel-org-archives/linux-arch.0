From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 13/21] csky: Library functions
Date: Thu, 18 Oct 2018 11:10:24 +0800
Message-ID: <20181018031024.GA15088@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <f884af8fffa1645c2650292a3001a2fbfc4cc390.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3hJ+Xt2xfTg=bkDBfahk7Z-3+Unt1MqmMQrRnCeJhVtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com, linfei_chen@c-sky.com, Mao Han <han_mao@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 05:24:36PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +++ b/arch/csky/lib/delay.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/delay.h>
> > +
> > +void __delay(unsigned long loops)
> > +{
> > +       asm volatile (
> > +               "mov r0, r0\n"
> > +               "1:declt %0\n"
> > +               "bf     1b"
> > +               : "=r"(loops)
> > +               : "0"(loops));
> > +}
> > +EXPORT_SYMBOL(__delay);
> > +
> > +void __const_udelay(unsigned long xloops)
> > +{
> > +       unsigned long long loops;
> > +
> > +       loops = (unsigned long long)xloops * loops_per_jiffy * HZ;
> > +
> > +       __delay(loops >> 32);
> > +}
> > +EXPORT_SYMBOL(__const_udelay);
> 
> I can't find any indication we discussed this part before. Can you
> explain (in the
> changelog and in a reply) if there is a reliable high-resolution clocksource
> available in the architecture? If you can read the elapsed time here instead of
> using the loops_per_jiffy estimate, that would make this more robust, as
> well as speed up the boot.
> 
> If you can't do that in general, that's fine, and you can add my
I'll add TODO list here, __delay should use get_cycles() and we didn't
implement __udelay() __ndelay() ... We'll improve it next.

Best Regards
 Guo Ren
