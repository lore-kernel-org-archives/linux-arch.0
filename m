From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 12/29] nios2: Interrupt handling
Date: Tue, 15 Jul 2014 11:27:55 +0200
Message-ID: <5170097.X9RFbxSEnp@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-13-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-13-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tuesday 15 July 2014 16:45:39 Ley Foon Tan wrote:
> +#ifndef _ASM_NIOS2_IRQ_H
> +#define _ASM_NIOS2_IRQ_H
> +
> +#define NIOS2_CPU_NR_IRQS	32
> +/* Reserve 32 additional interrupts for GPIO IRQs */
> +#define NR_IRQS			(NIOS2_CPU_NR_IRQS + 32)

Is this intentional? I would expect that you use SPARSE_IRQ
instead and not define NR_IRQS.

> +#ifndef NO_IRQ
> +#define NO_IRQ			(-1)
> +#endif

New architectures should no longer define NO_IRQ. Please fix all users
you encounter instead.

> diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
> new file mode 100644
> index 0000000..8770d50
> --- /dev/null
> +++ b/arch/nios2/kernel/irq.c
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>

Maybe move this into drivers/irqchip/? Probably doesn't matter either way,
your choice.

	Arnd
