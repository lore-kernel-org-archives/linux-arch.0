From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Wed, 4 Jul 2018 13:08:22 +0800
Message-ID: <20180704050822.GA23536@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 03, 2018 at 11:28:03AM +0200, Thomas Gleixner wrote:
> -EEMPTYCHANGELOG
Ok, I'll seperate this patchset's changelog from cover-letter in next
version patch.

> > +#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
> 
> I assume you meant _LEGACY
Yes.

> > +#include <asm/reg_ops.h>
> > +#endif
> 
> Also why making the include conditional. Just include it always and be done
> with it.
Ok.

> > +static void __iomem *reg_base;
> > +
> > +#define INTC_ICR	0x00
> > +#define INTC_ISR	0x00
> > +#define INTC_NEN31_00	0x10
> > +#define INTC_NEN63_32	0x28
> > +#define INTC_IFR31_00	0x08
> > +#define INTC_IFR63_32	0x20
> > +#define INTC_SOURCE	0x40
> > +
> > +#define INTC_IRQS	64
> > +
> > +#define INTC_ICR_AVE	BIT(31)
> > +
> > +#define VEC_IRQ_BASE	32
> > +
> > +static struct irq_domain *root_domain;
> > +
> > +static void __init ck_set_gc(void __iomem *reg_base, u32 irq_base,
> > +			     u32 mask_reg)
> > +{
> > +	struct irq_chip_generic *gc;
> > +
> > +	gc = irq_get_domain_generic_chip(root_domain, irq_base);
> > +	gc->reg_base = reg_base;
> > +	gc->chip_types[0].regs.mask = mask_reg;
> > +	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
> > +	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
> > +}
> > +
> > +static struct irq_domain *root_domain;
> 
> You have the same declaration 10 lines above already....
Opps, thx. I'll remove.

> > +static void ck_irq_handler(struct pt_regs *regs)
> > +{
> > +#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
> > +	irq_hw_number_t irq = ((mfcr("psr") >> 16) & 0xff) - VEC_IRQ_BASE;
> > +#else
> > +	irq_hw_number_t irq = readl_relaxed(reg_base + INTC_ISR) & 0x3f;
> > +#endif
> 
> You can avoid the ifdeffery by doing:
> 
> 	irq_hw_number_t irq;
> 
> 	if (IS_ENABLED(CONFIG_CSKY_VECIRQ_LEGENCY))
> 		irq = ((mfcr("psr") >> 16) & 0xff) - VEC_IRQ_BASE;
> 	else
> 		irq = readl_relaxed(reg_base + INTC_ISR) & 0x3f;
> 
> which makes the whole thing more readable.
Ok, good idea.

> > +#define expand_byte_to_word(i) (i|(i<<8)|(i<<16)|(i<<24))
> > +static inline void setup_irq_channel(void __iomem *reg_base)
> 
> Please do not glue a define and a function declaration togetther w/o a new
> line in between. That's really hard to parse.
> 
> Also please make that expand macro an inline function.
> 
> > +{
> > +	int i;
> 
> Bah: writel_relaxed(u32 value, ...). So why 'int' ? Just because?
> 
> > +
> > +	/*
> > +	 * There are 64 irq nums and irq-channels and one byte per channel.
> > +	 * Setup every channel with the same hwirq num.
> 
> This is magic and not understandable for an outsider.
> 
> > +	 */
> > +	for (i = 0; i < INTC_IRQS; i += 4) {
> > +		writel_relaxed(expand_byte_to_word(i) + 0x00010203,
> 
> No magic numbers please w/o explanation. And '+' is the wrong operator
> here, really.  Stick that into the expand function:
> 
> static inline u32 build_intc_ctrl(u32 idx)
> {
> 	u32 res;
> 
> 	/*
> 	 * Set the same index for each channel (or whatever
> 	 * this means in reality).
> 	 */
> 	res = idx | (idx << 8) | (idx || 16) | (idx << 24);
> 
> 	/*
> 	 * Set the channel magic number in descending order because
> 	 * the most significant bit comes first. (Replace with
> 	 * something which has not been pulled out of thin air).
> 	 */
> 	return res | 0x00010203;
> }
> 
> Hmm?
That's Ok. And here is my implementation:

static inline u32 build_intc_ctrl(u32 idx)
{
	/*
	 * One channel is one byte in a word-width register, so
	 * there are four channels in a word-width register.
	 *
	 * Set the same index for each channel and it will make
	 * "irq num = channel num".
	 */
	return (idx             | ((idx + 1) << 8) |
	      ((idx + 2) << 16) | ((idx + 3) << 24));
}
Hmm? (No magic number)

> > +#ifndef CONFIG_CSKY_VECIRQ_LEGENCY
> > +	writel_relaxed(INTC_ICR_AVE, reg_base + INTC_ICR);
> > +#else
> > +	writel_relaxed(0, reg_base + INTC_ICR);
> > +#endif
> 
> See above.
Ok, use if (IS_ENABLED(CONFIG_CSKY_VECIRQ_LEGENCY))

> > +++ b/drivers/irqchip/irq-csky-v2.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> 
> Please stick an empty newline here for separation
Ok

> > +	static void __iomem	*reg_base;
> > +	irq_hw_number_t		hwirq;
> > +
> > +	reg_base = *this_cpu_ptr(&intcl_reg);
> 
> Wheee!
> 
> 	static void __iomem *reg_base = this_cpu_read(intcl_reg);
> 	irq_hw_number_t	hwirq;
> 
> Hmm?
Thx for the tips and I'll use this_cpu_read() without static.
 	void __iomem *reg_base = this_cpu_read(intcl_reg);

> > +	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + (4*(d->hwirq - COMM_IRQ_BASE)));
> 
> Spaces between '4' and '*' and '(d->)' please. And to avoid the overly long
> line use a local variable to calculate the value.
Ok.

> > +	} else
> > +		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_fasteoi_irq);
> 
> The else path wants curly braces as well.
Ok.

> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
> 
> See above
Ok, stick an empty newline

> > +		writel_relaxed(expand_byte_to_word(i) + 0x03020100,
> 
> This magic number is the reverse of the above magic. Is that intentional.
> 
> > +			       reg_base + INTC_SOURCE + i);
> > +	}
> 
> See above. 
No magic number and use inline func.


> > +static int __init
> > +intc_init(struct device_node *node, struct device_node *parent)
> > +{
> > +	u32 clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> > +	int ret;
> 
> Aside of that the whole thing might share the code with the other one, but
> it might not be worth it. At least this wants to be documented in the
> changelog why sharing the code is not useful...
Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
one file eg: irq-csky.c? 

Guo Ren
