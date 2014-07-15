From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 12/29] nios2: Interrupt handling
Date: Tue, 15 Jul 2014 11:51:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407151147540.24854@nanos>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-13-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46854 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758039AbaGOJvH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:51:07 -0400
In-Reply-To: <1405413956-2772-13-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com

On Tue, 15 Jul 2014, Ley Foon Tan wrote:
> +#ifndef _ASM_NIOS2_IRQ_H
> +#define _ASM_NIOS2_IRQ_H
> +
> +#define NIOS2_CPU_NR_IRQS	32
> +/* Reserve 32 additional interrupts for GPIO IRQs */
> +#define NR_IRQS			(NIOS2_CPU_NR_IRQS + 32)

Please use sparse irqs. Hardcoded limits tend to work out really bad.

> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/of.h>
> +
> +asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
> +{
> +	struct pt_regs *oldregs = set_irq_regs(regs);
> +	int irq;
> +
> +	irq_enter();
> +	irq = irq_find_mapping(NULL, hwirq);
> +	generic_handle_irq(irq);
> +	irq_exit();
> +
> +	set_irq_regs(oldregs);
> +}
> +
> +static void chip_unmask(struct irq_data *d)
> +{
> +	u32 ien;
> +	ien = RDCTL(CTL_IENABLE);
> +	ien |= (1 << d->hwirq);
> +	WRCTL(CTL_IENABLE, ien);

So this is UP only, right?

Also why don't you cache the register content so spare the extra read
from the hardware?

Thanks,

	tglx
