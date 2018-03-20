From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Date: Tue, 20 Mar 2018 22:23:51 +0800
Message-ID: <20180320142350.GA13892@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1803191417140.2010@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803191417140.2010@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi Thomas,

On Mon, Mar 19, 2018 at 02:30:42PM +0100, Thomas Gleixner wrote:
> > +static struct irq_chip ck_irq_chip = {
> > +	.name		= "csky_intc_v1",
> > +	.irq_mask	= ck_irq_mask,
> > +	.irq_unmask	= ck_irq_unmask,
> > +};
> 
> Please use the generic interrupt chip infrastructure for this.
Ok, I will learn it.

> > +static unsigned int ck_get_irqno(void)
> > +{
> > +	unsigned int temp;
> 
> newline between declaration and code.
Ok

> > +	temp = __raw_readl(CK_VA_INTC_ISR);
> > +	return temp & 0x3f;
> > +};
> > +
> > +static int __init
> > +__intc_init(struct device_node *np, struct device_node *parent, bool ave)
> 
> What is 'ave'?
Ave means the irq-controller works on auto-vector-handler mode, it will
cause 10 exception number and it need read intc-reg to get irq-num.

> No magic numbers. Please use proper defines.
Ok

> > +	else
> > +		__raw_writel( 0x0, CK_VA_INTC_ICR);
> > +	/*
> > +	 * csky irq ctrl has 64 sources.
> > +	 */
> > +	#define INTC_IRQS 64
> 
> No defines in code.
Ok

> 
> > +	for (i=0; i<INTC_IRQS; i=i+4)
> 
> checkpatch.pl would have told you what's wrong with the above
Ok, Thx

> > +		__raw_writel((i+3)|((i+2)<<8)|((i+1)<<16)|(i<<24),
> 
> Eew. Tons of magic numbers and a unreadable coding style. Please use an
> inline function with proper comments to calculate that value
Ok

> > +				CK_VA_INTC_SOURCE + i);
> > +
> > +	root_domain = irq_domain_add_legacy(np, INTC_IRQS, 0, 0, &ck_irq_ops, NULL);
> > +	if (!root_domain)
> > +		panic("root irq domain not available\n");
> > +
> > +	irq_set_default_host(root_domain);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init
> > +intc_init(struct device_node *np, struct device_node *parent)
> > +{
> > +
> 
> Stray newline
I'll remove, Thx.

> > +	return __intc_init(np, parent, false);
> > +}
> > +IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", intc_init);
> > +
> > +/*
> > + * use auto vector exceptions 10 for interrupt.
> > + */
> > +static int __init
> > +intc_init_ave(struct device_node *np, struct device_node *parent)
> > +{
> > +	return __intc_init(np, parent, true);
> 
> Why is that 'ave' thing not a property of device tree?
I'll change it to a property.

> > +struct irq_chip nc_irq_chip = {
> > +	.name =		"nationalchip_intc_v1",
> > +	.irq_mask =	nc_irq_mask,
> > +	.irq_unmask =	nc_irq_unmask,
> > +	.irq_enable =	nc_irq_en,
> > +	.irq_disable =	nc_irq_dis,
> > +};
> 
> Again. This all can use the generic interrupt chip.
I'll learn the generic interrupt chip.

> > +inline int ff1_64(unsigned int hi, unsigned int lo)
> 
> What on earth means ff1_64?
Find the first high bit '1' of the reg :P

> > +	asm volatile(
> > +		"ff1 %0\n"
> > +		:"=r"(lo)
> > +		:"r"(lo)
> > +		:
> > +	);
> 
> So you want to decode the interrupt number from a bitfield. What's wrong
> with ffs()?
There is no wrong with ffs(). Ok, I will use the ffs().

> > +	if( lo != 32 )
> > +		result = 31-lo;
> 
> Why is this subtracted?
ff1 find from high bit, so we need reverse it to get the right num.
> That code makes no sense w/o comments.
Sorry, I will add.

> > +	else if( hi != 32 ) result = 31-hi + 32;
> > +	else {
> > +		printk("nc_get_irqno error hi:%x, lo:%x.\n", hi, lo);
> > +		result = NR_IRQS;
> > +	}
> 
> Pleas use braces consistently.
Ok

> > +unsigned int nc_get_irqno(void)
> 
> static?
Yes

> Same comments as for the other variant.
Ok

Best Regards
  Guo Ren
