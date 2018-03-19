From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Date: Mon, 19 Mar 2018 14:30:42 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803191417140.2010@nanos.tec.linutronix.de>
References: <cover.1521399976.git.ren_guo@c-sky.com> <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Mar 2018, Guo Ren wrote:
> +static void ck_irq_mask(struct irq_data *d)
> +{
> +	unsigned int temp, irq;
> +
> +	irq = d->irq;
> +
> +	if (irq < 32) {
> +		temp = __raw_readl(CK_VA_INTC_NEN31_00);
> +		temp &= ~(1 << irq);
> +		__raw_writel(temp, CK_VA_INTC_NEN31_00);
> +	} else {
> +		temp = __raw_readl(CK_VA_INTC_NEN63_32);
> +		temp &= ~(1 << (irq -32));
> +		__raw_writel(temp, CK_VA_INTC_NEN63_32);
> +	}
> +}
> +
> +static void ck_irq_unmask(struct irq_data *d)
> +{
> +	unsigned int temp, irq;
> +
> +	irq = d->irq;
> +
> +	/* set IFR to support rising edge triggering */
> +	if (irq < 32) {
> +		temp = __raw_readl(CK_VA_INTC_IFR31_00);
> +		temp &= ~(1 << irq);
> +		__raw_writel(temp, CK_VA_INTC_IFR31_00);
> +	} else {
> +		temp = __raw_readl(CK_VA_INTC_IFR63_32);
> +		temp &= ~(1 << (irq -32));
> +		__raw_writel(temp, CK_VA_INTC_IFR63_32);
> +	}
> +
> +	if (irq < 32) {
> +		temp = __raw_readl(CK_VA_INTC_NEN31_00);
> +		temp |= 1 << irq;
> +		__raw_writel(temp, CK_VA_INTC_NEN31_00);
> +	} else {
> +		temp = __raw_readl(CK_VA_INTC_NEN63_32);
> +		temp |= 1 << (irq -32);
> +		__raw_writel(temp, CK_VA_INTC_NEN63_32);
> +	}
> +}
> +
> +static struct irq_chip ck_irq_chip = {
> +	.name		= "csky_intc_v1",
> +	.irq_mask	= ck_irq_mask,
> +	.irq_unmask	= ck_irq_unmask,
> +};

Please use the generic interrupt chip infrastructure for this.

> +static unsigned int ck_get_irqno(void)
> +{
> +	unsigned int temp;

newline between declaration and code.

> +	temp = __raw_readl(CK_VA_INTC_ISR);
> +	return temp & 0x3f;
> +};
> +
> +static int __init
> +__intc_init(struct device_node *np, struct device_node *parent, bool ave)

What is 'ave'? 

> +{
> +	struct irq_domain *root_domain;
> +	int i;
> +
> +	csky_get_auto_irqno = ck_get_irqno;
> +
> +	if (parent)
> +		panic("pic not a root intc\n");
> +
> +	intc_reg = (unsigned int)of_iomap(np, 0);
> +	if (!intc_reg)
> +		panic("%s, of_iomap err.\n", __func__);
> +
> +	__raw_writel(0, CK_VA_INTC_NEN31_00);
> +	__raw_writel(0,	CK_VA_INTC_NEN63_32);
> +
> +	if (ave == true)

  	if (ave)

> +		__raw_writel( 0xc0000000, CK_VA_INTC_ICR);

No magic numbers. Please use proper defines.

> +	else
> +		__raw_writel( 0x0, CK_VA_INTC_ICR);
> +	/*
> +	 * csky irq ctrl has 64 sources.
> +	 */
> +	#define INTC_IRQS 64

No defines in code.

> +	for (i=0; i<INTC_IRQS; i=i+4)

checkpatch.pl would have told you what's wrong with the above

> +		__raw_writel((i+3)|((i+2)<<8)|((i+1)<<16)|(i<<24),

Eew. Tons of magic numbers and a unreadable coding style. Please use an
inline function with proper comments to calculate that value
> +				CK_VA_INTC_SOURCE + i);
> +
> +	root_domain = irq_domain_add_legacy(np, INTC_IRQS, 0, 0, &ck_irq_ops, NULL);
> +	if (!root_domain)
> +		panic("root irq domain not available\n");
> +
> +	irq_set_default_host(root_domain);
> +
> +	return 0;
> +}
> +
> +static int __init
> +intc_init(struct device_node *np, struct device_node *parent)
> +{
> +

Stray newline

> +	return __intc_init(np, parent, false);
> +}
> +IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", intc_init);
> +
> +/*
> + * use auto vector exceptions 10 for interrupt.
> + */
> +static int __init
> +intc_init_ave(struct device_node *np, struct device_node *parent)
> +{
> +	return __intc_init(np, parent, true);

Why is that 'ave' thing not a property of device tree?

> +}
> +IRQCHIP_DECLARE(csky_intc_v1_ave, "csky,intc-v1,ave", intc_init_ave);
> +
> +static unsigned int intc_reg;
> +
> +static void nc_irq_mask(struct irq_data *d)
> +{
> +	unsigned int mask, irq;
> +
> +	irq = d->irq;
> +
> +	if (irq < 32) {
> +		mask = __raw_readl(NC_VA_INTC_NMASK31_00);
> +		mask |= 1 << irq;
> +		__raw_writel(mask, NC_VA_INTC_NMASK31_00);
> +	} else {
> +		mask = __raw_readl(NC_VA_INTC_NMASK63_32);
> +		mask |= 1 << (irq - 32);
> +		__raw_writel(mask, NC_VA_INTC_NMASK63_32);
> +	}
> +}
> +
> +static void nc_irq_unmask(struct irq_data *d)
> +{
> +	unsigned int mask, irq;
> +
> +	irq = d->irq;
> +
> +	if (irq < 32) {
> +		mask = __raw_readl(NC_VA_INTC_NMASK31_00);
> +		mask &= ~( 1 << irq);
> +		__raw_writel(mask, NC_VA_INTC_NMASK31_00);
> +	} else {
> +		mask = __raw_readl( NC_VA_INTC_NMASK63_32);
> +		mask &= ~(1 << (irq - 32));
> +		__raw_writel(mask, NC_VA_INTC_NMASK63_32);
> +	}
> +}
> +
> +static void nc_irq_en(struct irq_data *d)
> +{
> +	unsigned int mask, irq;
> +
> +	irq = d->irq;
> +
> +	if (irq < 32) {
> +		mask = 1 << irq;
> +		__raw_writel(mask, NC_VA_INTC_NENSET31_00);
> +	} else {
> +		mask = 1 << (irq - 32);
> +		__raw_writel(mask, NC_VA_INTC_NENSET63_32);
> +	}
> +
> +	nc_irq_unmask(d);
> +}
> +
> +static void nc_irq_dis(struct irq_data *d)
> +{
> +	unsigned int mask, irq;
> +
> +	irq = d->irq;
> +
> +	if (irq < 32) {
> +		mask = 1 << irq;
> +		__raw_writel(mask, NC_VA_INTC_NENCLR31_00);
> +	} else {
> +		mask = 1 << (irq - 32);
> +		__raw_writel(mask, NC_VA_INTC_NENCLR63_32);
> +	}
> +
> +	nc_irq_mask(d);
> +}
> +
> +struct irq_chip nc_irq_chip = {
> +	.name =		"nationalchip_intc_v1",
> +	.irq_mask =	nc_irq_mask,
> +	.irq_unmask =	nc_irq_unmask,
> +	.irq_enable =	nc_irq_en,
> +	.irq_disable =	nc_irq_dis,
> +};

Again. This all can use the generic interrupt chip.

> +
> +inline int ff1_64(unsigned int hi, unsigned int lo)

What on earth means ff1_64?

> +{
> +	int result;
> +	asm volatile(
> +		"ff1 %0\n"
> +		:"=r"(hi)
> +		:"r"(hi)
> +		:
> +	);
> +
> +	asm volatile(
> +		"ff1 %0\n"
> +		:"=r"(lo)
> +		:"r"(lo)
> +		:
> +	);

So you want to decode the interrupt number from a bitfield. What's wrong
with ffs()?

> +	if( lo != 32 )
> +		result = 31-lo;

Why is this subtracted? That code makes no sense w/o comments.

> +	else if( hi != 32 ) result = 31-hi + 32;
> +	else {
> +		printk("nc_get_irqno error hi:%x, lo:%x.\n", hi, lo);
> +		result = NR_IRQS;
> +	}

Pleas use braces consistently.

> +	return result;
> +}
> +
> +unsigned int nc_get_irqno(void)

static?

> +{
> +	unsigned int nint64hi, nint64lo, irq_no;
> +
> +	nint64lo = __raw_readl(NC_VA_INTC_NINT31_00);
> +	nint64hi = __raw_readl(NC_VA_INTC_NINT63_32);
> +	irq_no = ff1_64(nint64hi, nint64lo);
> +
> +	return irq_no;
> +}


> +static int __init
> +intc_init(struct device_node *intc, struct device_node *parent)
> +{
> +	struct irq_domain *root_domain;
> +	unsigned int i;
> +
> +	if (parent)
> +		panic("DeviceTree incore intc not a root irq controller\n");
> +
> +	csky_get_auto_irqno = nc_get_irqno;
> +
> +	intc_reg = (unsigned int) of_iomap(intc, 0);
> +	if (!intc_reg)
> +		panic("Nationalchip Intc Reg: %x.\n", intc_reg);
> +
> +	__raw_writel(0xffffffff, NC_VA_INTC_NENCLR31_00);
> +	__raw_writel(0xffffffff, NC_VA_INTC_NENCLR63_32);
> +	__raw_writel(0xffffffff, NC_VA_INTC_NMASK31_00);
> +	__raw_writel(0xffffffff, NC_VA_INTC_NMASK63_32);
> +
> +	/*
> +	 * nationalchip irq ctrl has 64 sources.
> +	 */
> +	#define INTC_IRQS 64
> +	for (i=0; i<INTC_IRQS; i=i+4)
> +		__raw_writel(i|((i+1)<<8)|((i+2)<<16)|((i+3)<<24),
> +				NC_VA_INTC_SOURCE + i);

Same comments as for the other variant.

Thanks,

	tglx
