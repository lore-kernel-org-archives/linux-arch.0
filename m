From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Tue, 3 Jul 2018 11:28:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de>
References: <cover.1530465325.git.ren_guo@c-sky.com> <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Mon, 2 Jul 2018, Guo Ren wrote:

-EEMPTYCHANGELOG

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> +
> +#ifdef CONFIG_CSKY_VECIRQ_LEGENCY

I assume you meant _LEGACY

> +#include <asm/reg_ops.h>
> +#endif

Also why making the include conditional. Just include it always and be done
with it.

> +static void __iomem *reg_base;
> +
> +#define INTC_ICR	0x00
> +#define INTC_ISR	0x00
> +#define INTC_NEN31_00	0x10
> +#define INTC_NEN63_32	0x28
> +#define INTC_IFR31_00	0x08
> +#define INTC_IFR63_32	0x20
> +#define INTC_SOURCE	0x40
> +
> +#define INTC_IRQS	64
> +
> +#define INTC_ICR_AVE	BIT(31)
> +
> +#define VEC_IRQ_BASE	32
> +
> +static struct irq_domain *root_domain;
> +
> +static void __init ck_set_gc(void __iomem *reg_base, u32 irq_base,
> +			     u32 mask_reg)
> +{
> +	struct irq_chip_generic *gc;
> +
> +	gc = irq_get_domain_generic_chip(root_domain, irq_base);
> +	gc->reg_base = reg_base;
> +	gc->chip_types[0].regs.mask = mask_reg;
> +	gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
> +	gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
> +}
> +
> +static struct irq_domain *root_domain;

You have the same declaration 10 lines above already....

> +static void ck_irq_handler(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_CSKY_VECIRQ_LEGENCY
> +	irq_hw_number_t irq = ((mfcr("psr") >> 16) & 0xff) - VEC_IRQ_BASE;
> +#else
> +	irq_hw_number_t irq = readl_relaxed(reg_base + INTC_ISR) & 0x3f;
> +#endif

You can avoid the ifdeffery by doing:

	irq_hw_number_t irq;

	if (IS_ENABLED(CONFIG_CSKY_VECIRQ_LEGENCY))
		irq = ((mfcr("psr") >> 16) & 0xff) - VEC_IRQ_BASE;
	else
		irq = readl_relaxed(reg_base + INTC_ISR) & 0x3f;

which makes the whole thing more readable.

> +	handle_domain_irq(root_domain, irq, regs);
> +}
> +
> +#define expand_byte_to_word(i) (i|(i<<8)|(i<<16)|(i<<24))
> +static inline void setup_irq_channel(void __iomem *reg_base)

Please do not glue a define and a function declaration togetther w/o a new
line in between. That's really hard to parse.

Also please make that expand macro an inline function.

> +{
> +	int i;

Bah: writel_relaxed(u32 value, ...). So why 'int' ? Just because?

> +
> +	/*
> +	 * There are 64 irq nums and irq-channels and one byte per channel.
> +	 * Setup every channel with the same hwirq num.

This is magic and not understandable for an outsider.

> +	 */
> +	for (i = 0; i < INTC_IRQS; i += 4) {
> +		writel_relaxed(expand_byte_to_word(i) + 0x00010203,

No magic numbers please w/o explanation. And '+' is the wrong operator
here, really.  Stick that into the expand function:

static inline u32 build_intc_ctrl(u32 idx)
{
	u32 res;

	/*
	 * Set the same index for each channel (or whatever
	 * this means in reality).
	 */
	res = idx | (idx << 8) | (idx || 16) | (idx << 24);

	/*
	 * Set the channel magic number in descending order because
	 * the most significant bit comes first. (Replace with
	 * something which has not been pulled out of thin air).
	 */
	return res | 0x00010203;
}

Hmm?

> +			       reg_base + INTC_SOURCE + i);
> +	}
> +}
> +
> +static int __init
> +csky_intc_v1_init(struct device_node *node, struct device_node *parent)
> +{
> +	u32 clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> +	int ret;
> +
> +	if (parent) {
> +		pr_err("C-SKY Intc not a root irq controller\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_base = of_iomap(node, 0);
> +	if (!reg_base) {
> +		pr_err("C-SKY Intc unable to map: %p.\n", node);
> +		return -EINVAL;
> +	}
> +
> +	writel_relaxed(0, reg_base + INTC_NEN31_00);
> +	writel_relaxed(0, reg_base + INTC_NEN63_32);
> +
> +#ifndef CONFIG_CSKY_VECIRQ_LEGENCY
> +	writel_relaxed(INTC_ICR_AVE, reg_base + INTC_ICR);
> +#else
> +	writel_relaxed(0, reg_base + INTC_ICR);
> +#endif

See above.

> +++ b/drivers/irqchip/irq-csky-v2.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.

Please stick an empty newline here for separation

> +#include <linux/kernel.h>

...

> +static void csky_irq_v2_handler(struct pt_regs *regs)
> +{
> +	static void __iomem	*reg_base;
> +	irq_hw_number_t		hwirq;
> +
> +	reg_base = *this_cpu_ptr(&intcl_reg);

Wheee!

	static void __iomem *reg_base = this_cpu_read(intcl_reg);
	irq_hw_number_t	hwirq;

Hmm?

> +
> +#ifdef CONFIG_SMP
> +static int csky_irq_set_affinity(struct irq_data *d,
> +				 const struct cpumask *mask_val,
> +				 bool force)
> +{
> +	unsigned int cpu;
> +
> +	if (!force)
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +	else
> +		cpu = cpumask_first(mask_val);
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	/* Enable interrupt destination */
> +	cpu |= BIT(31);
> +
> +	writel_relaxed(cpu, INTCG_base + INTCG_CIDSTR + (4*(d->hwirq - COMM_IRQ_BASE)));

Spaces between '4' and '*' and '(d->)' please. And to avoid the overly long
line use a local variable to calculate the value.

> +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +
> +	return IRQ_SET_MASK_OK_DONE;
> +}
> +#endif
> +
> +static struct irq_chip csky_irq_chip = {
> +	.name           = "C-SKY SMP Intc V2",
> +	.irq_eoi	= csky_irq_v2_eoi,
> +	.irq_enable	= csky_irq_v2_enable,
> +	.irq_disable	= csky_irq_v2_disable,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity = csky_irq_set_affinity,
> +#endif
> +};
> +
> +static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
> +			      irq_hw_number_t hwirq)
> +{
> +	if(hwirq < COMM_IRQ_BASE) {
> +		irq_set_percpu_devid(irq);
> +		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_percpu_irq);
> +	} else
> +		irq_set_chip_and_handler(irq, &csky_irq_chip, handle_fasteoi_irq);

The else path wants curly braces as well. 

> +
> +	return 0;
> +}
> +++ b/drivers/irqchip/irq-nationalchip.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.

See above

> +#include <linux/kernel.h>

...

> +static struct irq_domain *root_domain;
> +
> +static void nc_irq_handler(struct pt_regs *regs)
> +{
> +	u32 status, irq;
> +
> +	do {
> +		status = readl_relaxed(reg_base + INTC_NINT31_00);
> +		if (status) {
> +			irq = __ffs(status);
> +		} else {
> +			status = readl_relaxed(reg_base + INTC_NINT63_32);
> +			if (status)
> +				irq = __ffs(status) + 32;
> +			else
> +				return;
> +		}
> +		handle_domain_irq(root_domain, irq, regs);
> +	} while(1);
> +}
> +

> +#define expand_byte_to_word(i) (i|(i<<8)|(i<<16)|(i<<24))
> +static inline void setup_irq_channel(void __iomem *reg_base)
> +{
> +	int i;
> +
> +	/*
> +	 * There are 64 irq nums and irq-channels and one byte per channel.
> +	 * Setup every channel with the same hwirq num.
> +	 */
> +	for (i = 0; i < INTC_IRQS; i += 4) {
> +		writel_relaxed(expand_byte_to_word(i) + 0x03020100,

This magic number is the reverse of the above magic. Is that intentional.

> +			       reg_base + INTC_SOURCE + i);
> +	}

See above. 

> +}
> +
> +static int __init
> +intc_init(struct device_node *node, struct device_node *parent)
> +{
> +	u32 clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
> +	int ret;

Aside of that the whole thing might share the code with the other one, but
it might not be worth it. At least this wants to be documented in the
changelog why sharing the code is not useful...

Thanks,

	tglx
