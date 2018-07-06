Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45030 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753457AbeGFGHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 02:07:51 -0400
Date: Fri, 6 Jul 2018 14:07:40 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Message-ID: <20180706060740.GB8707@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180705180503.GH2530@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705180503.GH2530@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706060740.JPMFBpKKTf_PExMAyoJZb3Ch3Y1kwo_2lbc1aWz8QTk@z>

On Thu, Jul 05, 2018 at 08:05:03PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:19AM +0800, Guo Ren wrote:
> > +static irqreturn_t handle_ipi(int irq, void *dev)
> > +{
> > +	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
> > +
> > +	while (true) {
> > +		unsigned long ops;
> > +
> > +		/* Order bit clearing and data access. */
> > +		mb();
> > +
> > +		ops = xchg(pending_ipis, 0);
> > +		if (ops == 0)
> > +			return IRQ_HANDLED;
> > +
> > +		if (ops & (1 << IPI_RESCHEDULE))
> > +			scheduler_ipi();
> > +
> > +		if (ops & (1 << IPI_CALL_FUNC))
> > +			generic_smp_call_function_interrupt();
> > +
> > +		BUG_ON((ops >> IPI_MAX) != 0);
> > +
> > +		/* Order data access and bit testing. */
> > +		mb();
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
> > +
> > +void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
> > +{
> > +	if (send_arch_ipi)
> > +		return;
> > +
> > +	send_arch_ipi = func;
> > +}
> > +
> > +static void
> > +send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
> > +{
> > +	int i;
> > +
> > +	mb();
> > +	for_each_cpu(i, to_whom)
> > +		set_bit(operation, &ipi_data[i].bits);
> > +
> > +	mb();
> > +	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
> > +}
> 
> 
> Please explain those mb()'s... I'm thinking you meant to use smp_mb().
Yes, smp_mb(). Current smp_mb()&mb() is the same: sync.is.

In next version patch, I'll seperate smp_mb() and mb() and use ld/st.barrier
instead of sync.is. Sync.is is expensive that it flush cpu's pipeline.

> But then for handle_ipi(), the xchg() should already imply all those.
Yes, approve.

> And the send_ipi_message() only needs the second.
Yes, approve.

 Guo Ren
