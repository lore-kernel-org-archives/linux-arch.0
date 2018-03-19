From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Date: Mon, 19 Mar 2018 15:08:59 +0800
Message-ID: <20180319070859.GC21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
 <20180319042535.fzssdiu4ot7nyhwe@salmiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319042535.fzssdiu4ot7nyhwe@salmiak>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 19, 2018 at 04:26:00AM +0000, Mark Rutland wrote:
> On Mon, Mar 19, 2018 at 03:51:41AM +0800, Guo Ren wrote:
> > +static unsigned int intc_reg;
> 
> This should be a void __iomem *ptr;
>
OK

> > +#define CK_VA_INTC_ICR		(void *)(intc_reg + 0x00)	/* Interrupt control register(High 16bits) */
> > +#define CK_VA_INTC_ISR		(void *)(intc_reg + 0x00)	/* Interrupt status register(Low 16bits) */
> > +#define CK_VA_INTC_NEN31_00	(void *)(intc_reg + 0x10)	/* Normal interrupt enable register Low */
> > +#define	CK_VA_INTC_NEN63_32	(void *)(intc_reg + 0x28)	/* Normal interrupt enable register High */
> > +#define CK_VA_INTC_IFR31_00	(void *)(intc_reg + 0x08)	/* Normal interrupt force register Low */
> > +#define CK_VA_INTC_IFR63_32	(void *)(intc_reg + 0x20)	/* Normal interrupt force register High */
> > +#define	CK_VA_INTC_SOURCE	(void *)(intc_reg + 0x40)	/* Proiority Level Select Registers 0 */
> 
> Please use mnemonics for the offsets, and add the base address in the IO
> accessors.
> 
OK

> > +		temp = __raw_readl(CK_VA_INTC_NEN31_00);
> 
> Please use readl_relaxed() rather than __raw_readl().
>
OK

> > +		__raw_writel(temp, CK_VA_INTC_NEN31_00);
> 
> Likewise, please use writel_relaxed() rather than __raw_writel().
>
OK
 
> These need devicetree bindings. Please see
> Documentation/devicetree/bindings/submitting-patches.txt.
>
OK

> Please avoid assembly in generic driver code. Here you cna use __ffs64() after
> combining the two halves into a 64-bit quantity, or you could use ffs() on each
> half.
>
OK

> > +IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);
> 
> This needs a devicetree binding document.
OK
Best Regards
 Guo Ren
