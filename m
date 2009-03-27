From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/13] score - New architecure port to SunplusCT S+CORE
 processor
Date: Fri, 27 Mar 2009 10:46:14 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903271042410.3397@localhost.localdomain>
References: <OF7CA377BE.25D639C0-ON48257586.0009A7DE-48257586.0009EF6F@sunplusct.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:53466 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbZC0JsQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Mar 2009 05:48:16 -0400
In-Reply-To: <OF7CA377BE.25D639C0-ON48257586.0009A7DE-48257586.0009EF6F@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Fri, 27 Mar 2009, liqin.chen@sunplusct.com wrote:
> +#include <linux/interrupt.h>
> +#include <asm/scoreregs.h>
> +
> +int timer_interrupt(int irq, void *dev_id)
> +{
> +       rTIMER0CPPR = 1;        /* clear timer interrupt flag */
> +       do_timer(1);
> +       update_process_times(user_mode(get_irq_regs()));
> +       return IRQ_HANDLED;
> +}

  Please convert this to CLOCK_EVENTS.

Thanks,

	tglx
