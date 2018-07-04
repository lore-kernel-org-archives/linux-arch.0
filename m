From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Wed, 4 Jul 2018 08:43:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807040841080.1816@nanos.tec.linutronix.de>
References: <cover.1530465325.git.ren_guo@c-sky.com> <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com> <alpine.DEB.2.21.1807031100280.1601@nanos.tec.linutronix.de> <20180704050822.GA23536@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704050822.GA23536@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, 4 Jul 2018, Guo Ren wrote:
> On Tue, Jul 03, 2018 at 11:28:03AM +0200, Thomas Gleixner wrote:
> That's Ok. And here is my implementation:
> 
> static inline u32 build_intc_ctrl(u32 idx)
> {
> 	/*
> 	 * One channel is one byte in a word-width register, so
> 	 * there are four channels in a word-width register.
> 	 *
> 	 * Set the same index for each channel and it will make
> 	 * "irq num = channel num".
> 	 */
> 	return (idx             | ((idx + 1) << 8) |
> 	      ((idx + 2) << 16) | ((idx + 3) << 24));
> }
> Hmm? (No magic number)

Ok :)

> > > +	static void __iomem	*reg_base;
> > > +	irq_hw_number_t		hwirq;
> > > +
> > > +	reg_base = *this_cpu_ptr(&intcl_reg);
> > 
> > Wheee!
> > 
> > 	static void __iomem *reg_base = this_cpu_read(intcl_reg);
> > 	irq_hw_number_t	hwirq;
> > 
> > Hmm?
> Thx for the tips and I'll use this_cpu_read() without static.
>  	void __iomem *reg_base = this_cpu_read(intcl_reg);

Yeah, I surely missed to drop the static ...

> > 
> > Aside of that the whole thing might share the code with the other one, but
> > it might not be worth it. At least this wants to be documented in the
> > changelog why sharing the code is not useful...
>
> Do you mean merge irq-csky-v1.c irq-csky-v2.c irq-nationalchip.c into
> one file eg: irq-csky.c? 

Yes, but only if there is enough code to share without creating an ifdef
mess. But that looks doable

Thanks,

	tglx
