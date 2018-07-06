Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53040 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932778AbeGFF5o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 01:57:44 -0400
Date: Fri, 6 Jul 2018 13:57:09 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 18/19] clocksource: add C-SKY clocksource drivers
Message-ID: <20180706055709.GA8707@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <aba005fd5005c066a2e3d760c334bb55f902d771.1530465326.git.ren_guo@c-sky.com>
 <bc765809-2d97-5ff8-d2ac-65479ce91ef2@linaro.org>
 <20180705033020.GA8023@guoren>
 <afdcf591-31cd-7610-0ff6-e345895ce4a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdcf591-31cd-7610-0ff6-e345895ce4a4@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706055709.5meM86aMeSqa4kPrf-iuBEaOolhJWDovJmgSLjy0v88@z>

On Thu, Jul 05, 2018 at 11:23:36AM +0200, Daniel Lezcano wrote:
> > So I still need "for_each_cpu(cpu, cpu_possible_mask)" to init every
> > csky_to ...
> 
> That is what is unclear for me. percpu or IRQF_PERCPU ?
IRQF_PERCPU
 
> Have a look at the commit 9995f4f184613fb02ee73092b03545520a72b104,
> changelog and the comment in the init function.
> 
> Can you give a similar description for this timer ?
Ok, thx for the tip.

> > #define STATUS_CLR	BIT(0)
> > 
> > #define CONTRL_RST	BIT(0)
> > #define CONTRL_START	BIT(1)
> > 
> > #define CONFIG_EN	BIT(0)
> > #define CONFIG_IRQ_EN	BIT(1)
> 
> NATCHIP_STATUS_CLR
> NATCHIP_CONTROL_RST
> NATCHIP_CONTROL_START
> 
> NATCHIP_CONFIG_EN
> NATCHIP_CONFIG_IRQ_EN
Ok

> >>> +		.rating = 300,
> >>> +		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_PERIODIC |
> >>> +			CLOCK_EVT_FEAT_ONESHOT,
> >>> +		.set_state_shutdown	= nc_timer_shutdown,
> >>> +		.set_state_periodic	= nc_timer_set_periodic,
> >>> +		.set_next_event		= nc_timer_set_next_event,
> >>
> >> set_oneshot ?
> > Yes oneshort, but also could support periodic. But in fact, it only
> > works with oneshort.
> 
> In the flags, it is specified periodic and oneshot but only the
> set_periodic ops is set.
Got it, add set_oneshot.

> > Thx, I'll modify it like this:
> > div = (timer_of_rate(&to) / TIMER_FREQ) - 1;
> 
> I wanted to be sure it wasn't the latter. In this case, you don't need
> parenthesis, so just add the spaces around the '/' operator.
Ok

 Guo Ren
