From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/19] csky: IRQ handling
Date: Mon, 19 Mar 2018 14:16:37 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803191413300.2010@nanos.tec.linutronix.de>
References: <cover.1521399976.git.ren_guo@c-sky.com> <28baa2d92e5c3145afdff68ca784075afbb64d88.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28baa2d92e5c3145afdff68ca784075afbb64d88.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org



On Mon, 19 Mar 2018, Guo Ren wrote:

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  arch/csky/include/asm/irq.h      | 12 +++++++++
>  arch/csky/include/asm/irqflags.h | 55 ++++++++++++++++++++++++++++++++++++++++
>  arch/csky/kernel/irq.c           | 41 ++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 arch/csky/include/asm/irq.h
>  create mode 100644 arch/csky/include/asm/irqflags.h
>  create mode 100644 arch/csky/kernel/irq.c
> 
> diff --git a/arch/csky/include/asm/irq.h b/arch/csky/include/asm/irq.h
> new file mode 100644
> index 0000000..f68e868
> --- /dev/null
> +++ b/arch/csky/include/asm/irq.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_IRQ_H
> +#define __ASM_CSKY_IRQ_H
> +
> +#define NR_IRQS CONFIG_CSKY_NR_IRQS
> +
> +#include <asm-generic/irq.h>
> +
> +extern unsigned int (*csky_get_auto_irqno) (void);
> +
> +#endif /* __ASM_CSKY_IRQ_H */
> diff --git a/arch/csky/include/asm/irqflags.h b/arch/csky/include/asm/irqflags.h
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +	unsigned long flags;

Newline between declaration and code please.

> +	asm volatile(
> +		"mfcr	%0, psr	\n"
> +		"psrclr	ie	\n"
> +		:"=r"(flags));

> +++ b/arch/csky/kernel/irq.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +
> +unsigned int (*csky_get_auto_irqno) (void) = NULL;
> +
> +void csky_do_IRQ(int irq, struct pt_regs *regs)

static? If not, then it needs a declaration in a header somewhere.

> +{
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irq_enter();
> +	generic_handle_irq(irq);
> +	irq_exit();
> +
> +	set_irq_regs(old_regs);
> +}
> +
> +asmlinkage void csky_do_auto_IRQ(struct pt_regs *regs)
> +{
> +	unsigned long irq, psr;
> +
> +	asm volatile("mfcr %0, psr":"=r"(psr));
> +
> +	irq = (psr >> 16) & 0xff;
> +
> +	if (irq == 10)
> +		irq = csky_get_auto_irqno();
> +	else
> +		irq -= 32;

Please add a comment explaining this magic here. Magic numbers w/o
explanation are bad.
