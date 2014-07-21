From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v2 19/29] nios2: Time keeping
Date: Mon, 21 Jul 2014 19:10:25 +0800
Message-ID: <CAFiDJ58t6pNgkAda2PRpoPS=UsBLKcm0GxP1kbNBms_2pkkmdA@mail.gmail.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<5348663.eHVXUR5shS@wuerfel>
	<CAFiDJ5-v7BEuLNEn0OyLpbLUJkeeZuKnDrFZZwQrjhFSU4PZSw@mail.gmail.com>
	<17740341.0lUJQdnn9z@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17740341.0lUJQdnn9z@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 21, 2014 at 6:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 21 July 2014 18:07:02 Ley Foon Tan wrote:
>> >
>> >> +#ifndef _ASM_NIOS2_TIMEX_H
>> >> +#define _ASM_NIOS2_TIMEX_H
>> >> +
>> >> +/* Supply dummy tick-rate. Real value will be read from devicetree */
>> >> +#define CLOCK_TICK_RATE              (HZ * 100000UL)
>> >> +
>> >> +#include <asm-generic/timex.h>
>> >> +
>> >> +#endif
>> >
>> > CLOCK_TICK_RATE is no longer used anywhere, no need for this file.
>>
>> I found jiffies.h still using this define. Can we still remove this?
>> In include/linux/jiffies.h:
>> #define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)   /* For divider */
>>
>
> Ah, I thought we had killed off LATCH, but at least it is only used
> on architecture specific code, and only in two files:
>
> arch/x86/kernel/apm_32.c:       outb_p(LATCH & 0xff, PIT_CH0);  /* LSB */
> arch/unicore32/kernel/time.c:   writel(readl(OST_OSMR0) - LATCH, OST_OSCR);
>
> We could decide to move the LATCH definition into those two files to
> remove it from common code, but it doesn't really hurt otherwise,
> and everything works fine if you don't define CLOCK_TICK_RATE on
> architectures that don't need LATCH or CLOCK_TICK_RATE in their
> architecture-specific code.

Okay, will remove CLOCK_TICK_RATE define.

Thanks.

Regards
Ley Foon
