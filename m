From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Date: Mon, 19 Mar 2018 04:26:00 +0000
Message-ID: <20180319042535.fzssdiu4ot7nyhwe@salmiak>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 19, 2018 at 03:51:41AM +0800, Guo Ren wrote:
> +static unsigned int intc_reg;

This should be a void __iomem *ptr;

> +
> +#define CK_VA_INTC_ICR		(void *)(intc_reg + 0x00)	/* Interrupt control register(High 16bits) */
> +#define CK_VA_INTC_ISR		(void *)(intc_reg + 0x00)	/* Interrupt status register(Low 16bits) */
> +#define CK_VA_INTC_NEN31_00	(void *)(intc_reg + 0x10)	/* Normal interrupt enable register Low */
> +#define	CK_VA_INTC_NEN63_32	(void *)(intc_reg + 0x28)	/* Normal interrupt enable register High */
> +#define CK_VA_INTC_IFR31_00	(void *)(intc_reg + 0x08)	/* Normal interrupt force register Low */
> +#define CK_VA_INTC_IFR63_32	(void *)(intc_reg + 0x20)	/* Normal interrupt force register High */
> +#define	CK_VA_INTC_SOURCE	(void *)(intc_reg + 0x40)	/* Proiority Level Select Registers 0 */

Please use mnemonics for the offsets, and add the base address in the IO
accessors.

[...]

> +		temp = __raw_readl(CK_VA_INTC_NEN31_00);

Please use readl_relaxed() rather than __raw_readl().

> +		__raw_writel(temp, CK_VA_INTC_NEN31_00);

Likewise, please use writel_relaxed() rather than __raw_writel().

[...]

> +static int __init
> +__intc_init(struct device_node *np, struct device_node *parent, bool ave)
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
> +		__raw_writel( 0xc0000000, CK_VA_INTC_ICR);
> +	else
> +		__raw_writel( 0x0, CK_VA_INTC_ICR);
> +	/*
> +	 * csky irq ctrl has 64 sources.
> +	 */
> +	#define INTC_IRQS 64
> +	for (i=0; i<INTC_IRQS; i=i+4)
> +		__raw_writel((i+3)|((i+2)<<8)|((i+1)<<16)|(i<<24),
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
> +}
> +IRQCHIP_DECLARE(csky_intc_v1_ave, "csky,intc-v1,ave", intc_init_ave);

These need devicetree bindings. Please see
Documentation/devicetree/bindings/submitting-patches.txt.

[...]

> +inline int ff1_64(unsigned int hi, unsigned int lo)
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
> +	if( lo != 32 )
> +		result = 31-lo;
> +	else if( hi != 32 ) result = 31-hi + 32;
> +	else {
> +		printk("nc_get_irqno error hi:%x, lo:%x.\n", hi, lo);
> +		result = NR_IRQS;
> +	}
> +	return result;
> +}

Please avoid assembly in generic driver code. Here you cna use __ffs64() after
combining the two halves into a 64-bit quantity, or you could use ffs() on each
half.

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
> +
> +	root_domain = irq_domain_add_legacy(intc, INTC_IRQS, 0, 0,
> +			&nc_irq_ops, NULL);
> +	if (!root_domain)
> +		panic("root irq domain not avail\n");
> +
> +	irq_set_default_host(root_domain);
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);

This needs a devicetree binding document.

Thanks,
Mark.
