From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 19/29] nios2: Time keeping
Date: Tue, 15 Jul 2014 11:45:17 +0200
Message-ID: <5348663.eHVXUR5shS@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-20-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-20-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tuesday 15 July 2014 16:45:46 Ley Foon Tan wrote:
> +
> +static inline void __delay(unsigned long loops)
> +{
> +	int dummy;
> +
> +	__asm__ __volatile__(
> +	"1:\n\t"
> +	"    beq    %0,zero,2f\n\t"
> +	"    addi   %0, %0, -1\n\t"
> +	"    br     1b\n\t"
> +	"2:\n\t"
> +	:  "=r" (dummy)		/* Need output for optimizer */
> +	:  "0" (loops));	/* %0  Input */
> +}

Do you have a reliable clock source? If you do, it would be better
to replace the delay loop with an implementation that waits for
the exact time to pass instead. This will also avoid the loop
calibration during boot and give you better boot times.

> +#ifndef _ASM_NIOS2_TIMEX_H
> +#define _ASM_NIOS2_TIMEX_H
> +
> +/* Supply dummy tick-rate. Real value will be read from devicetree */
> +#define CLOCK_TICK_RATE		(HZ * 100000UL)
> +
> +#include <asm-generic/timex.h>
> +
> +#endif

CLOCK_TICK_RATE is no longer used anywhere, no need for this file.

> diff --git a/arch/nios2/kernel/time.c b/arch/nios2/kernel/time.c
> new file mode 100644
> index 0000000..111ade1
> --- /dev/null
> +++ b/arch/nios2/kernel/time.c

Maybe move this to drivers/clocksource? Same argument as for the
irqchip driver, so either move both or neither.

	Arnd
