From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Date: Wed, 4 Jul 2018 18:49:58 +0800
Message-ID: <20180704104957.GB23536@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807031130050.1601@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 03, 2018 at 11:39:05AM +0200, Thomas Gleixner wrote:
> -EEMPTYCHANGELOG
Ok

> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou NationalChip Science & Technology Co.,Ltd.
> 
> newline please
Ok

> > +#define BITS_CSKY_TIMER	56
> > +
> > +DECLARE_PER_CPU(struct timer_of, csky_to);
> 
> static?
Ok.

> 
> > +
> > +static int csky_timer_irq;
> > +static int csky_timer_rate;
> > +
> > +static inline u64 get_ccvr(void)
> > +{
> > +	u32 lo, hi, t;
> > +
> > +	do {
> > +		hi = mfcr(PTIM_CCVR_HI);
> > +		lo = mfcr(PTIM_CCVR_LO);
> > +		t  = mfcr(PTIM_CCVR_HI);
> > +	} while(t != hi);
> 
> No idea which frequency this timer ticks at, but if the 32 bit wrap does
> not come too fast, then you really should avoid that loop. That function is
> called very frequently.

0000006c <clksrc_read>:
		hi = mfcr(PTIM_CCVR_HI);
  6c:	c1c26023 	mfcr      	r3, cr<2, 14>
		lo = mfcr(PTIM_CCVR_LO);
  70:	c1c36021 	mfcr      	r1, cr<3, 14>
		t  = mfcr(PTIM_CCVR_HI);
  74:	c1c26022 	mfcr      	r2, cr<2, 14>
	} while(t != hi);
  78:	648e      	cmpne      	r3, r2
  7a:	0bf9      	bt      	0x6c	// 6c <clksrc_read>

When two read cr<2, 14> is not equal, we'll retry. So only when
CCVR_LO is at 0xffffffff between the two read of CCVR_HI. That's very
very small probability event for "bt 0x6c".

Don't worry about the "do {...} whie(t != hi)", it's no performance issue.

> > +DEFINE_PER_CPU(struct timer_of, csky_to) = {
> 
> static
Ok.

> > +	.flags = TIMER_OF_CLOCK | TIMER_OF_IRQ,
> > +
> > +	.clkevt = {
> > +		.name = "C-SKY SMP Timer V1",
> > +		.rating = 300,
> > +		.features = CLOCK_EVT_FEAT_PERCPU | CLOCK_EVT_FEAT_ONESHOT,
> > +		.set_state_shutdown		= csky_timer_shutdown,
> > +		.set_state_oneshot		= csky_timer_oneshot,
> > +		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
> > +		.set_next_event			= csky_timer_set_next_event,
> > +	},
> > +
> > +	.of_irq = {
> > +		.handler = timer_interrupt,
> > +		.flags = IRQF_TIMER,
> > +		.percpu = 1,
> 
> This is inconsistent. You made it half tabular and half not. Please use
> tabular style consistently.
Ok.
	.clkevt = {
		.name				= "C-SKY SMP Timer V1",
		.features			= CLOCK_EVT_FEAT_PERCPU |
						  CLOCK_EVT_FEAT_ONESHOT,
		.rating				= 300,
		.set_state_shutdown		= csky_timer_shutdown,
		.set_state_oneshot		= csky_timer_oneshot,
		.set_state_oneshot_stopped	= csky_timer_oneshot_stopped,
		.set_next_event			= csky_timer_set_next_event,
	},

	.of_irq = {
		.handler			= timer_interrupt,
		.flags				= IRQF_TIMER,
		.percpu				= 1,

> > +/*** clock event for percpu ***/
> 
> Please refrain from inventing new horrible comment styles.
Ok.
/* clock event for percpu */

> > +struct clocksource csky_clocksource = {
> > +	.name = "csky_timer_v1_clksrc",
> > +	.rating = 400,
> > +	.mask = CLOCKSOURCE_MASK(BITS_CSKY_TIMER),
> > +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> > +	.read = clksrc_read,
> 
> tabular style please
Ok.

> > +	ret = cpuhp_setup_state(CPUHP_AP_DUMMY_TIMER_STARTING,
> > +				"clockevents/csky/timer:starting",
> > +				csky_timer_starting_cpu,
> > +				csky_timer_dying_cpu);
> 
> Oh no. Just picking a random hotplug event is not how it works. Add your
> own please and make sure it's at the proper place.
like this?
include/linux/cpuhotplug.h:
	CPUHP_AP_KVM_ARM_TIMER_STARTING,
+	CPUHP_AP_CSKY_TIMER_STARTING,
	/* Must be the last timer callback */
	CPUHP_AP_DUMMY_TIMER_STARTING,

> > +	struct clock_event_device *ce = (struct clock_event_device *) dev;
> 
> Pointless type cast.
Ok.
struct clock_event_device *ce = dev;

> > +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> > +	},
> 
> See above
Ok, tabular

Guo Ren
