From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 10/26] csky: IRQ handling
Date: Mon, 10 Sep 2018 15:30:39 +0800
Message-ID: <20180910073039.GA4022@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <a881fc9d1009f7b3ca1cfa50dd7f1ead7844d521.1536138304.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809061535040.1570@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 03:39:01PM +0200, Thomas Gleixner wrote:
> On Wed, 5 Sep 2018, Guo Ren wrote:
> 
> > +static void (*handle_arch_irq)(struct pt_regs *regs) = NULL;
> > +
> > +void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> > +{
> > +	if (handle_arch_irq)
> > +		return;
> > +
> > +	handle_arch_irq = handle_irq;
> > +}
> 
> Please don't introduce yet another variant of that. Please use
> CONFIG_GENERIC_IRQ_MULTI_HANDLER which provides that in the generic code.
Ok.

> 
> Btw, some of your patches have tab vs. space inconsistencies, e.g.
> 
> +        siginfo_t info;
> +       int fault;
> +       unsigned long address = mmu_meh & PAGE_MASK
Thx, I'll re-check.

Best Regards
 Guo Ren
